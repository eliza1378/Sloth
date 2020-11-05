`include "settings.h" 

module ID_Reg
(
    input                       clk,
    input                       rst,
    input      [`WORD_WIDTH-1:0] pc_in,
    input      [`WORD_WIDTH-1:0] instruction_in,
    output reg [`WORD_WIDTH-1:0] pc,
    output reg [`WORD_WIDTH-1:0] instruction
);

always @(posedge clk) begin
    pc <= pc_in;
    instruction <= instruction_in;
end

endmodule



