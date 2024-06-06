import uvm_pkg::*;
`include "uvm_macros.svh"

class sequencer extends uvm_sequencer #(fifo_seq_item);
	`uvm_component_utils(sequencer) // registering sequencer component class to the factory

	//constructor new 
	function new (string name ="sequencer",uvm_component parent);
		super.new(name,parent);
		`uvm_info("SEQUENCER", "Inside Constructor!",UVM_LOW)
	endfunction 

	//build_phase from uvm_phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("SEQUENCER", "Build Phase!",UVM_LOW)
	endfunction

	//connect_phase from uvm_phase
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		`uvm_info("SEQUENCER", "Connect Phase!",UVM_LOW)
	endfunction

endclass
