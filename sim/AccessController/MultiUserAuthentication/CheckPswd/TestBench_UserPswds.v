/*
Course Number: 5440
Author: Gantabya Kadel, 8522
Module Name: TestBench_UserPswds
Description: Test Bench Module created to test UserPswds module via simulation.
 Comments: For Simulation only
*/
`timescale 1 ns/100 ps
module TestBench_UserPswds();

// CheckPswd(Clk, Reset, EnterPswd, BeginCheck, InputSwitches, LogOutPulse, InternalID, Authenticated)
	reg Clk, Reset, Btn, Begin, LogOutPulse;
	reg [4:0] Internal_ID;
	reg [3:0] Input;
	reg [5:0] i;
	wire Verified;

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
	CheckPswd CheckPswd_DUT(Clk, Reset, Btn, Begin, Input, LogOutPulse, Internal_ID, Verified);
	initial
		begin
		Reset = 1'b0;
		Btn = 1'b0;
		Begin = 1'b0;
		Input = 4'b0000;
		i     = 6'b000000; // This is very adhock so we see for loop in the middle while elswhere there is just hard input of @(posedge Clk)
// Wrong ID Right Password condition below ....
		Internal_ID = 5'b00001;
		LogOutPulse = 1'b0;
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
		#5 Reset = 1'b1;
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		#5 Input = 4'b1010;  // A 
		@(posedge Clk);
		@(posedge Clk);		
		#5 Btn = 1'b1;
		@(posedge Clk);
		#5 Btn = 1'b0;
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		#5 Begin = 1'b1;
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
 //password: A54E32
		#5 Input = 4'b1010;  // A 
		@(posedge Clk);
		@(posedge Clk);		
		#5 Btn = 1'b1;
		@(posedge Clk);
		#5 Btn = 1'b0;
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);            
		#5 Input = 4'b0101; // 5
		@(posedge Clk);
		@(posedge Clk);
		#5 Btn = 1'b1;
		@(posedge Clk);
		#5 Btn = 1'b0;
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		#5 Input = 4'b0100; // 4
		@(posedge Clk);
		@(posedge Clk);
		#5 Btn = 1'b1;
		@(posedge Clk);
		#5 Btn = 1'b0;
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		#5 Input = 4'b1110; // E
		@(posedge Clk);
		@(posedge Clk);
		#5 Btn = 1'b1;
		@(posedge Clk);
		#5 Btn = 1'b0;
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		#5 Input = 4'b0011; // 3
		@(posedge Clk);
		@(posedge Clk);
		#5 Btn = 1'b1;
		@(posedge Clk);
		#5 Btn = 1'b0;
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		#5 Input = 4'b0010; // 2
		@(posedge Clk);
		@(posedge Clk);
		#5 Btn = 1'b1;
		@(posedge Clk);
		#5 Btn = 1'b0;
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
// Right ID Wrong Password Condition below .... 
		for(i = 6'b000000; i < 6'b101010; i = i + 1) // Might need 42 wait cycles.
			begin
				@(posedge Clk);
			end
		#5 Internal_ID = 5'b00000;
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
 // wrong password for ID = 00000 --> A54E33
		#5 Input = 4'b1010;  // A 
		@(posedge Clk);
		@(posedge Clk);		
		#5 Btn = 1'b1;
		@(posedge Clk);
		#5 Btn = 1'b0;
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);            
		#5 Input = 4'b0101; // 5
		@(posedge Clk);
		@(posedge Clk);
		#5 Btn = 1'b1;
		@(posedge Clk);
		#5 Btn = 1'b0;
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		#5 Input = 4'b0100; // 4
		@(posedge Clk);
		@(posedge Clk);
		#5 Btn = 1'b1;
		@(posedge Clk);
		#5 Btn = 1'b0;
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		#5 Input = 4'b1110; // E
		@(posedge Clk);
		@(posedge Clk);
		#5 Btn = 1'b1;
		@(posedge Clk);
		#5 Btn = 1'b0;
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		#5 Input = 4'b0011; // 3
		@(posedge Clk);
		@(posedge Clk);
		#5 Btn = 1'b1;
		@(posedge Clk);
		#5 Btn = 1'b0;
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		#5 Input = 4'b0011; // 3
		@(posedge Clk);
		@(posedge Clk);
		#5 Btn = 1'b1;
		@(posedge Clk);
		#5 Btn = 1'b0;
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);	
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		for(i = 6'b000000; i < 6'b101010; i = i + 1) // Might need 42 wait cycles.
			begin
				@(posedge Clk);
			end
		#5 Internal_ID = 5'b00000;
// Right ID Right Password Condition below ... 
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		#5 Begin = 1'b1;
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
 //password: A54E32
		#5 Input = 4'b1010;  // A 
		@(posedge Clk);
		@(posedge Clk);		
		#5 Btn = 1'b1;
		@(posedge Clk);
		#5 Btn = 1'b0;
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);            
		#5 Input = 4'b0101; // 5
		@(posedge Clk);
		@(posedge Clk);
		#5 Btn = 1'b1;
		@(posedge Clk);
		#5 Btn = 1'b0;
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		#5 Input = 4'b0100; // 4
		@(posedge Clk);
		@(posedge Clk);
		#5 Btn = 1'b1;
		@(posedge Clk);
		#5 Btn = 1'b0;
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		#5 Input = 4'b1110; // E
		@(posedge Clk);
		@(posedge Clk);
		#5 Btn = 1'b1;
		@(posedge Clk);
		#5 Btn = 1'b0;
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		#5 Input = 4'b0011; // 3
		@(posedge Clk);
		@(posedge Clk);
		#5 Btn = 1'b1;
		@(posedge Clk);
		#5 Btn = 1'b0;
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		#5 Input = 4'b0010; // 2
		@(posedge Clk);
		@(posedge Clk);
		#5 Btn = 1'b1;
		@(posedge Clk);
		#5 Btn = 1'b0;
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
// Cycles above will mimic logged in time...	
		#5 LogOutPulse = 1'b1;
		@(posedge Clk);
		#5 LogOutPulse = 1'b0;
		@(posedge Clk);
		@(posedge Clk);	
		end
endmodule
