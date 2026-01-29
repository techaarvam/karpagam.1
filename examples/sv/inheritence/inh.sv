// --------------------------------------------------
// Copyright
// --------------------------------------------------
//
// Tech Aarvam
// Copyright (c) 2026 Tech Aarvam.
// Author: Ram (Ramasubramanian B)

class A;
    integer data;
    task modifyData();
        // Base-class behavior.
        data = data + 1;
        $display("A says data is %x", data);
    endtask
    task init();
        // Common initialization for derived classes.
        data = 100;
    endtask
   
endclass;

class B extends A;
    task modifyData();
        //Override to show polymorphism.
        data = data + 2;
        $display("B says data is %x", data);
    endtask
endclass;

module top;
    A a ;
    B b;
    initial
    begin
        // Create derived instance and upcast.
        b = new();
        b.init();
        a=b;
        b.modifyData();
        a.modifyData();
    end
endmodule
