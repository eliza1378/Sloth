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
    # (clock_period / 2);
    rst = 0;
    // # clock_period;
    // rst = 1;
    // # clock_period;
    // rst = 0;
    # (100*clock_period);
    $stop;
  end
endmodule