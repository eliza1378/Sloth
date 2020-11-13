`include "settings.h"

module ID_Reg
(
  input                               clk,
  input                               rst,
  input [`WORD_WIDTH-1:0]             pc_in,
  input [`WORD_WIDTH-1:0]             instruction_in,
  input [`REG_FILE_DEPTH-1:0] 				reg_file_dst_in,
  input [`WORD_WIDTH-1:0] 						reg_file_out1_in, reg_file_out2_in,
  input [`SIGNED_IMM_WIDTH-1:0] 			signed_immediate_in,
  input [`SHIFTER_OPERAND_WIDTH-1:0]  shifter_operand_in,
  input [3:0] 												EX_command_in,
  input [3:0]             status_register_in,
  input mem_read_in, mem_write_in,
    WB_en_in,
    Imm_in,
    B_in,
    update_in,
    status_load_in,
  output reg [`WORD_WIDTH-1:0]            pc,
  output reg [`WORD_WIDTH-1:0]            instruction,
  output reg [`REG_FILE_DEPTH-1:0] 				reg_file_dst_out,
  output reg [`WORD_WIDTH-1:0] 						reg_file_out1_out, reg_file_out2_out,
  output reg [`SIGNED_IMM_WIDTH-1:0] 			signed_immediate_out,
  output reg [`SHIFTER_OPERAND_WIDTH-1:0] shifter_operand_out,
  output reg [3:0] 												EX_command_out,
  output reg [3:0]             status_register_out,
  output reg mem_read_out, mem_write_out,
    WB_en_out,
    Imm_out,
    B_out,
    update_out,
    status_load_out
);

  always @(posedge clk) begin
    pc <= pc_in;
    instruction <= instruction_in;
    reg_file_dst_out <= reg_file_dst_in;
    reg_file_out1_out <= reg_file_out1_in;
    reg_file_out2_out <= reg_file_out2_in;
    signed_immediate_out <= signed_immediate_in;
    shifter_operand_out <= shifter_operand_in;
    EX_command_out <= EX_command_in;
    status_register_out <= status_register_in;
    mem_read_out <= mem_read_in;
    mem_write_out <= mem_write_in;
    WB_en_out <= WB_en_in;
    Imm_out <= Imm_in;
    B_out <= B_in;
    update_out <= update_in;
    status_load_out <= status_load_in;
  end

endmodule

