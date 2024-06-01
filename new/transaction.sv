class transaction;
  parameter DATA_SIZE = 8;
  
  rand logic [DATA_SIZE-1:0] wr_data;
  logic wr_inc;
  logic wr_clk;
  logic wr_rstn;
  logic [DATA_SIZE-1:0] rd_data;
  logic rd_inc;
  logic rd_clk;
  logic rd_rstn;
  logic wr_full;
  logic rd_empty;
  int uniq_id;
  
  function void print ();
    $display("*******Transaction*******");
    $display("Inputs wdata= %0h, winc = %0h, and rdata = %0h", wr_data, wr_inc, rd_data);
  endfunction: print
  
endclass