// Author: Matthew Andersen 2071
// CrashDetector.v
// Sends a single HIGH pulse when a conflict is detected between the Player Position
// and Object Position. Once a crash is detected, it will wait to reset until the crash
// is cleared. 
module CrashDetector(ObjectPosition, PlayerPosition, DisplayOut, CrashDetected, clk, rst);
  
  input clk, rst;
  input [6:0] PlayerPosition, ObjectPosition;
  output [6:0] DisplayOut;
  output CrashDetected;
  reg [6:0]DisplayOut;
  reg CrashDetected;
  reg [1:0] State;

  parameter NOCRASH = 0, CRASH = 1, WAIT = 2;

  always@(posedge clk) begin
    if (rst == 1'b0) begin
      DisplayOut <= 7'b1111111;
      State <= NOCRASH;
      CrashDetected <= 1'b0;
    end
    else begin
      case(State)
        NOCRASH: begin
          DisplayOut <= PlayerPosition & ObjectPosition;
          if ((PlayerPosition[5:0] | ObjectPosition[5:0]) != 6'b111111) begin
            State <= CRASH;
          end
        end

        CRASH: begin
          CrashDetected <= 1'b1;
          State <= WAIT;
        end

        WAIT: begin
          CrashDetected <= 1'b0;
          if ((PlayerPosition[5:0] | ObjectPosition[5:0]) == 6'b111111) begin
            State <= NOCRASH;
          end
        end
        
        default: begin
          State <= NOCRASH;
          CrashDetected <= 1'b0;
          DisplayOut <= 7'b1111111;
        end

      endcase
    end
  end
endmodule
