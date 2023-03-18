class proc4_driver extends uvm_driver #(write_xtn);
`uvm_component_utils(proc4_driver);

parallel_processor_config m_cfg;
virtual parallel_processor_if.DRIVER1_MP vif;

extern function new(string name = "proc4_driver", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task send_to_dut(write_xtn xtn);

endclass

function proc4_driver::new(string name = "proc4_driver", uvm_component parent);
super.new(name, parent);
endfunction

function void proc4_driver::build_phase(uvm_phase phase);
super.build_phase(phase);
if(!uvm_config_db #(parallel_processor_config)::get(this,"","parallel_processor_config",m_cfg))
`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?") 
 endfunction

function void proc4_driver::connect_phase(uvm_phase phase);
vif=m_cfg.vif;
endfunction

task proc4_driver::run_phase(uvm_phase phase);
forever begin
seq_item_port.get_next_item(req);
send_to_dut(req);
seq_item_port.item_done();
end
endtask

task proc4_driver::send_to_dut(write_xtn xtn);
`uvm_info("PROC_DRIVER",$sformatf("printing from write driver \n %s", xtn.sprint()),UVM_HIGH) 
      @(vif.driver1_cb);
begin
	vif.driver1_cb.START[3]<=1'b1;
	vif.driver1_cb.A[3] <= xtn.A[3];
	vif.driver1_cb.B[3]  <= xtn.B[3];
	vif.driver1_cb.OPCODE[3]  <= xtn.OPCODE[3];
	vif.driver1_cb.ADDRESS[3]  <= xtn.ADDRESS[3];
	wait(vif.driver1_cb.DONE[3] /*| vif.driver1_cb.OPCODE[3]==4'b0000*/);
	vif.driver1_cb.START[3]<=1'b0;
	end

endtask
