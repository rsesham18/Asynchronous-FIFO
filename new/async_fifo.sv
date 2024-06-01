
module async_fifo #(parameter DATA_SIZE = 8, ADDR_SIZE = 8) (
  async_fifo_if.master bus
);
  logic [ADDR_SIZE-1:0] wr_addr, rd_addr;
  logic [ADDR_SIZE:0] wr_ptr, rd_ptr, wrq2_rdptr, rdq2_wrptr;

  sync_r2w sync_r2w (bus.wr_clk,bus.wr_rstn,rd_ptr,wrq2_rdptr);
  sync_w2r sync_w2r (bus.rd_clk ,bus.rd_rstn,wr_ptr,rdq2_wrptr);
  fifo_mem #(DATA_SIZE, ADDR_SIZE) fifomem (bus.wr_inc,bus.wr_full,bus.wr_clk,wr_addr,rd_addr,bus.wr_data,bus.rd_data);
  rdptr_empty #(ADDR_SIZE) rdptr_empty (bus.rd_inc,bus.rd_clk,bus.rd_rstn,rdq2_wrptr,bus.rd_empty,rd_addr,rd_ptr);
  wptr_full #(ADDR_SIZE) wrptr_full (bus.wr_inc,bus.wr_clk,bus.wr_rstn,wrq2_rdptr,bus.wr_full,wr_addr,wr_ptr);

endmodule

