class monitor extends uvm_monitor;
	`uvm_component_utils(monitor) //registering monitor component to the factory
virtual intfc Virtual_Intf; // creating virtual handle for interface 
fifo_seq_item mon_tx; //creating handle of sequence item for monitor

	uvm_analysis_port #(fifo_seq_item) monitor_port; //creating object for analysis port
	
// creating a new constructor for monitor class
function new (string name="monitor", uvm_component parent);
	super.new(name, parent);
	`uvm_info("Monitor", "Mon",UVM_LOW)
endfunction

//Build Phase
function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	`uvm_info("Monitor", "Mon",UVM_LOW)
	monitor_port = new("monitor_port", this);//creating a new constructor for monitor annalysis port
	if(!(uvm_config_db # (virtual intfc):: get (this, "*", "Virtual_Intf", Virtual_Intf))) //checking proper connection with interface
	begin
	`uvm_error (" DRIVER CLASS", "Failed")
	end
endfunction

//Connect Phase
function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	`uvm_info("Monitor", "Mon",UVM_LOW)
endfunction

//Run phase
task run_phase (uvm_phase phase);
	super.run_phase(phase);
	`uvm_info("Monitor", "Mon",UVM_LOW)
	
	forever begin
		mon_tx = fifo_seq_item #(8,8,256)::type_id::create("mon_tx");
		wait (Virtual_Intf.wr_rstn && Virtual_Intf.rd_rstn);
        //tranfering data when write enable is high
		if(Virtual_Intf.wr_en & !Virtual_Intf.rd_en)
		begin
			@(posedge Virtual_Intf.wr_clk);
		
			mon_tx.wr_en=Virtual_Intf.wr_en;
			mon_tx.rd_en=Virtual_Intf.rd_en;
			mon_tx.wr_addr= Virtual_Intf.wr_addr;
			mon_tx.rd_addr=Virtual_Intf.rd_addr;
			mon_tx.data_in= Virtual_Intf.data_in;
			mon_tx.data_out= Virtual_Intf.data_out;
			mon_tx.full= Virtual_Intf.full;
			mon_tx.empty= Virtual_Intf.empty;
			`uvm_info("Monitor WRITE",$sformatf("Burtst Dtails:time=%0d,wr_en=%d,rd_en=%d,data_in=%d,full=%0d,empty=%0d, wr_addr=%d,",$time,Virtual_Intf.wr_en,Virtual_Intf.rd_en,Virtual_Intf.data_in,Virtual_Intf.full,Virtual_Intf.empty,Virtual_Intf.wr_addr),UVM_LOW) 
		end
		
		if(Virtual_Intf.rd_en & !Virtual_Intf.wr_en)
		begin
		    @(posedge Virtual_Intf.rd_clk);
			mon_tx.wr_en=Virtual_Intf.wr_en;
			mon_tx.rd_en=Virtual_Intf.rd_en;
			mon_tx.wr_addr= Virtual_Intf.wr_addr;
			mon_tx.rd_addr=Virtual_Intf.rd_addr;
			mon_tx.data_in= Virtual_Intf.data_in;
			mon_tx.data_out= Virtual_Intf.data_out;
			mon_tx.full= Virtual_Intf.full;
			mon_tx.empty= Virtual_Intf.empty;
			`uvm_info("Monitor Read",$sformatf("Burtst Dtails:time=%0d,wr_en=%d,rd_en=%d,data_out=%d,full=%0d,empty=%0d, rd_addr=%d",$time,Virtual_Intf.wr_en,Virtual_Intf.rd_en,Virtual_Intf.data_out,Virtual_Intf.full,Virtual_Intf.empty,Virtual_Intf.rd_addr),UVM_LOW)
			
		end
		monitor_port.write(mon_tx); 
	end
endtask

endclass
