module wptr_full #(parameter ADDR_SIZE = 4)
(
  input logic  wr_inc, wr_clk, wr_rstn,
  input logic  [ADDR_SIZE :0] wrq2_rptr,
  output logic  wr_full,
  output logic [ADDR_SIZE-1:0] wr_addr,
  output logic[ADDR_SIZE :0] wr_ptr
);
  logic [ADDR_SIZE:0] wr_bin;
  logic [ADDR_SIZE:0] wr_graynext, wr_binnext;
  logic wr_full_val;

  // GRAYSTYLE2 pointer
  always_ff @(posedge wr_clk or negedge wr_rstn)
    if (!wr_rstn)
      {wr_bin, wr_ptr} <= '0;
    else
      {wr_bin, wr_ptr} <= {wr_binnext, wr_graynext};

  // Memory write-address pointer (okay to use binary to address memory)
always_comb begin 
   wr_addr = wr_bin[ADDR_SIZE-1:0];
   wr_binnext = wr_bin + (wr_inc & ~wr_full);
   wr_graynext = (wr_binnext>>1) ^ wr_binnext;
end
  //generating full condition
  assign wr_full_val = (wr_graynext=={~wrq2_rptr[ADDR_SIZE:ADDR_SIZE-1], wrq2_rptr[ADDR_SIZE-2:0]});
  
always_ff @(posedge wr_clk or negedge wr_rstn)
    if (!wr_rstn)
      wr_full <= 1'b0;
    else
      wr_full <= wr_full_val;

endmodule