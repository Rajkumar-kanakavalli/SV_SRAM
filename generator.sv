 //------------SRAM Generator------------------
class  generator;
   packet pkt;
   mailbox #(packet) gen_box;
   //event e;
   //int repeat_count;
   bit [3:0]no_of_pkts;
   
   function new(mailbox #(packet) mbx,bit [3:0]no_of_pkts);                 //int repeat_count); //Explicit Object Argument
    this.gen_box = mbx;
	this.no_of_pkts = no_of_pkts;
	//this.e = e;
	//this.repeat_count=repeat_count;
   endfunction
 
    extern task run();
  
 endclass
 //----------------------------------------
 task generator::run();
 $display("\n--------------Generator RUN STARTED---------------");
     pkt = new();
   repeat(no_of_pkts)
       begin
	   $display($time,"[Generator] number of Packets=%0d",no_of_pkts);
	   assert(pkt.randomize());
	   
	   $display("[Generator] Value of Addr=%0d \n Value of wdata=%0d \n Value of wr=%0d \n value of rd=%0d \n Value of rdata=%0d \n",pkt.addr,pkt.wdata,pkt.wr,pkt.rd,pkt.rdata);
	   
	   gen_box.put(pkt);
	   //#10;
	   //->e;    //Triggering event
      end
	  $display("--------------Generator RUN END-------------");
	  
endtask
   
   