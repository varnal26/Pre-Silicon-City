class proc_base_seq extends uvm_sequence #(write_xtn);
`uvm_object_utils(proc_base_seq)

function new(string name = "proc_base_seq");
endfunction

endclass


class proc1_seq1 extends proc_base_seq; // Transaction class as arg
`uvm_object_utils(proc1_seq1)
function new (string name = "proc1_seq1");
super.new(name);
endfunction               //Constructor

task body();
req=write_xtn::type_id::create("req");  //Creating the memory for the transaction
repeat(100)
begin
	   start_item(req);   // Handshaking between sequence and driver. 
   	   assert(req.randomize());   // Randamoizing the transaction class
	   `uvm_info("WR_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH) 
	   finish_item(req);
end
endtask

endclass

class proc2_seq1 extends proc_base_seq;
`uvm_object_utils(proc2_seq1)

extern function new(string name = "proc2_seq1");
extern task body();
endclass

function proc2_seq1::new(string name = "proc2_seq1");
super.new(name);
endfunction

task proc2_seq1::body();
req=write_xtn::type_id::create("req");
repeat(100)
begin
	start_item(req);
	assert(req.randomize());
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
repeat(100)
begin
	start_item(req);
	assert(req.randomize());
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
repeat(100)
begin
	start_item(req);
	assert(req.randomize());
	`uvm_info("WR_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH)
	finish_item(req);
end
endtask
//////////////seq2
class proc1_seq2 extends proc_base_seq;
`uvm_object_utils(proc1_seq2)

extern function new(string name = "proc1_seq2");
extern task body();
endclass

function proc1_seq2::new(string name = "proc1_seq2");
super.new(name);
endfunction

task proc1_seq2::body();
req=write_xtn::type_id::create("req");
repeat(100)
begin
	start_item(req);
	assert(req.randomize() with {OPCODE[0] == 4'b1000 || OPCODE[0] == 4'b1001;});
	`uvm_info("WR_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH)
	finish_item(req);
end
endtask



class proc2_seq2 extends proc_base_seq;
`uvm_object_utils(proc2_seq2)

extern function new(string name = "proc2_seq2");
extern task body();
endclass

function proc2_seq2::new(string name = "proc2_seq2");
super.new(name);
endfunction

task proc2_seq2::body();
req=write_xtn::type_id::create("req");
repeat(100)
begin
	start_item(req);
	assert(req.randomize() with {OPCODE[1] == 4'b1000 || OPCODE[1] == 4'b1001;});
	`uvm_info("WR_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH)
	finish_item(req);
end
endtask

class proc3_seq2 extends proc_base_seq;
`uvm_object_utils(proc3_seq2)

extern function new(string name = "proc3_seq2");
extern task body();
endclass

function proc3_seq2::new(string name = "proc3_seq2");
super.new(name);
endfunction

task proc3_seq2::body();
req=write_xtn::type_id::create("req");
repeat(100)
begin
	start_item(req);
	assert(req.randomize() with {OPCODE[2] == 4'b1000 || OPCODE[2] == 4'b1001;});
	`uvm_info("WR_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH)
	finish_item(req);
end
endtask

class proc4_seq2 extends proc_base_seq;
`uvm_object_utils(proc4_seq2)

extern function new(string name = "proc4_seq2");
extern task body();
endclass

function proc4_seq2::new(string name = "proc4_seq2");
super.new(name);
endfunction

task proc4_seq2::body();
req=write_xtn::type_id::create("req");
repeat(100)
begin
	start_item(req);
	assert(req.randomize() with {OPCODE[3] == 4'b1000 || OPCODE[3] == 4'b1001;});
	`uvm_info("WR_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH)
	finish_item(req);
end
endtask
///////////////////////////////////////////////////////////////////////

class proc1_seq3 extends proc_base_seq;
`uvm_object_utils(proc1_seq3)

extern function new(string name = "proc1_seq3");
extern task body();
endclass

function proc1_seq3::new(string name = "proc1_seq3");
super.new(name);
endfunction

task proc1_seq3::body();
req=write_xtn::type_id::create("req");
repeat(50)
begin
	start_item(req);
	assert(req.randomize() with {OPCODE[0] == 4'b1010 || OPCODE[0] == 4'b1011;});
	`uvm_info("WR_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH)
	finish_item(req);
end
endtask



class proc2_seq3 extends proc_base_seq;
`uvm_object_utils(proc2_seq3)

extern function new(string name = "proc2_seq3");
extern task body();
endclass

function proc2_seq3::new(string name = "proc2_seq3");
super.new(name);
endfunction

task proc2_seq3::body();
req=write_xtn::type_id::create("req");
repeat(50)
begin
	start_item(req);
	assert(req.randomize() with {OPCODE[1] == 4'b1010 || OPCODE[1] == 4'b1011;});
	`uvm_info("WR_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH)
	finish_item(req);
end
endtask

class proc3_seq3 extends proc_base_seq;
`uvm_object_utils(proc3_seq3)

extern function new(string name = "proc3_seq3");
extern task body();
endclass

function proc3_seq3::new(string name = "proc3_seq3");
super.new(name);
endfunction

