module write_ptr #(parameter Addr_Width=8)(wr_clk, wr_rstn, wr_en,  rd_ptr_sync,  wr_addr, wr_ptr, full);

	input bit wr_clk, wr_rstn, wr_en;
	input logic [Addr_Width:0] rd_ptr_sync;
	output bit full;
	output logic [Addr_Width:0] wr_addr, wr_ptr;
	logic wr_full;
	logic [Addr_Width:0]wr_addr_next; 
	logic [Addr_Width:0]wr_ptr_next;

	assign wr_addr_next= wr_addr + (wr_en & !full);
	assign wr_ptr_next= (wr_addr_next>>1)^wr_addr_next; 

	always_ff@(posedge wr_clk or negedge wr_rstn)
begin
	if(!wr_rstn)
		begin
		wr_addr<='0; //set default value
		wr_ptr<='0;
		end 
	else begin
		wr_addr<=wr_addr_next;//incrementing binary write pointer
		wr_ptr<=wr_ptr_next;//incrementing gray write pointer
	end
end

	always_ff@(posedge wr_clk or negedge wr_rstn)
begin
	if(!wr_rstn)
	full<=0;
else
	full<=wr_full;
end
	assign wr_full= (wr_ptr_next=={~rd_ptr_sync[Addr_Width-1],rd_ptr_sync[Addr_Width-2:0]});// FULL CONDITION

	
endmodule















 
