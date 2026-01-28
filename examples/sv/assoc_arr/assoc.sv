module top;
    integer a[string] = '{"ram":40, "sita":35};
    always 
    begin
            $display ("ram's age: %0h", a["ram"]);
            $display ("ram's age: %0h", a["kamal"]);
            #10 $finish;
    end
endmodule
