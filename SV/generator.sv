`include "transaction.sv"

class generator;
  rand transaction tx;  //instantiating transaction class
  mailbox gen2driv;  //instantiating mailbox and creating object
  virtual intfc bus_tb; //instantiating interface using virtual keyword
  int tx_count;
  int uniq_id;
  logic [8-1:0] verif_data_q[$];
  logic [8-1:0] verif_wrdata;
  int i;
  event ended;

  //constructor 
  function new(virtual intfc bus_tb, mailbox gen2driv);
    this.bus_tb = bus_tb; /// Assign the passed interface to the member variable
    this.gen2driv = gen2driv; /// Assign the passed mailbox to the member variable
  endfunction
  
  
  task main();
    $display("[ GENERATOR ] ****** GENERATOR STARTED ******");

    //creating a transaction
   tx = new();
fork 
   //write enable transaction generation
     for(int i=0;i <tx_count;i++) begin
       @(posedge bus_tb.wr_clk iff !bus_tb.full);
         bus_tb.wr_en = (i%1 == 0)? 1'b1 : 1'b0;
        
       if (bus_tb.wr_en) begin
          uniq_id ++;
          assert(tx.randomize());
          tx.uniq_id= uniq_id;
          gen2driv.put(tx);    // putting randomized transaction in the mailbox 
         verif_data_q.push_front(bus_tb.data_in); 
          if(tx.uniq_id==1) begin
             $display("[ GENERATOR ]wdata  =%h, uniq_id=%d", tx.data_in,tx.uniq_id);
           end
        end
       
      end
     //rd_en transaction generation
     for(int j=0;j<tx_count;j++) begin
        @(posedge bus_tb.rd_clk iff !bus_tb.empty)
        bus_tb.rd_en = (j%3 == 0)? 1'b1 : 1'b0;
        if (bus_tb.rd_en) begin
          verif_wrdata = verif_data_q.pop_back();
        end
      end 
     join
    
   -> ended; //trigerring the event handle
    $display("[ GENERATOR ] ****** GENERATOR ENDED ******");
  endtask
endclass
