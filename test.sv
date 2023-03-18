class parallel_processor_base_test extends uvm_test;
`uvm_component_utils(parallel_processor_base_test)
proc_env envh;
parallel_processor_config m_cfg;
extern function new(string name = "parallel_processor_base_test" , uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void end_of_elaboration_phase(uvm_phase phase);

endclass


	function parallel_processor_base_test::new(string name = "parallel_processor_base_test" , uvm_component parent);
		super.new(name,parent);
	endfunction


            
	function void parallel_processor_base_test::build_phase(uvm_phase phase);
		super.build_phase(phase);
		m_cfg=parallel_processor_config::type_id::create("m_cfg");
		if(!uvm_config_db#(virtual parallel_processor_if)::get(this, "","vif", m_cfg.vif))
		`uvm_fatal("TEST","cannot get() m_cfg from uvm_config_db. Have you set() it?")
	
		uvm_config_db #(parallel_processor_config)::set(this,"*","parallel_processor_config",m_cfg);
		envh=proc_env::type_id::create("envh", this);            
endfunction

function void parallel_processor_base_test::end_of_elaboration_phase(uvm_phase phase);
	super.end_of_elaboration_phase(phase);
	uvm_top.print_topology();
endfunction

class test extends parallel_processor_base_test;
`uvm_component_utils(test)
proc1_seq1 seq;
proc2_seq1 seq1;
proc3_seq1 seq2;
proc4_seq1 seq3;

extern function new(string name = "test" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

   	function test::new(string name = "test" , uvm_component parent);
		super.new(name,parent);
	endfunction


            
	function void test::build_phase(uvm_phase phase);
            super.build_phase(phase);
	
	endfunction


      	task test::run_phase(uvm_phase phase);
	 super.run_phase(phase);
		
          phase.raise_objection(this);
	  seq=proc1_seq1::type_id::create("seq");
	  seq1=proc2_seq1::type_id::create("seq1");
	  seq2=proc3_seq1::type_id::create("seq2");
	  seq3=proc4_seq1::type_id::create("seq3");
	fork
          seq.start(envh.agenth.seqrh);
	  seq1.start(envh.agent2h.seqr2h);
 	  seq2.start(envh.agent3h.seqr3h);
	  seq3.start(envh.agent4h.seqr4h);
join_none
					 #7050ns;
         phase.drop_objection(this);
	endtask   

//////////////////////////////////////////////////////
class test2 extends parallel_processor_base_test;
`uvm_component_utils(test2)
proc1_seq2 seq;
proc2_seq2 seq1;
proc3_seq2 seq2;
proc4_seq2 seq3;

extern function new(string name = "test2" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

   	function test2::new(string name = "test2" , uvm_component parent);
		super.new(name,parent);
	endfunction


            
	function void test2::build_phase(uvm_phase phase);
            super.build_phase(phase);
	
	endfunction


      	task test2::run_phase(uvm_phase phase);
	 super.run_phase(phase);
		
          phase.raise_objection(this);
	  seq=proc1_seq2::type_id::create("seq");
	  seq1=proc2_seq2::type_id::create("seq1");
	  seq2=proc3_seq2::type_id::create("seq2");
	  seq3=proc4_seq2::type_id::create("seq3");
	fork
          seq.start(envh.agenth.seqrh);
	  seq1.start(envh.agent2h.seqr2h);
 	  seq2.start(envh.agent3h.seqr3h);
	  seq3.start(envh.agent4h.seqr4h);
join_none
					 #1000ns;
         phase.drop_objection(this);
	endtask  

/////////////////////////////////////////////////////////////
class test3 extends parallel_processor_base_test;
`uvm_component_utils(test3)
proc1_seq3 seq;
proc2_seq3 seq1;
proc3_seq3 seq2;
proc4_seq3 seq3;

extern function new(string name = "test3" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

   	function test3::new(string name = "test3" , uvm_component parent);
		super.new(name,parent);
	endfunction


            
	function void test3::build_phase(uvm_phase phase);
            super.build_phase(phase);
	
	endfunction


      	task test3::run_phase(uvm_phase phase);
	 super.run_phase(phase);
		
          phase.raise_objection(this);
	  seq=proc1_seq3::type_id::create("seq");
	  seq1=proc2_seq3::type_id::create("seq1");
	  seq2=proc3_seq3::type_id::create("seq2");
	  seq3=proc4_seq3::type_id::create("seq3");
	fork
          seq.start(envh.agenth.seqrh);
	  seq1.start(envh.agent2h.seqr2h);
 	  seq2.start(envh.agent3h.seqr3h);
	  seq3.start(envh.agent4h.seqr4h);
join_none
					 #1000ns;
         phase.drop_objection(this);
	endtask   




/*class test1 extends parallel_processor_base_test;
`uvm_component_utils(test1)
proc1_seq1 seq1;

extern function new(string name = "test1" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

   	function test1::new(string name = "test1" , uvm_component parent);
		super.new(name,parent);
	endfunction


            
	function void test1::build_phase(uvm_phase phase);
            super.build_phase(phase);
	
	endfunction


      	task test1::run_phase(uvm_phase phase);
				
          phase.raise_objection(this);
	  seq1=proc1_seq1::type_id::create("seq1", this);
          seq1.start(envh.agenth.seqrh);
					 #30000;
         phase.drop_objection(this);
	endtask  */

