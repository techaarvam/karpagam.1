// --------------------------------------------------
// Copyright
// --------------------------------------------------
//
// Tech Aarvam
// Copyright (c) 2026 Tech Aarvam.
// Author: Ram (Ramasubramanian B)

module top;

// Dynamic array of bytes.
logic [7:0] arr[];
initial 
begin
        int i;
        // Allocate 10 elements at runtime.
        arr = new[10];
        // Write a single element to show random access.
        arr[3]=20;
        $display ("%0h", arr[3]);
        #200
        // Iterate over the allocated size.
        for (i=0; i< $size(arr); i++)
                $display("%0h", arr[i]);
end



endmodule
