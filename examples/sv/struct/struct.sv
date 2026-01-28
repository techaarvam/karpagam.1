`timescale 1ns/1ns

typedef struct packed  {
    byte test;//2-state and 4-state mix in a packed struct
    integer test_integer;
} test_struct;

module top;
    test_struct t;
    always begin
            #10
            $display("%x %x", t.test, t.test_integer);
            t.test_integer = t.test_integer + 1;

    end
    initial begin
	    $dumpfile ("dump.vcd");
	    $dumpvars (0, top);
            #1
            t.test=65;
            #10
            t.test_integer= -100000;
	    #300 $finish();
    end

endmodule
