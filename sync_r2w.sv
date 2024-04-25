module sync_r2w
#(
  parameter ADDR_SIZE = 4
)
(
  input logic   wr_clk, wr_rstn,
  input logic  [ADDR_SIZE:0] rd_ptr,
  output logic [ADDR_SIZE:0] wrq2_rptr //readpointer with write side
);

  logic [ADDR_SIZE:0] wrq1_rptr;

  always_ff @(posedge wr_clk or negedge wr_rstn)
    if (!wr_rstn) {wrq2_rptr,wrq1_rptr} <= 0;
    else {wrq2_rptr,wrq1_rptr} <= {wrq1_rptr,rd_ptr};

endmodule
