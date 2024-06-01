module rd_2_wr_sync #(parameter Addr_Width=8)( wr_clk, wr_rstn, rd_ptr,  rd_ptr_sync);

input bit wr_clk, wr_rstn;
  input logic [Addr_Width:0]  rd_ptr;
  output logic [Addr_Width:0] rd_ptr_sync;

  logic [Addr_Width:0] q1;
  always_ff@(posedge wr_clk) begin
    if(!wr_rstn) begin
      q1 <= 0;
      rd_ptr_sync <= 0;//one clock cycle delay
    end
    else begin
      q1 <= rd_ptr;
      rd_ptr_sync <= q1;//two clock cycles delay
    end
  end
endmodule
