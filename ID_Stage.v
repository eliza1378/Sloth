`include "settings.h"

module ID_Stage
(
    input                    clk,
    input                    rst,
    input  [`WORD_WIDTH-1:0] pc_in,
    input  [`WORD_WIDTH-1:0] instruction_in,
    output [`WORD_WIDTH-1:0] pc,
    output [`WORD_WIDTH-1:0] instruction
);

assign pc = pc_in;
assign instruction = instruction_in;

endmodule