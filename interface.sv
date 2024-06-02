/*interface async_fifo_if #(parameter DATA_SIZE = 8, ADDR_SIZE = 8);
  logic [DATA_SIZE-1:0] data_in;
  logic wr_en;
  logic wr_clk;
  logic wr_rstn;
  logic [DATA_SIZE-1:0] data_out;
  logic rd_en;
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

endinterface*/

interface intfc(input bit wr_clk, rd_clk, wr_rstn, rd_rstn);
  
parameter Depth=256, Data_Width=8, Addr_Width=8;
  
logic wr_en, rd_en;
  
logic [Addr_Width:0] rd_ptr_sync, wr_ptr_sync, wr_addr, wr_ptr,rd_addr, rd_ptr;
bit full, empty;
logic [Data_Width-1:0] data_in,data_out;
//logic  [Data_Width-1:0] wr_data_q[$],rd_data;
		
endinterface 
