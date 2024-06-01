class scoreboard extends uvm_scoreboard;
	`uvm_component_utils(scoreboard)
	 bit [7:0]transaction_queue[$];
	 fifo_seq_item trans[$];
	uvm_analysis_imp #(fifo_seq_item,scoreboard) ap_port; 
	 function new(string name= "scoreboard",uvm_component parent);
		super.new(name,parent);
		`uvm_info("Scoreboard", "Sbd",UVM_LOW)
	endfunction
	
	//Build Phase
	function void build_phase(uvm_phase phase);
	 super.build_phase(phase);
		`uvm_info("Scoreboard", "Build phase",UVM_LOW)
		ap_port = new("ap_port",this);
		endfunction
		
	//Connect Phase
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		`uvm_info("Scoreboard", "Connect Phase",UVM_LOW)
	endfunction
	
	//Run Phase
	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		`uvm_info("Scoreboard", "Run Phase",UVM_LOW)
	 forever 
	 begin

	 fifo_seq_item curr_trans;
	    wait(trans.size!=0);
		curr_trans=trans.pop_back();
		read(curr_trans);
	 end
	endtask
	 
	 
	 //write function for reference fifo queue
	 function void write(fifo_seq_item seqitem);
	 trans.push_front(seqitem);
	   if(seqitem.wr_en &!seqitem.full)
	   begin
		transaction_queue.push_front(seqitem.data_in);
		`uvm_info("Scoreboard write data_in",$sformatf("Burtst Dtails:wr_en=%d, data_in=%d, full=%0d",seqitem.wr_en, seqitem.data_in, seqitem.full),UVM_LOW) 
		end
	endfunction
	
	
	//Read method
	task read(fifo_seq_item read_trans);
	   bit [7:0] expected_data;
	   bit [7:0] actual_data;
	
		if(read_trans.rd_en &!read_trans.empty)
	   begin
		actual_data = read_trans.data_out;
	    expected_data= transaction_queue.pop_back();
		   `uvm_info("Scoreboard_getting read data_in",$sformatf("Burtst Dtails:r_en=%d, data_in=%d, full=%0d",read_trans.rd_en, read_trans.data_in, read_trans.empty),UVM_LOW)
		end
		if(actual_data != expected_data) begin
			`uvm_error("Comparing read", $sformatf("transaction failed actual_data=%d, expected_data=%d", actual_data,expected_data)) 
		end
	else begin
			`uvm_info("Comparing read", $sformatf("transaction passed actual_data=%d, expected_data=%d", actual_data,expected_data), UVM_LOW) 
		end
	endtask	
		
endclass
	
	

	 
