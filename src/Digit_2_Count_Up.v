//Course: ECE 5440
//Author: Christopher Andrew
//Module Name: Digit_2_Count_Up
//Description: A module to count up with 2 digits in base 10

module Digit_2_Count_Up(clock, reset, count_Up, reconfig, count);
	input clock, reset, count_Up, reconfig;
	
	output [7:0] count;
	wire carry;
	
	Digit_Count_Up digit_Count_0(clock, reset, count_Up, carry, count[3:0], reconfig);
	Digit_Count_Up digit_Count_1(clock, reset, carry, , count[7:4], reconfig);
	
endmodule