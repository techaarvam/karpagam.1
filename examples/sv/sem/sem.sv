// --------------------------------------------------
// Copyright
// --------------------------------------------------
//
// Tech Aarvam
// Copyright (c) 2026 Tech Aarvam.
// Author: Ram (Ramasubramanian B)

module top;
    semaphore sema = new(1);

    task automatic worker(input int id);
        // Only one worker can enter the critical section at a time.
        sema.get(1);
        $display("worker %0d entered at %0t", id, $time);
        #10;
        $display("worker %0d leaving at %0t", id, $time);
        sema.put(1);
    endtask

    initial begin
        fork
            worker(1);
            worker(2);
        join
    end
endmodule
