`include "settings.h"

module Control_Unit
(
    input        S, I,
    input  [1:0] mode,
    input  [3:0] op_code,
    output [3:0] EX_command,
    output       mem_read,
    output       mem_write,
    output       WB_en,
    output       Imm,
    output       B,
    output       update
);
    reg [3:0] EX_command_reg;
    reg mem_read_reg, mem_write_reg,
        WB_en_reg,
        B_reg;

    always @(*) begin
        mem_read_reg = 0;
        mem_write_reg = 0;
        WB_en_reg = 0;
        B_reg = 0;
        case (mode)
            `MODE_MEM: begin
                case (S)
                    0: begin
                        EX_command_reg = `EX_STR;
                        mem_write_reg = 1;
                    end

                    1: begin
                        EX_command_reg = `EX_LDR;
                        mem_read_reg = 1;
                        WB_en_reg = 1;
                    end
                endcase
            end

            `MODE_ARITHMETIC: begin
                case (op_code)
                    `OP_MOV: begin
                        EX_command_reg = `EX_MOV;
                        WB_en_reg = 1;
                    end

                    `OP_MVN: begin
                        EX_command_reg = `EX_MVN;
                        WB_en_reg = 1;
                    end

                    `OP_ADD: begin
                        EX_command_reg = `EX_ADD;
                        WB_en_reg = 1;
                    end

                    `OP_ADC: begin
                        EX_command_reg = `EX_ADC;
                        WB_en_reg = 1;
                    end

                    `OP_SUB: begin
                        EX_command_reg = `EX_SUB;
                        WB_en_reg = 1;
                    end

                    `OP_SBC: begin
                        EX_command_reg = `EX_SBC;
                        WB_en_reg = 1;
                    end
                    `OP_AND: begin
                        EX_command_reg = `EX_AND;
                        WB_en_reg = 1;
                    end

                    `OP_ORR: begin
                        EX_command_reg = `EX_ORR;
                        WB_en_reg = 1;
                    end

                    `OP_EOR: begin
                        EX_command_reg = `EX_EOR;
                        WB_en_reg = 1;
                    end

                    `OP_CMP: begin
                        EX_command_reg = `EX_CMP;
                    end

                    `OP_TST: begin
                        EX_command_reg = `EX_TST;
                    end
                endcase
            end

            `MODE_BRANCH: begin
                B_reg = 1;
            end
        endcase
    end

    assign EX_command = EX_command_reg;
    assign mem_read = mem_read_reg;
    assign mem_write = mem_write_reg;
    assign WB_en = WB_en_reg;
    assign Imm = I;
    assign B = B_reg;
    assign update = S;

endmodule