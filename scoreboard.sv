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
@(posedge vif.clock);
fork
check_data();
//check_data1();
//check_data2();
//check_data3();
join
end
endtask

   task check_data();
 
    //forever begin : self_checker

    shortint expected_result, expected_result2 ,expected_result3,expected_result4, expected_result5, expected_result6 ;
	expected_result = 2;
/*@(posedge vif.clock);
if(vif.monitor1_cb.OPCODE[0] == 4'b0000);
begin
	expected_result5 = 0;
	//if(!vif.monitor1_cb.OPCODE[0])
	//begin
	 if (expected_result5 !== vif.monitor1_cb.RESULT[0]) begin
          $error ("FAILED: A: %0h  B: %0h  OPCODE: %0d EXPECTED RESULT: %0h, ACTUAL RESULT : %0h", vif.driver1_cb.A[0], vif.driver1_cb.B[0], vif.driver1_cb.OPCODE[0], expected_result5, vif.monitor1_cb.RESULT[0]);
        end 
	else
	$display ("PASSED: A: %0h  B: %0h  OPCODE: %0d EXPECTED RESULT: %0h, ACTUAL RESULT : %0h", vif.driver1_cb.A[0], vif.driver1_cb.B[0], vif.driver1_cb.OPCODE[0], expected_result5,vif.monitor1_cb.RESULT[0]);
//end

end

if(vif.monitor1_cb.OPCODE[1] == 4'b0000);
begin
	expected_result6 = 0;
//	if(!vif.monitor1_cb.OPCODE[1])
//	begin
	 if (expected_result6 !== vif.monitor1_cb.RESULT[0]) begin
          $error ("FAILED: A: %0h  B: %0h  OPCODE: %0d EXPECTED RESULT: %0h, ACTUAL RESULT : %0h", vif.driver1_cb.A[1], vif.driver1_cb.B[1], vif.driver1_cb.OPCODE[1], expected_result6, vif.monitor1_cb.RESULT[1]);
        end 
	else
	$display ("PASSED: A: %0h  B: %0h  OPCODE: %0d EXPECTED RESULT: %0h, ACTUAL RESULT : %0h", vif.driver1_cb.A[1], vif.driver1_cb.B[1], vif.driver1_cb.OPCODE[1], expected_result6,vif.monitor1_cb.RESULT[1]);
//end

end */



@(posedge vif.monitor1_cb.DONE[0] or posedge vif.monitor1_cb.DONE[1] or posedge vif.monitor1_cb.DONE[2] or posedge vif.monitor1_cb.DONE[3]  );
if(vif.monitor1_cb.DONE[0])
begin
      case (vif.monitor1_cb.OPCODE[0])	
      	4'b0000: expected_result = 0;
      	4'b0001: expected_result = vif.monitor1_cb.A[0] + vif.monitor1_cb.B[0];
        4'b0010: expected_result = vif.monitor1_cb.A[0] & vif.monitor1_cb.B[0];
        4'b0011: expected_result = vif.monitor1_cb.A[0] ^ vif.monitor1_cb.B[0];
        4'b0100: expected_result = vif.monitor1_cb.A[0] *vif.monitor1_cb.B[0];
	4'b0101: expected_result = vif.monitor1_cb.A[0] + 2*vif.monitor1_cb.B[0];
        4'b0110: expected_result = vif.monitor1_cb.A[0] *2;
        4'b0111: expected_result = vif.monitor1_cb.A[0] *3;
        4'b1010: expected_result = vif.monitor1_cb.A[0] << 2;
        4'b1011: expected_result = vif.monitor1_cb.B[0] >> 3;
        4'b1111: expected_result = 0;
      endcase



        if (expected_result !== vif.monitor1_cb.RESULT[0]) begin
          $error ("FAILED: A: %0h  B: %0h  OPCODE: %0d EXPECTED RESULT: %0h, ACTUAL RESULT : %0h", vif.driver1_cb.A[0], vif.driver1_cb.B[0], vif.driver1_cb.OPCODE[0], expected_result, vif.monitor1_cb.RESULT[0]);
        end 
	else
	$display ("PASSED: A: %0h  B: %0h  OPCODE: %0d EXPECTED RESULT: %0h, ACTUAL RESULT : %0h", vif.driver1_cb.A[0], vif.driver1_cb.B[0], vif.driver1_cb.OPCODE[0], expected_result,vif.monitor1_cb.RESULT[0]);
