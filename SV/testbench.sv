// Code your testbench here
// or browse Examples
// Code your testbench here
// or browse Examples

`include "interface.sv"
`include "test.sv"

module async_fifo1_tb_uvm;

  parameter Data_Width = 8;
  parameter Addr_Width = 8;
  parameter Depth=256;
  parameter IDLE_R =3;
  parameter IDLE_W=1;

	bit rd_clk;
	bit wr_clk;
	bit wr_rstn, rd_rstn;
	
	
intfc bus_tb(.wr_clk(wr_clk), .rd_clk(rd_clk), .wr_rstn(wr_rstn), .rd_rstn(rd_rstn));
test test_inst(bus_tb);

  async_top #(Depth, Data_Width, Addr_Width) dut (
    .intf(bus_tb)
  );


// Coverage declarations
  covergroup fifo_coverage;
    option.per_instance = 1;
    coverpoint bus_tb.data_in {
      bins wrdata_bin[] = {[8'h00:8'hFF]};
    }
    coverpoint bus_tb.rd_en {
      bins rdinc_bin[] = {0, 1};
    }
    coverpoint bus_tb.wr_en {
      bins rdinc_wrinc[] = {0, 1};
    }
    coverpoint bus_tb.wr_rstn {
      bins rdinc_wrrst_n[] = {0, 1};
    }
    coverpoint bus_tb.rd_rstn {
      bins rdinc_rdrst_n[] = {0, 1};
    }
    // Coverpoints for wfull and rempty
    coverpoint bus_tb.full {
      bins wrfull_bin = {0, 1};
    }
    coverpoint bus_tb.empty {
      bins rdempty_bin = {0, 1};
    }
  endgroup

  // clock generation
	always #4 rd_clk=~rd_clk;
    always #2 wr_clk=~wr_clk;
    
 initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0);
  end
initial begin 
fifo_coverage fifo_cov; // Instantiate the coverage group
fifo_cov=new();

  forever begin@(negedge bus_tb.wr_clk);
        fifo_cov.sample();

     end

  end

endmodule

 
