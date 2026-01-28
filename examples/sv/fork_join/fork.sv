module top;

initial begin
  $display("%0t start", $time);

  fork
    begin
      #10;
      $display("%0t thread A", $time);
    end

    begin
      #20;
      $display("%0t thread B", $time);
    end
  join

  $display("%0t after fork-join", $time);
end

endmodule
