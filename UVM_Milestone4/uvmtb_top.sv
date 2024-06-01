`timescale 1ns/1ps

import uvm_pkg::*;
`include "uvm_macros.svh"

`include "interface.sv"
`include "FIFO_sequence_items.sv"
`include "sequence_fifo_write.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "monitor.sv"
`include "agent.sv"
`include "scoreboard.sv"
`include "coverage_uvm.sv"
`include "env.sv"
`include "uvmtest.sv"

module uvmtb_top;

parameter depth=256;
parameter data_width=8;
parameter ptr_width=8;


	bit rclk;
	bit wclk;
	bit w_rst_n, r_rst_n;
	
	
	intfc Intf_DUT(.wclk(wclk), .rclk(rclk), .w_rst_n(w_rst_n), .r_rst_n(r_rst_n));
	top #(.depth(depth), .data_width(data_width), .ptr_width(ptr_width)) DUT (.i1(Intf_DUT));
	
	// connecting interface through uvm_config_db to other test bench components
	initial begin
		uvm_config_db #(virtual intfc):: set(null, "*", "Virtual_Intf", Intf_DUT);
	end
	
	
	initial begin
		run_test("uvmtest");
	end
	
	// clock generation
	always #5 rclk=~rclk;
    always #2 wclk=~wclk;
	
	
	//reset Generation
    initial begin
	    w_rst_n = 0;
		r_rst_n = 0;
		
		#15 w_rst_n = 1;
		#15 r_rst_n = 1;
    end
	
	
	initial begin
		#1000000;
		$display("sorry ran out of clock cycles");
		$finish;
	end
	
	
endmodule