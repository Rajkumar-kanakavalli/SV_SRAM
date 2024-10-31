//--------------Output Monitor------------------
class output_monitor;
    packet pkt;
	mailbox #(packet) mbx;
	virtual sram_if.tb_mon_out vif;
	
	function new( mailbox #(packet) mbx_in,
	             input virtual sram_if.tb_mon_out vif);
	this.mbx = mbx_in;
	this.vif = vif;
	endfunction
	
	extern task run();
	endclass
//------------------------------------------------------------
  task output_monitor::run(); //  :: Scope Resolution Operator
   
   
   $display("\n----------OUTPUT MONITOR RUN STARTED---------------");
   $display("[OUTPUT MONITOR] Run started at time=%0t ",$time);
   
    forever
	
	   begin
	    pkt= new();
		@(vif.cb_mon_out.rdata);
		//Pin level to Packet level conversion
	    pkt.wr = vif.cb_mon_out.wr;
		pkt.rd = vif.cb_mon_out.rd;
		
		pkt.addr = vif.cb_mon_out.addr;        
	    pkt.wdata = vif.cb_mon_out.wdata;
	    pkt.rdata = vif.cb_mon_out.rdata;
		#10;
		$display($time,"[OUTPUT MONITOR] Value of Addr=%0d \n Value of wdata=%0d \n Value of wr=%0d \n Value of rd=%0d \n Value of rdata=%0d \n ",pkt.addr,pkt.wdata,pkt.wr,pkt.rd,pkt.rdata);		  
		mbx.put(pkt);
        //pkt.print();
		$display("-----------OUTPUT MONITOR END---------- \n");
		
		end
		endtask
