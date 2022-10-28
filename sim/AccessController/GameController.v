/*
Course Number: 5440
Author: Gantabya Kadel, 8522
Module Name: GameController
Description: One of the two duo-board module to be instantiated by the AccessController module, the top-level gatekeeper module. This module is responsibile for the enabling of in game functions post 
	     authentication. Will also output modes depending on state of the FSM to be used elsewhere by the rest of the system architecture 
 Comments: Made for Team Q4's Advanced Digital Design Final Project. Controls the enabling of in-game functions
*/
module GameController(Clk, Reset, Authenticated, GameStartBtn, LogOutBtn, CrashDetected, LEDTrackerTimeOut, OneSecPulse, NewGamePulse, PassedRoundPulse, GameOverPulse, EnableGameElements, Difficulty, LogOutPulse, EnableTimer, Mode);


// inputs: Clk, Reset, InputSwitches, logOutBtn, PswdBtn, GameStartBtn, CrashDetected, LEDTrackerTimeOut
// outputs: NewGamePulse, PassedRoundPulse, GameOverPulse, EnableGameElements, Difficulty, DisplayMode, PlayerId, Out0, Out1, Out2, Out3, Out4, Out5
// these are the inputs and outputs of the AccessController module, this module's top-level module.

	input Clk, Reset, Authenticated, GameStartBtn, LogOutBtn, LEDTrackerTimeOut, CrashDetected, OneSecPulse;
	output NewGamePulse, PassedRoundPulse, GameOverPulse, EnableGameElements, EnableTimer, LogOutPulse;
	output [1:0] Difficulty;
	output [2:0] Mode;
	reg NewGamePulse, PassedRoundPulse, GameOverPulse, EnableGameElements, EnableTimer, LogOutPulse, UpdatedInPass;
	reg [2:0] Mode, State, StayCounter;
	reg [1:0] Difficulty;
	parameter WaitForAuthentication = 0, GblScoreDisp = 1, PerScoreDisp = 2, Pass = 3, Fail = 4, GamePlay = 5, WAIT_FOR_LOG_OUT = 6;
