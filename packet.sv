//-------------------SRAM Packet------------------------------
class packet;

     rand bit[7:0]addr;
     rand bit[7:0]wdata;
     bit wr,rd;             //input signals
 
       bit[7:0]rdata;
	   //constraint c {rd!=wr;}
	   
	  //extern function void print();
      // extern function void copy();   
endclass
//---------------------------------------
 
 //bit[7:0] prev_addr, prev_wdata, prev_rdata;
 
 /* constraint c1{addr inside{[0:200]};           //constraint declaration
               wdata inside {[20:100]};
			   addr !=prev_addr;
			   wdata !=prev_wdata;}
			   
   function void post();
         prev_addr = addr;
         prev_addr = wdata;
		 endfunction */	

   
       /* function void packet::print();
	   $display("[packet] started at Time=%0t",$time);
	   endfunction  */
	   
	   /* function void packet::copy();
	      $display($time,"[packet] value of Addr=%0d \n value of wdata=%0d \n value of wr=%0d \n value of rd=%0d \n Value of rdata=%0d",addr,wdata,wr,rd,rdata);
       endfunction */
    //string marchipoyav ra............