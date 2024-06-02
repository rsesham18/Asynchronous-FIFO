vlib work
vdel -all
vlib work


vlog write2readsync.sv
vlog read2writesync.sv
vlog write_pointer.sv
vlog read_pointer.sv
vlog fifo_mem.sv
vlog top.sv 

vlog uvmtb_top.sv


vsim -coverage -vopt work.uvmtb_top 


run -all

vcover report -html fifo_coverage
coverage report -detail
