class proc4_sequencer extends uvm_sequencer #(write_xtn);
`uvm_component_utils(proc4_sequencer);

extern function new(string name = "proc4_sequencer", uvm_component parent);
endclass

function proc4_sequencer::new(string name = "proc4_sequencer", uvm_component parent);
super.new(name, parent);
endfunction
