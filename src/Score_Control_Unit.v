//Author: Christopher Andrew
//Course: ECE 5440
//Purpose: The purpose of this module is to control the score tacking of each player
//			personal best for each player
//			the final score they earned that game
//			the global best score earned
//			who earned the best score
//			no functional parts, just assemble sub modules

module Score_Control_Unit(Clk, Rst, score_Up_Pulse, reconfig, PID, score_Request_Pulse,
	score_Request_Complate_Pulse, new_PB_Pulse, new_GB_Pulse, pScore, bScore);
	
	//module inputs
	input score_Up_Pulse; //increments the score by 1
	input reconfig; //resets the current players score to 0
	input [4:0] PID; //the number of the player playing the game
	input score_Request_Pulse; //requests the module to update the PB, GB, and final of the player
	input Clk; //synch signal
	input Rst; //active low reset signal
	
	//module outputs
	output score_Request_Complate_Pulse; //signals other modules that scoring is complete
	output new_PB_Pulse; //signals other modules that a new personal best has been found
	output new_GB_Pulse; //signals other modules that a new global best has been found
	output [41:0] pScore; //player score display screen
	output [41:0] bScore; //global best/personal best display screen
	
	//internal wires
	wire [7:0] personal_Best_Score, global_Best_Score, buffer_Score, score, score_Write, score_Read;
	wire [4:0] global_Best_ID, address;
	wire R_W;
	//module instances
	Best_Score_Display best_Display(global_Best_Score, global_Best_ID, personal_Best_Score, PID, bScore);
	Player_Score_Display pScore_Display(buffer_Score, pScore);
	
	//score tracking/comparison control
	Score_Tracker score_Unit(Clk, Rst, score_Request_Pulse, PID, score, score_Request_Complate_Pulse, new_PB_Pulse, new_GB_Pulse, 
		address, score_Write, R_W, score_Read, global_Best_Score, global_Best_ID, personal_Best_Score, buffer_Score);

	//personal best storage
	Score_RAM RAM(address, Clk, score_Write, R_W, score_Read);
	
	//score keeping
	Digit_2_Count_Up score_Keeper(Clk, Rst, score_Up_Pulse, reconfig, score);
endmodule