class proc2_sequencer extends uvm_sequencer #(write_xtn);
`uvm_component_utils(proc2_sequencer)
extern function new(string name = "proc2_sequencer",uvm_component parent);
endclass


function proc2_sequencer::new(string name="proc2_sequencer",uvm_component parent);
super.new(name,parent);
endfunction



