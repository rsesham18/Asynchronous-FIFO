class driver extends uvm_driver #(fifo_seq_item);
	`uvm_component_utils(driver)
	virtual intfc Virtual_Intf;	
	fifo_seq_item driver_tx; 
	
	
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
			driver_tx = fifo_seq_item#(8,8,256)::type_id::create("driver_tx");
			seq_item_port.get_next_item(driver_tx);
			drive(driver_tx);
			seq_item_port.item_done();
		 end
    endtask
	
	//Drive Method
	task drive(fifo_seq_item driver_tx);
		begin
			if (!driver_tx.wr_rstn & !driver_tx.rd_rstn) begin
			Virtual_Intf.wr_rstn <= driver_tx.wr_rstn;
			Virtual_Intf.rd_rstn <= driver_tx.rd_rstn;
		end
		else begin
			if(driver_tx.wr_en & !driver_tx.rd_en)
			  begin
			  Virtual_Intf.wr_rstn <= driver_tx.wr_rstn;
				Virtual_Intf.rd_rstn <= driver_tx.rd_rstn;
				Virtual_Intf.wr_en <= driver_tx.wr_en;
				Virtual_Intf.rd_en <= driver_tx.rd_en;
				Virtual_Intf.data_in <= driver_tx.data_in;
				@(posedge Virtual_Intf.wr_clk);			
				`uvm_info("DRIVER_WRITE",$sformatf("Burtst Dtails:time=%0d,wr_en=%d,rd_en=%d,data_in=%d,full=%0d,empty=%0d,wr_addr=%d",$time,Virtual_Intf.wr_en,Virtual_Intf.rd_en,Virtual_Intf.data_in,Virtual_Intf.full,Virtual_Intf.empty,Virtual_Intf.wr_addr),UVM_LOW) 
				
			  end
			if(driver_tx.rd_en & !driver_tx.wr_en)
			  begin
			    Virtual_Intf.wr_rstn <= driver_tx.wr_rstn;
				Virtual_Intf.rd_rstn <= driver_tx.rd_rstn;
				Virtual_Intf.rd_en <= driver_tx.rd_en;
				Virtual_Intf.wr_en <= driver_tx.wr_en;
				Virtual_Intf.data_in <= driver_tx.data_in;
				 @(posedge Virtual_Intf.rd_clk);
				`uvm_info("DRIVER_READ",$sformatf("Burtst Dtails:time=%0d,wr_en=%d,rd_en=%d,data_out=%d,full=%0d,empty=%0d,rd_addr=%d",$time,Virtual_Intf.wr_en,Virtual_Intf.rd_en,Virtual_Intf.data_out,Virtual_Intf.full,Virtual_Intf.empty,Virtual_Intf.rd_addr),UVM_LOW)
			    
			  end
			  
		end
	end
	endtask
endclass
    		 
			 
		
	
