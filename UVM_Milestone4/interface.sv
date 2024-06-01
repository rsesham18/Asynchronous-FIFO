interface intfc(input bit wclk, rclk, w_rst_n, r_rst_n);
parameter depth=256, data_width=8, ptr_width=8;
parameter wclk_width=4;
parameter rclk_width=10;
logic w_en, r_en;
logic [ptr_width:0] rptr_sync, wptr_sync, waddr, wptr,raddr, rptr;
bit full, empty;
logic [data_width-1:0] data_in,data_out;
logic  [data_width-1:0] wdata_q[$],rdata;
		
endinterface 
/*
interface intfc #(parameter DATA_SIZE = 8, ADDR_SIZE = 8);
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

  int uniq_id;


  modport master (
    input wr_clk, wr_rstn,
    output wr_data, wr_inc, wr_full,
    input rd_clk, rd_rstn,
    output rd_data, rd_inc, rd_empty
  );

  

endinterface
  
*/