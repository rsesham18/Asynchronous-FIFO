interface intfc(input bit wr_clk, rd_clk, wr_rstn, rd_rstn);
parameter Depth=256, Data_Width=8, Addr_Width=8;
parameter wr_clk_width=4;
parameter rd_clk_width=10;
logic wr_en, rd_en;
logic [Addr_Width:0] rd_ptr_sync, wr_ptr_sync, wr_addr, wr_ptr,rd_addr, rd_ptr;
bit full, empty;
logic [Data_Width-1:0] data_in,data_out;
logic  [Data_Width-1:0] wr_data_q[$],rd_data;

//assertions
//EMPTY CONDITION
assert property (@(posedge wr_clk or posedge rd_clk) disable iff (!(rd_rstn), !(wr_rstn))
    (wr_ptr == rd_ptr) |=> (empty == 1)
) else $fatal("FIFO empty flag error");

//FULL_CONDITION
assert property (@(posedge wr_clk or posedge rd_clk) disable iff (!(rd_rstn), !(wr_rstn))
    ((wr_ptr + 1) % Depth == rd_ptr) |=> (full == 1)
) else $fatal("FIFO full flag error");

// Write when FIFO is full
assert property (@(posedge wr_clk) disable iff (!(wr_rstn)
    !(wr_en && full)
) else $fatal("Write attempted when FIFO is full");

// Read when FIFO is empty
 assert property (@(posedge rd_clk) disable iff (!(rd_rstn))
    !(rd_en && empty)
) else $fatal("Read attempted when FIFO is empty");

endinterface 