end

if(vif.monitor1_cb.DONE[1])
begin
      case (vif.monitor1_cb.OPCODE[1])
      	4'b0000: expected_result2 = 0;
      	4'b0001: expected_result2 = vif.monitor1_cb.A[1] + vif.monitor1_cb.B[1];
        4'b0010: expected_result2 = vif.monitor1_cb.A[1] & vif.monitor1_cb.B[1];
        4'b0011: expected_result2 = vif.monitor1_cb.A[1] ^ vif.monitor1_cb.B[1];
        4'b0100: expected_result2 = vif.monitor1_cb.A[1] *vif.monitor1_cb.B[1];
	4'b0101: expected_result2 = vif.monitor1_cb.A[1] + 2*vif.monitor1_cb.B[1];
        4'b0110: expected_result2 = vif.monitor1_cb.A[1] *2;
        4'b0111: expected_result2 = vif.monitor1_cb.A[1] *3;
        4'b1010: expected_result2 = vif.monitor1_cb.A[1] << 2;
        4'b1011: expected_result2 = vif.monitor1_cb.B[1] >> 3;
        4'b1111: expected_result2 = 0;
      endcase



        if (expected_result2 !== vif.monitor1_cb.RESULT[1]) begin
          $error ("FAILED: A: %0h  B: %0h  OPCODE: %0d EXPECTED RESULT: %0h, ACTUAL RESULT : %0h", vif.driver1_cb.A[1], vif.driver1_cb.B[1], vif.driver1_cb.OPCODE[1], expected_result2, vif.monitor1_cb.RESULT[1]);
        end 
	else
	$display ("PASSED: A: %0h  B: %0h  OPCODE: %0d EXPECTED RESULT: %0h, ACTUAL RESULT : %0h", vif.driver1_cb.A[1], vif.driver1_cb.B[1], vif.driver1_cb.OPCODE[1], expected_result2,vif.monitor1_cb.RESULT[1]);
end

if(vif.monitor1_cb.DONE[2])
begin
case (vif.monitor1_cb.OPCODE[2])
      	4'b0000: expected_result3 = 0;
      	4'b0001: expected_result3 = vif.monitor1_cb.A[2] + vif.monitor1_cb.B[2];
        4'b0010: expected_result3 = vif.monitor1_cb.A[2] & vif.monitor1_cb.B[2];
        4'b0011: expected_result3 = vif.monitor1_cb.A[2] ^ vif.monitor1_cb.B[2];
        4'b0100: expected_result3 = vif.monitor1_cb.A[2] *vif.monitor1_cb.B[2];
	4'b0101: expected_result3 = vif.monitor1_cb.A[2] + 2*vif.monitor1_cb.B[2];
        4'b0110: expected_result3 = vif.monitor1_cb.A[2] *2;
        4'b0111: expected_result3 = vif.monitor1_cb.A[2] *3;
        4'b1010: expected_result3 = vif.monitor1_cb.A[2] << 2;
        4'b1011: expected_result3 = vif.monitor1_cb.B[2] >> 3;
        4'b1111: expected_result3 = 0;
      endcase



        if (expected_result3 !== vif.monitor1_cb.RESULT[2]) begin
          $error ("FAILED: A: %0h  B: %0h  OPCODE: %0d EXPECTED RESULT: %0h, ACTUAL RESULT : %0h", vif.driver1_cb.A[2], vif.driver1_cb.B[2], vif.driver1_cb.OPCODE[2], expected_result3, vif.monitor1_cb.RESULT[2]);
        end 
	else
	$display ("PASSED: A: %0h  B: %0h  OPCODE: %0d EXPECTED RESULT: %0h, ACTUAL RESULT : %0h", vif.driver1_cb.A[2], vif.driver1_cb.B[2], vif.driver1_cb.OPCODE[2], expected_result3,vif.monitor1_cb.RESULT[2]);
