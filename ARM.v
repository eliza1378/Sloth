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

  wire [`WORD_WIDTH-1:0] ID_stage_pc_out;
  wire [`WORD_WIDTH-1:0] ID_stage_instruction_out;

  ID_Stage ID_Stage_Inst(
    .clk(clk),
    .rst(rst),
    .pc_in(IF_reg_pc_out),
    .instruction_in(IF_reg_instruction_out),
    .pc(ID_stage_pc_out),
    .instruction(ID_stage_instruction_out)
  );

  wire [`WORD_WIDTH-1:0] ID_reg_pc_out;
  wire [`WORD_WIDTH-1:0] ID_reg_instruction_out;

  ID_Reg ID_Reg_Inst(
    .clk(clk),
    .rst(rst),
    .pc_in(ID_stage_pc_out),
    .instruction_in(ID_stage_instruction_out),
    .pc(ID_reg_pc_out),
    .instruction(ID_reg_instruction_out)
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
  
endmodule
