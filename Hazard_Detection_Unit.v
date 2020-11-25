`include "settings.h"  

module Hazard_Detection_Unit (
    input  [4:0] src1,
    input  [4:0] src2, 
    input  [4:0] EXE_dest,
    input  [4:0] MEM_dest,
    input        EXE_WB_en,
    input        MEM_WB_en,
    input        has_src1,
    input        has_src2,
    output reg   hazard_detected
); 
  
  always @(*) begin
    if (src1 == EXE_dest && EXE_WB_en) begin
      hazard_detected = 1'b1;
    end
    else if (src1 == MEM_dest && MEM_WB_en) begin 
      hazard_detected = 1'b1;
    end
    else if (src2 == EXE_dest && EXE_WB_en && has_src2) begin
      hazard_detected = 1'b1;
    end
    else if (src2 == MEM_dest && MEM_WB_en && has_src2) begin
      hazard_detected = 1'b1;
    end
    else begin
      hazard_detected = 1'b0;
    end
  end
  
endmodule



