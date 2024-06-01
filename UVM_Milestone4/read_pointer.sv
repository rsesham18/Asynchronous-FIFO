module read_ptr #(parameter Addr_Width=8)( rdclk, rd_rst_n, rd_en,   wptr_sync,  rdraddr, rptr,  empty);

input bit rdclk,rd_rst_n, rd_en;
	input logic [Addr_Width:0]  wptr_sync;
output bit empty;
	output logic [Addr_Width:0] rdraddr, rptr;

 logic rempty;
 logic emptyr;
 logic readempty;

	logic [Addr_Width:0]raddr_next;
	logic [Addr_Width:0]rptr_next;


assign raddr_next= rdraddr + (rd_en & !empty);
assign rptr_next=(raddr_next>>1)^raddr_next; // GRAY CONVERTED VALUE
assign rempty= (wptr_sync == rptr_next); // CHECKING THE EMPTY CONDITION 

always_ff@(posedge rdclk or negedge rd_rst_n)
begin
	if(!rd_rst_n)
		begin
		rdraddr<=0; //default value
		rptr<=0;
		end 
	else begin
		rdraddr<=raddr_next;//incrementing binary read pointer
		rptr<=rptr_next;//incrementing gray read pointer
	end
end

always_ff@(posedge rdclk or negedge rd_rst_n)
begin
if(!rd_rst_n)
	empty<=1;//initial empty condition
else
	empty<=rempty;
	
end

endmodule












 
