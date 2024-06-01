module r2wsync #(parameter Addr_Width=8)( wrclk, wr_rst_n, rptr,  rptr_sync);

input bit wrclk, wr_rst_n;
  input logic [Addr_Width:0]  rptr;
  output logic [Addr_Width:0]rptr_sync;

  logic [Addr_width:0] q1;
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
