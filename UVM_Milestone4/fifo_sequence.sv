import uvm_pkg::*;
`include "uvm_macros.svh"

class fifo_sequence extends uvm_sequence;
	
	`uvm_object_utils (fifo_sequence) // registering the class with factory
	
	fifo_seq_item trans; // creating the class handle for sequence item class
	
	// creating a new constructor for write_sequence class
	function new( string name = "fifo_sequence");
		super.new (name);
		`uvm_info("FIFO_SEQUENCE", "Inside Constructor!", UVM_LOW)
	endfunction
	 
	 

	// randomizing with write_enable-1 and read enable-0
	task body();
		begin
		    `uvm_info("FIFO_SEQUENCE","INSIDE THE TASK BODY!",UVM_LOW)
			trans = fifo_seq_item#(8,8,256)::type_id ::create ("trans");
			start_item(trans);
			trans.no_rst.constraint_mode(0);
			assert (trans.randomize() with {trans.wr_rstn==0;trans.rd_rstn==0;});
			`uvm_info("SEQ",$sformatf("Generate new item: %s",trans.convert2str()),UVM_LOW)
			$display("-----------------------In reset body--------------------------------------");
			$display("------------------------------------------------------------------");
			finish_item(trans);
	    end
	endtask
	
endclass
	  
	  
class fifo_sequence_wr extends uvm_sequence;
	
	`uvm_object_utils (fifo_sequence_wr) // registering the class with factory
	
	fifo_seq_item trans_wr; // creating the class handle for sequence item class
	
	// creating a new constructor for write_sequence class
	function new( string name = "fifo_sequence_wr");
		super.new (name);
		`uvm_info("FIFO_SEQUENCE", "Inside Constructor!", UVM_LOW)
	endfunction
	 
	 
	int tx_count=256;
	// randomizing with write_enable-1 and read enable-0
	task body();
		for (int i=0; i<tx_count;i++) begin
		    `uvm_info("FIFO_SEQUENCE","INSIDE THE TASK BODY!",UVM_LOW)
			trans_wr = fifo_seq_item#(8,8,256)::type_id ::create ("trans_wr");
			start_item(trans_wr);
			assert (trans_wr.randomize() with {wr_en==1 ; rd_en==0;});
			`uvm_info("SEQ",$sformatf("Generate new item: %s",trans_wr.convert2str()),UVM_LOW)
			$display("------------------------------------------------------------------");
			$display("------------------------------------------------------------------");
			finish_item(trans_wr);
			`uvm_info("SEQ",$sformatf(" Done Generate new item: %d",i),UVM_LOW)
	    end
		 `uvm_info("SEQ",$sformatf(" Done Generation of items: %d",tx_count),UVM_LOW)
	endtask
	
endclass

// raed sequence class	 
class sequence_fifo_rd extends uvm_sequence;
	
	`uvm_object_utils (sequence_fifo_rd) // registered the read sequence class with factory
	
	fifo_seq_item trans_rd;// class handle for sequence item 
	
	// created a new constructor for the sequence_fifo_rd
	function new( string name = "sequence_fifo_rd");
		super.new (name);
		`uvm_info("FIFO_READ_SEQUENCE", "Inside Constructor!", UVM_LOW)
	endfunction
	 
    int tx_count=256;
	// randomizing with write_enable-0 and read enable-1
	task body();
		for (int i=0; i<tx_count;i++) begin
		    `uvm_info("FIFO_READ_SEQUENCE","INSIDE THE TASK BODY!",UVM_LOW)
			fifo_rd_pkt = fifo_seq_item#(8,8,256)::type_id::create ("trans_rd");
			start_item(trans_rd);
			assert (trans_rd.randomize() with {wr_en==0 & rd_en==1;});
			`uvm_info("SEQ",$sformatf("Generate new item:%s ",trans_rd.convert2str()),UVM_LOW)
			
			$display("------------------------------------------------------------------");
			$display("------------------------------------------------------------------");
			finish_item(trans_rd);
			`uvm_info("SEQ",$sformatf(" done Generate new item: %d",i),UVM_LOW)
		end
		 `uvm_info("SEQ",$sformatf(" Done Generation of items: %d",tx_count),UVM_LOW)
	endtask
	
endclass	 
