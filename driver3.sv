class proc3_driver extends uvm_driver #(write_xtn);
`uvm_component_utils(proc3_driver);

virtual parallel_processor_if.DRIVER1_MP vif;
parallel_processor_config m_cfg;

extern function new(string name = "proc3_driver", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task send_to_dut(write_xtn xtn);
endclass

function proc3_driver::new(string name = "proc3_driver", uvm_component parent);
super.new(name, parent);
endfunction

function void proc3_driver::build_phase(uvm_phase phase);
super.build_phase(phase);
if(!uvm_config_db #(parallel_processor_config)::get(this,"","parallel_processor_config",m_cfg))
`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?") 
 endfunction

function void proc3_driver::connect_phase(uvm_phase phase);
vif=m_cfg.vif;
endfunction

task proc3_driver::run_phase(uvm_phase phase);
         forever begin
         seq_item_port.get_next_item(req);
         send_to_dut(req);
         seq_item_port.item_done();
         end
endtask

task proc3_driver::send_to_dut(write_xtn xtn);
`uvm_info("PROC3_DRIVER",$sformatf("printing from write driver \n %s", xtn.sprint()),UVM_HIGH) 
@(vif.driver1_cb);
      begin
	vif.driver1_cb.START[2]<=1'b1;
	vif.driver1_cb.A[2] <= xtn.A[2];
	vif.driver1_cb.B[2]  <= xtn.B[2];
	vif.driver1_cb.OPCODE[2]  <= xtn.OPCODE[2];
	vif.driver1_cb.ADDRESS[2]  <= xtn.ADDRESS[2];
	wait(vif.driver1_cb.DONE[2] | vif.driver1_cb.OPCODE[2]==4'b0000);
	vif.driver1_cb.START[2]<=1'b0;
	end
endtask
