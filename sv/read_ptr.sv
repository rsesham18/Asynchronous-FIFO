module read_ptr #(parameter Addr_Width=8)( rd_clk, rd_rstn, rd_en,   wr_ptr_sync,  rd_addr, rd_ptr,  empty);

	input bit rd_clk,rd_rstn, rd_en;
	input logic [Addr_Width:0]  wr_ptr_sync;
	output bit empty;
	output logic [Addr_Width:0] rd_addr, rd_ptr;

 	logic rd_empty;
	
	logic [Addr_Width:0] rd_addr_next;
	logic [Addr_Width:0] rd_ptr_next;


	assign rd_addr_next= rd_addr + (rd_en & !empty);
	assign rd_ptr_next=(rd_addr_next>>1)^rd_addr_next; // GRAY CONVERTED VALUE
	assign rd_empty= (wr_ptr_sync == rd_ptr_next); // CHECKING THE EMPTY CONDITION 

	always_ff@(posedge rd_clk or negedge rd_rstn)
begin
	if(!rd_rstn)
		begin
		rd_addr<=0; //default value
		rd_ptr<=0;
		end 
	else begin
		rd_addr<=rd_addr_next;//incrementing binary read pointer
		rd_ptr<=rd_ptr_next;//incrementing gray read pointer
	end
end

	always_ff@(posedge rd_clk or negedge rd_rstn)
begin
if(!rd_rstn)
	empty<=1;//initial empty condition
else
	empty<=rd_empty;
	
end

endmodule












 
