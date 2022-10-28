// Author: Matthew Andersen 2071
// testbench_LED_Animator
// This tests the LED Animator

`timescale 1 ns/ 100 ps
module testbench_LED_Animator();

  reg [9:0] FuelGaugeIn;
  reg [2:0] DispMode;
  reg NewPersonalBest, NewGlobalBest, clk, rst;
  wire [9:0] LEDDispOut;

  LED_Animator  DUT_LED_Animator(FuelGaugeIn, DispMode, NewPersonalBest, NewGlobalBest, LEDDispOut, clk, rst);

  always begin
    clk = 1'b0; #10;
    clk = 1'b1; #10;
  end
  
  initial begin
    FuelGaugeIn = 10'b1110000000;
    DispMode = 3'b000;
    NewPersonalBest = 1'b0;
    NewGlobalBest = 1'b0;
    rst = 1'b1;
    @(posedge clk);@(posedge clk);@(posedge clk);
    #5 rst = 1'b0;  // initial reset
    @(posedge clk);@(posedge clk);@(posedge clk);
    #5 rst = 1'b1; @(posedge clk);
    @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
    #5 NewPersonalBest = 1'b1; @(posedge clk); #5 NewPersonalBest = 1'b0; @(posedge clk);
    @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
    @(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
   
  end
endmodule


