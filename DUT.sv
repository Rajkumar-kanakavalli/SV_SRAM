//---------------SRAM DUT-----------------------------------------

module  sram_dut(sram_if dut_if);
 
     reg[31:0]mem[0:5];
	 
	 always@(posedge dut_if.clk)
	  begin
	         if(dut_if.rst) 
	       begin
		       for(int i=0;i<10;i++)
		           mem[i]<=0;
				   end 
		    
	else if(dut_if.rst==0)
		   begin
		if(dut_if.wr==1&& dut_if.rd==0)
		    
		   mem[dut_if.addr] <= dut_if.wdata;  //addr =wdata
		   
		   //foreach (mem[i])
			 // $display("wdata in mem[%0d]=%0d",i,mem[i]);
	      
		  else if(dut_if.rd==1&& dut_if.wr==0)
		  dut_if.rdata <= mem[dut_if.addr];    //rdata =addr
		   
		 
		 end
		 
	end
endmodule