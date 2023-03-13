class proc_sequencer extends uvm_sequencer #(write_xtn);
`uvm_component_utils(proc_sequencer)
extern function new(string name = "proc_sequencer",uvm_component parent);
endclass


function proc_sequencer::new(string name="proc_sequencer",uvm_component parent);
super.new(name,parent);
endfunction



