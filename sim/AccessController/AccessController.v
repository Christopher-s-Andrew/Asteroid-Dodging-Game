/*
Course Number: 5440
Author: Gantabya Kadel, 8522
Module Name: AccessController
Description: Top Level Access Controller module. This instantiates both the MultiUserAuthentication and GameController module, who intern instate other innner modules, to essentiall
	     authenticate users and take "control" of the game. It also instansiates the OneSecondTimer module. (Timer module is only used internally)
 Comments: Made with help, mainly from Lecture, from Dr. Chen. The IDs of each indidivual partner are the last 4 Digits of their ID numbers.
		Team Member 1: Gantabya Kadel         ===> ID: 8522  Password: A54E32
		Team Member 2: Nhat Nguyen    	      ===> ID: 4700  Password: EEE420
		Team Member 3: Christopher Andrew     ===> ID: 5928  Password: F24630
		Team Member 4: Matthew Andersen	      ===> ID: 2071  Password: AAB431
*/
module AccessController(Clk, Reset, InputSwitches, EnterPswd, GameStartBtn, LogOutBtn, CrashDetected, LEDTimeOut, NewGamePulse, PassedRoundPulse, GameOverPulse, EnableGameElements, Difficulty, DisplayMode, PlayerId, Hex1Out, Hex2Out, Hex3Out, Hex4Out, Hex5Out, Hex6Out);

// inputs: Clk, Reset, InputSwitches, logOutBtn, PswdBtn, GameStartBtn, CrashDetected, LEDTrackerTimeOut
// outputs: NewGamePulse, PassedRoundPulse, GameOverPulse, EnableGameElements, Difficulty, DisplayMode, PlayerId, Out0, Out1, Out2, Out3, Out4, Out5
// these are the inputs and outputs of the AccessController module, this module's top-level module.

	input Clk, Reset, EnterPswd, GameStartBtn, LogOutBtn, CrashDetected, LEDTimeOut;
	input [3:0] InputSwitches;
	output NewGamePulse, PassedRoundPulse, GameOverPulse, EnableGameElements;
	output [1:0] Difficulty;
	output [2:0] DisplayMode;
	output [4:0] PlayerId;
	output [6:0] Hex1Out, Hex2Out, Hex3Out, Hex4Out, Hex5Out, Hex6Out;
	wire LogOutPulseWire, SuccessfulWire, OneSecPulseWire, EnableElementsWire, EnableTimerWire, NewGamePulseWire, PassedRoundPulseWire, GameOverPulseWire;
	wire [1:0] DifficultyWire;
	wire [2:0] ModeWire;
	wire [4:0] PlayerIDWire;
	wire [6:0] Out1Wire, Out2Wire, Out3Wire, Out4Wire, Out5Wire, Out6Wire;


// -------------------------------------------------------------------------------------------------------- Instantiation Block ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// MultiUserAuthentication(Clk, Reset, InputSwitches, EnterPswd, LogOutPulse, Mode, Successful, PlayerID, SevenSegOut1, SevenSegOut2, SevenSegOut3, SevenSegOut4, SevenSegOut5, SevenSegOut6)
	MultiUserAuthentication Multi_Authen(Clk, Reset, InputSwitches, EnterPswd, LogOutPulseWire, ModeWire, SuccessfulWire, PlayerIDWire, Out1Wire, Out2Wire, Out3Wire, Out4Wire, Out5Wire, Out6Wire);

// GameController(Clk, Reset, Authenticated, GameStartBtn, LogOutBtn, CrashDetected, LEDTrackerTimeOut, OneSecPulse, NewGamePulse, PassedRoundPulse, GameOverPulse, EnableGameElements, Difficulty, LogOutPulse, EnableTimer, Mode)
	GameController GameControl(Clk, Reset, SuccessfulWire, GameStartBtn, LogOutBtn, CrashDetected, LEDTimeOut, OneSecPulseWire, NewGamePulseWire, PassedRoundPulseWire, GameOverPulseWire, EnableElementsWire, DifficultyWire, LogOutPulseWire, EnableTimerWire, ModeWire);

// OneSecondTimer(Clk, Reset, Enable, OneSecond)
	OneSecondTimer OneSecTimer(EnableTimerWire, OneSecPulseWire, Clk, Reset);
	

// -------------------------------------------------------------------------------------------------------- Assigning Block -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	assign Hex1Out = Out1Wire;
	assign Hex2Out = Out2Wire;
	assign Hex3Out = Out3Wire;
	assign Hex4Out = Out4Wire;
	assign Hex5Out = Out5Wire;
	assign Hex6Out = Out6Wire;
	assign DisplayMode = ModeWire;
	assign Difficulty = DifficultyWire;
	assign PlayerId	= PlayerIDWire;
	assign EnableGameElements = EnableElementsWire;
	assign NewGamePulse = NewGamePulseWire;
	assign PassedRoundPulse = PassedRoundPulseWire;
	assign GameOverPulse = GameOverPulseWire;
endmodule
