 
//-----------SRAM Environment------------------------------



`include "package.sv"
import pkg::*;

class environment;
    generator gen;
	driver drv;
	input_monitor mon_in;
	output_monitor mon_out;
	scoreboard scb;
	  // 3 mailbox creations
	mailbox #(packet) gen_drv_mbx;  // Generator to Driver 
	mailbox #(packet) ipm_scb_mbx;  //Input Monitor to Scoreboard
	mailbox #(packet) opm_scb_mbx; //Output Monitor tp Scoreboard
	
	virtual sram_if.tb vif_in;
	virtual sram_if.tb_mon_in vif_mon_in;   //3interface creations
	virtual sram_if.tb_mon_out vif_mon_out;
	
	//event e;
	 // int repeat_count;
	  bit[3:0] no_of_pkts;
	function new(input virtual  sram_if.tb vif_in,
	             input virtual sram_if.tb_mon_in vif_mon_in,
				 input virtual sram_if.tb_mon_out vif_mon_out,
				 bit [3:0] no_of_pkts);
				 
	this.vif_in =  vif_in;
	this.vif_mon_in = vif_mon_in;
	this.vif_mon_out = vif_mon_out;
	this.no_of_pkts = no_of_pkts;
	endfunction
	//extern function void build();
	//extern task run();
	
	
function void build();
    gen_drv_mbx = new();
	ipm_scb_mbx = new();
	opm_scb_mbx = new();
	
	gen     = new(gen_drv_mbx,no_of_pkts);
	drv     = new(gen_drv_mbx,vif_in);
	mon_in  = new(ipm_scb_mbx,vif_mon_in);
	mon_out  = new(opm_scb_mbx,vif_mon_out);
	scb      = new(ipm_scb_mbx,opm_scb_mbx);
endfunction

task run();
     $display("\n [ENVIRONMENT] Run Started at Time=%0t",$time);
	// repeat_count =1;
	 build();
	 
	 //Start all the components of Environment
	 fork
	 gen.run();
	 drv.run();
	 mon_in.run();
	 mon_out.run();
	 scb.run();
	 join
	// repeat(100)
	 @(posedge vif_in.clk);
	 endtask
	 
	  /* function void print();
	     if(scb.j==0)
		  $display("----------TEST PASSED-----------");
		  else
		   $display("----------TEST FAILED-----------");
	 
	 $display("ENVIRONMENT END at=%0d",$time);
	 endfunction */
	 
	endclass

 

	 










	
	
	