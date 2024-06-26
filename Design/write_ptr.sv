module write_ptr #(parameter Addr_Width=8)(wr_clk, wr_rstn, wr_en,  rd_ptr_sync,  wr_addr, wr_ptr, full, half_full);

	input bit wr_clk, wr_rstn, wr_en;
	input logic [Addr_Width:0] rd_ptr_sync;
	output bit full, half_full;
	output logic [Addr_Width:0] wr_addr, wr_ptr;
	logic wr_full;
	logic [Addr_Width:0]wr_addr_next; 
	logic [Addr_Width:0]wr_ptr_next;

	assign wr_addr_next= wr_addr + (wr_en & !full); //incrementing pointer untill fifo is full
	assign wr_ptr_next= (wr_addr_next>>1)^wr_addr_next; //binary to gray conversion

	always_ff@(posedge wr_clk or negedge wr_rstn)
	begin
		//reset condition
		if(!wr_rstn)
		begin
			wr_addr<='0; //set default value
			wr_ptr<='0;  //set value to zero on reset
		end 
		//non-reset condition
		else begin
			wr_addr<=wr_addr_next;//incrementing binary write pointer
			wr_ptr<=wr_ptr_next;//incrementing gray write pointer
		end
	end

	// updating the full condition on reset and non-reset conditions
	always_ff@(posedge wr_clk or negedge wr_rstn)
	begin
		if(!wr_rstn)
			full<=0;
		else
			full<=wr_full;
	end
	assign wr_full= (wr_ptr_next=={~rd_ptr_sync[Addr_Width-1],rd_ptr_sync[Addr_Width-2:0]});// generating full condition 
	assign half_full = (wr_ptr >= (1 << (Addr_Depth-1)));//generating half fullcondition
	
endmodule















 
