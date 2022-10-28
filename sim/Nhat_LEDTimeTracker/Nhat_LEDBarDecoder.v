module Nhat_LEDBarDecoder(hexInput, decoderOut);
	input[3:0] hexInput;
	output[9:0] decoderOut;
	reg[9:0] decoderOut;
	
	always @(hexInput) begin
		case (hexInput)
			4'b0000: begin decoderOut = 10'b0000000000; end
			4'b0001: begin decoderOut = 10'b1000000000; end
			4'b0010: begin decoderOut = 10'b1100000000; end
			4'b0011: begin decoderOut = 10'b1110000000; end
			4'b0100: begin decoderOut = 10'b1111000000; end
			4'b0101: begin decoderOut = 10'b1111100000; end
			4'b0110: begin decoderOut = 10'b1111110000; end
			4'b0111: begin decoderOut = 10'b1111111000; end
			4'b1000: begin decoderOut = 10'b1111111100; end
			4'b1001: begin decoderOut = 10'b1111111110; end
			4'b1010: begin decoderOut = 10'b1111111111; end
			
			default: begin decoderOut = 10'b1111111111; end
		endcase
	end
endmodule
