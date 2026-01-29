// --------------------------------------------------
// Copyright
// --------------------------------------------------
//
// Tech Aarvam
// Copyright (c) 2026 Tech Aarvam.
// Author: Ram (Ramasubramanian B)


// rst is active high in this example

module counter_asserts (
input logic rst, 
input logic clk,
input logic [4:0] count);

property count_is_resettable;
   @(posedge clk)
    rst |-> (count == 0);
endproperty
assert property (count_is_resettable);

property count_increments_only_if_reset_deasserted;
   @(posedge clk)
    rst |-> $stable(count);
endproperty;
assert property (count_increments_only_if_reset_deasserted);

property count_increments_every_edge_of_clock; 
  logic [4:0] c;
  @(posedge clk) disable iff ((count == 5'b11111) || rst)
    (1, c=count) |-> (count == c+1); 
endproperty
assert property (count_increments_every_edge_of_clock);

property count_rolls_over_to_zero;
  @(posedge clk) disable iff (rst)
    (count==5'b11111) |-> (count == 0); 
endproperty
   
assert property (count_rolls_over_to_zero);

endmodule

bind counter counter_asserts assert_inst(.*);

