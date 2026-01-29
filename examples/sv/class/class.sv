// --------------------------------------------------
// Copyright
// --------------------------------------------------
//
// Tech Aarvam
// Copyright (c) 2026 Tech Aarvam.
// Author: Ram (Ramasubramanian B)

class Packet;
    int id;

    function new(int id_in);
        // Simple constructor for class demo.
        id = id_in;
    endfunction

    function void display();
        $display("Packet id=%0d", id);
    endfunction
endclass

module top;
    Packet p;
    initial begin
        // Create and use a class object.
        p = new(42);
        p.display();
    end
endmodule
