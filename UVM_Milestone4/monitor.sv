class monitor extends uvm_monitor;
`uvm_component_utils(monitor)
virtual intfc Virtual_Intf; 
fifo_seq_item Monitor_pkt;

uvm_analysis_port #(fifo_seq_item) monitor_port; 
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
		Monitor_pkt = fifo_seq_item #(8,8,256)::type_id::create("Monitor_pkt");
		wait (Virtual_Intf.w_rst_n && Virtual_Intf.r_rst_n);
        //tranfering data when write enable is high
		if(Virtual_Intf.w_en & !Virtual_Intf.r_en)
		begin
			@(posedge Virtual_Intf.wclk);
		
			Monitor_pkt.w_en=Virtual_Intf.w_en;
			Monitor_pkt.r_en=Virtual_Intf.r_en;
			Monitor_pkt.waddr= Virtual_Intf.waddr;
			Monitor_pkt.raddr=Virtual_Intf.raddr;
			Monitor_pkt.data_in= Virtual_Intf.data_in;
			Monitor_pkt.data_out= Virtual_Intf.data_out;
			Monitor_pkt.full= Virtual_Intf.full;
			Monitor_pkt.empty= Virtual_Intf.empty;
			`uvm_info("Monitor WRITE",$sformatf("Burtst Dtails:time=%0d,w_en=%d,r_en=%d,data_in=%d,full=%0d,empty=%0d, waddr=%d,",$time,Virtual_Intf.w_en,Virtual_Intf.r_en,Virtual_Intf.data_in,Virtual_Intf.full,Virtual_Intf.empty,Virtual_Intf.waddr),UVM_LOW) 
		end
		
		if(Virtual_Intf.r_en & !Virtual_Intf.w_en)
		begin
		    @(posedge Virtual_Intf.rclk);
			Monitor_pkt.w_en=Virtual_Intf.w_en;
			Monitor_pkt.r_en=Virtual_Intf.r_en;
			Monitor_pkt.waddr= Virtual_Intf.waddr;
			Monitor_pkt.raddr=Virtual_Intf.raddr;
			Monitor_pkt.data_in= Virtual_Intf.data_in;
			Monitor_pkt.data_out= Virtual_Intf.data_out;
			Monitor_pkt.full= Virtual_Intf.full;
			Monitor_pkt.empty= Virtual_Intf.empty;
			`uvm_info("Monitor Read",$sformatf("Burtst Dtails:time=%0d,w_en=%d,r_en=%d,data_out=%d,full=%0d,empty=%0d, raddr=%d",$time,Virtual_Intf.w_en,Virtual_Intf.r_en,Virtual_Intf.data_out,Virtual_Intf.full,Virtual_Intf.empty,Virtual_Intf.raddr),UVM_LOW)
			
		end
		monitor_port.write(Monitor_pkt); 
	end
endtask

endclass