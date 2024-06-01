


module r2wsync #(parameter ptr_width=8)( wrclk, wr_rst_n, rptr,  rptr_sync);

input bit wrclk, wr_rst_n;
input logic [ptr_width:0]  rptr;
output logic [ptr_width:0]rptr_sync;

logic [ptr_width:0] q1;
  always_ff@(posedge wrclk) begin
    if(!wr_rst_n) begin
      q1 <= 0;
      rptr_sync <= 0;//one clock cycle delay
    end
    else begin
      q1 <= rptr;
      rptr_sync <= q1;//two clock cycles delay
    end
  end
endmodule