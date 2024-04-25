module top;
parameter DSIZE = 8;
parameter ASIZE = 4;
logic [DSIZE-1 : 0] rdata;
logic wfull; 
logic rempty;
logic [DSIZE-1 : 0] wdata=0;
logic winc=0, wclk=0, wrst_n=0;
logic rinc, rclk=0, rrst_n;

logic [DSIZE-1:0] data_queue[$];
logic [DSIZE-1:0] verif_w_data;

async_fifo1 #(.DATA_SIZE(DSIZE), .ADDR_SIZE(ASIZE)) DUT (.wr_inc(winc), .wr_clk(wclk), .rd_clk(rclk), .rd_inc(rinc), .rd_rstn(rrst_n), .wr_rstn(wrst_n), 
                                                              .wr_data(wdata),
                                                              .rd_data(rdata),
                                                              .wr_full(wfull),
                                                              .rd_empty(rempty));


always #4ns wclk=~wclk;
always #20ns rclk=~rclk;

initial 
begin
repeat(10) @(posedge wclk);
wrst_n = 1'b1;

for (int j = 0; j < 2; j++) 
begin
    for (int i = 0; i < 32; i++) 
	begin
		@(posedge wclk iff !wfull);
        winc = (i%2 == 0) ? 1'b1 : 1'b0;
        if (winc) 
		begin
			wdata = $urandom;
			data_queue.push_front(wdata);
        end
    end
    #50ns;
end
end

initial 
begin
rinc = 1'b0;
rrst_n = 1'b0;
repeat(8) @(posedge rclk);
rrst_n = 1'b1;
for (int j = 0; j < 2; j++) 
begin
    for (int i = 0; i < 32; i++) 
	begin
        @(posedge rclk iff !rempty)
        rinc = (i%2 == 0) ? 1'b1 : 1'b0;
        if (rinc) 
		begin
			verif_w_data = data_queue.pop_back();
			if(rdata !== verif_w_data) 
				$display("Time = %0t: Comparison Data FAILED: wr_data = %h && rd_data = %h", $time, verif_w_data, rdata);
			else 
				$display("Time = %0t: Comparison Data PASSED: wr_data = %h && rd_data = %h", $time, verif_w_data, rdata);
        end
      end
      #50ns;
end
$finish;
end
endmodule
