// --------------------------------------------------
// Copyright
// --------------------------------------------------
//
// Tech Aarvam
// Copyright (c) 2026 Tech Aarvam.
// Author: Ram (Ramasubramanian B)

`timescale 1ns/1ps
import uvm_pkg::*;
import apb_tb_pkg::*;

module tb;
    logic psel0, pready0, penable0, pwrite0, perr0;
    logic [7:0] pwdata0, prdata0, paddr0; 
    logic psel1, pready1, penable1, pwrite1, perr1;
    logic [7:0] pwdata1, prdata1, paddr1; 
    master_intf intf();
    
    typedef enum logic [1:0] {DMA_START, WAIT_COMPLETION} tb_state_t;
    tb_state_t state;
    apb_master apb_rtl(
        .clk(intf.clk),
        .nrst(intf.nrst),
        .valid(intf.valid),
        .ready(intf.ready),
        .length(intf.length),
        .source(intf.source),
        .destination(intf.destination)
    );
    apb_target_tb #(.DEVID(0))  apb_target0  (
         .*,
         .nrst(intf.nrst),
         .clk (intf.clk),
         .psel(psel0),  
         .pready(pready0), 
         .penable(penable0),
         .pwrite(pwrite0),
         .pwdata(pwdata0),
         .prdata(prdata0),
         .perr(perr0),
         .paddr(paddr0)
    );
    apb_target_tb  #(.DEVID(1)) apb_target1  (
         .*,
         .nrst(intf.nrst),
         .clk (intf.clk),
         .psel(psel1),  
         .pready(pready1), 
         .penable(penable1),
         .pwrite(pwrite1),
         .pwdata(pwdata1),
         .prdata(prdata1),
         .perr(perr1),
         .paddr(paddr1)

    );
          

    always 
    begin
        #5
        intf.clk <= ~intf.clk;
        $display("clock is running");
    end

    initial
    begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb);
        intf.nrst = 0;
        intf.clk = 0;
        state = DMA_START;
        #15 intf.nrst = 1;
    end

`ifdef VERILOG_TB
    always @(posedge intf.clk)
    begin
        //source = 0, destination = 128, length=8
        case (state)
            DMA_START:
            begin
                intf.source <=0;
                intf.destination <= 128;
                intf.length <=8;
                intf.valid <= 1;
                // since this is the TB, writing the code free-style 
                // state change is not in its own always_comb 
                state <= WAIT_COMPLETION;
            end
            WAIT_COMPLETION:
            begin
                $display ("waiting ... ");
                if (ready == 1) begin
                    $display ("DMA operation complete. Terminating the simulation");
                    $display (" Memory Dump ");
                    $display ("=============");
                    for (int i = 0; i < 128; i++) begin
                        $display("mem[%0d] = 0x%02h", i, apb_target0.mem[i]);
                    end
                    $display ("=============");
                    for (int i = 0; i < 128; i++) begin
                        $display("mem[%0d] = 0x%02h", i, apb_target1.mem[i]);
                    end
                    $display ("=============");

                    $finish;
                end
            end
        endcase
        
    end
`endif 
`ifndef VERILOG_TB
// UVM TB
    virtual master_intf vintf = intf;
    initial 
    begin
        uvm_resource_db#(virtual master_intf)::set("master_tb_env",
          "apb_master_intf", vintf);
        uvm_root::get().set_timeout(100000, 1);
        
        run_test();
    end

    always @(posedge intf.ready)
    begin
                    $display ("DMA operation complete. Terminating the simulation");
                    $display (" Memory Dump ");
                    $display ("=============");
                    for (int i = 0; i < 128; i++) begin
                        $display("mem[%0d] = 0x%02h", i, apb_target0.mem[i]);
                    end
                    $display ("=============");
                    for (int i = 0; i < 128; i++) begin
                        $display("mem[%0d] = 0x%02h", i, apb_target1.mem[i]);
                    end
                    $display ("=============");


    end

`endif
    
endmodule

module apb_target_tb #(parameter DEVID=0) (nrst, clk, psel, pready, penable, pwrite, pwdata, prdata, perr, paddr);
    input nrst, clk, psel, penable, pwrite;
    input logic [7:0] pwdata, paddr;
    output logic [7:0] prdata;
    output logic pready, perr;

    logic [7:0] addr;
    logic [7:0] mem [0:127];

    initial begin
      for (int i = 0; i < 128; i++) begin
        if (DEVID==0)
        mem[i] = 8'hA5 ^ i[7:0];   // simple signature pattern
        else mem[i] = 8'h5A ^ i[7:0];
      end

    end

    always @(posedge clk)
    begin
        addr <= paddr;
        if (psel && penable)
        begin
            if (pwrite) mem[addr] <= pwdata;
            else prdata <= mem[addr];
            pready <= 1;
        end 
        else pready <=0; // again TB only losely written code
    end

endmodule
