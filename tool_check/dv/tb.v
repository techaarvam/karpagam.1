// --------------------------------------------------
// Copyright
// --------------------------------------------------
//
// Tech Aarvam
// Copyright (c) 2026 Tech Aarvam.
// Author: Ram (Ramasubramanian B)

module tb;
    logic rst, clk;
    logic [4:0] count;

    counter t(rst,clk, count);
    always 
    begin
        #5 clk <= ~clk;
        $display ("count is %lx\n", count);
    end
  
    initial
    begin
        rst <= 1;
        clk <= 0;
        #10
        rst <= 0;
        #10000 $finish;
    end

endmodule
