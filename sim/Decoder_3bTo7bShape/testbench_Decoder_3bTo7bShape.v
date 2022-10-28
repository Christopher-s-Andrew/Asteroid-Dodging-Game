// Author: Matthew Andersen 2071
// testbench_Decoder_3bTo7bShape
// Input is 3 bits and a 7bit shape is output

`timescale 1 ns / 100 ps

module testbench_Decoder_3bTo7bShape();

   reg [2:0] decoder3bIn;
   wire [6:0] decoder7bOut;

   Decoder_3bTo7bShape DUT_Decoder_3bTo7bShape(decoder3bIn, decoder7bOut);
   
   initial begin
      decoder3bIn = 3'b000; #10;
      decoder3bIn = 3'b001; #10;
      decoder3bIn = 3'b010; #10;
      decoder3bIn = 3'b011; #10;
      decoder3bIn = 3'b100; #10;
      decoder3bIn = 3'b101; #10;
      decoder3bIn = 3'b110; #10;
      decoder3bIn = 3'b111; #10;
   end
endmodule

