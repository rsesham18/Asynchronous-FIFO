interface async_fifo_if #(parameter DATA_SIZE = 8, ADDR_SIZE = 8);
  logic [DATA_SIZE-1:0] wr_data;
  logic wr_inc;
  logic wr_clk;
  logic wr_rstn;
  logic [DATA_SIZE-1:0] rd_data;
  logic rd_inc;
  logic rd_clk;
  logic rd_rstn;
  logic wr_full;
  logic rd_empty;
//Tb parameters
  int uniq_id;
  // Define clocking block for write clock
  /*clocking wr_clk @(posedge wclk);
    output winc, wrst_n;
  endclocking

  // Define clocking block for read clock
  clocking rd_clk @(posedge rclk);
    output rinc, rrst_n;
  endclocking */

  modport master (
    input wr_clk, wr_rstn,
    output wr_data, wr_inc, wr_full,
    input rd_clk, rd_rstn,
    output rd_data, rd_inc, rd_empty
  );

  

endinterface
  