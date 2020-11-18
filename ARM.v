`include "settings.h"

module ARM
(
  input clk,
  input rst
);

  wire [`WORD_WIDTH-1:0] IF_stage_pc_out;
  wire [`WORD_WIDTH-1:0] IF_stage_instruction_out;
  wire [`WORD_WIDTH-1:0] branch_address;
  wire EXE_stage_B_out;

  IF_Stage  IF_Stage_Inst (
   .clk(clk),
   .rst(rst),
   .freeze(1'b0),
   .branch_taken(EXE_stage_B_out),
   .branch_addr(branch_address),
   .pc(IF_stage_pc_out),
   .instruction(IF_stage_instruction_out)
  );

  wire [`WORD_WIDTH-1:0] IF_reg_pc_out;
  wire [`WORD_WIDTH-1:0] IF_reg_instruction_out;

  IF_Reg  IF_Reg_Inst (
   .clk(clk),
   .rst(rst),
   .freeze(1'b0),
   .flush(1'b0),
   .pc_in(IF_stage_pc_out),
   .instruction_in(IF_stage_instruction_out),
   .pc(IF_reg_pc_out),
   .instruction(IF_reg_instruction_out)
  );

  wire [`WORD_WIDTH-1:0]              ID_stage_pc_out;
  wire [`WORD_WIDTH-1:0]              ID_stage_instruction_out;
	wire [`REG_FILE_DEPTH-1:0] 				ID_stage_reg_file_dst;
	wire [`WORD_WIDTH-1:0] 						ID_stage_val_Rn, ID_stage_val_Rm;
	wire [`SIGNED_IMM_WIDTH-1:0] 			ID_stage_signed_immediate;
	wire [`SHIFTER_OPERAND_WIDTH-1:0] ID_stage_shifter_operand;
	wire [3:0] 												ID_stage_EX_command_out;
	wire [3:0]              status;
	wire ID_stage_mem_read_out, ID_stage_mem_write_out,
		ID_stage_WB_en_out,
		ID_stage_Imm_out,
		ID_stage_B_out,
		ID_stage_SR_update_out;

  ID_Stage ID_Stage_Inst(
    .clk(clk),
    .rst(rst),
    .pc_in(IF_reg_pc_out),
    .instruction_in(IF_reg_instruction_out),
    .status_register(status),
    .pc(ID_stage_pc_out),
    .instruction(ID_stage_instruction_out),
	  .reg_file_dst(ID_stage_reg_file_dst),
	  .val_Rn(ID_stage_val_Rn), .val_Rm(ID_stage_val_Rm),
	  .signed_immediate(ID_stage_signed_immediate),
	  .shifter_operand(ID_stage_shifter_operand),
	  .EX_command_out(ID_stage_EX_command_out),
	  .mem_read_out(ID_stage_mem_read_out), .mem_write_out(ID_stage_mem_write_out),
		.WB_en_out(ID_stage_WB_en_out),
		.Imm_out(ID_stage_Imm_out),
		.B_out(ID_stage_B_out),
		.SR_update_out(ID_stage_SR_update_out)
  );

  wire [`WORD_WIDTH-1:0] ID_reg_pc_out;
  wire [`WORD_WIDTH-1:0] ID_reg_instruction_out;
  wire [`REG_FILE_DEPTH-1:0] ID_reg_reg_file_dst_out;
  wire [`WORD_WIDTH-1:0] ID_reg_val_Rn_out, ID_reg_val_Rm_out;
  wire [`SIGNED_IMM_WIDTH-1:0] ID_reg_signed_immediate_out;
  wire [`SHIFTER_OPERAND_WIDTH-1:0] ID_reg_shifter_operand_out;
  wire [3:0] ID_reg_SR_out, ID_reg_EX_command_out;
  wire ID_reg_mem_read_out, ID_reg_mem_write_out,
    ID_reg_WB_en_out,
    ID_reg_Imm_out,
    ID_reg_B_out,
    ID_reg_SR_update_out;

  ID_Reg ID_Reg_Inst(
    .clk(clk),
    .rst(rst),
    .pc_in(ID_stage_pc_out),
    .instruction_in(ID_stage_instruction_out),
    .reg_file_dst_in(ID_stage_reg_file_dst),
	  .val_Rn_in(ID_stage_val_Rn), .val_Rm_in(ID_stage_val_Rm),
	  .signed_immediate_in(ID_stage_signed_immediate),
	  .shifter_operand_in(ID_stage_shifter_operand),
    .EX_command_in(ID_stage_EX_command_out),
	  .mem_read_in(ID_stage_mem_read_out), .mem_write_in(ID_stage_mem_write_out),
		.WB_en_in(ID_stage_WB_en_out),
		.Imm_in(ID_stage_Imm_out),
		.B_in(ID_stage_B_out),
		.SR_update_in(ID_stage_SR_update_out),
    .pc(ID_reg_pc_out),
    .instruction(ID_reg_instruction_out),
    .reg_file_dst_out(ID_reg_reg_file_dst_out),
	  .val_Rn_out(ID_reg_val_Rn_out), .val_Rm_out(ID_reg_val_Rm_out),
	  .signed_immediate_out(ID_reg_signed_immediate_out),
	  .shifter_operand_out(ID_reg_shifter_operand_out),
    .EX_command_out(ID_reg_EX_command_out),
	  .mem_read_out(ID_reg_mem_read_out), .mem_write_out(ID_reg_mem_write_out),
		.WB_en_out(ID_reg_WB_en_out),
		.Imm_out(ID_reg_Imm_out),
		.B_out(ID_reg_B_out),
    .SR_update_out(ID_reg_SR_update_out),
    .status_register_in(status),
    .status_register_out(ID_reg_SR_out)
  );

  wire [`WORD_WIDTH-1:0] EXE_stage_pc_out;
  wire [`WORD_WIDTH-1:0] EXE_stage_instruction_out;
  wire [`REG_FILE_DEPTH-1:0] EXE_stage_reg_file_dst_out;
  wire [`WORD_WIDTH-1:0] EXE_stage_val_Rm_out;
  wire [3:0] EXE_stage_SR_out;
  wire [`WORD_WIDTH-1:0] ALU_res;
  wire EXE_stage_mem_read_out, EXE_stage_mem_write_out,
    EXE_stage_WB_en_out;

  EXE_Stage EXE_Stage_Inst(
    .clk(clk),
    .rst(rst),
    .pc_in(ID_reg_pc_out),
    .instruction_in(ID_reg_instruction_out),
    .signed_immediate(ID_reg_signed_immediate_out),
    .EX_command(ID_reg_EX_command_out),
    .SR_in(ID_reg_SR_out),
    .shifter_operand(ID_reg_shifter_operand_out),
    .dst_in(ID_reg_reg_file_dst_out),
    .mem_read_in(ID_reg_mem_read_out), .mem_write_in(ID_reg_mem_write_out),
    .imm(ID_reg_Imm_out),
    .WB_en_in(ID_reg_WB_en_out),
    .B_in(ID_reg_B_out),
    .val_Rn_in(ID_reg_val_Rn_out), .val_Rm_in(ID_reg_val_Rm_out),
    .dst_out(EXE_stage_reg_file_dst_out),
    .SR_out(EXE_stage_SR_out),
    .ALU_res(ALU_res),
    .val_Rm_out(EXE_stage_val_Rm_out),
    .branch_address(branch_address),
    .mem_read_out(EXE_stage_mem_read_out), .mem_write_out(EXE_stage_mem_write_out),
    .WB_en_out(EXE_stage_WB_en_out),
    .B_out(EXE_stage_B_out),
    .pc(EXE_stage_pc_out),
    .instruction(EXE_stage_instruction_out)
  );

  wire [`WORD_WIDTH-1:0] EXE_reg_pc_out;
  wire [`WORD_WIDTH-1:0] EXE_reg_instruction_out;
  wire [`REG_FILE_DEPTH-1:0] EXE_reg_dst_out;
  wire [`WORD_WIDTH-1:0] EXE_reg_ALU_res_out;
  wire [`WORD_WIDTH-1:0] EXE_reg_val_Rm_out;
  wire EXE_reg_mem_read_out, EXE_reg_mem_write_out, EXE_reg_WB_en_out;

  EXE_Reg EXE_Reg_Inst(
    .clk(clk),
    .rst(rst),
    .pc_in(EXE_stage_pc_out),
    .instruction_in(EXE_stage_instruction_out),
    .dst_in(EXE_stage_reg_file_dst_out),
    .mem_read_in(EXE_stage_mem_read_out), .mem_write_in(EXE_stage_mem_write_out),
    .WB_en_in(EXE_stage_WB_en_out),
    .val_Rm_in(EXE_stage_val_Rm_out),
    .ALU_res_in(ALU_res),
    .dst_out(EXE_reg_dst_out),
    .ALU_res_out(EXE_reg_ALU_res_out),
    .val_Rm_out(EXE_reg_val_Rm_out),
    .mem_read_out(EXE_reg_mem_read_out), .mem_write_out(EXE_reg_mem_write_out),
    .WB_en_out(EXE_reg_WB_en_out),
    .pc(EXE_reg_pc_out),
    .instruction(EXE_reg_instruction_out)
  );

  wire [`WORD_WIDTH-1:0] MEM_stage_pc_out;
  wire [`WORD_WIDTH-1:0] MEM_stage_instruction_out;

  MEM_Stage MEM_Stage_Inst(
    .clk(clk),
    .rst(rst),
    .pc_in(EXE_reg_pc_out),
    .instruction_in(EXE_reg_instruction_out),
    .pc(MEM_stage_pc_out),
    .instruction(MEM_stage_instruction_out)
  );

  wire [`WORD_WIDTH-1:0] MEM_reg_pc_out;
  wire [`WORD_WIDTH-1:0] MEM_reg_instruction_out;

  MEM_Reg MEM_Reg_Inst(
    .clk(clk),
    .rst(rst),
    .pc_in(MEM_stage_pc_out),
    .instruction_in(MEM_stage_instruction_out),
    .pc(MEM_reg_pc_out),
    .instruction(MEM_reg_instruction_out)
  );

  wire [`WORD_WIDTH-1:0] WB_stage_pc_out;
  wire [`WORD_WIDTH-1:0] WB_stage_instruction_out;

  WB_Stage WB_Stage_Inst(
    .clk(clk),
    .rst(rst),
    .pc_in(MEM_reg_pc_out),
    .instruction_in(MEM_reg_instruction_out),
    .pc(WB_stage_pc_out),
    .instruction(WB_stage_instruction_out)
  );

  Status_Reg Status_Reg_Inst(
    .clk(clk),
    .rst(rst),
    .load(ID_reg_SR_update_out),
    .status_in(EXE_stage_SR_out),
    .status(status)
  );

endmodule
