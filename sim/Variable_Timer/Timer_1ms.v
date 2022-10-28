//Course Number: ECE 5440
//Author: Christopher Andrew
//purpose: This modules goal is to create a 1 clock tick pulse every ms from a 50 [MHz] source

module Timer_1ms(clock, reset, enable, time_Out);
	input clock, reset, enable;
	output time_Out;
	reg time_Out;
	reg [15:0] count;
	
	always@(posedge clock)
	begin
		if (reset == 1'b0) //active low reset
		begin
			count <= 0;
			time_Out <= 1'b0;
		end
		else
		begin
			if (enable == 1'b1)
			begin
				if(count == 3) //count to 50,000-1 for real 1 ms
				begin
					count <= 0;
					time_Out <= 1'b1;
				end
				else
				begin
					count <= count + 1;
					time_Out <= 1'b0;
				end
			end
			else
			begin
				time_Out <= 1'b0; //set to 0 in case time out goes high when enable turns off
			end
		end
	end
endmodule