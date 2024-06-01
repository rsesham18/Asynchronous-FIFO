module top #(parameter Depth=256, Data_Width=8,Addr_Width=8) (intfc i1 );


//2 flop sunchronizers
  w2rsync #(Addr_Width) w2rsync_inst(i1.rclk,  i1.r_rst_n,  i1.wptr ,  i1.wptr_sync );
  r2wsync #(Addrr_Width) r2wsync_inst(i1.wclk,  i1.w_rst_n, i1.rptr,  i1.rptr_sync );

//write point handler
  write_ptr #(Addr_Width) write_ptr_inst (i1.wclk, i1.w_rst_n, i1.w_en,  i1.rptr_sync,  i1.waddr, i1.wptr, i1.full);

//read point handler
  read_ptr #(Addr_Width) read_ptr_inst (i1.rclk, i1.r_rst_n, i1.r_en,   i1.wptr_sync,  i1.raddr, i1.rptr,  i1.empty);

//fifo memory
  fifo_mem #(Data_Width,ptr_width,depth) fifo_mem_inst (i1.wclk,i1.rclk,i1.r_rst_n,i1.w_rst_n,i1.w_en,i1.r_en,i1.full,i1.empty, i1.data_in,  i1.waddr,i1.raddr,  i1.data_out);

endmodule