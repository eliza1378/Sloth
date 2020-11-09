`include "settings.h"

 module Instruction_Mem
(
  input      [`WORD_WIDTH-1:0] addr,
  output reg [`WORD_WIDTH-1:0] instruction
);

always @*
  case(addr)
    32'd0: instruction = 32'b1110_00_1_1101_0_0000_0000_000000010100;
    32'd1: instruction = 32'b000000_00011_00100_00000_00000000000;
    32'd2: instruction = 32'b000000_00101_00110_00000_00000000000;
    32'd3: instruction = 32'b000000_00111_01000_00010_00000000000;
    32'd4: instruction = 32'b000000_01001_01010_00011_00000000000;
    32'd5: instruction = 32'b000000_01011_01100_00000_00000000000;
    32'd6: instruction = 32'b000000_01101_01110_00000_00000000000;
    default: instruction = 32'b000000_00000_00000_00000_00000000000;
  endcase

endmodule
