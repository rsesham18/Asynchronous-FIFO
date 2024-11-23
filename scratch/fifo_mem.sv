module fifo_mem
#(
  parameter DATA_SIZE = 8, // Memory data word width
  parameter ADDR_SIZE = 4  // Number of mem address bits
)
(
  input logic  wr_inc, wr_full, wr_clk,
  input logic  [ADDR_SIZE-1:0] wr_addr, rd_addr,
  input logic  [DATA_SIZE-1:0] wr_data,
  output logic [DATA_SIZE-1:0] rd_data
);

  localparam DEPTH = 1<< ADDR_SIZE;   //2*addsize

  logic [DATA_SIZE-1:0] mem [0:DEPTH-1];

  always_comb begin
   rd_data = mem[rd_addr];
  end

  always_ff @(posedge wr_clk)
    if (wr_inc && !wr_full)
      mem[wr_addr] <= wr_data;

endmodule
