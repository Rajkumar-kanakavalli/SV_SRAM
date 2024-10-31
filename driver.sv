//-------------SRAM Driver---------------------
class driver;
   packet got_pkt;
   mailbox #(packet) drv_mbx;    //parameterized mailbox
  // event e;
   virtual sram_if vif_in;
   //int repeat_count;
   
   function new(input mailbox #(packet) mbx,
                input virtual sram_if vif_in);
				//int repeat_count);
				//event e);
	this.drv_mbx =mbx;
	this.vif_in = vif_in;
	//this.repeat_count= repeat_count;
	//this.e =e;
	endfunction
	
		extern task run();
	extern task write();
	extern task read();
	
endclass
//---------------------------------------------------	
   
   
   task driver::run();   // :: Scope Resolution Operator
  $display("-------------DRIVER RUN STARTED-----------------");
     forever
		  begin
		  //wait(e);
		   // got_pkt=new;
		     drv_mbx.get(got_pkt);
			 @(vif_in.cb)
			 
			 vif_in.wr = got_pkt.wr;   
             vif_in.rd = got_pkt.rd;			 
			 
			 
			 vif_in.addr = got_pkt.addr;
			 vif_in.wdata = got_pkt.wdata;
			 vif_in.rdata = got_pkt.rdata;
			 
			 write();
			// repeat(repeat_count)
			// @(posedge vif_in.clk)
			 
			 #20; 
			   read();
				 
			   $display($time,"[DRIVER ] Value of Addr=%0d  \n Value of  wdata=%0d \n Value of wr=%0d \n Value of rd=%0d \n Value of rdata=%0d",vif_in.addr,vif_in.wdata,vif_in.wr,vif_in.rd,vif_in.rdata);
			   $display("-----------------DRIVER RUN ENDED-------------------");
			   end
			 endtask
			 
	task driver::write();
	    vif_in.wr=1;     //write operation
		vif_in.rd=0;
		
	endtask
	  
	    task driver::read();
	      
		  vif_in.rd=1;     //read operation
		   vif_in.wr=0;
	  endtask 
			 
		  
		  
		  
		  
		  
		  
		  /* driver::write;     //w_r=1  Write Operation
		  vif_in.addr = got_pkt.addr;
		  vif_in.wdata = got_pkt.wdata;    //packet Level to Pin Level Conversion
		  vif_in.w_r = vif_in.w_r;
		  //vif_in.rdata = vif_in.rdata;
		  $display("[DRIVER Write] time=%0t, Addr=%0d, wdata=%0d, w_r=%0d",$time,got_pkt.addr,got_pkt.wdata,got_pkt.w_r);
		 #5;
		  
		  driver::read;     //w_r=0   Read Operation
		  vif_in.addr = got_pkt.addr;
		  vif_in.wdata = got_pkt.wdata;     //packet Level to Pin Level Conversion
		  vif_in.w_r = vif_in.w_r;
		  $display("[DRIVER Read] time=%0t, Addr=%0d, wdata=%0d, w_r=%0d",$time,got_pkt.addr,got_pkt.wdata,got_pkt.w_r);
		 // #5;
		  
		  $display("[Driver - Interface] Addr=%0d, wdata=%0d, w_r=%0d \n",vif_in.addr,vif_in.wdata,vif_in.w_r);
		  end
		  $display("-----------------DRIVER RUN ENDED-------------------");
		  endtask*/
	
      
		  