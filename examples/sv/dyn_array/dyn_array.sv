module top;

logic [7:0] arr[];
initial 
begin
        int i;
        arr = new[10];
        arr[3]=20;
        $display ("%0h", arr[3]);
        #200
        for (i=0; i< $size(arr); i++)
                $display("%0h", arr[i]);
end



endmodule
