class proc2_agent extends uvm_agent;
`uvm_component_utils(proc2_agent);

parallel_processor_config m_cfg;
proc2_driver drv2h;
//proc2_monitor mon2h;
proc2_sequencer seqr2h;

extern function new(string name = "proc2_agent", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);

endclass

function proc2_agent::new(string name = "proc2_agent", uvm_component parent);
super.new(name, parent);
endfunction

function void proc2_agent::build_phase(uvm_phase phase);
super.build_phase(phase);
if(!uvm_config_db #(parallel_processor_config)::get(this,"","parallel_processor_config",m_cfg))
		`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?") 
	     // mon2h=proc2_monitor::type_id::create("mon2h",this);	
		if(m_cfg.is_active==UVM_ACTIVE)
		begin
		drv2h=proc2_driver::type_id::create("drv2h",this);
		seqr2h=proc2_sequencer::type_id::create("seqr2h",this);
		end
	endfunction

function void proc2_agent::connect_phase(uvm_phase phase);
		if(m_cfg.is_active==UVM_ACTIVE)
		begin
		drv2h.seq_item_port.connect(seqr2h.seq_item_export);
  		end
	endfunction

