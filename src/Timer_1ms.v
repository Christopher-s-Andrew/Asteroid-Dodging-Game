//Course Number: ECE 5440
//Author: Christopher Andrew
//purpose: This modules goal is to create a 1 clock tick pulse every ms from a 50 [MHz] source
// Uses a LFSR based implimentation of previous 1 ms timer
module Timer_1ms(clock, reset, enable, time_Out);
	input clock, reset, enable;
	output time_Out;

	reg [15:0] LFSR;
	reg time_Out;

	wire feedback = LFSR[15];

	always @(posedge clock)
	begin
	if (reset == 1'b0)
	begin
		LFSR <= 16'b1111_1111_1111_1111;
		time_Out <= 0;
	end
	else
	begin
		if ( enable == 1'b1)
		begin
			if(LFSR == 16'b0110_1101_1011_0110) //time out here, magic numbers are !FUN!
			begin
				LFSR <= 16'b1111_1111_1111_1111;
				time_Out <= 1'b1;
			end
			else
			begin
				//LFSR Counting here
				LFSR[0] <= feedback;
				LFSR[1] <= LFSR[0];
				LFSR[2] <= LFSR[1] ^ feedback;
				LFSR[3] <= LFSR[2] ^ feedback;
				LFSR[4] <= LFSR[3];
				LFSR[5] <= LFSR[4] ^ feedback;
				LFSR[6] <= LFSR[5];
				LFSR[7] <= LFSR[6];
				LFSR[8] <= LFSR[7];
				LFSR[9] <= LFSR[8];
				LFSR[10] <= LFSR[9];
				LFSR[11] <= LFSR[10];
				LFSR[12] <= LFSR[11];
				LFSR[13] <= LFSR[12];
				LFSR[14] <= LFSR[13];
				LFSR[15] <= LFSR[14];
				time_Out <= 1'b0;
			end
		end
		else
		begin
			time_Out <= 1'b0; //just in case of getting disabled at a weird time
			LFSR <= 16'b1111_1111_1111_1111;
		end
	end
	
	end
endmodule