`include "environment.sv"
 class  base_test;
     
	 environment env;
	 bit [3:0]no_of_pkts;
	 
	 virtual sram_if.tb vif_in;
	 virtual sram_if.tb_mon_in vif_mon_in;
	 virtual sram_if.tb_mon_out vif_mon_out;
	 
	 function new(input virtual sram_if.tb vif_in,
	              input virtual sram_if.tb_mon_in vif_mon_in,
				  input virtual sram_if.tb_mon_out vif_mon_out);
	this.vif_in = vif_in;
	this.vif_mon_in = vif_mon_in;
	this.vif_mon_out = vif_mon_out;
	endfunction
	
	function  void build();
	  no_of_pkts = 5;
      env = new(vif_in,vif_mon_in,vif_mon_out,no_of_pkts);
    endfunction
 
   task run();
     $display("\n [TEST CASE] Run started at time=%0t",$time);
     build();
     env.run();
     $display("[TEST CASE] Run ended at time=%0t",$time);
   endtask
	
	
	//extern function  build();
	//extern task run();
	
endclass



 
	