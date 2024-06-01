`include "environment.sv"
program test(intfc vif);
	environment env;
	initial
    begin	
		env = new(vif); 
		env.gen.count =16;
		env.gen.size =1;
		env.run();
	end
 endprogram