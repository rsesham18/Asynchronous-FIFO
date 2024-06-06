class agent extends uvm_agent;
	`uvm_component_utils(agent) //registering agent component class to the factory
	sequencer sqr; //creating handle for the sequencer
	driver drv; //creating handle for the driver
	monitor mon; //creating handle for the monitor

	//constructor new
	function new(string name ="agent",uvm_component parent);
		super.new(name,parent);
		`uvm_info("Agent Class", "Agent",UVM_LOW)
	endfunction
	

	//build_phase
	function void build_phase (uvm_phase phase);
		super.build_phase(phase);
		
		`uvm_info("Agent Class", "Build",UVM_LOW)
		sqr = sequencer::type_id::create("sqr",this);
		drv = driver::type_id::create("drv",this);
		mon = monitor:: type_id::create("mon", this);
	endfunction
	
	//connect_phase
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		`uvm_info("Agent Class", "Connect ",UVM_LOW)
		drv.seq_item_port.connect(sqr.seq_item_export); //connecting driver sequence port with sequencer sequence item export
	endfunction
	
	//run_phase
	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		`uvm_info("Agent Class", "Run",UVM_LOW)
	endtask
	
endclass
