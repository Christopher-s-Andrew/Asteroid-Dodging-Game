// ECE 5440
// Author: Nhat Nguyen
// Module: Timer1msLFSR

// about module:
    // this module utilizes an XOR many-to-one LFSR setup
	// the shift register length is 16
	// the size is 2^n - 1
	// the sequence will count down and begin at FFFF
	
	// 50000th timeout value is found to be 16'b0100001011001110

module Timer1msLFSR(enable, timeoutPulse, clk, rst); // LFSR16_8016
  input clk, rst, enable;
  output timeoutPulse;

  reg timeoutPulse;
  reg [15:0] LFSR;

  always @(posedge clk) begin
    if (rst == 1'b0) begin
	  timeoutPulse <= 1'b0;
	  LFSR <= 16'b1111111111111111; // reset state back to 0th index
	end else begin
	  timeoutPulse <= 1'b0;
	  if (LFSR == 16'b0100001011001110) begin
	    timeoutPulse <= 1'b1;
		LFSR <= 16'b1111111111111111; // reset state back to 0th index
	  end else if (enable == 1'b1) begin
        LFSR[0] <= LFSR[1] ^ LFSR[2] ^ LFSR[4] ^ LFSR[15];
        LFSR[15:1] <= LFSR[14:0];
	  end
	end
  end
  
endmodule

