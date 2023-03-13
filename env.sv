	class proc_env extends uvm_env;

        
             	`uvm_component_utils(proc_env)
proc_agent agenth;
proc2_agent agent2h;
proc3_agent agent3h;
proc4_agent agent4h;


extern function new(string name = "proc_env", uvm_component parent);
extern function void build_phase(uvm_phase phase);
//extern function void connect_phase(uvm_phase phase);

endclass
	


	function proc_env::new(string name = "proc_env", uvm_component parent);
		super.new(name,parent);
	endfunction

        	function void proc_env::build_phase(uvm_phase phase);
	
	 /* if(!uvm_config_db #(bridge_env_config)::get(this,"","bridge_env_config",m_cfg))
		`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")
                if(m_cfg.has_wagents) begin*/

	

	          agenth=proc_agent::type_id::create("agenth",this);
		agent2h=proc2_agent::type_id::create("agent2h",this);
               agent3h=proc3_agent::type_id::create("agent3h",this);
		agent4h=proc4_agent::type_id::create("agent4h",this);
	             
               	super.build_phase(phase);
endfunction
 


