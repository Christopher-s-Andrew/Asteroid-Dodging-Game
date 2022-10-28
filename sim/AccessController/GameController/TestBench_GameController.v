/*
Course Number: 5440
Author: Gantabya Kadel, 8522
Module Name: TestBench_GameController
Description: Test Bench file to test GameController module via simulation
 Comments: Made for Team Q4's Advanced Digital Design Final Project.
*/
`timescale 1 ns/100 ps
module TestBench_GameController();
// GameController(Clk, Reset, Authenticated, GameStartBtn, LogOutBtn, CrashDetected, LEDTrackerTimeOut, OneSecPulse, NewGamePulse, PassedRoundPulse, GameOverPulse, EnableGameElements, Difficulty, LogOutPulse, EnableTimer, Mode)
reg 		Clk, Reset, Authenticated, GameStartBtn, LogOutBtn, CrashDetected, LEDTimeOut, OneSecPulse;
wire		NewGamePulse, PassedRoundPulse, GameOverPulse, EnableGameElements, LogOutPulse, EnableTimer;
wire [1:0]	Difficulty;
wire [2:0]	Mode;

// ------------------------ Clock Gen Block --------------------------------------
	always
		begin
			Clk = 1'b0;
			#10;
			Clk = 1'b1;
			#10;
		end
// --------------------------------------------------------------------------------
// ------------------------- Simulation Block -------------------------------------
GameController GameController_DUT(Clk, Reset, Authenticated, GameStartBtn, LogOutBtn, CrashDetected, LEDTimeOut, OneSecPulse, NewGamePulse, PassedRoundPulse, GameOverPulse, EnableGameElements, Difficulty, LogOutPulse, EnableTimer, Mode);
//
	initial
		begin
		Reset = 	1'b0;
		Authenticated = 1'b0;
		GameStartBtn = 1'b0;
		LogOutBtn = 1'b0;
		LEDTimeOut = 1'b0;
		OneSecPulse = 1'b0;
		CrashDetected = 1'b0;
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
//
		#5 Reset =	1'b1;
		@(posedge Clk);
		@(posedge Clk);
		#5 Authenticated = 1'b1;
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		#5 GameStartBtn = 1'b1;
		@(posedge Clk);
		#5 GameStartBtn = 1'b0;
// 5 Seconds ... simulate
		@(posedge Clk);
// 1
		OneSecPulse = 1'b1;
		@(posedge Clk);
		OneSecPulse = 1'b0;
// 2 
		@(posedge Clk);
		OneSecPulse = 1'b1;
		@(posedge Clk);
		OneSecPulse = 1'b0;
		@(posedge Clk);
// 3
		OneSecPulse = 1'b1;
		@(posedge Clk);
		OneSecPulse = 1'b0;
		@(posedge Clk);
// 4
		OneSecPulse = 1'b1;
		@(posedge Clk);
		OneSecPulse = 1'b0;
// 5
		@(posedge Clk);
		OneSecPulse = 1'b1;
		@(posedge Clk);
		OneSecPulse = 1'b0;
// 
		@(posedge Clk);
		#5 GameStartBtn = 1'b1;
		@(posedge Clk);
		#5 GameStartBtn = 1'b0;
// Gameplay cycles
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);

// 	
		#5 LEDTimeOut = 1'b1;
		@(posedge Clk);
		#5 LEDTimeOut = 1'b0;
		@(posedge Clk);
// 5 seconds 
// 1
		OneSecPulse = 1'b1;
		@(posedge Clk);
		OneSecPulse = 1'b0;
// 2 
		@(posedge Clk);
		OneSecPulse = 1'b1;
		@(posedge Clk);
		OneSecPulse = 1'b0;
		@(posedge Clk);
// 3
		OneSecPulse = 1'b1;
		@(posedge Clk);
		OneSecPulse = 1'b0;
		@(posedge Clk);
// 4
		OneSecPulse = 1'b1;
		@(posedge Clk);
		OneSecPulse = 1'b0;
// 5
		@(posedge Clk);
		OneSecPulse = 1'b1;
		@(posedge Clk);
		OneSecPulse = 1'b0;
// 
// Play Game Again
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		#5 GameStartBtn = 1'b1;
		@(posedge Clk);
		#5 GameStartBtn = 1'b0;
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		#5 CrashDetected = 1'b1;
		@(posedge Clk);
		#5 CrashDetected = 1'b0;
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		#5 LogOutBtn = 1'b1;
		@(posedge Clk);
		#5 LogOutBtn = 1'b0;
		#5 Authenticated = 1'b0; // Have to manually pull the signal low for simulaiton purposes. .. would be "immediate" in the real fpga.
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
	end
endmodule