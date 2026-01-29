// --------------------------------------------------
// Copyright
// --------------------------------------------------
//
// Tech Aarvam
// Copyright (c) 2026 Tech Aarvam.
// Author: Ram (Ramasubramanian B)

module top;
    event done;

    initial begin
        // Wait for the event to be triggered.
        @done;
        $display("event received at %0t", $time);
    end

    initial begin
        // Trigger the event after a delay.
        #20;
        -> done;
    end
endmodule