//
// --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	always@(posedge Clk)
		begin
			if(Reset == 1'b0)
				begin
					NewGamePulse		<=	1'b0;
					PassedRoundPulse	<=	1'b0;
					GameOverPulse		<=	1'b0;
					EnableGameElements	<=	1'b0;
					EnableTimer		<=	1'b0;
					LogOutPulse		<=	1'b0;
					UpdatedInPass		<=	1'b0;
					Difficulty		<=	2'b00;
					Mode			<=	3'b000;
					StayCounter		<=	2'b00;
					State			<=	WaitForAuthentication;
				end
			else
				begin
					case(State)
						WaitForAuthentication:
							begin
								PassedRoundPulse	<=	1'b0;
								EnableGameElements	<=	1'b0;
								LogOutPulse		<=	1'b0;
								UpdatedInPass		<=	1'b0;
								Difficulty		<=	2'b00;
								Mode			<=	3'b000;
								StayCounter		<=	2'b00;
//
								if(Authenticated == 1'b1)
									begin
										EnableTimer <= 1'b1; // This timer is for Internal AccessController module use, therefore need this enabled upon Authentication.
										State <= GblScoreDisp;
										NewGamePulse <= 1'b1;
										GameOverPulse		<=	1'b1;
									end
								else
									begin
										State <= WaitForAuthentication;
										NewGamePulse <=	1'b0;
										GameOverPulse		<=	1'b0;
										EnableTimer		<=	1'b0;
									end 
							end
						GblScoreDisp:
							// Access Controller doesn't actuall control the score display ... just need output the mode according to design plan.
							begin
							GameOverPulse		<=	1'b0;
							NewGamePulse <=	1'b0;
							Mode	<=	3'b001;
//
								if(OneSecPulse == 1'b1)
									begin
										StayCounter <= StayCounter + 1;
									end
//
								if(StayCounter == 3'b101) // 5 Secs
									begin
										StayCounter <= 3'b000;
										State <= PerScoreDisp;
									end
								else
									begin
										if(LogOutBtn == 1'b1)
											begin
												StayCounter		<=	2'b10;
												LogOutPulse <= 1'b1;												
												State <= WAIT_FOR_LOG_OUT;
											end
										else
											begin
												State <= GblScoreDisp;
											end
									end
							end
//
						PerScoreDisp:
							begin
								GameOverPulse		<=	1'b0;
								NewGamePulse <=	1'b0;
								Mode <= 3'b010;
								if(GameStartBtn == 1'b1)
									begin
										if(UpdatedInPass == 1'b1)
											begin
												if(Difficulty == 2'b11)
													begin
														Difficulty <= 2'b11;
														UpdatedInPass <= 1'b0;
													end
												else
													begin
														Difficulty <= Difficulty + 1;
														UpdatedInPass <= 1'b0;
													end
													// Cap difficulty at 3.
											end
// Sequential doesn't require else ... since no latches form
									//	NewGamePulse <=	1'b1; // Only turned on if GameStartBtn == 1'b1 ... Have to do it here to generate a single cycle pulse 1x only.
										GameOverPulse <= 1'b1;
										NewGamePulse  <= 1'b0;
										State <= GamePlay;
									end
								else if (LogOutBtn == 1'b1)
									begin
										StayCounter		<=	2'b10;
										LogOutPulse <= 1'b1;												
										State <= WAIT_FOR_LOG_OUT;
									end
								else
									begin
										State <= PerScoreDisp;
									end
							end
//
						Pass:
							begin
								Mode			<=	3'b011;
								NewGamePulse		<=	1'b0;
								PassedRoundPulse	<=	1'b0; // Need to Turn this one a state ahead because FSM will stay in this state for about 5 secs and that will generate 5x 1 cycle pulse.
								GameOverPulse		<=	1'b1;
								EnableGameElements	<=	1'b0;
								LogOutPulse		<=	1'b0;
								UpdatedInPass		<=	1'b0;
//							
								if(LogOutBtn == 1'b1)
									begin
										LogOutPulse <= 1'b1;
										State <= WAIT_FOR_LOG_OUT;
										StayCounter		<=	2'b10;
									end
								else
									begin
										if(OneSecPulse == 1'b1)
											begin
												StayCounter <= StayCounter + 1;
											end
//
										if(StayCounter == 3'b101) // 5 sec
											begin
												StayCounter <= 3'b000;
												UpdatedInPass <= 1'b1; // using this in PerScoreDisp state to make it more dynamic
												State <= PerScoreDisp;
											end
										else
											begin
												State <= Pass;
											end
											// So stay in this state unless player decides to either log out or play the game with incremented difficulty		
								end		
							end
						Fail:
							begin
								Mode			<=	3'b100;
								NewGamePulse		<=	1'b0;
								GameOverPulse		<=	1'b1; // Same scenario as the NewGamePulse on Pass state
								EnableGameElements	<=	1'b0;
								LogOutPulse		<=	1'b0;
								UpdatedInPass		<=	1'b0;
								Difficulty		<=	2'b00;
//
								if(LogOutBtn == 1'b1)
									begin
										LogOutPulse <= 1'b1;
										State <= WAIT_FOR_LOG_OUT;
										StayCounter		<=	2'b10;
									end
								if(OneSecPulse == 1'b1)
									begin
										StayCounter <= StayCounter + 1;
									end
//
								if(StayCounter == 3'b101) // 5 secs
									begin
										StayCounter <= 3'b000;
										State <= GblScoreDisp;
									end
							end
						GamePlay:
							begin
// Level Success is defined by LEDTImeOut signal 
// Level Failure or player "death" is defined by CrashDetected signal
								Mode <= 3'b101;
								NewGamePulse		<=	1'b0; // Need this pulled up a state ahead because it's a pulse.
								GameOverPulse		<=	1'b0; // Will be pulling up the pulse signals in transisition because can't get the pulse only in this state as repeated visit is required to maintain play.
								EnableGameElements	<=	1'b1;
								EnableTimer		<=	1'b1;
								LogOutPulse		<=	1'b0;
								StayCounter		<=	2'b00;
//
								if(LEDTrackerTimeOut == 1'b1)
									begin
									PassedRoundPulse <= 1'b1; // Need it here to ensure that only 1x single cycle active high pulse is generated.
										State <= Pass;
									end
								else if(CrashDetected == 1'b1)
									begin
										GameOverPulse <= 1'b1; // Same scenario as PassRoundPulse above.
										State <= Fail;
									end
								else
									begin
										State <= GamePlay;
									end
							end
						WAIT_FOR_LOG_OUT: //wait for it to be safe to log out
						begin
								PassedRoundPulse	<=	1'b0;
								GameOverPulse		<=	1'b0;
								EnableGameElements	<=	1'b0;
								EnableTimer		<=	1'b1;
								LogOutPulse		<=	1'b0;
								UpdatedInPass		<=	1'b0;
								Difficulty		<=	2'b00;
								Mode			<=	3'b000;
								
								//tries to stop the previous round score from being displayed after logging back in, too tired to figure out
								if(StayCounter != 0) //trying to stay here for a little bit to do a new game pulse but does not seem to want to stay
								
								begin
									
									StayCounter <= StayCounter - 1;
								end
								else
								begin
									NewGamePulse <= 1'b1;
									State <= WaitForAuthentication;
								end
						end
						default:
							begin
								State <= WaitForAuthentication;
							end
					endcase
				end
		end
endmodule
