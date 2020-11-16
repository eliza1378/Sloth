`include "settings.h"

module ALU
(
    input       [`WORD_WIDTH-1:0]   val1, val2,  
    input                           Carry,
    input       [3:0]               EX_command,
    output  [`WORD_WIDTH-1:0]   res,
    output  [3:0]               SR_update
);

    wire Z1, C1, N1, V1;
    reg [`WORD_WIDTH:0] temp_res;

    assign res = temp_res[`WORD_WIDTH-1:0];
    assign SR_update = {Z1, C1, N1, V1};

    assign N1 = res[`WORD_WIDTH-1];
    assign Z1 = |res ? 0:1;
    assign C1 = temp_res[`WORD_WIDTH];
    assign V1 = 1'b0;

    always @(*) begin
        case (EX_command)
            `EX_MOV: begin
                temp_res = val2;
            end
            `EX_MVN: begin
                temp_res = ~val2;
            end
            `EX_ADD: begin
                temp_res = val1 + val2;
            end
            `EX_ADC: begin
                temp_res = val1 + val2 + Carry;
            end
            `EX_SUB: begin
                temp_res = val1 - val2;
            end
            `EX_SBC: begin
                temp_res = val1 - val2 - 2'b01;
            end
            `EX_AND: begin
                temp_res = val1 & val2;
            end
            `EX_ORR: begin
                temp_res = val1 | val2;
            end
            `EX_EOR: begin
                temp_res = val1 ^ val2;
            end
            `EX_CMP: begin
                temp_res = val1 - val2;
            end
            `EX_TST: begin
                temp_res = val1 & val2;
            end
            `EX_LDR: begin
                temp_res = val1 + val2;
            end
            `EX_STR: begin
                temp_res = val1 - val2;
            end
            default:
                temp_res = 3'bx;
            
        endcase
    end

endmodule