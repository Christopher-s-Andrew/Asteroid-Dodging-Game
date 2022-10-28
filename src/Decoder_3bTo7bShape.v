// ECE 5440
// Author: Matthew Andersen 2071
// Decoder_3bTo7bShape
// This module will take a 3 bit input representing a random number 0-7 decimal
// and convert it to a 7-bit output which to be used as an object in the 7seg display

module Decoder_3bTo7bShape(Decoder3bIn, Decoder7bOut);

   input [2:0] Decoder3bIn;
   output [6:0] Decoder7bOut;
   reg [6:0] Decoder7bOut;

   always @ (Decoder3bIn) begin
      case (Decoder3bIn)
         3'h0: begin Decoder7bOut = 7'b0011100; end // Top shapes
         3'h1: begin Decoder7bOut = 7'b0011110; end
         3'h2: begin Decoder7bOut = 7'b1011110; end
         3'h3: begin Decoder7bOut = 7'b1011111; end
         3'h4: begin Decoder7bOut = 7'b0100011; end // Bottom shapes
         3'h5: begin Decoder7bOut = 7'b0110011; end
         3'h6: begin Decoder7bOut = 7'b1110011; end
         3'h7: begin Decoder7bOut = 7'b1101111; end
         default: begin Decoder7bOut = 7'b111_1111; end //no LED lit
      endcase
   end
endmodule

