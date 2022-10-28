/*
Course Number: 5440
Author: Gantabya Kadel, 8522
Module Name: CheckID
Description: Verilog implementation of Multi User Authentication process. Module created for Team Q4's Advanced Digital Design Final Project to verify user inputted ID.
	     Guest users have a unique id and password as well. IDs are 4 bits and Passwords are 6 bits. IDs and Passwords are in HEX.
 Comments: Made with help, mainly from Lecture, from Dr. Chen. The IDs of each indidivual partner are the last 4 Digits of their ID numbers.
		Team Member 1: Gantabya Kadel         ===> ID: 8522  Password: A54E32
		Team Member 2: Nhat Nguyen    	      ===> ID: 4700  Password: EEE420
		Team Member 3: Christopher Andrew     ===> ID: 5928  Password: F24630
		Team Member 4: Matthew Anderson	      ===> ID: 2071  Password: AAB431
		Guest				      ===> ID: FFFF  Password: FFFFFF
*/
module CheckID(Clk, Reset, InputSwitches, EnterPswd, LogOutPulse, IDOK, InternalID);
	input Clk, Reset, EnterPswd, LogOutPulse;
	input [3:0] InputSwitches;
	output IDOK;
	output [4:0] InternalID;
	reg [4:0] State, InternalID;
	reg Matched, IDOK;
	reg [1:0] WaitCounter;
	reg [2:0] AddrCounter;
	reg [4:0] Address;
	reg [2:0] EnteredVerifyCount;
	wire [15:0] FetchedQ;
	reg [15:0] UserId, FetchedID;
	parameter DigOne = 0, DigTwo = 1, DigThree = 2, DigFour = 3, FetchROM = 4, Wait = 5, CatchROM = 6, Compare = 7, Verify = 8, Success = 9;


// Instansiate the ROM 

	UserIds  ROM_IDS(Address, Clk, FetchedQ);
// 
	always@(posedge Clk)
		begin
			if(Reset == 1'b0)
				begin
					Matched	      	   <=   1'b0;
					IDOK	       	   <=   1'b0;
					AddrCounter    	   <=   3'b000;
					Address        	   <=   5'b00000;
					InternalID         <=   5'b00000;
					UserId             <=   16'b0000000000000000;
					FetchedID     	   <=   16'b0000000000000000;
					WaitCounter        <=   2'b10;
					EnteredVerifyCount <= 3'b000;
					State	           <=   DigOne;	
				end
			else
				begin
					case(State)
						DigOne:
							begin
								Matched	      	   <=   1'b0;
								IDOK	       	   <=   1'b0;
								AddrCounter    	   <=   3'b000;
								Address        	   <=   5'b00000;
								InternalID         <=   5'b00000;
								UserId             <=   16'b0000000000000000;
								FetchedID     	   <=   16'b0000000000000000;
								WaitCounter        <=   2'b10;
								EnteredVerifyCount <= 3'b000;
								if(EnterPswd == 1'b1)
									begin
										UserId[15:12] <= InputSwitches;
										State <= DigTwo;
									end
								else
									begin
										State <= DigOne;
									end
							end
						DigTwo:
							begin
								if(EnterPswd == 1'b1)
									begin
										UserId[11:8] <= InputSwitches;
										State <= DigThree;
									end
								else
									begin
										State <= DigTwo;
									end
							end
						DigThree:
							begin
								if(EnterPswd == 1'b1)
									begin
										UserId[7:4] <= InputSwitches;
										State <= DigFour;
									end
								else
									begin
										State <= DigThree;
									end
							end
						DigFour:
							begin
								if(EnterPswd == 1'b1)
									begin
										UserId[3:0] <= InputSwitches;
										State <= FetchROM;
									end
								else
									begin
										State <= DigFour;
									end
							end
						FetchROM:
							begin
								Address <= {2'b00, AddrCounter};
								State <= Wait;			
							end
						Wait:
							begin
								if(WaitCounter == 2'b00)
									begin
										WaitCounter <= 2'b10;
										State <= CatchROM;
									end
								else
									begin
										WaitCounter = WaitCounter - 1;
										State <= Wait;
									end
							end
						CatchROM:
							begin
								FetchedID <= FetchedQ;
								State <= Compare;
							end
						Compare:
							begin
								if(FetchedID == UserId)
									begin
										Matched <= 1'b1;			
									end
								else
									begin
										Matched <= 1'b0;
									end
								State <= Verify;
							end
						Verify:
							begin
								EnteredVerifyCount <= EnteredVerifyCount + 1;
//
								if(Matched == 1'b1)
									begin
										EnteredVerifyCount <= 3'b000;
										State <= Success;
									end
								else
									begin
										AddrCounter <= AddrCounter + 1;
										if(AddrCounter == 3'b101)
											begin
												AddrCounter <= 3'b000; // This is so that extra cycle isn't used to get rom values that are meaningless. ONly 5 users in rom .... 4 team memebers and 1 guest.
											end
										if(EnteredVerifyCount == 3'b101)
											begin
												State <= DigOne;
											// Basically If 5 attempts to verify fail then it means user entered an ID that's not in ROM ... User must enter again.
											end
										else
											begin
												State <= FetchROM;
											end
									end
							end
						Success:
							begin
// Check For Log Out ... Only this state really requires this check becuase you can't really log out before logging in.
// Even Check Id really doesn't require log perse. Only really check it here so that State can go back to initial state. No other reason.
//
								IDOK <= 1'b1;
								InternalID <= Address;
								if(LogOutPulse == 1'b1)
									begin
										State <= DigOne;
										IDOK <= 1'b0;
									end
								else
									begin								
										State <= Success; // Stay in Success till reset is pressed essentially.
									end
								
							end
						default:
							begin
								State <= DigOne;
							end
					endcase
				end
		end
endmodule
