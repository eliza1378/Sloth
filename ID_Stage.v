`include "settings.h"

module ID_Stage
(
    input                    clk,
    input                    rst,
    input  [`WORD_WIDTH-1:0] pc_in,
    input  [`WORD_WIDTH-1:0] instruction_in,
    output [`WORD_WIDTH-1:0] pc,
    output [`WORD_WIDTH-1:0] instruction,
    output [3:0] EX_command,
    output [`REG_FILE_DEPTH-1:0] reg_file_src1, reg_file_src2,
	output [`REG_FILE_DEPTH-1:0] reg_file_dst,
    output [`WORD_WIDTH-1:0] reg_file_out1, reg_file_out2,
	output [`SIGNED_IMM_WIDTH-1:0] signed_immediate,
	output [`SHIFTER_OPERAND_WIDTH-1:0] shifter_operand,
	output mem_read, mem_write,
		WB_en,
        Imm,
		B,
        update
);

    assign pc = pc_in;
    assign instruction = instruction_in;

    wire [9:0] control_unit_mux_in, control_unit_mux_out;

    MUX_2_to_1 MUX_2_to_1_Reg_File (
			.in1(instruction_in[15:12]), .in2(instruction_in[3:0]),
			.sel(mem_write),
			.out(reg_file_src2));

	Register_File register_file(
		.clk(clk), .rst(rst),
        .WB_en(WB_en),
		.src1(reg_file_src1), .src2(reg_file_src2),
		.WB_dest(reg_file_wb_address),
		.WB_result(reg_file_wb_data),
		.reg1(reg_file_out1), .reg2(reg_file_out2)
	);

    Control_Unit Control_Unit_Inst (
		.S(instruction_in[20]), .I(instruction_in[25]),
        .mode(instruction_in[27:26]), .op_code(instruction_in[24:21]),
		.EX_command(EX_command),
		.mem_read(mem_read), .mem_write(mem_write),
		.WB_en(WB_en), .Imm(Imm),
		.B(B),
		.update(update)
	);

	assign shifter_operand = instruction_in[11:0];
	assign reg_file_dst = instruction_in[15:12];
    assign reg_file_src1 = instruction_in[19:16];
	assign signed_immediate = instruction_in[23:0];

endmodule