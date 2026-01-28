module top;

typedef enum logic [3:0] {RED, YELLOW, GREEN, ORANGE} my_enum_t;

my_enum_t my;
always
begin
        #10
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
