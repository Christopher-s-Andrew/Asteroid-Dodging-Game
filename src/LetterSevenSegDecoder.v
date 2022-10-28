/*
Course Number: 5440
Author: Gantabya Kadel, 8522
Module Name: LetterSevenSegDecoder
Description: Custom Letter Seven Segment Decoder Module. Module created for Team Q4's Advanced Digital Design Final Project.
	     A-Z letters covered. Exculed Letters are K, M, V, W, X, Z
	     Also includes number symbols 1 - 9
 Comments: Made to display letter for User Authentication
*/
module LetterSevenSegDecoder(DecoderInput, DecoderOutput);
	input[4:0] DecoderInput;
	output[6:0] DecoderOutput;
	reg[6:0] DecoderOutput;

	always@(DecoderInput)
		begin
			case(DecoderInput)
				5'b00000: begin DecoderOutput = 7'b1111111; end // Blank
				5'b00001: begin DecoderOutput = 7'b0001000; end // A
				5'b00010: begin DecoderOutput = 7'b0000011; end // b
				5'b00011: begin DecoderOutput = 7'b1000110; end // c
				5'b00100: begin DecoderOutput = 7'b0100001; end // d
				5'b00101: begin DecoderOutput = 7'b0000110; end // e
				5'b00110: begin DecoderOutput = 7'b0001110; end // f
				5'b00111: begin DecoderOutput = 7'b0010000; end // g
				5'b01000: begin DecoderOutput = 7'b0001001; end // H
				5'b01001: begin DecoderOutput = 7'b1111001; end // i
				5'b01010: begin DecoderOutput = 7'b1110000; end // j
				5'b01011: begin DecoderOutput = 7'b1000111; end // l
				5'b01100: begin DecoderOutput = 7'b1001000; end // n
				5'b01101: begin DecoderOutput = 7'b1000000; end // o
				5'b01110: begin DecoderOutput = 7'b0001100; end // p
				5'b01111: begin DecoderOutput = 7'b0011000; end // q
				5'b10000: begin DecoderOutput = 7'b0101111; end // r
				5'b10001: begin DecoderOutput = 7'b0010010; end // s
				5'b10010: begin DecoderOutput = 7'b0000111; end // t
				5'b10011: begin DecoderOutput = 7'b1000001; end // u
				5'b10100: begin DecoderOutput = 7'b0011001; end // y
			// Number symbols below
				5'b10101: begin DecoderOutput = 7'b1111001; end //1
				5'b10110: begin DecoderOutput = 7'b0100100; end //2
				5'b10111: begin DecoderOutput = 7'b0110000; end //3
				5'b11000: begin DecoderOutput = 7'b0011001; end //4
				5'b11001: begin DecoderOutput = 7'b0010010; end //5
				5'b11010: begin DecoderOutput = 7'b0000010; end //6
				5'b11011: begin DecoderOutput = 7'b1111000; end //7
				5'b11100: begin DecoderOutput = 7'b0000000; end //8
				5'b11101: begin DecoderOutput = 7'b0011000; end //9
				default: begin DecoderOutput = 7'b1111111;  end //blank
			endcase
		end
endmodule