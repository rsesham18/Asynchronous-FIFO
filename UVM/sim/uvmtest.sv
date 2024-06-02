class uvmtest extends uvm_test;
	`uvm_component_utils(uvmtest)
	env Env_Handle; 
	fifo_sequence    rst_sequence;
	fifo_sequence_wr wr_seq; 
	sequence_fifo_rd rd_Seq;
	
	function new(string name ="uvmtest",uvm_component parent);
		super.new(name,parent);
		`uvm_info("TEST CLASS", "test ",UVM_LOW)
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("TEST CLASS", "Test",UVM_LOW)
		Env_Handle = env::type_id::create("Env_Handle",this);
	endfunction
	
	//Connect Phase(defined using functions as it does to consume simulation time)
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		`uvm_info("TEST CLASS", "Test",UVM_LOW)
		
	endfunction
	
	// Run phase (defined using task because it consumes simulation time)
	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		`uvm_info("TEST CLASS", "Test",UVM_LOW)
		phase.raise_objection(this);
		
			rst_sequence=	fifo_sequence::type_id::create("rst_sequence");
			rst_sequence.start(Env_Handle.agt.Seq);
			
		#10;
			wr_seq=	fifo_sequence_wr::type_id::create("wr_seq");
			wr_seq.start(Env_Handle.agt.Seq);
		#4;
			rd_Seq= sequence_fifo_rd::type_id::create("rd_Seq");
			rd_Seq.start(Env_Handle.agt.Seq);
		#10;
			
		phase.drop_objection(this);
	endtask



function void end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
  uvm_root::get().print_topology();
endfunction

endclass
