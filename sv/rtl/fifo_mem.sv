module fifo_mem #(parameter Data_Width =  8, Addr_Width =  8, Depth =256)( wr_clk,rd_clk,rd_rstn,wr_rstn,wr_en,rd_en,full,empty, data_in,  wr_addr,rd_addr,  data_out);

input bit wr_clk,rd_clk,rd_rstn,wr_rstn,wr_en,rd_en,full,empty;
  input logic [Addr_Width:0]  wr_addr, rd_addr;

  input logic [Data_Width-1:0] data_in;
  output logic [Data_Width-1:0]data_out;

  logic [Data_Width-1:0] fifo [0: Depth-1];

always_ff@(posedge wclk)
begin
  if(wr_en & !full)
begin
  fifo[wr_addr[Addr_Width-1:0]]<=data_in; // WRITE OPERATION
end
end
  assign data_out=fifo[rd_addr[Addr_Width-1:0]]; // READ OPERATION
endmodule
