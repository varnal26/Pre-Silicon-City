class parallel_processor_config extends uvm_object;
`uvm_object_utils(parallel_processor_config)

virtual parallel_processor_if vif;
uvm_active_passive_enum is_active = UVM_ACTIVE;   //Creates all 3 components if passive only monitor will be created
bit number_of_agents = 5;

function new(string name = "parallel_processor_config");
super.new(name);
endfunction

endclass

