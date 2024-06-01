vlib work
vdel -all
vlib work

vlog interface.sv +acc 
vlog async_fifo.sv +acc 
vlog fifo_mem.sv +acc
vlog rdptr_empty.sv +acc
vlog sync_r2w.sv +acc
vlog sync_w2r.sv +acc
vlog wptr_full.sv +acc
vlog testbench.sv +acc 
vlog env.sv +acc 
vlog test.sv +acc 


vsim work.async_fifo1_tb_uvm
vopt async_fifo1_tb_uvm -o top_optimized  +acc +cover=sbfec+async_fifo(rtl).
vsim top_optimized -coverage
#vsim work.tb

run -all
coverage save async_fifo.ucdb
vcover report async_fifo.ucdb 
vcover report async_fifo.ucdb -cvg -details
coverage report -codeAll