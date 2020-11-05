`include "settings.h"  

 module Instruction_Mem 
(
  input      [`WORD_WIDTH-1:0] addr,
  output reg [`WORD_WIDTH-1:0] instruction
);

always @*
  case(addr)
    32'b000: instruction = 32'b000000_00001_00010_00000_00000000000;
    32'b001: instruction = 32'b000000_00011_00100_00000_00000000000;
    32'b010: instruction = 32'b000000_00101_00110_00000_00000000000;
    32'b011: instruction = 32'b000000_00111_01000_00010_00000000000;
    32'b100: instruction = 32'b000000_01001_01010_00011_00000000000;
    32'b101: instruction = 32'b000000_01011_01100_00000_00000000000;
    32'b110: instruction = 32'b000000_01101_01110_00000_00000000000;
    default: instruction = 32'b000000_00000_00000_00000_00000000000;
  endcase

endmodule


