import uvm_pkg::*;
`include "uvm_macros.svh"

class fifo_seq_item #(parameter  Data_Width =8, Addr_Width = 8, Depth=256)extends uvm_sequence_item;
    `uvm_object_utils(fifo_seq_item #(8,8,256))// registering 
	rand bit w_en;
	rand bit r_en;
	rand bit w_rst_n;
	rand bit r_rst_n;
	rand bit [Data_Width-1:0] data_in;
	bit [Data_Width-1:0] data_out;
	bit empty, full;
	bit [Addr_Width:0] waddr, raddr;
	constraint no_rst {w_rst_n == 1 && r_rst_n ==1;}
	
	function string convert2str();
	   return $sformatf ("w_en =%0d, r_en =%0d,data_in =%0d",w_en,r_en,data_in);
	endfunction
	
	// creating a new constructor 
	function new (string name = "fifo_seq_item");
		super.new(name);
	endfunction
endclass
		
	
