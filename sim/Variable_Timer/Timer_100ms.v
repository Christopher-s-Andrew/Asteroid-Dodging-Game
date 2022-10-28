//class: ECE 5440
//author: Christopher Andrew
//Purpose: this module performas as a 100 ms timer and has a 1 clock  pulse time out. assumes 50 [Mhz] clock

module Timer_100ms(clock, reset, enable, time_Out);
	input clock, reset, enable;
	output time_Out;
	reg time_Out;
	reg [7:0] count;
	
	//instance of 1 ms timer
	Timer_1ms Timer_100(clock, reset, enable, time_Out_1ms);
	
	always@(posedge clock)
	begin
		if (reset == 1'b0) //active low reset
		begin
			count <= 0;
			time_Out <= 1'b0;
		end
		else
		begin
			if (time_Out_1ms == 1'b1)
			begin
				if(count == 2) //count to 100 set to 100 - 1
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