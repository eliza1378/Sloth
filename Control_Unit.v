`include "settings.h"

module Control_Unit
(
    input        S,
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

endmodule