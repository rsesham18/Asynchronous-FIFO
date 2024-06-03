interface intfc(input bit wr_clk, rd_clk, wr_rstn, rd_rstn);
parameter Depth=256, Data_Width=8, Addr_Width=8;
parameter wr_clk_width=4;
parameter rd_clk_width=10;
logic wr_en, rd_en;
	logic [Addr_Width:0] rd_ptr_sync, wr_ptr_sync, wr_addr, wr_ptr,rd_addr, rd_ptr;
bit full, empty;
	logic [Data_Width-1:0] data_in,data_out;
	logic  [Data_Width-1:0] wr_data_q[$],rd_data;
assert property (@(posedge wr_clk or posedge rd_clk) disable iff (!(rd_rstn), !(wr_rstn))
    (wr_ptr == rd_ptr) |=> (empty == 1)
) else $fatal("FIFO empty flag error");
	
assert property (@(posedge wr_clk or posedge rd_clk) disable iff (!(rd_rstn), !(wr_rstn))
    ((wr_ptr + 1) % Depth == rd_ptr) |=> (full == 1)
) else $fatal("FIFO full flag error");
		
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
