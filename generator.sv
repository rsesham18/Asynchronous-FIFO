
`include "transaction.sv"

class generator;
  rand transaction tx;
  mailbox gen2driv;
  virtual async_fifo_if bus_tb;
  int tx_count;
  int uniq_id;
  logic [8-1:0] verif_data_q[$];
  logic [8-1:0] verif_wrdata;
  int i;
  event ended;
  function new(virtual async_fifo_if bus_tb, mailbox gen2driv);
    this.bus_tb = bus_tb;
    this.gen2driv = gen2driv;
  endfunction
  
  
  task main();
    $display("[ GENERATOR ] ****** GENERATOR STARTED ******");
    //$display("{Genarator} tx_count = %d,uniq_id =%d",tx_count,uniq_id);
 
   tx = new();
fork 
     for(int i=0;i <tx_count;i++) begin
       @(posedge bus_tb.wr_clk iff !bus_tb.wr_full);
         bus_tb.wr_inc = (i%1 == 0)? 1'b1 : 1'b0;
        
       if (bus_tb.wr_inc) begin
          uniq_id ++;
          assert(tx.randomize());
          tx.uniq_id= uniq_id;
          gen2driv.put(tx);
         verif_data_q.push_front(bus_tb.wr_data);
           if(tx.uniq_id==1) begin
             $display("[ GENERATOR ]wdata  =%h, uniq_id=%d", tx.wr_data,tx.uniq_id);
           end
        end
       
      end
      for(int j=0;j<tx_count;j++) begin
        
        //@(posedge bus_tb.rclk)
        @(posedge bus_tb.rd_clk iff !bus_tb.rd_empty)
        bus_tb.rd_inc = (j%3 == 0)? 1'b1 : 1'b0;
        if (bus_tb.rd_inc) begin
          verif_wrdata = verif_data_q.pop_back();
        end
      end 
     join
      
    
   -> ended;
    $display("[ GENERATOR ] ****** GENERATOR ENDED ******");
  endtask
endclass
