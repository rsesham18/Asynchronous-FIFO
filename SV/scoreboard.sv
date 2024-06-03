
class scoreboard;
  mailbox mon_in2scb;
  mailbox mon_out2scb;
  virtual intfc vif;
  logic [7:0] rddata_fifo[$];
  logic [7:0] wrdata_fifo[$]; 
  int fd;
  logic [8-1:0] verif_data_q[$];
  int verif_data_id[$];
  logic [8-1:0] verif_wrdata;
  int verif_id;
 function new(virtual intfc vif, mailbox mon_in2scb, mailbox mon_out2scb);
    this.vif = vif;
    this.mon_in2scb  = mon_in2scb;
    this.mon_out2scb = mon_out2scb;
  endfunction
  
  task main;
	fork 
      get_data_w();
      get_data_r();
    join_none;
  endtask
  
  task get_data_w();
    
     transaction tx;
   
   for(int i=0;i <100;i++) begin
      
     @(posedge vif.wr_clk iff !vif.full);
        
     if (vif.wr_en) begin
          mon_in2scb.get(tx);
       verif_data_q.push_front(tx.data_in); 
           verif_data_id.push_front(tx.uniq_id); 
         if(tx.uniq_id==1)
           $display("[SCOREBOARD] wdata =%h, uniq_id=%d",tx.data_in,tx.uniq_id);
        end
     end 
    
  endtask
  task get_data_r();
    
     transaction tx;
    
    fd= $fopen("output1.txt","w");
    $fdisplay(fd,"Team1 scoreboard results");

    for(int j=0;j<100;j++) begin
      @(posedge vif.rd_clk iff !vif.empty)
        vif.rd_en = (j%3 == 0)? 1'b1 : 1'b0;
      if ((vif.rd_en) &&(j!=0)) begin
          verif_wrdata = verif_data_q.pop_back();
          verif_id = verif_data_id.pop_back();
              mon_out2scb.get(tx);
        if(tx.data_out === verif_wrdata) 
		$display("PASS : expected wr_ata = %h, rd_data = %h, uniq_id=%d", verif_wrdata, tx.data_out,verif_id);
	else 
		$error("Checking failed: expected wr_data = %h, rd_data = %h,uniq_id=%d", verif_wrdata, tx.data_out, verif_id);
     end      
  end 
      mon_out2scb.get(tx);
  endtask
endclass
