// Author: Matthew Andersen 2071
// testbench_PlayerPosition
// This tests the PlayerPosition module with shaped button input.
`timescale 1 ns/ 100 ps
module testbench_PlayerPosition();
  reg PlayerToggle, clk, rst;
  wire [6:0] PlayerPosition;


PlayerPosition DUT_PlayerPosition(PlayerToggle, PlayerPosition, clk, rst);

  always begin
    clk = 1'b0; #10;
    clk = 1'b1; #10;
  end
  
  initial begin
    PlayerToggle = 1'b0;
    rst = 1'b1;
    @(posedge clk);@(posedge clk);@(posedge clk);
    #5 rst = 1'b0;  // initial reset
    @(posedge clk);@(posedge clk);@(posedge clk);
    #5 rst = 1'b1; @(posedge clk); //Player should be in top position
    @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
    #5 PlayerToggle = 1'b1; @(posedge clk); #5 PlayerToggle = 1'b0; @(posedge clk);
    @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
    @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
    #5 PlayerToggle = 1'b1; @(posedge clk); #5 PlayerToggle = 1'b0; @(posedge clk);
    @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
    @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
    #5 PlayerToggle = 1'b1; @(posedge clk); #5 PlayerToggle = 1'b0; @(posedge clk);
    @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
    @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
    #5 PlayerToggle = 1'b1; @(posedge clk); #5 PlayerToggle = 1'b0; @(posedge clk);
    @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
    @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
    #5 PlayerToggle = 1'b1; @(posedge clk); #5 PlayerToggle = 1'b0; @(posedge clk);
    @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
    @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
    #5 PlayerToggle = 1'b1; @(posedge clk); #5 PlayerToggle = 1'b0; @(posedge clk);
    @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
    @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
    #5 PlayerToggle = 1'b1; @(posedge clk); #5 PlayerToggle = 1'b0; @(posedge clk);
    @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
    @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
    #5 PlayerToggle = 1'b1; @(posedge clk); #5 PlayerToggle = 1'b0; @(posedge clk);
    @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
    @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
  end
endmodule


