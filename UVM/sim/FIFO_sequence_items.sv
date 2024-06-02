import uvm_pkg::*;
`include "uvm_macros.svh"

class fifo_seq_item #(parameter  Data_Width =8, Addr_Width = 8, Depth=256)extends uvm_sequence_item;
    `uvm_object_utils(fifo_seq_item #(8,8,256))// registering 
	rand bit wr_en;
	rand bit rd_en;
	rand bit wr_rstn;
	rand bit rd_rstn;
	rand bit [Data_Width-1:0] data_in;
	bit [Data_Width-1:0] data_out;
	bit empty, full;
	bit [Addr_Width:0] wr_addr, rd_addr;
	constraint no_rst {wr_rstn == 1 && rd_rstn ==1;}
	
	function string convert2str();
		return $sformatf ("wr_en =%0d, rd_en =%0d,data_in =%0d",wr_en,rd_en,data_in);
	endfunction
	
	// creating a new constructor 
	function new (string name = "fifo_seq_item");
		super.new(name);
	endfunction
endclass
		
	
