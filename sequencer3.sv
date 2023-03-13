class proc3_sequencer extends uvm_sequencer #(write_xtn);
`uvm_component_utils(proc3_sequencer);

extern function new(string name = "proc3_sequencer", uvm_component parent);
endclass

function proc3_sequencer::new(string name ="proc3_sequencer", uvm_component parent);
super.new(name, parent);
endfunction
