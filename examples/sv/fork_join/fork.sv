// --------------------------------------------------
// Copyright
// --------------------------------------------------
//
// Tech Aarvam
// Copyright (c) 2026 Tech Aarvam.
// Author: Ram (Ramasubramanian B)

module top;

initial begin
  // Start of concurrent execution demo.
  $display("%0t start", $time);

  fork
    begin
      #10;
      // Thread A finishes first.
      $display("%0t thread A", $time);
    end

    begin
      #20;
      // Thread B finishes later.
      $display("%0t thread B", $time);
    end
  join

  // This runs after both forked blocks complete.
  $display("%0t after fork-join", $time);
end

endmodule
