//ECE 5440
//Author: Christopher Andrew
//Module name: Decoder_7SegAnode
//Description: This moduel takes in a 4 bit number and decodes it into a form such that it can be displayed using a common anode 7 segment display

//display format
//0123456
// 0 
//5 1
// 6 
//4 2
// 3 

module Decoder_7SegAnode(dataIn4, seg7Out);
	input [3:0] dataIn4; //4 bit data input
	output [6:0]  seg7Out; //common anode output
	reg [6:0] seg7Out;  //keep output

	always@(dataIn4)
	begin
		case(dataIn4)
			4'b0000: begin seg7Out = 7'b100_0000; end //0
			4'b0001: begin seg7Out = 7'b111_1001; end //1
			4'b0010: begin seg7Out = 7'b010_0100; end //2
			4'b0011: begin seg7Out = 7'b011_0000; end //3	
			4'b0100: begin seg7Out = 7'b001_1001; end //4
			4'b0101: begin seg7Out = 7'b001_0010; end //5
			4'b0110: begin seg7Out = 7'b000_0010; end //6	
			4'b0111: begin seg7Out = 7'b111_1000; end //7
			4'b1000: begin seg7Out = 7'b000_0000; end //8
			4'b1001: begin seg7Out = 7'b001_1000; end //9
			4'b1010: begin seg7Out = 7'b000_1000; end //a
			4'b1011: begin seg7Out = 7'b000_0011; end //b
			4'b1100: begin seg7Out = 7'b100_0110; end //c
			4'b1101: begin seg7Out = 7'b010_0001; end //d
			4'b1110: begin seg7Out = 7'b000_0110; end //e
			4'b1111: begin seg7Out = 7'b000_1110; end //f
			default: begin seg7Out = 7'b100_0000; end //defualt to 0
		endcase
	end
endmodule