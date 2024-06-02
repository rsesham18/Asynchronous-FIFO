vlib work 

vlog async_top.sv +acc
vlog fifo_mem.sv +acc
vlog read_ptr.sv +acc
vlog rd_2_wr_sync.sv +acc
vlog wr_2_rd_sync.sv +acc
vlog write_ptr.sv +acc
vlog -lint tb.sv +acc


vsim work.top
add wave -r *
run -all














