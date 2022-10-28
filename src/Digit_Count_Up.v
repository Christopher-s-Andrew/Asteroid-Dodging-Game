
//Course: ECE 5440
//Author: Christopher Andrew
//Module Name: Digit_Count_Up
//Description: A module to count up in base 10, can be chained with other modules to count more digits

module Digit_Count_Up(clock, reset, count_Up, carry, digit, reconfig);
	input clock, reset, count_Up, reconfig;
	
	output carry;
	output [3:0] digit;
	
	reg carry;
	reg [3:0] digit;

	always@(posedge clock)
	begin
		if ((reset == 1'b0) || (reconfig == 1'b1))
		begin
			carry <= 1'b0;
			digit <= 4'b0000;
		end
		else
		begin
			if(count_Up == 1'b1)
			begin
				if(digit ==  9)//  roll over point
				begin
					digit <= 0;
					carry  <= 1'b1;
				end
				else
				begin
					digit <= digit + 1'b1;
				end
			end
			else
			begin
				carry <= 1'b0;
			end
		end
	end
endmodule