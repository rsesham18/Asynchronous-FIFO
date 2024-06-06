class monitor_in;
  virtual intfc vif; //virtual handle of interface
  mailbox mon_in2scb; // mailbox handle for monitor to scoreboard
  transaction tx=new(); // creating a transaction
int fd;

  //constructor for assigning passing mailbox and interface to member variables  
  function new(virtual intfc vif, mailbox mon_in2scb);
    this.vif = vif;
    this.mon_in2scb = mon_in2scb;
  endfunction
  
  task main;
     
    $display("[ MONITOR_IN ] ****** MONITOR_IN STARTED ******"); 
 
    forever begin

      //passing input data from stimulus to the scorboard
      @(posedge vif.wr_clk iff !vif.full);
        
      if (vif.wr_en) begin
           tx.data_in =vif.data_in;
           tx.uniq_id =vif.uniq_id;
             if(vif.uniq_id ==1)
               $display("[ MONITOR]wdata =%h,uniq_id =%d \n",tx.data_in,tx.uniq_id);
        mon_in2scb.put(tx); //putting the transsaction packet into the mailbox
         
          fd= $fopen("output1.txt","a");
        end
     end 
    
    $display("[ MONITOR_IN ] ****** MONITOR_IN ENDED ******");    
  endtask
endclass
