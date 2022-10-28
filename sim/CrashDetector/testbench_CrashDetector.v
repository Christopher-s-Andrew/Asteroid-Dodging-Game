// Author: Matthew Andersen 2071
// testbench_CrashDetector
// This tests the CrashDetector by sending PlayerPosition and ObjectPosition values
// and observing the DisplayOut and CrashDetected signals.
`timescale 1 ns/ 100 ps
module testbench_CrashDetector();
  reg clk, rst;
  reg [6:0] ObjectPosition, PlayerPosition;
  wire [6:0] DisplayOut;
  wire CrashDetected;

  CrashDetector  DUT_CrashDetector(ObjectPosition, PlayerPosition, DisplayOut, CrashDetected, clk, rst);

  always begin
    clk = 1'b0; #10;
    clk = 1'b1; #10;
  end
  
  initial begin
    PlayerPosition = 7'b1111111;
    ObjectPosition = 7'b1111111;
    rst = 1'b1;
    @(posedge clk);@(posedge clk);@(posedge clk);
    #5 rst = 1'b0;  // initial reset
    @(posedge clk);@(posedge clk);@(posedge clk);
    #5 rst = 1'b1; @(posedge clk);
    @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);

    #5 PlayerPosition = 7'b0011100; @(posedge clk); // TOP Player position test BOTTOM objects
    #5 ObjectPosition = 7'b1111111; @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
    #5 ObjectPosition = 7'b0100011; @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
    #5 ObjectPosition = 7'b1111111; @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
    #5 ObjectPosition = 7'b0110011; @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
    #5 ObjectPosition = 7'b1111111; @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
    #5 ObjectPosition = 7'b1110011; @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
    #5 ObjectPosition = 7'b1111111; @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
    #5 ObjectPosition = 7'b1101111; @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
    #5 ObjectPosition = 7'b1111111; @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);

    #5 PlayerPosition = 7'b0011100; @(posedge clk); // TOP Player position test TOP objects
    #5 ObjectPosition = 7'b1111111; @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
    #5 ObjectPosition = 7'b0011100; @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
    #5 ObjectPosition = 7'b1111111; @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
    #5 ObjectPosition = 7'b0011110; @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
    #5 ObjectPosition = 7'b1111111; @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
    #5 ObjectPosition = 7'b1011110; @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
    #5 ObjectPosition = 7'b1111111; @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
    #5 ObjectPosition = 7'b1011111; @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);    
    #5 ObjectPosition = 7'b1111111; @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);

    #5 PlayerPosition = 7'b0100011; @(posedge clk); // BOTTOM Player position test BOTTOM objects
    #5 ObjectPosition = 7'b1111111; @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
    #5 ObjectPosition = 7'b0100011; @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
    #5 ObjectPosition = 7'b1111111; @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
    #5 ObjectPosition = 7'b0110011; @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
    #5 ObjectPosition = 7'b1111111; @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
    #5 ObjectPosition = 7'b1110011; @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
    #5 ObjectPosition = 7'b1111111; @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
    #5 ObjectPosition = 7'b1101111; @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
    #5 ObjectPosition = 7'b1111111; @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);

    #5 PlayerPosition = 7'b0100011; @(posedge clk); // BOTTOM Player position test TOP objects
    #5 ObjectPosition = 7'b1111111; @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
    #5 ObjectPosition = 7'b0011100; @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
    #5 ObjectPosition = 7'b1111111; @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
    #5 ObjectPosition = 7'b0011110; @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
    #5 ObjectPosition = 7'b1111111; @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
    #5 ObjectPosition = 7'b1011110; @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
    #5 ObjectPosition = 7'b1111111; @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
    #5 ObjectPosition = 7'b1011111; @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);    
    #5 ObjectPosition = 7'b1111111; @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);



  end
endmodule
