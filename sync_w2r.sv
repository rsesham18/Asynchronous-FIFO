module sync_w2r
#(
  parameter ADDR_SIZE = 4
)
(
  input logic  rd_clk, rd_rstn,
  input logic  [ADDR_SIZE:0] wr_ptr,
  output logic[ADDR_SIZE:0] rdq2_wptr //writepointer with read side
);

  logic [ADDR_SIZE:0] rdq1_wptr;

  always_ff @(posedge rd_clk or negedge rd_rstn)
    if (!rd_rstn)
      {rdq2_wptr,rdq1_wptr} <= 0;
    else
      {rdq2_wptr,rdq1_wptr} <= {rdq1_wptr,wr_ptr};

endmodule