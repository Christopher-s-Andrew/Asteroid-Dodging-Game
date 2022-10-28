//Author: Christopher Andrew
//Course: ECE 5440
//Purpose: The purpose of this module is to test the Score_Tracker/RAM Combo unit
`timescale 1 ns/100 ps;
module testBench_Score_Tracker();
	
	
	//system input
	reg clock_S, reset_S, score_Request_S; //control inputs
	reg [7:0] score_S;
	reg [4:0] PID_S;
	//RAM interface signals
	wire [7:0] score_Read_I; //the score read from RAM
	wire [4:0] address_I; //RAM location
	wire [7:0] score_Write_I; //data to write to RAM
	wire R_W_I; //read = 0, write = 1
	
	//signals that leave the module
	wire valid_E; //has the score module finished and if it is safe to reset score count
	wire new_PB_E; // a new personal best was found
	wire new_GB_E; //a new global best was found
	wire [7:0] final_Score_E; //the final score as of the score request
	wire [7:0] global_Best_E; //the best score
	wire [4:0] global_Best_ID_E; //ID of the best score
	wire [7:0] personal_best_E; //the current best score of the user after valid goes high
	//module instances
	Score_RAM RAM_DUT(address_I, clock_S, score_Write_I, R_W_I, score_Read_I);
	Score_Tracker tracker_DUT(clock_S, reset_S, score_Request_S, PID_S, score_S, valid_E, new_PB_E, new_GB_E, 
	address_I, score_Write_I, R_W_I, score_Read_I, global_Best_E, global_Best_ID_E, personal_best_E, final_Score_E);
	
	//clock_S generation
	always
	begin
		clock_S = 1'b0;
		#10;
		clock_S = 1'b1;
		#10;
	end


	//test case start
	initial
	begin
		reset_S = 0;
		score_Request_S = 0;
		score_S = 0;
		PID_S = 0;
		
		//reset testing
		@(posedge clock_S);
		#5 reset_S = 0;
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		#5 reset_S = 1;
		
		//wait for RAM instanciation to complete
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		
		//supply a score and ID
		#5 PID_S = 0;
		@(posedge clock_S);
		#5 score_S = 1;
		@(posedge clock_S);
		#5 score_Request_S = 1;
		@(posedge clock_S);
		#5 score_Request_S = 0;
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		
		//submit a new score request for a different player and check if global updates right
		#5 PID_S = 1;
		@(posedge clock_S);
		#5 score_S = 9;
		@(posedge clock_S);
		#5 score_Request_S = 1;
		@(posedge clock_S);
		#5 score_Request_S = 0;
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		
		//submit a score request to player 1 to check if PB updates correctly
		#5 PID_S = 0;
		@(posedge clock_S);
		#5 score_S = 5;
		@(posedge clock_S);
		#5 score_Request_S = 1;
		@(posedge clock_S);
		#5 score_Request_S = 0;
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		@(posedge clock_S);
		
	end
endmodule