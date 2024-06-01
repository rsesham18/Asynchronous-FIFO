module w2rsync #(parameter  ptr_width=8)( rdclk, rd_rst_n,  wptr ,  wptr_sync);

input bit rdclk,rd_rst_n;
input [ptr_width:0] wptr;
output logic [ptr_width:0]  wptr_sync;

 logic [ptr_width:0] q2;
  always_ff@(posedge rdclk) begin
    if(!rd_rst_n) begin
      q2 <= 0;
      wptr_sync <= 0;//one cycle delay
    end
    else begin
      q2 <= wptr;
      wptr_sync <= q2;//two cycle delay
    end
  end
endmodule