vlib work
vdel -all
vlib work


vlog wr_2_rd_sync.sv
vlog rd_2_wr_sync.sv
vlog write_ptr.sv
vlog read_ptr.sv
vlog fifo_mem.sv
vlog async_top.sv 

vlog uvmtb_top.sv


vsim -coverage -vopt work.uvmtb_top 


run -all

vcover report -html fifo_coverage
coverage report -detail