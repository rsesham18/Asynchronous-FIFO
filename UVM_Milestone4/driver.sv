class driver extends uvm_driver #(fifo_seq_item);
	`uvm_component_utils(driver)
	virtual intfc Virtual_Intf;	
	fifo_seq_item Driver_Packet; 
	
	
	//creating a new constructor
	function new(string name ="driver",uvm_component parent);
		super.new (name,parent);
		`uvm_info("DRIVER", "Drv",UVM_LOW)
	endfunction
	

	//Build Phase
	function void build_phase (uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("Driver Class", "Build Phase!",UVM_LOW)
		if(!(uvm_config_db #(virtual intfc)::get(this,"*","Virtual_Intf",Virtual_Intf))) 
		begin
			`uvm_error("Driver Class", "Failed")
		end
		
	endfunction
	
	
	//Connect Phase
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		`uvm_info("Driver Class", "Connect Phase!",UVM_LOW)
	endfunction	
		
			
	//Run Phase	
	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		`uvm_info("Driver Class", "Inside run Phase!",UVM_LOW)
		forever 
		 begin
			Driver_Packet = fifo_seq_item#(8,8,256)::type_id::create("Driver_Packet");
			seq_item_port.get_next_item(Driver_Packet);
			drive(Driver_Packet);
			seq_item_port.item_done();
		 end
    endtask
	
	//Drive Method
	task drive(fifo_seq_item Driver_Packet);
		begin
		if (!Driver_Packet.w_rst_n & !Driver_Packet.r_rst_n) begin
			Virtual_Intf.w_rst_n <= Driver_Packet.w_rst_n;
			Virtual_Intf.r_rst_n <= Driver_Packet.r_rst_n;
		end
		else begin
			if(Driver_Packet.w_en & !Driver_Packet.r_en)
			  begin
			  Virtual_Intf.w_rst_n <= Driver_Packet.w_rst_n;
				Virtual_Intf.r_rst_n <= Driver_Packet.r_rst_n;
				Virtual_Intf.w_en <= Driver_Packet.w_en;
				Virtual_Intf.r_en <= Driver_Packet.r_en;
				Virtual_Intf.data_in <= Driver_Packet.data_in;
				@(posedge Virtual_Intf.wclk);			
				`uvm_info("DRIVER_WRITE",$sformatf("Burtst Dtails:time=%0d,w_en=%d,r_en=%d,data_in=%d,full=%0d,empty=%0d,waddr=%d",$time,Virtual_Intf.w_en,Virtual_Intf.r_en,Virtual_Intf.data_in,Virtual_Intf.full,Virtual_Intf.empty,Virtual_Intf.waddr),UVM_LOW) 
				
			  end
			if(Driver_Packet.r_en & !Driver_Packet.w_en)
			  begin
			    Virtual_Intf.w_rst_n <= Driver_Packet.w_rst_n;
				Virtual_Intf.r_rst_n <= Driver_Packet.r_rst_n;
				Virtual_Intf.r_en <= Driver_Packet.r_en;
				Virtual_Intf.w_en <= Driver_Packet.w_en;
				Virtual_Intf.data_in <= Driver_Packet.data_in;
				 @(posedge Virtual_Intf.rclk);
				`uvm_info("DRIVER_READ",$sformatf("Burtst Dtails:time=%0d,w_en=%d,r_en=%d,data_out=%d,full=%0d,empty=%0d,raddr=%d",$time,Virtual_Intf.w_en,Virtual_Intf.r_en,Virtual_Intf.data_out,Virtual_Intf.full,Virtual_Intf.empty,Virtual_Intf.raddr),UVM_LOW)
			    
			  end
			  
		end
	end
	endtask
endclass
    		 
			 
		
	