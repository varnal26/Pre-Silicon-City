class proc3_monitor extends uvm_monitor;

	`uvm_component_utils(proc3_monitor)

   	virtual parallel_processor_if.MONITOR3_MP vif;
        parallel_processor_config m_cfg;
	write_xtn  xtn;

  // uvm_analysis_port #(write_xtn) monitor_port;

extern function new(string name = "proc3_monitor", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task collect_data();
endclass

function proc3_monitor::new(string name = "proc3_monitor", uvm_component parent);
super.new(name,parent);
//monitor_port = new("monitor_port", this);
endfunction

function void proc3_monitor::build_phase(uvm_phase phase);
          super.build_phase(phase);

	  if(!uvm_config_db #(parallel_processor_config)::get(this,"","parallel_processor_config",m_cfg))
		`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?") 
endfunction

function void proc3_monitor::connect_phase(uvm_phase phase);
          vif = m_cfg.vif;
endfunction

task proc3_monitor::run_phase(uvm_phase phase);
repeat(4)
	 @(vif.monitor3_cb);
	forever
	   collect_data();
		 endtask


	task proc3_monitor::collect_data();
  xtn=write_xtn::type_id::create("xtn", this);
	// 
begin
//wait( vif.monitor3_cb.START1);
        xtn.A3     = vif.monitor3_cb.A3;
	xtn.B3     = vif.monitor3_cb.B3;
	xtn.OPCODE3= vif.monitor3_cb.OPCODE3;
	xtn.ADDRESS3= vif.monitor3_cb.ADDRESS3;
	xtn.DATA3   =  vif.monitor3_cb.DATA3;
	//xtn.RW3     =vif.monitor3_cb.RW3;
`uvm_info("MONITOR",$sformatf("printing from write monitor \n %s", xtn.sprint()),UVM_LOW)
	end
endtask
