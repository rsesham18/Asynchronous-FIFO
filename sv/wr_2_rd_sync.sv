module wr_2_rd_sync #(parameter  Addr_Width=8)( rd_clk, rd_rstn,  wr_ptr ,  wr_ptr_sync);

input bit rd_clk,rd_rstn;
 input [Addr_Width:0] wr_ptr;
 output logic [Addr_Width:0]  wr_ptr_sync;

 logic [Addr_Width:0] wr_ptr1;
 always_ff@(posedge rd_clk) begin
    if(!rd_rstn) begin
       wr_ptr1 <= 0;
      wr_ptr_sync <= 0;//one cycle delay
    end
    else begin
      wr_ptr1 <= wr_ptr;
      wr_ptr_sync <= wr_ptr1;//two cycle delay
    end
  end
endmodule
