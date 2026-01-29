// --------------------------------------------------
// Copyright
// --------------------------------------------------
//
// Tech Aarvam
// Copyright (c) 2026 Tech Aarvam.
// Author: Ram (Ramasubramanian B)

module top;
    mailbox #(int) m = new();

    initial begin
        // Producer: put an item into the mailbox.
        m.put(123);
    end

    initial begin
        int value;
        // Consumer: block until a value is available.
        m.get(value);
        $display("mailbox value=%0d", value);
    end
endmodule
