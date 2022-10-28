/*
Course Number: 5440
Author: Gantabya Kadel, 8522
Module Name: TestBench_CheckID
Description: Test Bench module created to test CheckID module via simulation.
Comments: Used for simulation.
*/
`timescale 1 ns/100 ps
module TestBench_CheckID();
// CheckID(Clk, Reset, InputSwitches, EnterPswd, LogOutPulse, IDOK, InternalID)
	reg Clk, Rst, Pswd_Btn, LogOutPulse;
	reg [3:0] Input;
	reg [4:0] i;
	wire IDOK;
	wire [4:0] ID;
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
	CheckID CheckID_DUT(Clk, Rst, Input, Pswd_Btn, LogOutPulse, IDOK, ID);
	initial
		begin
			Input = 4'b0000;
			i = 4'b00000; // 100 in 7 bits is 1100100 ... later changed to 5 bits and now requires 27 ==> 5'b11011
			Rst = 1'b0;
			Pswd_Btn = 1'b0;
			LogOutPulse = 1'b0;
			@(posedge Clk);
			@(posedge Clk);
			@(posedge Clk);
			@(posedge Clk);
			@(posedge Clk);
			@(posedge Clk);
			@(posedge Clk);
			#5 Rst = 1'b1;
			@(posedge Clk);
			@(posedge Clk);
			@(posedge Clk);
			#5 Input = 4'b1000; // 8
			@(posedge Clk);
			@(posedge Clk);
			#5 Pswd_Btn = 1'b1;
			@(posedge Clk);
			#5 Pswd_Btn = 1'b0;
			@(posedge Clk);
			@(posedge Clk);
			@(posedge Clk);
			#5 Input = 4'b0101; // 5
			@(posedge Clk);
			@(posedge Clk);
			#5 Pswd_Btn = 1'b1;
			@(posedge Clk);
			#5 Pswd_Btn = 1'b0;
			@(posedge Clk);
			@(posedge Clk);
			@(posedge Clk);
			#5 Input = 6'b0010; // 2
			#5 Pswd_Btn = 1'b1;
			@(posedge Clk);
			#5 Pswd_Btn = 1'b0;
			@(posedge Clk);
			@(posedge Clk);
			@(posedge Clk);
			#5 Input = 6'b0011; // 3
			@(posedge Clk);
			@(posedge Clk);
			#5 Pswd_Btn = 1'b1;
			@(posedge Clk);
			#5 Pswd_Btn = 1'b0;
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
// Trying again with right UserID
			for(i = 5'b00000; i < 5'b11011; i = i + 1) // From testing looks like only 27 cycles need in this loop to revert back to address 00000
				begin
					@(posedge Clk);
				end
			@(posedge Clk);
			#5 Input = 4'b1000; // 8
			@(posedge Clk);
			@(posedge Clk);
			#5 Pswd_Btn = 1'b1;
			@(posedge Clk);
			#5 Pswd_Btn = 1'b0;
			@(posedge Clk);
			@(posedge Clk);
			@(posedge Clk);
			#5 Input = 4'b0101; // 5
			@(posedge Clk);
			@(posedge Clk);
			#5 Pswd_Btn = 1'b1;
			@(posedge Clk);
			#5 Pswd_Btn = 1'b0;
			@(posedge Clk);
			@(posedge Clk);
			@(posedge Clk);
			#5 Input = 6'b0010; // 2
			#5 Pswd_Btn = 1'b1;
			@(posedge Clk);
			#5 Pswd_Btn = 1'b0;
			@(posedge Clk);
			@(posedge Clk);
			@(posedge Clk);
			#5 Input = 6'b0010; // 2
			@(posedge Clk);
			@(posedge Clk);
			#5 Pswd_Btn = 1'b1;
			@(posedge Clk);
			#5 Pswd_Btn = 1'b0;
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
// Hopefully it's enough cycles to take into account delays and ofcourse IDOK signal.
			#5 LogOutPulse = 1'b1;
			@(posedge Clk);
			#5 LogOutPulse = 1'b0;
			@(posedge Clk);
			@(posedge Clk);
			@(posedge Clk);
			@(posedge Clk);
		end
endmodule
