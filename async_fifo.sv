module async_fifo1 #(parameter DATA_SIZE = 8, ADDR_SIZE = 4) (input logic wr_inc, wr_clk, rd_clk, rd_inc, rd_rstn, wr_rstn, 
                                                              input logic [DATA_SIZE-1:0] wr_data,
                                                              output logic [DATA_SIZE-1:0] rd_data,
                                                              output wr_full,
                                                              output rd_empty);

  logic [ADDR_SIZE-1:0] wr_addr, rd_addr;
  logic [ADDR_SIZE:0] wr_ptr, rd_ptr, wrq2_rptr, rdq2_wptr;

  sync_r2w sync_r2w (.*);
  sync_w2r sync_w2r (.*);
  fifo_mem #(DATA_SIZE, ADDR_SIZE) fifomem (.*);
  rdptr_empty #(ADDR_SIZE) rptr_empty (.*);
  wptr_full #(ADDR_SIZE) wptr_fulldut (.*);

endmodule


