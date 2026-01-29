// --------------------------------------------------
// Copyright
// --------------------------------------------------
//
// Tech Aarvam
// Copyright (c) 2026 Tech Aarvam.
// Author: Ram (Ramasubramanian B)

`timescale 1ns/1ns

typedef struct packed  {
    byte test; // 2-state and 4-state mix in a packed struct
    integer test_integer;
} test_struct;

module top;
    test_struct t;
    always begin
            #10
            // Display the packed struct fields.
            $display("%x %x", t.test, t.test_integer);
            // Simple counter update.
            t.test_integer = t.test_integer + 1;

    end
    initial begin
	    // Set up waveform dumping.
	    $dumpfile ("dump.vcd");
	    $dumpvars (0, top);
            #1
            // Initialize values after time 0.
            t.test=65;
            #10
            t.test_integer= -100000;
	    #300 $finish();
    end

endmodule
