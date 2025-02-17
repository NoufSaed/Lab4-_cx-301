`include "../home/Nouf_Alsufyani/CX-301/CX-301-DesignVerification/Labs/Lab4/Task2/mem_test.sv"
`include "../home/Nouf_Alsufyani/CX-301/CX-301-DesignVerification/Labs/Lab4/Task2/top.sv"
`include "/home/Nouf_Alsufyani/CX-301/CX-301-DesignVerification/Labs/Lab4/Task2/random.sv"

module top;
timeunit 1ns;
timeprecision 1ns;

  // clock generator starts 
  bit clk = 0;
  always #5 clk = ~clk;
  // clock generator ends
  
  mem_interf mif(clk);  // SystemVerilog interface instance
  
  mem_test test (.mif(mif.tb));  // memory test
  mem memory (.mif(mif.mem));  // memory design 

  

  initial begin 
    $dumpfile("waveform.vcd");
    $dumpvars(0);
  end

endmodule

