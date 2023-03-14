class proc_monitor extends uvm_monitor;

	`uvm_component_utils(proc_monitor)

   	virtual parallel_processor_if.MONITOR1_MP vif;
        parallel_processor_config m_cfg;
	write_xtn  xtn;

   uvm_analysis_port #(write_xtn) monitor_port;

extern function new(string name = "proc_monitor", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task collect_data();
endclass

function proc_monitor::new(string name = "proc_monitor", uvm_component parent);
super.new(name,parent);

endfunction

function void proc_monitor::build_phase(uvm_phase phase);
          super.build_phase(phase);

	  if(!uvm_config_db #(parallel_processor_config)::get(this,"","parallel_processor_config",m_cfg))
		`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?") 

	monitor_port = new("monitor_port", this);
endfunction

function void proc_monitor::connect_phase(uvm_phase phase);
          vif = m_cfg.vif;
endfunction

task proc_monitor::run_phase(uvm_phase phase);
//repeat(4)
	 //@(vif.monitor1_cb);
	forever 
	   collect_data();
	//@(vif.monitor1_cb);
		 endtask


	task proc_monitor::collect_data();
  xtn=write_xtn::type_id::create("xtn", this);
	// 
begin
wait( vif.monitor1_cb.DONE);
    //    xtn.A     = vif.monitor1_cb.A;
	xtn.A[0]     = vif.monitor1_cb.A[0];
	xtn.A[1]    = vif.monitor1_cb.A[1];
	xtn.A[2]     = vif.monitor1_cb.A[2];
	xtn.A[3]     = vif.monitor1_cb.A[3];
	xtn.B[0]     = vif.monitor1_cb.B[0];
	xtn.B[1]     = vif.monitor1_cb.B[1];
	xtn.B[2]     = vif.monitor1_cb.B[2];
	xtn.B[3]     = vif.monitor1_cb.B[3];
	xtn.OPCODE[0]= vif.monitor1_cb.OPCODE[0];
	xtn.OPCODE[1]= vif.monitor1_cb.OPCODE[1];
	xtn.OPCODE[2]= vif.monitor1_cb.OPCODE[2];
	xtn.OPCODE[3]= vif.monitor1_cb.OPCODE[3];
	xtn.ADDRESS[0]= vif.monitor1_cb.ADDRESS[0];
	xtn.ADDRESS[1]= vif.monitor1_cb.ADDRESS[1];
	xtn.ADDRESS[2]= vif.monitor1_cb.ADDRESS[2];
	xtn.ADDRESS[3]= vif.monitor1_cb.ADDRESS[3];
	xtn.RESULT[0]=vif.monitor1_cb.RESULT[0];
	xtn.RESULT[1]=vif.monitor1_cb.RESULT[1];
	xtn.RESULT[2]=vif.monitor1_cb.RESULT[2];
	xtn.RESULT[3]=vif.monitor1_cb.RESULT[3];
	xtn.data_in[0]   =  vif.monitor1_cb.data_in[0];
	xtn.data_in[1]   =  vif.monitor1_cb.data_in[1];
	xtn.data_in[2]   =  vif.monitor1_cb.data_in[2];
	xtn.data_in[3]   =  vif.monitor1_cb.data_in[3];
	xtn.data_out   =  vif.monitor1_cb.data_out;
         @(vif.monitor1_cb);
	//xtn.RW1      =vif.monitor1_cb.RW1;
`uvm_info("MONITOR",$sformatf("printing from write monitor \n %s", xtn.sprint()),UVM_LOW)
	end
monitor_port.write(xtn);
endtask
