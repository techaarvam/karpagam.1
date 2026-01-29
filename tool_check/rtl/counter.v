// --------------------------------------------------
// Copyright
// --------------------------------------------------
//
// Tech Aarvam
// Copyright (c) 2026 Tech Aarvam.
// Author: Ram (Ramasubramanian B)

module counter (rst, clk, count);
    output reg [4:0] count;
    input rst, clk;
    always_ff @(posedge clk)
    begin
        if (!rst)
            count <= count + 1'b1;
        else 
            count <= 5'b0;
    end
endmodule
