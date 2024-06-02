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
  
intfc bus_tb();
test test_inst(bus_tb);

  async_top #(Depth, Data_Width, Addr_Width) dut (
    .bus(bus_tb)
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

  
    
  initial begin
   
    bus_tb.wr_clk = 1'b0;
    bus_tb.rd_clk = 1'b0;
       
  
    fork
      forever #10ns bus_tb.wr_clk = ~bus_tb.wr_clk;
      forever #35ns bus_tb.rd_clk = ~bus_tb.rd_clk;
    join
  end
    
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

 
