//`include "transaction.sv"
class driver;
  int tx_count1=0;
  int tx_count2=0;
  
  virtual async_fifo_if intf_vi;
  mailbox gen2driv;
  
 
  function new(virtual async_fifo_if intf_vi, mailbox gen2driv);
    this.intf_vi = intf_vi;
    this.gen2driv = gen2driv;
  endfunction
  
 //`include "transaction.sv" 
  
  task reset;
    intf_vi.wr_rstn <= 0;
    intf_vi.rd_rstn <= 0;
    wait(!intf_vi.wr_rstn);
    $display("[ DRIVER ] ****** RESET STARTED ******");
    intf_vi.wr_inc <= 0;
    intf_vi.wr_data <= 0;
    intf_vi.rd_inc <= 0;
    intf_vi.rd_data <= 0;
    repeat(2) @(posedge intf_vi.wr_clk);
    intf_vi.wr_rstn <= 1'b1;
    intf_vi.rd_rstn <= 1'b1;
    wait(intf_vi.wr_rstn);
    $display("[ DRIVER ] ****** RESET ENDED ******");
  endtask
  
  task main;
    $display("[ DRIVER ] ****** DRIVER STARTED ******");
    
    forever begin
	  transaction tx;  
      gen2driv.get(tx);
      intf_vi.uniq_id = tx.uniq_id;
      
      @(posedge intf_vi.wr_clk);
      tx_count1++;
      intf_vi.uniq_id =tx.uniq_id;
      intf_vi.wr_data = tx.wr_data;
      if(intf_vi.uniq_id ==1)
        $display("[ DRIVER ] wdata =%h uniq_id =%d \n",intf_vi.wr_data,intf_vi.uniq_id);
     
      if (intf_vi.wr_inc== 1'b1) tx_count2++;
    end
    
    $display("[ DRIVER ] ****** DRIVER ENDED ******");
  endtask
endclass