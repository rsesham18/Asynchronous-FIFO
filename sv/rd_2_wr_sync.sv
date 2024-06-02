module rd_2_wr_sync #(parameter Addr_Width=8)( wr_clk, wr_rstn, rd_ptr,  rd_ptr_sync);

input bit wr_clk, wr_rstn;
  input logic [Addr_Width:0]  rd_ptr;
  output logic [Addr_Width:0] rd_ptr_sync;

  logic [Addr_Width:0] rd_ptr1;
  always_ff@(posedge wr_clk) begin
    if(!wr_rstn) begin
      rd_ptr1 <= 0;
      rd_ptr_sync <= 0;//one clock cycle delay
    end
    else begin
      rd_ptr1 <= rd_ptr;
      rd_ptr_sync <= rd_ptr1;//two clock cycles delay
    end
  end
endmodule
