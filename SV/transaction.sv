class transaction;
  parameter  Data_Width =8, Addr_Width = 8;
  rand bit wr_en;
  rand bit rd_en;
  randc bit [Data_Width-1:0] data_in;
  int flag,mflag;
  bit [Data_Width-1:0] data_out;
  bit empty, full;
  bit [Addr_Width:0] wr_addr;
  bit [Addr_Width:0] rd_addr;
  int uniq_id;
endclass
	
	
