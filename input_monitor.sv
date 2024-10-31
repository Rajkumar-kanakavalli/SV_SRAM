//-------------SRAM Input Monitor---------------------------
class input_monitor;
     packet pkt;
	 mailbox #(packet) mbx;
	 virtual sram_if.tb_mon_in vif;
	// event e;
	 bit [31:0]mem[0:5];
	 
	 function new( mailbox	#(packet) mbx,
	              input virtual sram_if.tb_mon_in vif);
				  
	this.mbx = mbx;
	this.vif = vif;
	//this.e = e;
	endfunction
	
	extern task run();
	endclass
  //---------------------------------------------------------------
 
 task input_monitor::run();   //  :: Scope Resolution Operator
   $display("--------------INPUT Monitor RUN STARTED----------------");
   
  pkt = new();
  $display("[INPUT MONITOR] Run started at time=%0t",$time);
  while(1)
    begin
	
     //wait(e);
	 @(vif.cb_mon_in.wr or vif.cb_mon_in.rd);
	
	//Pin level to Packet level conversion
	pkt.wr = vif.cb_mon_in.wr;
	pkt.rd = vif.cb_mon_in.rd;
	
	pkt.addr = vif.cb_mon_in.addr;        
	pkt.wdata = vif.cb_mon_in.wdata;
	pkt.rdata = vif.cb_mon_in.rdata;
	
	//-------------------BFM Logic-------------------
	        begin 
		  
		      if(pkt.wr==1 && pkt.rd==0)
			  begin
		      mem[pkt.addr] <=pkt.wdata;
			  end
			  
			  //foreach (mem[i])
			  //$display("data in mem[%0d]=%0d",i,mem[i]);
			  
			  else if(pkt.rd==1&& pkt.wr==0)
			  begin
			  pkt.rdata <= mem[pkt.addr];
			  end
			  
			end
			  
			 // @(vif.cb_mon_in);
			  #10;
			  			foreach (mem[i])
			  $display("data in mem[%0d]=%0d",i,mem[i]);
			  
	         $display($time,"[INPUT MONITOR] Value of Addr=%0d \n Value of wdata=%0d \n Value of wr=%0d \n Value of rd=%0d \n Value of rdata=%0d \n ",pkt.addr,pkt.wdata,pkt.wr,pkt.rd,pkt.rdata);		  
	         mbx.put(pkt);

			 
			  $display("---------INPUT MONITOR END-------------- ");
	 
	 end
endtask
			  
	
	
	
	/* mbx.put(pkt);
	 pkt.print();
	$display("[INPUT MONITOR] at Time=%0t, Addr=%0d, wdata=%0d, w_r=%0d",$time,pkt.addr,pkt.wdata,pkt.w_r);
	
	//REFERNCE BFM LOGIC  ------OR------Dummy DUT------------
	
	//if(pkt.rst)
	  
	      // begin
		    // mem[pkt.addr] =0;  //addr=0
			// end
	//else
		 // begin
		if(pkt.w_r)
		   
		   begin 
		   $display("rrrrrrrrrrr");
		   foreach (mem[i])
		  $display("mem[%0d]=%0d",i,mem[i]);
		   mem[pkt.addr] <= pkt.wdata;  //addr =wdata
		   end
	else
	      begin
		  pkt.rdata <= mem[pkt.addr];    //rdata =addr
		   end
		//end
		mbx.put(pkt);
	 pkt.print();
	 $display("INPUT MONITOR PROCESSED \n");
	 
	 end
endtask

	
 
   */