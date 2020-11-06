`include "settings.h"

module ARM_TB;  
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
    # clock_period;
    rst = 0;
    # clock_period;
    rst = 1;
    # clock_period;
    rst = 0;
    # (5*clock_period);
    $stop;
  end
  
  initial begin
    $monitor("@%3tns: pc = %0d , instruction = %0d", 
      $time, CPU.WB_Stage_Inst.pc, CPU.WB_Stage_Inst.instruction);
    end
    
endmodule 