class proc_driver extends uvm_driver #(write_xtn);
`uvm_component_utils(proc_driver)

virtual parallel_processor_if.DRIVER1_MP vif;
parallel_processor_config m_cfg;


extern function new(string name ="proc_driver",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task  run_phase(uvm_phase phase);   //
extern task send_to_dut(write_xtn xtn);
endclass

function proc_driver :: new(string name ="proc_driver",uvm_component parent);
super.new(name,parent);
endfunction

function void proc_driver :: build_phase(uvm_phase phase);
super.build_phase(phase);
if(!uvm_config_db #(parallel_processor_config)::get(this,"","parallel_processor_config",m_cfg))
`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")
 
 endfunction

function void proc_driver::connect_phase(uvm_phase phase);
vif = m_cfg.vif;
endfunction

task proc_driver::run_phase(uvm_phase phase);
	/*vif.driver1_cb.RESETn<=1'b0; 
	@(vif.driver1_cb);
        vif.driver1_cb.RESETn<=1'b1;*/
	//@(vif.driver1_cb);
//@(vif.driver1_cb);

         forever begin
         seq_item_port.get_next_item(req);
         send_to_dut(req);
         seq_item_port.item_done();
         end
endtask

task proc_driver::send_to_dut(write_xtn xtn);
`uvm_info("PROC_DRIVER",$sformatf("printing from write driver \n %s", xtn.sprint()),UVM_HIGH) 
@(vif.driver1_cb);
	fork
       begin
	//do  begin
 	//wait(!vif.driver1_cb.BUSY1);
	vif.driver1_cb.START[0]<=1'b1;
	vif.driver1_cb.A[0] <= xtn.A[0];
	vif.driver1_cb.B[0]  <= xtn.B[0];
	vif.driver1_cb.OPCODE[0]  <= xtn.OPCODE[0];
	vif.driver1_cb.ADDRESS[0]  <= xtn.ADDRESS[0];
	vif.driver1_cb.data_in[0] <= xtn.data_in[0];
	wait(vif.driver1_cb.DONE[0] | vif.driver1_cb.OPCODE[0]==4'b0000);
	vif.driver1_cb.START[0]<=1'b0;
	end
	begin
	vif.driver1_cb.START[1]<=1'b1;
	vif.driver1_cb.A[1] <= xtn.A[1];
	vif.driver1_cb.B[1]  <= xtn.B[1];
	vif.driver1_cb.OPCODE[1]  <= xtn.OPCODE[1];
	vif.driver1_cb.ADDRESS[1]  <= xtn.ADDRESS[1];
	wait(vif.driver1_cb.DONE[1] | vif.driver1_cb.OPCODE[1]==4'b0000);
	vif.driver1_cb.START[1]<=1'b0;
	end
	begin
	vif.driver1_cb.START[2]<=1'b1;
	vif.driver1_cb.A[2] <= xtn.A[2];
	vif.driver1_cb.B[2]  <= xtn.B[2];
	vif.driver1_cb.OPCODE[2]  <= xtn.OPCODE[2];
	vif.driver1_cb.ADDRESS[2]  <= xtn.ADDRESS[2];
	wait(vif.driver1_cb.DONE[2] | vif.driver1_cb.OPCODE[2]==4'b0000);
	vif.driver1_cb.START[2]<=1'b0;
	end
	begin
	vif.driver1_cb.START[3]<=1'b1;
	vif.driver1_cb.A[3] <= xtn.A[3];
	vif.driver1_cb.B[3]  <= xtn.B[3];
	vif.driver1_cb.OPCODE[3]  <= xtn.OPCODE[3];
	vif.driver1_cb.ADDRESS[3]  <= xtn.ADDRESS[3];
	wait(vif.driver1_cb.DONE[3] | vif.driver1_cb.OPCODE[3]==4'b0000);
	vif.driver1_cb.START[3]<=1'b0;
	end

	join_none

endtask
		
