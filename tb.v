`include "settings.h"

module tb; 
  reg clk, reset; 

  wire [`WORD_WIDTH-1:0] result_pc;
  wire [`WORD_WIDTH-1:0] result_instruction; 
    
  ARM CPU(
   .clk(clk), 
   .rst(reset),
   .pc(result_pc),
   .instruction(result_instruction)
  );
    
  initial 
  begin 
    clk = 0; 
    reset = 0;
  end 
    
  always 
    #20 clk = !clk; 

  //initial
  //#10000  $finish;
    
endmodule 