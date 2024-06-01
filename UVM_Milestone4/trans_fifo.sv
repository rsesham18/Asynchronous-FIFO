class trans_fifo;

    parameter  data_width =8, ptr_width = 8;
	rand bit w_en;
	rand bit r_en;
	randc bit [data_width-1:0] data_in;
	int flag,mflag;
	bit [data_width-1:0] data_out;
	bit empty, full;
	bit [ptr_width:0] waddr;
	bit [ptr_width:0]raddr;
	
endclass
	
	

