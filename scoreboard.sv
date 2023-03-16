class scoreboard extends uvm_scoreboard;

  `uvm_component_utils(scoreboard)
  uvm_analysis_imp#(write_xtn, scoreboard) item_collected_export;
  parallel_processor_config m_cfg;
	write_xtn  xtn;
  virtual parallel_processor_if vif;

  // new - constructor
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    item_collected_export = new("item_collected_export", this);
	
	if(!uvm_config_db #(parallel_processor_config)::get(this,"","parallel_processor_config",m_cfg))
		`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?") 
  endfunction: build_phase
  
  
  function void connect_phase(uvm_phase phase);
          vif = m_cfg.vif;
endfunction
  
  // write
  virtual function void write(write_xtn xtn);
    $display("SCB:: Pkt recived");
    //xtn.print();
  endfunction : write
  
  
  task run_phase(uvm_phase phase);
forever begin
check_data();
end
endtask

   task check_data();
 
    //forever begin : self_checker

    shortint expected_result;
@(posedge vif.monitor1_cb.DONE[0]);
      case (vif.monitor1_cb.OPCODE[0])
      	4'b0001: expected_result = vif.monitor1_cb.A[0] + vif.monitor1_cb.B[0];
        4'b0010: expected_result = vif.monitor1_cb.A[0] & vif.monitor1_cb.B[0];
        4'b0011: expected_result = vif.monitor1_cb.A[0] ^ vif.monitor1_cb.B[0];
        4'b0100: expected_result = vif.monitor1_cb.A[0] *vif.monitor1_cb.B[0];
	4'b0101: expected_result = vif.monitor1_cb.A[0] + 2*vif.monitor1_cb.B[0];
        4'b0110: expected_result = vif.monitor1_cb.A[0] *2;
        4'b0111: expected_result = vif.monitor1_cb.A[0] *3;
      endcase



        if (expected_result != vif.monitor1_cb.RESULT[0]) begin
          $error ("FAILED: A: %0h  B: %0h  OPCODE: %0d EXPECTED RESULT: %0h, ACTUAL RESULT : %0h", vif.driver1_cb.A[0], vif.driver1_cb.B[0], vif.driver1_cb.OPCODE[0], expected_result, vif.monitor1_cb.RESULT[0]);
        end 
	else
	$display ("PASSED: A: %0h  B: %0h  OPCODE: %0d EXPECTED RESULT: %0h, ACTUAL RESULT : %0h", vif.driver1_cb.A[0], vif.driver1_cb.B[0], vif.driver1_cb.OPCODE[0], expected_result,vif.monitor1_cb.RESULT[0]);
  endtask

endclass : scoreboard




