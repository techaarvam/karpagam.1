// --------------------------------------------------
// Copyright
// --------------------------------------------------
//
// Tech Aarvam
// Copyright (c) 2026 Tech Aarvam.
// Author: Ram (Ramasubramanian B)

module top;
    task swap(ref int a, ref int b);
        int tmp;
        // Swap two variables by reference.
        tmp = a;
        a = b;
        b = tmp;
    endtask

    initial begin
        int x = 1;
        int y = 2;
        $display("before: x=%0d y=%0d", x, y);
        swap(x, y);
        $display("after:  x=%0d y=%0d", x, y);
    end
endmodule
