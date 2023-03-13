	class proc_agent extends uvm_agent;

 	`uvm_component_utils(proc_agent)

         parallel_processor_config m_cfg;
       
proc_monitor monh;
proc_sequencer seqrh;
proc_driver drvh;

  extern function new(string name = "proc_agent", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);

endclass

       function proc_agent::new(string name = "proc_agent", uvm_component parent);
         super.new(name, parent);
       endfunction
     
  
	function void proc_agent::build_phase(uvm_phase phase);
		super.build_phase(phase);
          	  if(!uvm_config_db #(parallel_processor_config)::get(this,"","parallel_processor_config",m_cfg))
		`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?") 
	      monh=proc_monitor::type_id::create("monh",this);	
		if(m_cfg.is_active==UVM_ACTIVE)
		begin
		drvh=proc_driver::type_id::create("drvh",this);
		seqrh=proc_sequencer::type_id::create("seqrh",this);
		end
	endfunction

      
      
	function void proc_agent::connect_phase(uvm_phase phase);
		if(m_cfg.is_active==UVM_ACTIVE)
		begin
		drvh.seq_item_port.connect(seqrh.seq_item_export);
  		end
	endfunction


