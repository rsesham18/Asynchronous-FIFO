class env extends uvm_env;
	`uvm_component_utils(env)
	agent agt;
	scoreboard sbd; 
	coverage  covrg;
	

	// creating a new constructor 
	function new(string name ="env" , uvm_component parent);
		super.new(name,parent);
		`uvm_info("Env Class", "Env",UVM_LOW)
	endfunction

	//Build Phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("Env Class", "Build",UVM_LOW)
		agt = agent ::type_id::create("agt",this);
		sbd = scoreboard:: type_id::create("sbd", this);
		covrg=coverage::type_id::create("covrg",this);
	endfunction
	
	
    //Connect Phase
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		`uvm_info("Env Class", "Connect",UVM_LOW)
		agt.mon.monitor_port.connect(sbd.ap_port);
		agt.mon.monitor_port.connect(covrg.coverage_port);
	endfunction
	
	//Run Phase
	task run_phase (uvm_phase phase);
		super.run_phase(phase);
		`uvm_info("Env Class", "Run",UVM_LOW)
	endtask
endclass
		
	
	
	
	
