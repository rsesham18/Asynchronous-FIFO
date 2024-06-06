module async_top #(parameter Depth=256, Data_Width=8,Addr_Width=8) (intfc intf );


//2 flop sunchronizers
  wr_2_rd_sync #(Addr_Width) w2rsync_inst(intf.rd_clk,  intf.rd_rstn,  intf.wr_ptr ,  intf.wr_ptr_sync );
  rd_2_wr_sync #(Addrr_Width) r2wsync_inst(intf.wr_clk,  intf.wr_rstn, intf.rd_ptr,  intf.rd_ptr_sync );

//write point handler
  write_ptr #(Addr_Width) write_ptr_inst (intf.wr_clk, intf.wr_rstn, intf.wr_en,  intf.rd_ptr_sync,  intf.wr_addr, intf.wr_ptr, intf.full,intf.half_full);

//read point handler
  read_ptr #(Addr_Width) read_ptr_inst (intf.rd_clk, intf.rd_rstn, intf.rd_en,   intf.wr_ptr_sync,  intf.rd_addr, intf.rd_ptr,  intf.empty, intf.half_empty);

//fifo memory
  fifo_mem #(Data_Width,Addr_Width,Depth) fifo_mem_inst (intf.wr_clk,intf.rd_clk,intf.rd_rstn,intf.wr_rstn,intf.wr_en,intf.rd_en,intf.full,intf.empty, intf.data_in,  intf.wr_addr,intf.rd_addr,  intf.data_out);

endmodule
