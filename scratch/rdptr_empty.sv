module rdptr_empty
#(
  parameter ADDR_SIZE = 4
)
(
  input logic  rd_inc, rd_clk, rd_rstn,
  input logic  [ADDR_SIZE :0] rdq2_wptr,
  output logic rd_empty,
  output logic [ADDR_SIZE-1:0] rd_addr,
  output logic [ADDR_SIZE :0] rd_ptr
);

  logic [ADDR_SIZE:0] rd_bin;
  logic [ADDR_SIZE:0] rd_graynext, rd_binnext;

  //-------------------
  // GRAYSTYLE2 pointer
  //-------------------
  always_ff @(posedge rd_clk or negedge rd_rstn)
    if (!rd_rstn)
      {rd_bin, rd_ptr} <= '0;
    else
      {rd_bin, rd_ptr} <= {rd_binnext, rd_graynext};

  // Memory read-address pointer (okay to use binary to address memory)
  always_comb begin
  	rd_addr = rd_bin[ADDR_SIZE-1:0];
  	rd_binnext = rd_bin + (rd_inc & ~rd_empty);
  	rd_graynext = (rd_binnext>>1) ^ rd_binnext;
  end

  //fifo empty condition generation
     assign rd_empty_val = (rd_graynext == rdq2_wptr);

  always_ff @(posedge rd_clk or negedge rd_rstn)
    if (!rd_rstn)
      rd_empty <= 1'b1;
    else
      rd_empty <= rd_empty_val;

endmodule
