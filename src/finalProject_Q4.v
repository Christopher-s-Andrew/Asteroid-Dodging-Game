// ECE 5440
// Author: Matthew Andersen 2071
// finalProject_Q4.v
// This wires the gameplay modules to test how it works.


module finalProject_Q4(GameLengthSwitches, PWSwitches, GameStartRawBtn, PswdEnterRawBtn, LogOutRawBtn,
                  TenLEDOutput, SevenSegDisplay, clk, rst);

   input [3:0] GameLengthSwitches, PWSwitches;
	input GameStartRawBtn, PswdEnterRawBtn, LogOutRawBtn, clk, rst;
	output [41:0] SevenSegDisplay;
	wire [41:0] GameSegDisplay, AccessSegDisplay, FailDisplay, PassDisplay, PlayerScoreDisplay, GlobalScoreDisplay;
	output [9:0] TenLEDOutput;
	
	wire ShiftPulse, DebrisDodge, CrashDetected, GameStartBtnPulse, PswdBtnPulse,LogOutBtnPulse, LEDTimeOut;
	wire VarTimerEnable, LEDTimeOUt, NewGamePulse, PassedRoundPulse, GameOverPulse, EnableGameElements, new_PB_Pulse,new_GB_Pulse ;
	wire [1:0] Difficulty;
	wire [6:0] CrashDetectorOut, GameOut5, GameOut4, GameOut3, GameOut2, GameOut1, GameOut0, PlayerPosition;
	wire [6:0] Hex1Out, Hex2Out, Hex3Out, Hex4Out, Hex5Out, Hex6Out;
	wire [6:0] hex5, hex4, hex3, hex2, hex1, hex0;
	wire [2:0] Random_Num, DisplayMode;
	wire [4:0] PlayerId;
	wire [9:0] FuelGauge;
	
   ButtonShaper GameStartButton(GameStartRawBtn, GameStartBtnPulse, clk, rst);
	ButtonShaper PWEnterButton(PswdEnterRawBtn, PswdBtnPulse, clk, rst);
	ButtonShaper LogOutButton(LogOutRawBtn, LogOutBtnPulse, clk, rst);
	
	AccessController MultiAuthGameCtrl(clk, rst, PWSwitches, PswdBtnPulse, GameStartBtnPulse, LogOutBtnPulse, CrashDetected,
               	  LEDTimeOut, NewGamePulse, PassedRoundPulse, GameOverPulse, EnableGameElements, Difficulty, DisplayMode, PlayerId, 
						  Hex1Out, Hex2Out, Hex3Out, Hex4Out, Hex5Out, Hex6Out);
						  
   assign AccessSegDisplay = {Hex1Out, Hex2Out, Hex3Out, Hex4Out, Hex5Out, Hex6Out};
	
	LED_Animator LEDDisplay(FuelGauge, DisplayMode, new_PB_Pulse, new_GB_Pulse, TenLEDOutput, clk, rst);
	
	Variable_Timer SpeedControl(clk, rst, EnableGameElements, ShiftPulse, Difficulty);
	
	RNG_LFSR_3b RandomShape(1'b1, Random_Num, clk, rst);
	
	ObjectShifter ShiftObj(ShiftPulse, EnableGameElements, 1'b0, Random_Num, GameOut5, GameOut4, GameOut3, GameOut2,
	                       GameOut1, GameOut0, DebrisDodge, clk, rst);
	
	CrashDetector Crashed(GameOut5, PlayerPosition, CrashDetectorOut, CrashDetected, clk, rst);
	assign GameSegDisplay = {CrashDetectorOut, GameOut4, GameOut3, GameOut2, GameOut1, GameOut0};
	
	PlayerPosition PlayerPos(GameStartBtnPulse, PlayerPosition, clk, rst);
	
	Nhat_LEDBarTimer FuelGaugeGen(GameLengthSwitches, EnableGameElements, LEDTimeOut, FuelGauge, clk, rst);

	Score_Control_Unit Scorer(clk, rst, PassedRoundPulse, NewGamePulse, PlayerId, GameOverPulse, score_Request_Complate_Pulse,
	                          new_PB_Pulse, new_GB_Pulse, PlayerScoreDisplay, GlobalScoreDisplay);
	
	Seg_7_Control segControl(DisplayMode, hex5, hex4, hex3, hex2, hex1, hex0, AccessSegDisplay, GlobalScoreDisplay, PlayerScoreDisplay,
	              AccessSegDisplay, AccessSegDisplay, GameSegDisplay, {2'b11,40'hFFFFFFFFFF}, {2'b11,40'hFFFFFFFFFF});
   assign SevenSegDisplay = {hex5, hex4, hex3, hex2, hex1, hex0};

endmodule

