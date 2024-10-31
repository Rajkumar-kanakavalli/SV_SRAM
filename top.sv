`include "interface.sv"
`include "DUT.sv"
`include "program.sv"

  module top;
      bit clk,rst;
 
 always #5 clk=~clk;
 
 initial begin
 
     clk=0; rst=1;
	 
 #5   rst=0;
 
 #500; 
 $finish;
 
 end 

   sram_if intf(clk,rst);    //Interface Instantiation
   
    sram_dut dut(intf);    //DUT Instantiation
   
   program_test testbench(intf);  //program block instantiation
   
   endmodule