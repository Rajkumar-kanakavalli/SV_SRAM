//------------SRAM Scoreboard----------------
class scoreboard;
   packet ref_pkt;  //handle creation
   packet got_pkt;
   
   mailbox #(packet) ipm_sbd;  //mailbox creation
   mailbox #(packet) opm_sbd;
   
   
    bit[15:0]match;
    bit [15:0]mismatch;
   
   function new(input mailbox #(packet) ipm_sbd,
                input mailbox #(packet) opm_sbd);
	
	this.ipm_sbd = ipm_sbd;
	this.opm_sbd = opm_sbd;
	endfunction
	 
	extern task run();
	
	endclass
 //--------------------------------------------------  
 task scoreboard::run(); //  :: Scope Resolution Operator
       $display("--------------SCOREBOARD RUN STARTED-----------",$time);
	   
	   //ref_pkt=new;
	   //got_pkt=new;
	   
	       while(1)   //acts as forevr loop
	       begin
		        ipm_sbd.get(ref_pkt);
		        opm_sbd.get(got_pkt);
		   
		   if(ref_pkt.rdata == got_pkt.rdata)
			begin
			 match++;
			 
		       $display("[SCOREBOARD] packet=%0d",match++);
		       $display("[SOCREBOARD ref_pkt] Value of Addr=%0d, Value of wdata=%0d, Value of wr=%0d, Value of rd=%0d, Value of rdata=%0d ",ref_pkt.addr,ref_pkt.wdata,ref_pkt.wr,ref_pkt.rd,ref_pkt.rdata);
		       $display("[SOCREBOARD got_pkt] Value of Addr=%0d, Value of wdata=%0d, Value of wr=%0d, Value of rd=%0d, Value of rdata=%0d ",got_pkt.addr,got_pkt.wdata,got_pkt.wr,got_pkt.rd,got_pkt.rdata);
			   $display("\n******************TEST CASE PASS*************");
		      end
		 else
			  begin
			  mismatch++;
			  $display("[SCOREBOARD] packet=%0d",mismatch++);
		      $display("[SOCREBOARD ref_pkt] Value of Addr=%0d, Value of wdata=%0d, Value of wr=%0d, Value of rd=%0d, Value of rdata=%0d ",ref_pkt.addr,ref_pkt.wdata,ref_pkt.wr,ref_pkt.rd,ref_pkt.rdata);
		       $display("[SOCREBOARD got_pkt] Value of Addr=%0d, Value of wdata=%0d, Value of wr=%0d, Value of rd=%0d, Value of rdata=%0d ",got_pkt.addr,got_pkt.wdata,got_pkt.wr,got_pkt.rd,got_pkt.rdata);
			  $display("*********************TEST CASE FAILED*************");
			  end
			  //$display("************SOCREBOARD RUN END*****************");
			 end
			 endtask
