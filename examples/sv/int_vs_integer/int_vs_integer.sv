// --------------------------------------------------
// Copyright
// --------------------------------------------------
//
// Tech Aarvam
// Copyright (c) 2026 Tech Aarvam.
// Author: Ram (Ramasubramanian B)

// Notes: Experiment based learning has a limitation.
// integer is 4-state and verilator tool limitation will print 0.
// vcs may print x. 
// Experiments are valuable, but does not replace reading carefully!.


module top;
    // integer is 4-state; int is 2-state by default.
    integer i;
    int     j;

    initial begin
        // Assign unknowns to highlight 4-state vs 2-state behavior.
        i = 'bx;
        j = 'bx;

        $display("integer i = %0d", i); // prints X in 4-state integer
        $display("int     j = %0d", j); // prints 0 (or some value) in 2-state int
        #1 $finish;
    end
endmodule
