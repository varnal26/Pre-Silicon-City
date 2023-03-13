class scoreboard extends uvm_scoreboard;

    `uvm_component_utils (scoreboard)
 
    function new (string name = "scoreboard", uvm_component parent = null);
      super.new (name, parent);
    endfunction

//TLM Analysis Port to receive data objects from other TB components
    uvm_analysis_imp #(write_xtn, scoreboard) anp_imp;
	
// Instantiate the analysis port
    function void build_phase (uvm_phase phase);
	anp_imp = new ("anp_imp", this);
    endfunction


     virtual task run_phase (uvm_phase phase);
	

	logic [15:0] predicted_result= 16'b0;

	super.run_phase(phase);
	phase.raise_objection(this); 

       @(posedge vif.DONE);
      
       #1;
      case (vif.OPCODE[1])
 	4'b0000: predicted_result =0;
	4'b1111: predicted_result =0;
      	4'b0001: predicted_result = vif.A + vif.B;
        4'b0010: predicted_result = vif.A & vif.B;
        4'b0011: predicted_result = vif.A ^ vif.B;
        4'b0100: predicted_result = vif.A * vif.B;
	4'b0101: predicted_result = vif.A +2* vif.B;
	4'b0110: predicted_result = vif.A * 2;
	4'b0111: predicted_result = vif.A * 3;
	//load:predicted_result=memory;
	//store:memory=predicted_result;
	4'b1010: predicted_result = vif.A << 2;
	4'b1011: predicted_result = vif.B >> 3;
		
      endcase
      
      if ((vif.OPCODE[1] != 4'b1000)||(vif.OPCODE[1] != 4'b1001)||(vif.OPCODE[1] != 4'b1100)||(vif.OPCODE[1] != 4'b1101)||(vif.OPCODE[1] != 4'b1110)) begin
        if (predicted_result != vif.RESULT[1]) begin
          $error ("FAILED: A: %0d  B: %0d  op: %s result: %0d predicted:%0d", vif.A[1], vif.B[1], vif.OPCODE[1], vif.RESULT[1],predicted_result);
        end 
	//else begin
	$info("passed: A: %0h  B: %0h  op: %s result: %0h",vif.A[1], vif.B[1], vif.OPCODE[1], vif.RESULT[1],predicted_result);
      	//end 
      end
      

    phase.drop_objection(this);

   endtask
	

endclass
