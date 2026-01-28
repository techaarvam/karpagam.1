class A;
    integer data;
    task modifyData();
        $display("A says data is %x", data);
    endtask
    task init();
        data = 100;
    endtask
   
endclass;

class B extends A;
    task modifyData();
        $display("B says data is %x", data);
    endtask
endclass;

module top;
    A a ;
    B b;
    initial
    begin
        b = new();
        b.init();
        a=b;
        b.modifyData();
        a.modifyData();
    end
endmodule
