class trans_fifo;

    parameter  Data_Width =8, Addr_Width = 8;
	rand bit w_en;
	rand bit r_en;
	randc bit [Data_Width-1:0] data_in;
	int flag,mflag;
	bit [Data_Width-1:0] data_out;
	bit empty, full;
	bit [Addr_Width:0] waddr;
	bit [Addr_Width:0] raddr;
	
endclass
	
	

