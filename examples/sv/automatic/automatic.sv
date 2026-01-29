// --------------------------------------------------
// Copyright
// --------------------------------------------------
//
// Tech Aarvam
// Copyright (c) 2026 Tech Aarvam.
// Author: Ram (Ramasubramanian B)

// Suggested: Questions / experiments 
//  what happens if you remove the automic keyword in the task?
//  Run an experiment.

module top;
    // Automatic task allows re-entrant execution.
    task automatic count(input int id);
        int i;
        for (i = 0; i < 3; i++) begin
            #5;
            $display("id=%0d i=%0d", id, i);
        end
    endtask

    initial begin
        // Run two instances concurrently to show separate stacks.
        fork
            count(1);
            count(2);
        join
    end
endmodule
