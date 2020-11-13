`include "settings.h"

module ARM
(
  input clk,
  input rst
);

  wire [`WORD_WIDTH-1:0] IF_stage_pc_out;
  wire [`WORD_WIDTH-1:0] IF_stage_instruction_out;

  IF_Stage  IF_Stage_Inst (
   .clk(clk),
   .rst(rst),
   .freeze(1'b0),
   .branch_taken(1'b0),
   .branch_addr(32'b0),
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
	wire [`WORD_WIDTH-1:0] 						ID_stage_reg_file_out1, ID_stage_reg_file_out2;
	wire [`SIGNED_IMM_WIDTH-1:0] 			ID_stage_signed_immediate;
	wire [`SHIFTER_OPERAND_WIDTH-1:0] ID_stage_shifter_operand;
	wire [3:0] 												ID_stage_EX_command_out;
	wire [3:0]              status;
	wire ID_stage_mem_read_out, ID_stage_mem_write_out,
		ID_stage_WB_en_out,
		ID_stage_Imm_out,
		ID_stage_B_out,
		ID_stage_update_out;

  ID_Stage ID_Stage_Inst(
    .clk(clk),
    .rst(rst),
    .pc_in(IF_reg_pc_out),
    .instruction_in(IF_reg_instruction_out),
    .status_register(status),
    .pc(ID_stage_pc_out),
    .instruction(ID_stage_instruction_out),
	  .reg_file_dst(ID_stage_reg_file_dst),
	  .reg_file_out1(ID_stage_reg_file_out1), .reg_file_out2(ID_stage_reg_file_out2),
	  .signed_immediate(ID_stage_signed_immediate),
	  .shifter_operand(ID_stage_shifter_operand),
	  .EX_command_out(ID_stage_EX_command_out),
	  .mem_read_out(ID_stage_mem_read_out), .mem_write_out(ID_stage_mem_write_out),
		.WB_en_out(ID_stage_WB_en_out),
		.Imm_out(ID_stage_Imm_out),
		.B_out(ID_stage_B_out),
		.update_out(ID_stage_update_out)
  );

  wire [`WORD_WIDTH-1:0] ID_reg_pc_out;
  wire [`WORD_WIDTH-1:0] ID_reg_instruction_out;
  wire [`REG_FILE_DEPTH-1:0] ID_reg_reg_file_dst_out;
  wire [`WORD_WIDTH-1:0] ID_reg_reg_file_out1_out, ID_reg_reg_file_out2_out;
  wire [`SIGNED_IMM_WIDTH-1:0] ID_reg_signed_immediate_out;
  wire [`SHIFTER_OPERAND_WIDTH-1:0] ID_reg_shifter_operand_out;
  wire [3:0] status_register_out, ID_reg_EX_command_out;
  wire ID_reg_mem_read_out, ID_reg_mem_write_out,
    ID_reg_WB_en_out,
    ID_reg_Imm_out,
    ID_reg_B_out,
    ID_reg_update_out;

  ID_Reg ID_Reg_Inst(
    .clk(clk),
    .rst(rst),
    .pc_in(ID_stage_pc_out),
    .instruction_in(ID_stage_instruction_out),
    .reg_file_dst_in(ID_stage_reg_file_dst),
	  .reg_file_out1_in(ID_stage_reg_file_out1), .reg_file_out2_in(ID_stage_reg_file_out2),
	  .signed_immediate_in(ID_stage_signed_immediate),
	  .shifter_operand_in(ID_stage_shifter_operand),
    .EX_command_in(ID_stage_EX_command_out),
	  .mem_read_in(ID_stage_mem_read_out), .mem_write_in(ID_stage_mem_write_out),
		.WB_en_in(ID_stage_WB_en_out),
		.Imm_in(ID_stage_Imm_out),
		.B_in(ID_stage_B_out),
		.update_in(ID_stage_update_out),
    .pc(ID_reg_pc_out),
    .instruction(ID_reg_instruction_out),
    .reg_file_dst_out(ID_reg_reg_file_dst_out),
	  .reg_file_out1_out(ID_reg_reg_file_out1_out), .reg_file_out2_out(ID_reg_reg_file_out2_out),
	  .signed_immediate_out(ID_reg_signed_immediate_out),
	  .shifter_operand_out(ID_reg_shifter_operand_out),
    .EX_command_out(ID_reg_EX_command_out),
	  .mem_read_out(ID_reg_mem_read_out), .mem_write_out(ID_reg_mem_write_out),
		.WB_en_out(ID_reg_WB_en_out),
		.Imm_out(ID_reg_Imm_out),
		.B_out(ID_reg_B_out),
    .update_out(ID_reg_update_out),
    .status_register_in(status),
    .status_load_in(),
    .status_register_out(status_register_out),
    .status_load_out()
  );

  wire [`WORD_WIDTH-1:0] EXE_stage_pc_out;
  wire [`WORD_WIDTH-1:0] EXE_stage_instruction_out;

  EXE_Stage EXE_Stage_Inst(
    .clk(clk),
    .rst(rst),
    .pc_in(ID_reg_pc_out),
    .instruction_in(ID_reg_instruction_out),
    .pc(EXE_stage_pc_out),
    .instruction(EXE_stage_instruction_out)
  );

  wire [`WORD_WIDTH-1:0] EXE_reg_pc_out;
  wire [`WORD_WIDTH-1:0] EXE_reg_instruction_out;

  EXE_Reg EXE_Reg_Inst(
    .clk(clk),
    .rst(rst),
    .pc_in(EXE_stage_pc_out),
    .instruction_in(EXE_stage_instruction_out),
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
    .load(),
    .status_in(),
    .status(status)
  );

endmodule

