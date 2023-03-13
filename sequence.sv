class proc_base_seq extends uvm_sequence #(write_xtn);
`uvm_object_utils(proc_base_seq)

function new(string name = "proc_base_seq");
endfunction

endclass


class proc1_seq extends proc_base_seq; // Transaction class as arg
`uvm_object_utils(proc1_seq)
function new (string name = "proc1_seq");
super.new(name);
endfunction               //Constructor

task body();
req=write_xtn::type_id::create("req");  //Creating the memory for the transaction
repeat(16)
begin
	   start_item(req);   // Handshaking between sequence and driver. 
   	   assert(req.randomize() with {OPCODE[0]<4'b1000; /*OPCODE[1]<4'b1000; OPCODE[2]<4'b1000; OPCODE[3]<4'b1000;*/});   // Randamoizing the transaction class
	   `uvm_info("WR_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH) 
	   finish_item(req);
end
endtask

endclass

class proc1_seq1 extends proc_base_seq;
`uvm_object_utils(proc1_seq1)

extern function new(string name = "proc1_seq1");
extern task body();
endclass

function proc1_seq1::new(string name = "proc1_seq1");
super.new(name);
endfunction

task proc1_seq1::body();
req=write_xtn::type_id::create("req");
repeat(16)
begin
	start_item(req);
	assert(req.randomize() with {OPCODE[1] == 4'b1001 || OPCODE[1] == 4'b0011;});
	`uvm_info("WR_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH)
	finish_item(req);
end
endtask

class proc3_seq1 extends proc_base_seq;
`uvm_object_utils(proc3_seq1)

extern function new(string name = "proc3_seq1");
extern task body();
endclass

function proc3_seq1::new(string name = "proc3_seq1");
super.new(name);
endfunction

task proc3_seq1::body();
req=write_xtn::type_id::create("req");
repeat(16)
begin
	start_item(req);
	assert(req.randomize() with {OPCODE[2] < 4'b1000;});
	`uvm_info("WR_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH)
	finish_item(req);
end
endtask

class proc4_seq1 extends proc_base_seq;
`uvm_object_utils(proc4_seq1)

extern function new(string name = "proc4_seq1");
extern task body();
endclass

function proc4_seq1::new(string name = "proc4_seq1");
super.new(name);
endfunction

task proc4_seq1::body();
req=write_xtn::type_id::create("req");
repeat(16)
begin
	start_item(req);
	assert(req.randomize() with {OPCODE[3] < 4'b1000;});
	`uvm_info("WR_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH)
	finish_item(req);
end
endtask



