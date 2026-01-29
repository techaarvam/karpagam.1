// --------------------------------------------------
// Copyright
// --------------------------------------------------
//
// Tech Aarvam
// Copyright (c) 2026 Tech Aarvam.
// Author: Ram (Ramasubramanian B)

module top;

// Static arrays with different initialization styles.
logic [31:0] a[200] = '{default:32'hff223344}; // demonstrates use of the default
logic [31:0] b[3] = '{1,2,3}; // fixed initializer
logic [31:0] c[3] = '{1:1,0:2,2:3}; // indexed initializer
initial begin
        int i;
        // Fill a with a simple pattern so the first few entries are distinct.
        for (i=0; i<200; i++) a[i] = 32'hff12<<16 | i;
end

always begin
        int i;
        #300
        // Print a few values to show array contents.
        for (i=0; i<3; i++)
            $display("%0h %0h", a[i], b[i], c[i]);
        #20 $finish();
end

endmodule
