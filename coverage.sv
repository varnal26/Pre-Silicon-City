
class coverage extends uvm_subscriber#(write_xtn);
  `uvm_component_utils(coverage);
  
  virtual parallel_processor_if.MONITOR2_MP vif;
        parallel_processor_config m_cfg;
	write_xtn  xtn;
	real cov;
  
  byte unsigned A, B;
  bit [3:0]OPCODE;
  //operation_t op_set;*/

 covergroup op_cov1;
  option.per_instance = 1;
    coverpoint vif.OPCODE[0] {
      bins single_cycle[] = {[4'b0001:4'b0011], 4'b0000};
      bins multi_cycle = {[4'b0100:4'b0111]};
      bins load_store = {[4'b1000:4'b1001]}; 
      bins add = {4'b0001};
}

endgroup:op_cov1

  
  function new(string name, uvm_component parent);
    super.new(name, parent);
    
    op_cov1 = new();
	
    //zeros_or_ones_on_ops = new();
  endfunction : new
  
  function void build_phase (uvm_phase phase);
        super.build_phase(phase);

	  if(!uvm_config_db #(parallel_processor_config)::get(this,"","parallel_processor_config",m_cfg))
		`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?") 
   endfunction

function void connect_phase(uvm_phase phase);
          vif = m_cfg.vif;
endfunction

 
function void write(write_xtn t);
    xtn=t;
    //op_cov1.sample();
  endfunction


task run_phase(uvm_phase phase);
    forever begin
      @( vif.clock);
	op_cov1.sample();
	end
endtask

function void extract_phase(uvm_phase phase);
    super.extract_phase(phase);
    cov=op_cov1.get_coverage();
  endfunction


function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info(get_type_name(),$sformatf("Coverage is %f",cov),UVM_MEDIUM)
  endfunction
  

endclass
 











/*function void connect_phase(uvm_phase phase);
          vif = m_cfg.vif;
endfunction





          
  task run_phase(uvm_phase phase);
    forever begin
      @( vif.monitor1_cb);
	A = vif.monitor1_cb.A[0];
	B  = vif.monitor1_cb.B[0];
	OPCODE = vif.monitor1_cb.OPCODE[0];
	
	//op = new();
      op_cov.sample();
//      zeros_or_ones_on_ops.sample();
    end //forever
  endtask : run_phase
  
  covergroup op_cov;
  
    coverpoint vif.monitor1_cb.OPCODE[0] {
      bins single_cycle[] = {[4'b0001:4'b0011], 4'b0000};
      bins multi_cycle = {[4'b0100:4'b0111]};
      
      bins open_rst[] = ([add_op:mul_op] => rst_op);
      bins rst_opn[] = (rst_op => [add_op:mul_op]);
      
      bins sngl_mul[] = ([add_op:xor_op], no_op => mul_op);
      bins mul_sngl[] = (mul_op => [add_op:xor_op], no_op);
      
      bins twoops[] = ([add_op:mul_op] [* 2]);
      bins manymult = (mul_op [* 3:5]);
    }
  //endgroup:op_cov
//op_cov op;
  
   covergroup zeros_or_ones_on_ops;

      all_ops : coverpoint op_set {
         ignore_bins null_ops = {rst_op, no_op};}

      a_leg: coverpoint A {
         bins zeros = {'h00};
         bins others= {['h01:'hFE]};
         bins ones  = {'hFF};
      }

      b_leg: coverpoint B {
         bins zeros = {'h00};
         bins others= {['h01:'hFE]};
         bins ones  = {'hFF};
      }

      op_00_FF:  cross a_leg, b_leg, all_ops {
         bins add_00 = binsof (all_ops) intersect {add_op} &&
                       (binsof (a_leg.zeros) || binsof (b_leg.zeros));

         bins add_FF = binsof (all_ops) intersect {add_op} &&
                       (binsof (a_leg.ones) || binsof (b_leg.ones));

         bins and_00 = binsof (all_ops) intersect {and_op} &&
                       (binsof (a_leg.zeros) || binsof (b_leg.zeros));

         bins and_FF = binsof (all_ops) intersect {and_op} &&
                       (binsof (a_leg.ones) || binsof (b_leg.ones));

         bins xor_00 = binsof (all_ops) intersect {xor_op} &&
                       (binsof (a_leg.zeros) || binsof (b_leg.zeros));

         bins xor_FF = binsof (all_ops) intersect {xor_op} &&
                       (binsof (a_leg.ones) || binsof (b_leg.ones));

         bins mul_00 = binsof (all_ops) intersect {mul_op} &&
                       (binsof (a_leg.zeros) || binsof (b_leg.zeros));

         bins mul_FF = binsof (all_ops) intersect {mul_op} &&
                       (binsof (a_leg.ones) || binsof (b_leg.ones));

         bins mul_max = binsof (all_ops) intersect {mul_op} &&
                        (binsof (a_leg.ones) && binsof (b_leg.ones));

         ignore_bins others_only =
                                  binsof(a_leg.others) && binsof(b_leg.others);

      }

	endgroup

//op_cov op;
  
endclass : coverage*/
