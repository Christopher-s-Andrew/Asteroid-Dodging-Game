module Nhat_LEDTimeTracker(enable, timeout, timeOutput, startTime, clk, rst);
	input enable;
	input[3:0] startTime;
	
	input clk, rst;
	
	output timeout;
	output[3:0] timeOutput;
	
	reg[3:0] counterToRemovePoint;
	reg[3:0] timeOutput;
	reg timeout;
	
	wire timeout1SecPulse;
	OneSecondTimer OneSecModule(enable, timeout1SecPulse, clk, rst);
	
	always @(posedge clk) begin
		if (rst == 1'b0) begin
			counterToRemovePoint <= 4'b0000;
			timeOutput <= 4'b0000;
			timeout <= 1'b0;
		end else begin
			if (enable == 1'b0) begin // tracker NOT enabled
				counterToRemovePoint <= 4'b0000;
				
				if (startTime == 4'b0000) begin
					timeOutput <= 4'b1010;
				end else begin
					timeOutput <= startTime;
				end
				
				timeout <= 1'b0;
			end else begin // tracker is enabled
				if (timeOutput == 4'b0000) begin
					counterToRemovePoint <= 4'b0000;
					timeout <= 1'b1;
				end else begin
					timeout <= 1'b0;
					
					if (timeout1SecPulse == 1'b1) begin
						counterToRemovePoint <= counterToRemovePoint + 4'b0001;
					end
					
					if (counterToRemovePoint == 4'b0101) begin
						counterToRemovePoint <= 4'b0000;
						timeOutput <= timeOutput - 4'b0001;
					end
				end
			end
		end
	end
endmodule
