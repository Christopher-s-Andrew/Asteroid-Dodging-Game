// ECE 5440
// Author: Nhat Nguyen 4700
// Module: Nhat_LEDBarTimer

// about module:
    // this module controls LEDs 0-9 and treats them
	// as a "progress bar"
	
module Nhat_LEDBarTimer(startTime, enable, timeout, decoderOut, clk, rst);
	input[3:0] startTime;
	input enable;
	
	input clk, rst;
	
	output timeout;
	output[9:0] decoderOut;
	
	wire[3:0] timeOutput;
	
	Nhat_LEDTimeTracker LEDTimer(enable, timeout, timeOutput, startTime, clk, rst);
	Nhat_LEDBarDecoder Decoder(timeOutput, decoderOut);
endmodule