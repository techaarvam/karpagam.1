// --------------------------------------------------
// Copyright
// --------------------------------------------------
//
// Tech Aarvam
// Copyright (c) 2026 Tech Aarvam.
// Author: Ram (Ramasubramanian B)

module top;
    // Associative array indexed by string.
    integer a[string] = '{"ram":40, "sita":35};
    always begin
            // Lookup an existing key.
            $display ("ram's age: %0h", a["ram"]);
            // Lookup a missing key to show the default value.
            $display ("ram's age: %0h", a["kamal"]);
            // Questions for learners: What will be the output X or 0? 
            // Questions for learners: is integer 4-state or 2-state?
            #10 $finish;
    end
endmodule
