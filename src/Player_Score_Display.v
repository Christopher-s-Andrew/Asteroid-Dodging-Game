//Author: Christopher Andrew
//Course: ECE 5440
//Purpose: The purpose of this module is to format the players score for display along with the word SCOr

module Player_Score_Display(final_Score, pScore);
	input [7:0] final_Score; //the final score when the score system finalizes it 
	
	output [41:0] pScore; //output in form SCOr##
	
	//internal wires for splitting score bus
	reg [41:14] text_Display;
	//decoder instances
	Decoder_7SegAnode digit0(final_Score[3:0], pScore[6:0]);
	Decoder_7SegAnode digit1(final_Score[7:4], pScore[13:7]);
	
	//assign
	assign pScore [41:14] = text_Display;
	always@(final_Score)
	begin
		text_Display[41:35] = 7'b0010010;
		text_Display[34:28] = 7'b1000110;
		text_Display[27:21] = 7'b1000000;
		text_Display[20:14] = 7'b0101111;
	end
endmodule