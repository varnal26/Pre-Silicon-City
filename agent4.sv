class proc4_agent extends uvm_agent;
`uvm_component_utils(proc4_agent);

parallel_processor_config m_cfg;
proc4_driver drv4h;
//proc4_monitor mon4h;
proc4_sequencer seqr4h;

extern function new(string name = "proc4_agent", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);

endclass

function proc4_agent::new(string name = "proc4_agent", uvm_component parent);
super.new(name, parent);
endfunction

function void proc4_agent::build_phase(uvm_phase phase);
super.build_phase(phase);

if(!uvm_config_db #(parallel_processor_config)::get(this, "","parallel_processor_config",m_cfg))
	`uvm_fatal("AGENT","Unable to get the config at the agent, have you set m_cfg()?");
//mon4h=proc4_monitor::type_id::create("mon4h", this);
if(m_cfg.is_active==UVM_ACTIVE)
begin
drv4h=proc4_driver::type_id::create("drv4h", this);
seqr4h=proc4_sequencer::type_id::create("seqr4h", this);
end
endfunction

function void proc4_agent::connect_phase(uvm_phase phase);
if(m_cfg.is_active==UVM_ACTIVE)
begin
drv4h.seq_item_port.connect(seqr4h.seq_item_export);
end
endfunction
