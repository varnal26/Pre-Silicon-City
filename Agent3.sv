class proc3_agent extends uvm_agent;
`uvm_component_utils(proc3_agent);

parallel_processor_config m_cfg;
proc3_driver drv3h;
//proc3_monitor mon3h;
proc3_sequencer seqr3h;

extern function new(string name = "proc3_agent", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);

endclass

function proc3_agent::new(string name = "proc3_agent", uvm_component parent);
super.new(name, parent);
endfunction

function void proc3_agent::build_phase(uvm_phase phase); 
super.build_phase(phase);
if(!uvm_config_db # (parallel_processor_config)::get(this,"", "parallel_processor_config", m_cfg))
 `uvm_fatal("CONFIG", "FAILED to get the config, have you set m_cfg?")
//mon3h=proc3_monitor::type_id::create("mon3h", this);
if(m_cfg.is_active==UVM_ACTIVE)
	begin
	drv3h=proc3_driver::type_id::create("drv3h", this);
	seqr3h=proc3_sequencer::type_id::create("seqr3h", this);
	end
endfunction

function void proc3_agent::connect_phase(uvm_phase phase);
super.connect_phase(phase);
if(m_cfg.is_active==UVM_ACTIVE)
	begin
	drv3h.seq_item_port.connect(seqr3h.seq_item_export);
	end
endfunction
