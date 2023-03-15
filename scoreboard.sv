class scoreboard extends uvm_scoreboard;

  `uvm_component_utils(scoreboard)
  uvm_analysis_imp#(write_xtn, scoreboard) item_collected_export;

  // new - constructor
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    item_collected_export = new("item_collected_export", this);
  endfunction: build_phase
  
  // write
  virtual function void write(write_xtn xtn);
    $display("SCB:: Pkt recived");
    xtn.print();
  endfunction : write

endclass : scoreboard





/*class scoreboard extends uvm_scoreboard;

  `uvm_component_utils(scoreboard)

  // TLM Analysis Port to receive data objects from other TB components
  uvm_analysis_imp #(write_xtn) anp_imp;

  function new(string name = "scoreboard", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    anp_imp = new("anp_imp", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);

    write_xtn txn;
    while (1) begin
      // Wait for a write transaction to arrive at the analysis port
      @(anp_imp.get_port(), txn);

      // Compute the expected result based on the input transaction
      logic [15:0] expected_result = 16'b0;
      case (txn.OPCODE[0])
        4'b0000, 4'b1111: expected_result = 0;
        4'b0001: expected_result = txn.A[0] + txn.B[0];
        4'b0010: expected_result = txn.A[0] & txn.B[0];
        4'b0011: expected_result = txn.A[0] ^ txn.B[0];
        4'b0100: expected_result = txn.A[0] * txn.B[0];
        4'b0101: expected_result = txn.A[0] + 2 * txn.B[0];
        4'b0110: expected_result = txn.A[0] * 2;
        4'b0111: expected_result = txn.A[0] * 3;
        4'b1010: expected_result = txn.A[0] << 2;
        4'b1011: expected_result = txn.B[0] >> 3;
      endcase

      // Compare the expected result with the actual result
      if (txn.RESULT[0] !== expected_result) begin
        `uvm_error(get_type_name(), $sformatf("ALU test failed: A=%0d B=%0d Opcode=%b Expected=%0d Actual=%0d",
          txn.A[0], txn.B[0], txn.OPCODE[0], expected_result, txn.RESULT[0]))
      end
      else begin
        `uvm_info(get_type_name(), $sformatf("ALU test passed: A=%0d B=%0d Opcode=%b Result=%0d",
          txn.A[0], txn.B[0], txn.OPCODE[0], txn.RESULT[0]), UVM_LOW)
      end
    end

    phase.drop_objection(this);
  endtask

endclass*/
