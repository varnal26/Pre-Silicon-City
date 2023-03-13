class proc2_monitor extends uvm_monitor;
`uvm_component_utils(proc2_monitor);

   	virtual parallel_processor_if.MONITOR2_MP vif;
        parallel_processor_config m_cfg;
	write_xtn  xtn;

  // uvm_analysis_port #(write_xtn) monitor_port;

extern function new(string name = "proc2_monitor", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task collect_data();
endclass

function proc2_monitor::new(string name = "proc2_monitor", uvm_component parent);
super.new(name,parent);
//monitor_port = new("monitor_port", this);
endfunction

function void proc2_monitor::build_phase(uvm_phase phase);
          super.build_phase(phase);

	  if(!uvm_config_db #(parallel_processor_config)::get(this,"","parallel_processor_config",m_cfg))
		`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?") 
endfunction

function void proc_monitor::connect_phase(uvm_phase phase);
          vif = m_cfg.vif;
endfunction

task proc2_monitor::run_phase(uvm_phase phase);
repeat(4)
	 @(vif.monitor2_cb);
	forever
	   collect_data();
		 endtask


	task proc2_monitor::collect_data();
  xtn=write_xtn::type_id::create("xtn", this);
	// 
begin
//wait( vif.monitor1_cb.START1);
        xtn.A2     = vif.monitor2_cb.A2;
	xtn.B2     = vif.monitor2_cb.B2;
	xtn.OPCODE2= vif.monitor2_cb.OPCODE2;
	xtn.ADDRESS2= vif.monitor2_cb.ADDRESS2;
	xtn.DATA2   =  vif.monitor2_cb.DATA2;
	//xtn.RW2      =vif.monitor2_cb.RW2;
`uvm_info("MONITOR2",$sformatf("printing from write monitor \n %s", xtn.sprint()),UVM_LOW)
	end
endtask
