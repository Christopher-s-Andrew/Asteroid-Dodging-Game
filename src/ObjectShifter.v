// Author: Matthew Andersen 2071
// ObjectShifter.v
// This takes a shift pulse to either add a random shape from the shape decoder,
// or a blank space (between shapes) and shift them along the 7seg displays.
// It requires a 3bit LFSR random number generator at the input, and outputs a pulse
// if an object is dodged.

module ObjectShifter(ShiftPulse, ObjShifterEnable, Reconfig, RNGReadIn, Out5, Out4, Out3, Out2, Out1, Out0, DebrisDodge, clk, rst);
  
  input ShiftPulse, ObjShifterEnable, Reconfig, clk, rst;
  input [2:0] RNGReadIn;
  output [6:0] Out5, Out4, Out3, Out2, Out1, Out0;
  output DebrisDodge;

  reg DebrisDodge;
  reg [6:0] Out5, Out4, Out3, Out2, Out1, Out0;
  reg [2:0] State, RandNum3b;
  reg ShapeSent;
  wire [6:0] RandShape;
  parameter INIT = 0, GETRNG = 1, SENDSHAPE = 2, WAIT = 3;

  Decoder_3bTo7bShape RandomShape(RandNum3b, RandShape);

  always@(posedge clk) begin
    if (rst == 1'b0) begin
      Out5 <= 7'b1111111;
      Out4 <= 7'b1111111;
      Out3 <= 7'b1111111;
      Out2 <= 7'b1111111;
      Out1 <= 7'b1111111;
      Out0 <= 7'b1111111;
      ShapeSent <= 1'b0;
      RandNum3b <= 3'b000;
      DebrisDodge <= 1'b0;
      State <= INIT;
    end
    else begin
      case(State)
        INIT: begin
          Out5 <= 7'b1111111;
          Out4 <= 7'b1111111;
          Out3 <= 7'b1111111;
          Out2 <= 7'b1111111;
          Out1 <= 7'b1111111;
          Out0 <= 7'b1111111;
          ShapeSent <= 1'b0;
          RandNum3b <= 3'b000;
          DebrisDodge <= 1'b0;
          if (ObjShifterEnable == 1) begin
             if (ShiftPulse == 1'b1) begin
                State <= GETRNG;
             end
          end
        end

        GETRNG: begin
          RandNum3b <= RNGReadIn;
          State <= SENDSHAPE;
        end

        SENDSHAPE: begin
          if (ShapeSent == 1'b1) begin
            Out0 <= 7'b1111111;
            ShapeSent <= 1'b0;
          end
          else begin
            Out0 <= RandShape;
            ShapeSent <= 1'b1;
          end
          Out1 <= Out0;
          Out2 <= Out1;
          Out3 <= Out2;
          Out4 <= Out3;
          Out5 <= Out4;
          if (Out5 != 7'b1111111) begin
            DebrisDodge <= 1'b1;
          end
          State <= WAIT;
        end

        WAIT: begin
          DebrisDodge <= 1'b0;
          if (ObjShifterEnable == 1) begin
             if (ShiftPulse == 1'b1) begin
                State <= GETRNG;
             end
          end
          else begin
            State <= INIT;
          end
        end
        
        default: begin
          State <= INIT;
        end

      endcase
    end
  end
endmodule