
module apb_asserts(
      nrst, clk, //clocks and resets
      valid, ready, source, destination, length,  // upstream interface
      //target0
      psel0, pready0, penable0, pwrite0, pwdata0, prdata0, perr0, paddr0,
      //target1
      psel1, pready1, penable1, pwrite1, pwdata1, prdata1, perr1, paddr1
    );

input nrst, clk, valid, ready, psel0, pready0, penable0, pwrite0, perr0;
input logic [7:0] source, destination, pwdata0, prdata0, paddr0;
input logic [3:0] length;

input psel1, pready1, penable1, pwrite1, perr1;
input logic [7:0]  pwdata1, prdata1, paddr1;

sequence sel_enable;
    psel0 ##1 (psel0 && penable0);
endsequence


property penable_after_psel;
    @(posedge clk) disable iff(nrst == 0)
        psel0 |-> ##[1:$] penable0;
endproperty
assert property (penable_after_psel);

property psel_not_when_penable;
    @(posedge clk) disable iff(nrst == 0)
        penable0 |-> !$rose(psel0) ;
endproperty
assert property (psel_not_when_penable);

property pready_only_if_penable_psel;
    @(posedge clk) disable iff(nrst == 0)
        sel_enable |-> pready0;
endproperty
assert property (pready_only_if_penable_psel);

property pwdata_not_x;
    @(posedge clk) disable iff(nrst == 0)
        pready0 |=> !$isunknown(pwdata0);
endproperty
assert property (pwdata_not_x);

property prdata_not_x;
    @(posedge clk) disable iff(nrst == 0)
        pready0 |=> !$isunknown(prdata0);
endproperty
assert property (prdata_not_x);


property pwrite_no_change_if_penable;
    @(posedge clk) disable iff(nrst == 0)
        penable0 |-> $stable(pwrite0);
endproperty
assert property (pwrite_no_change_if_penable);

property pwdata_no_change_if_penable;
    @(posedge clk) disable iff(nrst == 0)
        penable0 |-> $stable(pwdata0);
endproperty
assert property (pwdata_no_change_if_penable);

property paddr_no_change_if_penable;
    @(posedge clk) disable iff(nrst == 0)
        penable0 |-> $stable(paddr0);
endproperty
assert property (paddr_no_change_if_penable);
//check that the must hit gets covered
cover property (@(posedge clk) disable iff (!nrst)
  ##[1:20] (psel0 && penable0)
);

assume property (@(posedge clk) !nrst |-> ##[1:5] nrst);

endmodule

bind apb_master apb_asserts bind_inst (
      .*
);