task proc3_seq3::body();
req=write_xtn::type_id::create("req");
repeat(50)
begin
	start_item(req);
	assert(req.randomize() with {OPCODE[2] == 4'b1010 || OPCODE[2] == 4'b1011;});
	`uvm_info("WR_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH)
	finish_item(req);
end
endtask


class proc4_seq3 extends proc_base_seq;
`uvm_object_utils(proc4_seq3)

extern function new(string name = "proc4_seq3");
extern task body();
endclass

function proc4_seq3::new(string name = "proc4_seq3");
super.new(name);
endfunction

task proc4_seq3::body();
req=write_xtn::type_id::create("req");
repeat(50)
begin
	start_item(req);
	assert(req.randomize() with {OPCODE[3] == 4'b1010 || OPCODE[3] == 4'b1011;});
	`uvm_info("WR_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH)
	finish_item(req);
end
endtask
////////////////////////////////////////////////////////seq5
class proc1_seq4 extends proc_base_seq;
`uvm_object_utils(proc1_seq4)

extern function new(string name = "proc1_seq4");
extern task body();
endclass

function proc1_seq4::new(string name = "proc1_seq4");
super.new(name);
endfunction

task proc1_seq4::body();
req=write_xtn::type_id::create("req");
repeat(1)
begin
	start_item(req);
	assert(req.randomize() with {OPCODE[0] == 4'b1001; ADDRESS[0] == 8'h0; data_in[0] == 8'hab;});
	`uvm_info("WR_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH)
	finish_item(req);
end
endtask



class proc2_seq4 extends proc_base_seq;
`uvm_object_utils(proc2_seq4)

extern function new(string name = "proc2_seq4");
extern task body();
endclass

function proc2_seq4::new(string name = "proc2_seq4");
super.new(name);
endfunction

task proc2_seq4::body();
req=write_xtn::type_id::create("req");
repeat(1)
begin
	start_item(req);
	assert(req.randomize() with {OPCODE[1] == 4'b1000; ADDRESS[1] == 8'h0;});
	`uvm_info("WR_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH)
	finish_item(req);
end
endtask

class proc3_seq4 extends proc_base_seq;
`uvm_object_utils(proc3_seq4)

extern function new(string name = "proc3_seq4");
extern task body();
endclass

function proc3_seq4::new(string name = "proc3_seq4");
super.new(name);
endfunction

task proc3_seq4::body();
req=write_xtn::type_id::create("req");
repeat(50)
begin
	start_item(req);
	assert(req.randomize() with {OPCODE[2] == 4'b1010 || OPCODE[2] == 4'b1011;});
	`uvm_info("WR_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH)
	finish_item(req);
end
endtask


class proc4_seq4 extends proc_base_seq;
`uvm_object_utils(proc4_seq4)

extern function new(string name = "proc4_seq4");
extern task body();
endclass

function proc4_seq4::new(string name = "proc4_seq4");
super.new(name);
endfunction

task proc4_seq4::body();
req=write_xtn::type_id::create("req");
repeat(50)
begin
	start_item(req);
	assert(req.randomize() with {OPCODE[3] == 4'b1010 || OPCODE[3] == 4'b1011;});
	`uvm_info("WR_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH)
	finish_item(req);
end
endtask

//////////////////////////////////////////////////
class proc1_seq5 extends proc_base_seq;
`uvm_object_utils(proc1_seq5)

extern function new(string name = "proc1_seq5");
extern task body();
endclass

function proc1_seq5::new(string name = "proc1_seq5");
super.new(name);
endfunction

task proc1_seq5::body();
req=write_xtn::type_id::create("req");
repeat(50)
begin
	start_item(req);
	assert(req.randomize() with {OPCODE[0] == 4'b1010 || OPCODE[0] == 4'b1011;});
	`uvm_info("WR_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH)
	finish_item(req);
end
endtask



class proc2_seq5 extends proc_base_seq;
`uvm_object_utils(proc2_seq5)

extern function new(string name = "proc2_seq5");
extern task body();
endclass

function proc2_seq5::new(string name = "proc2_seq5");
super.new(name);
endfunction

task proc2_seq5::body();
req=write_xtn::type_id::create("req");
repeat(50)
begin
	start_item(req);
	assert(req.randomize() with {OPCODE[1] == 4'b1010 || OPCODE[1] == 4'b1011;});
	`uvm_info("WR_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH)
	finish_item(req);
end
endtask

class proc3_seq5 extends proc_base_seq;
`uvm_object_utils(proc3_seq5)

extern function new(string name = "proc3_seq5");
extern task body();
endclass

function proc3_seq5::new(string name = "proc3_seq5");
super.new(name);
endfunction

task proc3_seq5::body();
req=write_xtn::type_id::create("req");
repeat(50)
begin
	start_item(req);
	assert(req.randomize() with {OPCODE[2] == 4'b1010 || OPCODE[2] == 4'b1011;});
	`uvm_info("WR_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH)
	finish_item(req);
end
endtask


class proc4_seq5 extends proc_base_seq;
`uvm_object_utils(proc4_seq5)

extern function new(string name = "proc4_seq5");
extern task body();
endclass

function proc4_seq5::new(string name = "proc4_seq5");
super.new(name);
endfunction

task proc4_seq5::body();
req=write_xtn::type_id::create("req");
repeat(50)
begin
	start_item(req);
	assert(req.randomize() with {OPCODE[3] == 4'b1010 || OPCODE[3] == 4'b1011;});
	`uvm_info("WR_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH)
	finish_item(req);
end
endtask


