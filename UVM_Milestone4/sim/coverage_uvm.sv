class coverage extends uvm_subscriber;
`uvm_component_utils(coverage)
uvm_analysis_imp #(fifo_seq_item, coverage) coverage_port;

real coverage_score1;
real coverage_score2;
real coverage_score3;
real total_coverage;
fifo_seq_item cov_pkt;
virtual intfc cov_if; 


covergroup CG_1 with function sample(fifo_seq_item cov_pkt) ;
    CP_1: coverpoint cov_pkt.waddr { 
       bins waddr[]= {[0:255]};
     }
	 CP_2: coverpoint cov_pkt.raddr { 
     bins raddr[]= {[0:255]};
     }
     w_r_addr: cross CP_1,CP_2;
   endgroup

covergroup CG_2 with function sample(fifo_seq_item w_pkt) ;

CP_3:coverpoint w_pkt.w_rst_n{
             bins RESET_1 = {1};
			 bins RESET_0 ={0};
			 }
CP_4:coverpoint w_pkt.empty {
             bins  fifo_empty_1 = {1};
			 bins fifo_empty_0 = {0};
			 }
CP_5:coverpoint w_pkt.full {
             bins fifo_full_1 = {1};
			 bins fifo_full_0 = {0};
}
			 
CP_6 : coverpoint w_pkt.w_en {
             bins write_1 = {1};
			 bins write_0 = {0};
			 }

CP_7 : coverpoint w_pkt.data_in {
             bins wr_data = {[0:255]};
			  }

CP_8 : coverpoint w_pkt.r_en {
             bins read_1 = {1};
			 bins read_0 = {0};
			 }
			  
read_fifo_empty:cross CP_6,CP_4;       
read_write_fifo_empty:cross CP_6,CP_7,CP_4;  
read_and_clear:cross CP_6,CP_3;      
write_and_fifo_full:cross CP_7,CP_5;   
read_write_clear:cross CP_6,CP_3,CP_8;   
clear_and_fifo_empty:cross CP_4,CP_3; 
commands_while_reset: cross CP_3,CP_6,CP_8;

endgroup

covergroup test_read with function sample(fifo_seq_item r_pkt) ;
c5 : coverpoint r_pkt.r_en {
             bins read_1 = {1};
			 bins read_0 = {0};
			 }
c6: coverpoint r_pkt.r_rst_n {
             bins r_rst_n_high = {1};
			 bins r_rst_n_low = {0};
			 }			 

c7 : coverpoint r_pkt.data_out {
             bins rd_data = {[0:255]};
			  }
			  
c8:coverpoint r_pkt.empty {
             bins  fifo_empty_1 = {1};
			 bins fifo_empty_0 = {0};
			 }
c9:coverpoint r_pkt.full {
             bins fifo_full_1 = {1};
			 bins fifo_full_0 = {0};
}
c11 : coverpoint r_pkt.w_en {
             bins write_1 = {1};
			 bins write_0 = {0};
			 }

read_fifo_emptyr:cross c5,c8;       
read_write_fifo_emptyr:cross c11,c5,c8;  
read_and_clear_read:cross c5,c6;      
write_and_fifo_fullr:cross c9,c11;   
read_write_clear:cross c5,c6,c11;   
clear_and_fifo_empty:cross c6,c8; 
commands_while_reset: cross c5,c6,c11;

endgroup


function new (string name="coverage",uvm_component parent);
super.new(name,parent);
`uvm_info("COVERAGE CLASS", "Cov", UVM_LOW)
CG_2=new();
test_read=new();
endfunction

//Buid Phase
function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("COVERAGE CLASS", "Build", UVM_LOW)
   
    coverage_port = new("coverage_port", this); 
endfunction

function void write(fifo_seq_item t);

test_read.sample(t);
CG_2.sample(t);

endfunction

// Extract Phase
function void extract_phase(uvm_phase phase);
   super.extract_phase(phase);
coverage_score2=CG_2.get_coverage();
coverage_score3=test_read.get_coverage();
endfunction

//Report Phase
function void report_phase(uvm_phase phase);
	super.report_phase(phase);
	`uvm_info("COVERAGE",$sformatf("Coverage=%0f%%",coverage_score2),UVM_LOW);
	`uvm_info("COVERAGE",$sformatf("Coverage=%0f%%",coverage_score3),UVM_LOW);
endfunction

endclass
