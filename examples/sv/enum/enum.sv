// --------------------------------------------------
// Copyright
// --------------------------------------------------
//
// Tech Aarvam
// Copyright (c) 2026 Tech Aarvam.
// Author: Ram (Ramasubramanian B)

module top;

// 4-bit encoded enum for a simple traffic light example.
typedef enum logic [3:0] {RED, YELLOW, GREEN, ORANGE} my_enum_t;

my_enum_t my;
always
begin
        #10
        // Randomize the enum to trigger different cases.
        my = my_enum_t'($urandom_range(0,15));

        case (my)
              RED:;
              YELLOW: $display("yellow");
              GREEN:;
              ORANGE: $display ("orange");
              default: $display ("none of the above");

        endcase 
end

endmodule;
