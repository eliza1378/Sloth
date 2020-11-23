`include "settings.h"

module TB;
  parameter clock_period = `CLOCK_PERIOD;

  reg clk;
  reg rst;


  ARM CPU(
    .clk(clk),
    .rst(rst)
  );

  initial begin
    clk = 0;
    forever clk = #clock_period ~clk;
  end

  initial begin
    rst = 1;
    # (clock_period / 2);
    rst = 0;
    // # clock_period;
    // rst = 1;
    // # clock_period;
    // rst = 0;
    # (20*clock_period);
    $stop;
  end

endmodule



















// `include "settings.h"

// module ARM_TB1;
//     parameter clock_period = `CLOCK_PERIOD;

//     reg clk, rst;
    
//     reg [`REG_FILE_DEPTH-1:0] EXE_reg_dst_out;
//     reg [`WORD_WIDTH-1:0] EXE_reg_ALU_res_out;
//     reg [`WORD_WIDTH-1:0] EXE_reg_val_Rm_out;
//     reg EXE_reg_mem_read_out, EXE_reg_mem_write_out, EXE_reg_WB_en_out;

//     wire [`REG_FILE_DEPTH-1:0] WB_Stage_dst_out;
//     wire [`WORD_WIDTH-1:0] WB_Value;
//     wire WB_Stage_WB_en_out;


//     wire [`REG_FILE_DEPTH-1:0] Mem_Stage_dst_out;
//     wire [`WORD_WIDTH-1:0] Mem_Stage_ALU_res_out;
//     wire [`WORD_WIDTH-1:0] Mem_Stage_mem_out;
//     wire Mem_Stage_read_out, Mem_Stage_WB_en_out;
  
//   Mem_Stage Mem_Stage_Inst(
//     .clk(clk),
//     .rst(rst),
//     .dst(EXE_reg_dst_out),
//     .ALU_res(EXE_reg_ALU_res_out),
//     .val_Rm(EXE_reg_val_Rm_out),
//     .mem_read(EXE_reg_mem_read_out),
//     .mem_write(EXE_reg_mem_write_out), 
//     .WB_en(EXE_reg_WB_en_out),
//     .dst_out(Mem_Stage_dst_out),
//     .ALU_res_out(Mem_Stage_ALU_res_out),
//     .mem_out(Mem_Stage_mem_out),
//     .mem_read_out(Mem_Stage_read_out), 
//     .WB_en_out(Mem_Stage_WB_en_out)
//   );

//   wire [`REG_FILE_DEPTH-1:0] Mem_Reg_dst_out;
//   wire [`WORD_WIDTH-1:0] Mem_Reg_ALU_res_out;
//   wire [`WORD_WIDTH-1:0] Mem_Reg_mem_out;
//   wire Mem_Reg_read_out, Mem_Reg_WB_en_out;
  
//   MEM_Reg Mem_Reg_Inst(
//     .clk(clk),
//     .rst(rst),
//     .dst(Mem_Stage_dst_out),
//     .ALU_res(Mem_Stage_ALU_res_out),
//     .mem(Mem_Stage_mem_out),
//     .mem_read(Mem_Stage_read_out), 
//     .WB_en(Mem_Stage_WB_en_out),

//     .dst_out(Mem_Reg_dst_out),
//     .ALU_res_out(Mem_Reg_ALU_res_out),
//     .mem_out(Mem_Reg_mem_out),
//     .mem_read_out(Mem_Reg_read_out), 
//     .WB_en_out(Mem_Reg_WB_en_out)
//   );

//   WB_Stage WB_Stage_Inst(
//     .clk(clk),
//     .rst(rst),
//     .dst(Mem_Reg_dst_out),
//     .ALU_res(Mem_Reg_ALU_res_out),
//     .mem(Mem_Reg_mem_out),
//     .mem_read(Mem_Reg_read_out),
//     .WB_en(Mem_Reg_WB_en_out),
//     .WB_Dest(WB_Stage_dst_out),
//     .WB_en_out(WB_Stage_WB_en_out),
//     .WB_Value(WB_Value)
//   );

//     initial begin
//         clk = 0;
//         forever clk = #clock_period ~clk;
//     end

//     // reg [`REG_FILE_DEPTH-1:0] EXE_reg_dst_out;
//     // reg [`WORD_WIDTH-1:0] EXE_reg_ALU_res_out;
//     // reg [`WORD_WIDTH-1:0] EXE_reg_val_Rm_out;
//     // reg EXE_reg_mem_read_out, EXE_reg_mem_write_out, EXE_reg_WB_en_out;

//     initial begin
//         rst = 1;
//         # (clock_period);
//         rst = 0;
//         EXE_reg_dst_out = `REG_FILE_DEPTH'b1011;
//         EXE_reg_ALU_res_out = `WORD_WIDTH'b0000000000000000000000000000_1111;
//         EXE_reg_val_Rm_out =  `WORD_WIDTH'b0000000000000000000000000000_1001;
//         EXE_reg_mem_read_out = 1'b1;
//         EXE_reg_mem_write_out = 1'b0;
//         EXE_reg_WB_en_out = 1'b0;
//         # (clock_period*2);

//         EXE_reg_dst_out = `REG_FILE_DEPTH'b0011;
//         EXE_reg_ALU_res_out = `WORD_WIDTH'b0000000000000000000000000000_0011;
//         EXE_reg_val_Rm_out =  `WORD_WIDTH'b0000000000000000000000000000_1011;
//         EXE_reg_mem_read_out = 1'b0;
//         EXE_reg_mem_write_out = 1'b1;
//         EXE_reg_WB_en_out = 1'b0;
//         # (clock_period*2);

//         EXE_reg_dst_out = `REG_FILE_DEPTH'b0010;
//         EXE_reg_ALU_res_out = `WORD_WIDTH'b0000000000000000000000000000_1111;
//         EXE_reg_val_Rm_out =  `WORD_WIDTH'b0000000000000000000000000000_0011;
//         EXE_reg_mem_read_out = 1'b1;
//         EXE_reg_mem_write_out = 1'b1;
//         EXE_reg_WB_en_out = 1'b1;
//         # (16*clock_period);
//         $stop;
//     end

//     // initial begin
//     //     $monitor("@%3tns: pc = %0d , instruction = %0d",
//     //     $time, CPU.WB_Stage_Inst.pc, CPU.WB_Stage_Inst.instruction);
//     //     end

// endmodule