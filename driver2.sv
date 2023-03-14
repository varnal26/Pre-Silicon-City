class proc2_driver extends uvm_driver # (write_xtn);
`uvm_component_utils(proc2_driver) 

virtual parallel_processor_if.DRIVER2_MP vif;
parallel_processor_config m_cfg;


extern function new(string name ="proc2_driver",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task  run_phase(uvm_phase phase);   //
extern task send_to_dut(write_xtn xtn);
endclass

function proc2_driver :: new(string name ="proc2_driver",uvm_component parent);
super.new(name,parent);
endfunction

function void proc2_driver :: build_phase(uvm_phase phase);
super.build_phase(phase);
if(!uvm_config_db #(parallel_processor_config)::get(this,"","parallel_processor_config",m_cfg))
`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?") 
 endfunction

function void proc2_driver::connect_phase(uvm_phase phase);
vif = m_cfg.vif;
endfunction

task proc2_driver::run_phase(uvm_phase phase);
	/*vif.driver2_cb.RESETn<=1'b0; 
	@(vif.driver2_cb);
        vif.driver2_cb.RESETn<=1'b1;
	@(vif.driver2_cb);*/

         forever begin
         seq_item_port.get_next_item(req);
         send_to_dut(req);
         seq_item_port.item_done();
         end
endtask

task proc2_driver::send_to_dut(write_xtn xtn);
`uvm_info("PROC2_DRIVER",$sformatf("printing from write driver \n %s", xtn.sprint()),UVM_LOW) 
@(vif.driver1_cb);
       begin
	vif.driver1_cb.A[1] <= xtn.A[1];
	vif.driver1_cb.B[1]  <= xtn.B[1];
	vif.driver1_cb.OPCODE[1]  <= xtn.OPCODE[1];
	vif.driver1_cb.START[1]<=1'b1;
	vif.driver1_cb.ADDRESS[1]  <= xtn.ADDRESS[1];
	vif.driver1_cb.data_in[1] <= xtn.data_in[1];
	wait(vif.driver1_cb.DONE[1] | vif.driver1_cb.OPCODE[1]==4'b0000);
	vif.driver1_cb.START[1]<=1'b0;
	end
//	#100;

endtask


