class agent extends uvm_agent;
	`uvm_component_utils(agent) 
	sequencer sqr;
	driver drv;
	monitor mon;


	function new(string name ="agent",uvm_component parent);
		super.new(name,parent);
		`uvm_info("Agent Class", "Agent",UVM_LOW)
	endfunction
	

	function void build_phase (uvm_phase phase);
		super.build_phase(phase);
		
		`uvm_info("Agent Class", "Build",UVM_LOW)
		sqr = sequencer::type_id::create("sqr",this);
		drv = driver::type_id::create("drv",this);
		mon = monitor:: type_id::create("mon", this);
	endfunction
	
	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		`uvm_info("Agent Class", "Connect ",UVM_LOW)
		drv.seq_item_port.connect(sqr.seq_item_export);
	endfunction
	

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		`uvm_info("Agent Class", "Run",UVM_LOW)
	endtask
	
endclass