end

if(vif.monitor1_cb.DONE[3])
begin
case (vif.monitor1_cb.OPCODE[3])
      	4'b0000: expected_result4 = 0;
      	4'b0001: expected_result4 = vif.monitor1_cb.A[3] + vif.monitor1_cb.B[3];
        4'b0010: expected_result4= vif.monitor1_cb.A[3] & vif.monitor1_cb.B[3];
        4'b0011: expected_result4 = vif.monitor1_cb.A[3] ^ vif.monitor1_cb.B[3];
        4'b0100: expected_result4 = vif.monitor1_cb.A[3] *vif.monitor1_cb.B[3];
	4'b0101: expected_result4 = vif.monitor1_cb.A[3] + 2*vif.monitor1_cb.B[3];
        4'b0110: expected_result4 = vif.monitor1_cb.A[3] *2;
        4'b0111: expected_result4 = vif.monitor1_cb.A[3] *3;
        4'b1010: expected_result4 = vif.monitor1_cb.A[3] << 2;
        4'b1011: expected_result4 = vif.monitor1_cb.B[3] >> 3;
        4'b1111: expected_result4 = 0;
      endcase



        if (expected_result4 !== vif.monitor1_cb.RESULT[3]) begin
          $error ("FAILED: A: %0h  B: %0h  OPCODE: %0d EXPECTED RESULT: %0h, ACTUAL RESULT : %0h", vif.driver1_cb.A[3], vif.driver1_cb.B[3], vif.driver1_cb.OPCODE[3], expected_result4, vif.monitor1_cb.RESULT[3]);
        end 
	else
	$display ("PASSED: A: %0h  B: %0h  OPCODE: %0d EXPECTED RESULT: %0h, ACTUAL RESULT : %0h", vif.driver1_cb.A[3], vif.driver1_cb.B[3], vif.driver1_cb.OPCODE[3], expected_result4,vif.monitor1_cb.RESULT[3]);

end
  endtask

