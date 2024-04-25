vlib work 

vlog async_fifo.sv +acc
vlog fifo_mem.sv +acc
vlog rdptr_empty.sv +acc
vlog sync_r2w.sv +acc
vlog sync_w2r.sv +acc
vlog wptr_full.sv +acc
vlog -lint tb.sv +acc


vsim work.top
add wave -r *
run -all














