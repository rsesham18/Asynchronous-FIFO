`timescale 1ns/1ps

import uvm_pkg::*;
`include "uvm_macros.svh"

//including interface
`include "interface.sv"

//including all the objects and components
`include "FIFO_sequence_items.sv"
`include "fifo_sequence.sv"
`include "fifo_sequencer.sv"
`include "driver.sv"
`include "monitor.sv"
`include "agent.sv"
`include "scoreboard.sv"
`include "coverage_uvm.sv"
`include "env.sv"
`include "uvmtest.sv"

//testbench top
module uvmtb_top;

parameter Depth=256;
parameter Data_Width=8;
parameter Addr_Width=8;


	bit rd_clk;
	bit wr_clk;
	bit wr_rstn, rd_rstn;
	
	//getting instance of an interface
	intfc Intf_DUT(.wr_clk(wr_clk), .rd_clk(rd_clk), .wr_rstn(wr_rstn), .rd_rstn(rd_rstn
	
	//creating instance of DUT
	async_top #(.Depth(Depth), .Data_Width(Data_Width), .Addr_Width(Addr_Width)) DUT (.intf(Intf_DUT));
	
	
	initial begin
		uvm_config_db #(virtual intfc):: set(null, "*", "Virtual_Intf", Intf_DUT); //set the interface handle to the configuartion database
	end
	
	
	initial begin
		run_test("uvmtest"); //running the test component uvmtest
	end
	
	//write clock generation
	always #5 rd_clk=~rd_clk;

	//read clock generation
    	always #2 wr_clk=~wr_clk;
	
	
	//reset Generation
    initial begin
	    wr_rstn = 0;
		rd_rstn = 0;
		
		#15 wr_rstn = 1;
		#15 rd_rstn = 1;
    end
	
	
	initial begin
		#1000000;
		$display("sorry ran out of clock cycles");
		$finish;
	end
	
	
endmodule
