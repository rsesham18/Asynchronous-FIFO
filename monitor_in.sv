class monitor_in;
  virtual intfc vif;
  mailbox mon_in2scb;
  transaction tx=new();
int fd;
  function new(virtual intfc vif, mailbox mon_in2scb);
    this.vif = vif;
    this.mon_in2scb = mon_in2scb;
  endfunction
  
  task main;
     
    $display("[ MONITOR_IN ] ****** MONITOR_IN STARTED ******"); 
 
    forever begin
       
      @(posedge vif.wr_clk iff !vif.full);
        
      if (vif.wr_en) begin
           tx.data_in =vif.data_in;
           tx.uniq_id =vif.uniq_id;
             if(vif.uniq_id ==1)
               $display("[ MONITOR]wdata =%h,uniq_id =%d \n",tx.data_in,tx.uniq_id);
          mon_in2scb.put(tx);
         
          fd= $fopen("output1.txt","a");
        end
     end 
    
    $display("[ MONITOR_IN ] ****** MONITOR_IN ENDED ******");    
  endtask
endclass
