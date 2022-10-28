// Author: Matthew Andersen 2071
// LED_Animator.v
// This outputs a 10-bit signal for the LED bar in the game. It takes the fuel gauge signal as an input, and
// changes the output if a new personal high score is achieved or if a new global high score is achieved.

module LED_Animator(FuelGaugeIn, DispMode, NewPersonalBest, NewGlobalBest, LEDDispOut, clk, rst);
  
  input NewPersonalBest, NewGlobalBest, clk, rst;
  input [9:0] FuelGaugeIn;
  input [2:0] DispMode;
  output [9:0] LEDDispOut;

  reg [9:0] LEDDispOut;
  reg VarTimerEnable;
  reg [1:0] State;
  reg [4:0] Count;

  wire VarTimeout;

  parameter INIT = 0, PBEST = 1, GBEST = 2;

  Variable_Timer PBestTimer(clk, rst, VarTimerEnable, VarTimeout, 2'b11);

  always@(posedge clk) begin
    if (rst == 1'b0) begin
      LEDDispOut <= 10'b0000000000;
      State <= INIT;
      Count <= 5'd0;
      VarTimerEnable <= 1'b0;
    end
    else begin
      case(State)
        INIT: begin
          Count <= 5'd0;         
          VarTimerEnable <= 1'b0;
          if (NewGlobalBest == 1'b1) begin
            State <= GBEST;
            LEDDispOut <= 10'b1111111111;
          end
          else begin
            if (NewPersonalBest == 1'b1) begin
              State <= PBEST;
              LEDDispOut <= 10'b1111111111;
            end
            else begin
              if (DispMode == 3'd0) begin
              LEDDispOut <= 10'b0000000000;
				  end
              else begin
                  LEDDispOut <= FuelGaugeIn;
              end
            end
          end
        end

        PBEST: begin
          VarTimerEnable <= 1'b1;
          if (Count == 5'd20) begin
            State <= INIT;
            Count <= 5'd0;
          end
          else begin
            if (VarTimeout == 1'b1) begin
              Count <= Count + 1;
              if (LEDDispOut == 10'b0000000000) begin
                LEDDispOut <= 10'b1111111111;
              end
              else begin
                LEDDispOut <= 10'b0000000000;
              end
            end
          end
        end

        GBEST: begin
          VarTimerEnable <= 1'b1;
          if (Count == 5'd20) begin
            State <= INIT;
            Count <= 5'd0;
          end
          else begin
            if (VarTimeout == 1'b1) begin
              Count <= Count + 1;
              if (LEDDispOut == 10'b0000000000) begin
                LEDDispOut <= 10'b1100000000;
              end
              if (LEDDispOut == 10'b1100000000) begin
                LEDDispOut <= 10'b1111000000;
              end
              if (LEDDispOut == 10'b1111000000) begin
                LEDDispOut <= 10'b1111110000;
              end
              if (LEDDispOut == 10'b1111110000) begin
                LEDDispOut <= 10'b1111111100;
              end
              if (LEDDispOut == 10'b1111111100) begin
                LEDDispOut <= 10'b1111111111;
              end
              if (LEDDispOut == 10'b1111111111) begin
                LEDDispOut <= 10'b0000000000;
              end
            end
          end
        end
        
        default: begin
          State <= INIT;
        end

      endcase
    end
  end
endmodule