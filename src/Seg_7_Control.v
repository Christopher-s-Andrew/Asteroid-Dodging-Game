//Author: Christopher Andrew
//Course: ECE 5440
//Purpose: The purpose of this modules is to control who has access to the 6 7 segment displays

module Seg_7_Control(mode, hex5, hex4, hex3, hex2, hex1, hex0, inputSet1, inputSet2, inputSet3, inputSet4, inputSet5, inputSet6, inputSet7, inputSet8);
	input [2:0] mode; //input set selector
	input [41:0] inputSet1, inputSet2, inputSet3, inputSet4, inputSet5, inputSet6, inputSet7, inputSet8; //the set of bunddeled 7 seg inputs
	
	output [6:0] hex5, hex4, hex3, hex2, hex1, hex0; //7 segment driver pins
	reg [6:0]  hex5, hex4, hex3, hex2, hex1, hex0;
	
	always@(mode, inputSet1, inputSet2, inputSet3, inputSet4, inputSet5, inputSet6, inputSet7, inputSet8)
	begin
		case(mode)
			0:
			begin
				hex5 = inputSet1[41:35];
				hex4 = inputSet1[34:28];
				hex3 = inputSet1[27:21];
				hex2 = inputSet1[20:14];
				hex1 =inputSet1[13:7];
				hex0 =inputSet1[6:0];
			end
			1:
			begin
				hex5 = inputSet2[41:35];
				hex4 = inputSet2[34:28];
				hex3 = inputSet2[27:21];
				hex2 = inputSet2[20:14];
				hex1 = inputSet2[13:7];
				hex0 = inputSet2[6:0];
			end
			2:
			begin
				hex5 = inputSet3[41:35];
				hex4 = inputSet3[34:28];
				hex3 = inputSet3[27:21];
				hex2 = inputSet3[20:14];
				hex1 =inputSet3[13:7];
				hex0 = inputSet3[6:0];
			end
			3:
			begin
				hex5 = inputSet4[41:35];
				hex4 = inputSet4[34:28];
				hex3 = inputSet4[27:21];
				hex2 = inputSet4[20:14];
				hex1 = inputSet4[13:7];
				hex0 = inputSet4[6:0];
			end
			4:
			begin
				hex5 = inputSet5[41:35];
				hex4 = inputSet5[34:28];
				hex3 = inputSet5[27:21];
				hex2 = inputSet5[20:14];
				hex1 = inputSet5[13:7];
				hex0 = inputSet5[6:0];
			end
			5:
			begin
				hex5 = inputSet6[41:35];
				hex4 = inputSet6[34:28];
				hex3 = inputSet6[27:21];
				hex2 = inputSet6[20:14];
				hex1 = inputSet6[13:7];
				hex0 = inputSet6[6:0];
			end
			6:
			begin
				hex5 = inputSet7[41:35];
				hex4 = inputSet7[34:28];
				hex3 = inputSet7[27:21];
				hex2 = inputSet7[20:14];
				hex1 = inputSet7[13:7];
				hex0 = inputSet7[6:0];
			end
			7:
			begin
				hex5 = inputSet8[41:35];
				hex4 = inputSet8[34:28];
				hex3 = inputSet8[27:21];
				hex2 = inputSet8[20:14];
				hex1 = inputSet8[13:7];
				hex0 = inputSet8[6:0];
			end
			default:
			begin
				hex5 = 7'b1111111;
				hex4 = 7'b1111111;
				hex3 = 7'b1111111;
				hex2 = 7'b1111111;
				hex1 = 7'b1111111;
				hex0 = 7'b1111111;
			end
		endcase
	end

endmodule