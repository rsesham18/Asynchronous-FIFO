`include "transaction.sv"

class generator;
  rand transaction tx;
  mailbox gen2driv;
  virtual intfc bus_tb;
  int tx_count;
  int uniq_id;
  logic [8-1:0] verif_data_q[$];
  logic [8-1:0] verif_wrdata;
  int i;
  event ended;
  function new(virtual intfc bus_tb, mailbox gen2driv);
    this.bus_tb = bus_tb;
    this.gen2driv = gen2driv;
  endfunction
  
  
  task main();
    $display("[ GENERATOR ] ****** GENERATOR STARTED ******");
 
   tx = new();
fork 
     for(int i=0;i <tx_count;i++) begin
       @(posedge bus_tb.wr_clk iff !bus_tb.full);
         bus_tb.wr_en = (i%1 == 0)? 1'b1 : 1'b0;
        
       if (bus_tb.wr_en) begin
          uniq_id ++;
          assert(tx.randomize());
          tx.uniq_id= uniq_id;
          gen2driv.put(tx);
         verif_data_q.push_front(bus_tb.data_in);
           if(tx.uniq_id==1) begin
             $display("[ GENERATOR ]wdata  =%h, uniq_id=%d", tx.data_in,tx.uniq_id);
           end
        end
       
      end
      for(int j=0;j<tx_count;j++) begin
        
        //@(posedge bus_tb.rclk)
        @(posedge bus_tb.rd_clk iff !bus_tb.empty)
        bus_tb.rd_en = (j%3 == 0)? 1'b1 : 1'b0;
        if (bus_tb.rd_en) begin
          verif_wrdata = verif_data_q.pop_back();
        end
      end 
     join
    
   -> ended;
    $display("[ GENERATOR ] ****** GENERATOR ENDED ******");
  endtask
endclass
