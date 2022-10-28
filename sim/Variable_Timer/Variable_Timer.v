//class: ECE 5440
//author: Christopher Andrew
//Purpose: This module creates a varrible delay in multiples of 100 ms, this delay is determined from the
//			Speed value fead into the modules and a internally set value
//			timeShift - 1 - Speed = time*100 [ms]

module Variable_Timer(Clk, Rst, VarTimerEnable, TimeoutPulse, Speed);
	input Clk, Rst, VarTimerEnable;
	input [3:0] Speed;
	output TimeoutPulse;
	reg TimeoutPulse;
	reg [3:0] count;
	wire timer_out_100ms;
	
	//instance of 1 ms timer
	Timer_100ms Timer_1(Clk, Rst, VarTimerEnable, timer_out_100ms);
	parameter timeShift = 5; //change me to change the time value timeShift + 1 - Speed = time* 100 ms, ex 5 + 1 - 1 = 500 ms 
	//or set timeShift to 15 to be safe and prevent all possibilities of underflow
	always@(posedge Clk)
	begin
		if (Rst == 1'b0) //active low reset
		begin
			count <= 0;
			TimeoutPulse <= 1'b0;
		end
		else
		begin
			if(VarTimerEnable == 0)
			begin
				count <= 0;
				TimeoutPulse <= 0;
			end
			else if (timer_out_100ms == 1'b1)
			begin
				if(count >= (timeShift - Speed)) //remove timeshift and subtraction for timer to count up to the time out
				begin
					count <= 0;
					TimeoutPulse <= 1'b1;
				end
				else
				begin
					count <= count + 1'b1;
					TimeoutPulse <= 1'b0;
				end
			end
			else
			begin
				TimeoutPulse <= 1'b0; //set to 0 in case time out goes high when enable turns off
			end
		end
		
		
	end
endmodule