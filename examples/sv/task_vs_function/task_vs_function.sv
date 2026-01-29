// --------------------------------------------------
// Copyright
// --------------------------------------------------
//
// Tech Aarvam
// Copyright (c) 2026 Tech Aarvam.
// Author: Ram (Ramasubramanian B)

module top;
    // Function: returns a value; must not contain blocking timing controls.
    function int add(input int a, input int b);
        add = a + b;
    endfunction

    // Task: can include delays; no return value (uses output instead).
    task show_after_delay(input int value);
        #10; // blocking timing control allowed in tasks
        $display("[t=%0t] task value=%0d", $time, value);
    endtask

    initial begin
        int sum;

        sum = add(2, 3);
        $display("[t=%0t] function sum=%0d", $time, sum);

        // Task call blocks until it finishes.
        show_after_delay(sum);

        #1 $finish;
    end
endmodule
