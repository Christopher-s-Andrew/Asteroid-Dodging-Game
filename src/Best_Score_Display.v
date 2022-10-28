//Author: Christopher Andrew
//Course: ECE 5440
//Purpose: Formats the best score into the proper form

module Best_Score_Display(global_Best, global_Best_ID, pB, PID, bScore);
	
	input [7:0] global_Best, pB;
	input [4:0] global_Best_ID, PID;
	
	output [41:0] bScore;
	
	//decoder instances
	Decoder_7SegAnode player_ID(PID[3:0], bScore[41:35]); //hex5
	Decoder_7SegAnode pB_D1(pB[7:4], bScore[34:28]); //hex4
	Decoder_7SegAnode pB_D0(pB[3:0], bScore[27:21]); //hex3
	Decoder_7SegAnode best_ID(global_Best_ID[3:0], bScore[20:14]); //hex2
	Decoder_7SegAnode gB_D1(global_Best[7:4], bScore[13:7]); //hex1
	Decoder_7SegAnode gB_D0(global_Best[3:0], bScore[6:0]); //hex0
endmodule