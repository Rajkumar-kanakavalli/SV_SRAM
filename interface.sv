//---------------SRAM Interface-----------------------------
interface sram_if(input clk,input rst);
 
      logic wr,rd;
	  logic[7:0]addr;
	  logic [7:0]wdata;
	  logic [7:0]rdata;
	  
	clocking cb @(posedge clk);   //Clocking Block for DUT
	      output addr;
		  output wdata;
		  output wr,rd;
		  input  rdata;
	endclocking 
	
	clocking cb_mon_in @ (posedge clk);    //Clocking Block for Input Monitor
	     input addr;
		 input wdata;
		 input wr,rd;
		 output rdata;
	endclocking
	
	clocking cb_mon_out @(posedge clk);  //Clocking Block for Output Monitor
	   input  rdata;
	   input addr;
	   input wdata;
	   input wr,rd;
	endclocking 
	
	//------------MODPORT DECLARATION-------------------------
	modport tb       (clocking cb,output clk,output rst);
	
	modport tb_mon_in (clocking cb_mon_in);
	
	modport tb_mon_out (clocking cb_mon_out);
	
endinterface