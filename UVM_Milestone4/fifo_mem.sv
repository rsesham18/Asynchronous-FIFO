module fifo_mem #(parameter Data_Width =  8, Addr_Width =  8, Depth =256)( wclk,rclk,r_rst_n,w_rst_n,w_en,r_en,full,empty, data_in,  waddr,raddr,  data_out);

input bit wclk,rclk,r_rst_n,w_rst_n,w_en,r_en,full,empty;
  input logic [Addr_Width:0]  waddr, raddr;

  input logic [Data_Width-1:0] data_in;
  output logic [Data_Width-1:0]data_out;

  logic [Data_Width-1:0] fifo [0: Depth-1];

always_ff@(posedge wclk)
begin
if(w_en & !full)
begin
  fifo[waddr[Addr_width-1:0]]<=data_in; // WRITE OPERATION
end
end
  assign data_out=fifo[raddr[Addr_width-1:0]]; // READ OPERATION
endmodule
