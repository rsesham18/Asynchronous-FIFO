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
	
	//Constraints dor read and write enable
	//constraint wr {w_en dist {1:/50, 0:/(50)};}
	//constraint rd {r_en dist {0:/50, 1:/(50)};}
	// function void post_randomize();
	// r_en = ~w_en;
	// endfunction
	
endclass
	
	

