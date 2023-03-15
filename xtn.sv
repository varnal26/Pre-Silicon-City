
class write_xtn extends uvm_sequence_item;
	bit RESETN;
//rand bit [7:0] A1, A2, A3, A4;
rand bit [7:0] A[3:0]; 
rand bit [7:0] B[3:0];
//randc bit [3:0] OPCODE1, OPCODE2,OPCODE3, OPCODE4;
randc bit [3:0]OPCODE[3:0];
//rand bit [4:0] ADDRESS1, ADDRESS2;
rand bit [7:0] ADDRESS[3:0];
rand bit [7:0]data_in[3:0];
bit [7:0]data_out;
bit [15:0] RESULT[3:0];
//rand bit [7:0] DATA1, DATA2, DATA3, DATA4;
//rand bit RW1, RW2;
//bit START1;
bit START[3:0];
bit DONE[3:0];
`uvm_object_utils_begin(write_xtn)
	`uvm_field_int(A[0],UVM_ALL_ON)
	`uvm_field_int(B[0],UVM_ALL_ON)
	`uvm_field_int(OPCODE[0],UVM_ALL_ON)
	`uvm_field_int(ADDRESS[0],UVM_ALL_ON)
	`uvm_field_int(START[0],UVM_ALL_ON)
	`uvm_field_int(DONE[0],UVM_ALL_ON)
	`uvm_field_int(RESULT[0],UVM_ALL_ON)
	`uvm_object_utils_end	
function new(string name = "write_xtn");
super.new(name);
endfunction


function void do_print (uvm_printer printer);
    super.do_print(printer);
/*
   
    //                   srting name   		bitstream value     size       radix for printing
    printer.print_field( "A", this.A, 	    8,		 UVM_DEC		);
    
		printer.print_field( "B1",this.B, 	   8,		 UVM_DEC		);
		 
    printer.print_field( "OPCODE1", this.OPCODE1, 	    4,		 UVM_DEC		);
    
		printer.print_field( "ADDRESS1",this.ADDRESS, 	   5,		 UVM_DEC		);
		 
printer.print_field( "DATA1",this.DATA1, 	   8,		 UVM_DEC		);
		 
   

 */  


   endfunction:do_print
endclass

