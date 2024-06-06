interface intfc(input bit wr_clk, rd_clk, wr_rstn, rd_rstn);
  
parameter Depth=256, Data_Width=8, Addr_Width=8;
  
logic wr_en, rd_en;
bit full, empty, half_full, half_empty;
logic [Data_Width-1:0] data_in, data_out;
logic [Addr_Width:0] rd_ptr_sync, wr_ptr_sync, wr_addr, wr_ptr,rd_addr, rd_ptr;
logic  [Data_Width-1:0] wdata_q[$],rdata;
int uniq_id;

//assertions
assert property (@(posedge rd_clk)
 disable iff (!rd_rstn)
 (rd_ptr == wr_ptr) |-> empty
) else $error("FIFO empty signal error at time %t", $time);


assert property (@(posedge wr_clk)
disable iff (!wr_rstn)
  (wr_ptr + 1 == rd_ptr) |-> full
) else $error("FIFO full signal error at time %t", $time);
  
  
 assert property (@(posedge wr_clk)
disable iff (!wr_rstn)
                  wr_en |-> !($isunknown(data_in))
) else $error("FIFO data_in signal error at time %t", $time);
   
  
assert property (@(posedge rd_clk)
 disable iff (!rd_rstn)
 rd_en |-> !($isunknown(data_out))
 ) else $error("FIFO data_out signal error at time %t", $time);

assert property (@(posedge wr_clk)
                 disable iff (!wr_rstn)
                 (!wr_rstn |-> (wr_ptr == 0))
) else $error("Write pointer reset error at time %t", $time);

  assert property (@(posedge rd_clk)
                   disable iff (!rd_rstn)
                   (!rd_rstn |-> (rd_ptr == 0))
) else $error("Write pointer reset error at time %t", $time);
endinterface 
