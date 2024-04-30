
`include "env.sv"
module test(async_fifo_if intf);
  environment env;
  
  initial begin
    env = new(intf);
    
    
    env.gen.tx_count = 100;
    
    env.run();
  end
endmodule