//////////////////////////////////////////////
/*task check_data1();
 
    //forever begin : self_checker

    shortint expected_result;
@(posedge vif.monitor1_cb.DONE[1]);
      case (vif.monitor1_cb.OPCODE[1])
      	4'b0001: expected_result = vif.monitor1_cb.A[1] + vif.monitor1_cb.B[1];
        4'b0010: expected_result = vif.monitor1_cb.A[1] & vif.monitor1_cb.B[1];
        4'b0011: expected_result = vif.monitor1_cb.A[1] ^ vif.monitor1_cb.B[1];
        4'b0100: expected_result = vif.monitor1_cb.A[1] *vif.monitor1_cb.B[1];
	4'b0101: expected_result = vif.monitor1_cb.A[1] + 2*vif.monitor1_cb.B[1];
        4'b0110: expected_result = vif.monitor1_cb.A[1] *2;
        4'b0111: expected_result = vif.monitor1_cb.A[1] *3;
      endcase



        if (expected_result != vif.monitor1_cb.RESULT[1]) begin
          $error ("FAILED: A: %0h  B: %0h  OPCODE: %0d EXPECTED RESULT: %0h, ACTUAL RESULT : %0h", vif.driver1_cb.A[1], vif.driver1_cb.B[1], vif.driver1_cb.OPCODE[1], expected_result, vif.monitor1_cb.RESULT[1]);
        end 
	else
	$display ("PASSED: A: %0h  B: %0h  OPCODE: %0d EXPECTED RESULT: %0h, ACTUAL RESULT : %0h", vif.driver1_cb.A[1], vif.driver1_cb.B[1], vif.driver1_cb.OPCODE[1], expected_result,vif.monitor1_cb.RESULT[1]);
  endtask
//////////////////////////////////////////////////////////////////////////////////////
task check_data2();
 
    //forever begin : self_checker

    shortint expected_result;
@(posedge vif.monitor1_cb.DONE[2]);
      case (vif.monitor1_cb.OPCODE[2])
      	4'b0001: expected_result = vif.monitor1_cb.A[2] + vif.monitor1_cb.B[2];
        4'b0010: expected_result = vif.monitor1_cb.A[2] & vif.monitor1_cb.B[2];
        4'b0011: expected_result = vif.monitor1_cb.A[2] ^ vif.monitor1_cb.B[2];
        4'b0100: expected_result = vif.monitor1_cb.A[2] *vif.monitor1_cb.B[2];
	4'b0101: expected_result = vif.monitor1_cb.A[2] + 2*vif.monitor1_cb.B[2];
        4'b0110: expected_result = vif.monitor1_cb.A[2] *2;
        4'b0111: expected_result = vif.monitor1_cb.A[2] *3;
      endcase



        if (expected_result != vif.monitor1_cb.RESULT[2]) begin
          $error ("FAILED: A: %0h  B: %0h  OPCODE: %0d EXPECTED RESULT: %0h, ACTUAL RESULT : %0h", vif.driver1_cb.A[2], vif.driver1_cb.B[2], vif.driver1_cb.OPCODE[2], expected_result, vif.monitor1_cb.RESULT[2]);
        end 
	else
	$display ("PASSED: A: %0h  B: %0h  OPCODE: %0d EXPECTED RESULT: %0h, ACTUAL RESULT : %0h", vif.driver1_cb.A[2], vif.driver1_cb.B[2], vif.driver1_cb.OPCODE[2], expected_result,vif.monitor1_cb.RESULT[2]);
  endtask
//////////////////////////////////////////////////////////////////////////////////////////
task check_data3();
 
    //forever begin : self_checker

    shortint expected_result;
@(posedge vif.monitor1_cb.DONE[3]);
      case (vif.monitor1_cb.OPCODE[3])
      	4'b0001: expected_result = vif.monitor1_cb.A[3] + vif.monitor1_cb.B[3];
        4'b0010: expected_result = vif.monitor1_cb.A[3] & vif.monitor1_cb.B[3];
        4'b0011: expected_result = vif.monitor1_cb.A[3] ^ vif.monitor1_cb.B[3];
        4'b0100: expected_result = vif.monitor1_cb.A[3] *vif.monitor1_cb.B[3];
	4'b0101: expected_result = vif.monitor1_cb.A[3] + 2*vif.monitor1_cb.B[3];
        4'b0110: expected_result = vif.monitor1_cb.A[3] *2;
        4'b0111: expected_result = vif.monitor1_cb.A[3] *3;
      endcase



        if (expected_result != vif.monitor1_cb.RESULT[3]) begin
          $error ("FAILED: A: %0h  B: %0h  OPCODE: %0d EXPECTED RESULT: %0h, ACTUAL RESULT : %0h", vif.driver1_cb.A[3], vif.driver1_cb.B[3], vif.driver1_cb.OPCODE[3], expected_result, vif.monitor1_cb.RESULT[3]);
        end 
	else
	$display ("PASSED: A: %0h  B: %0h  OPCODE: %0d EXPECTED RESULT: %0h, ACTUAL RESULT : %0h", vif.driver1_cb.A[3], vif.driver1_cb.B[3], vif.driver1_cb.OPCODE[3], expected_result,vif.monitor1_cb.RESULT[3]);
  endtask */


endclass : scoreboard




