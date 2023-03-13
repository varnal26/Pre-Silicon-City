// Code your design here
// TO DO - DUT doesn't need output address_m-remove


 

module DUT(//bus_intf intf_inst,
        input [7:0]A[3:0],
		input [7:0]B[3:0], //operands
		input [3:0]op[3:0], //opcodes for the operations
		input clk, // positive edge triggered clock 
		input reset, //synchronous reset
		input start[3:0],
		input [7:0]address[3:0],
		output done[3:0],
		output [15:0]result[3:0],
		// to mem
		//output [7:0]address_m,
  		input [7:0]data_in[3:0]);
  		//output [7:0]data_out);
		//output valid,
		//output req[3:0],
		//input ack[3:0],
		//input busy,
		//output rw,
		//inout [7:0]data_out);
		
	logic [7:0] mem [0:63]; //memory array	
	bit ack[3:0];
  	wire valid;
  	wire valid_aa0;
  	wire valid_aa1;
  	wire valid_aa2;
  	wire valid_aa3;
	wire req[3:0];
 	wire [7:0]address_m;
  	wire [7:0]address_aa0;
  	wire [7:0]address_aa1;
  	wire [7:0]address_aa2;
  	wire [7:0]address_aa3;
  	wire rw;
  	wire rw0;
  	wire rw1;
  	wire rw2;
 	wire rw3;
  	wire busy;
  	logic [7:0] data_out_check;
  	wire [7:0] data_out0;
  	wire [7:0] data_out1;
  	wire [7:0] data_out2;
  	wire [7:0] data_out3;
  	wire [7:0] data_mem_in;
	

  processor p0(.clk, .reset, .rw(rw0), .busy ,.valid(valid_aa0) , .A(A[0]), .B(B[0]), .op(op[0]), .start(start[0]), .address(address[0]), .done(done[0]), .result(result[0]), .address_m(address_aa0), .internal_data(data_in[0]), .req(req[0]), .ack(ack[0]), .data(data_out0), .valid_mem(valid), .data_mem_in);

  processor p1(.clk, .reset, .rw(rw1), .busy ,.valid(valid_aa1) , .A(A[1]), .B(B[1]), .op(op[1]), .start(start[1]), .address(address[1]), .done(done[1]), .result(result[1]), .address_m(address_aa1), .internal_data(data_in[1]), .req(req[1]), .ack(ack[1]), .data(data_out1), .valid_mem(valid), .data_mem_in);		
		
  processor p2(.clk, .reset, .rw(rw2), .busy ,.valid(valid_aa2) , .A(A[2]), .B(B[2]), .op(op[2]), .start(start[2]), .address(address[2]), .done(done[2]), .result(result[2]), .address_m(address_aa2), .internal_data(data_in[2]), .req(req[2]), .ack(ack[2]), .data(data_out2), .valid_mem(valid), .data_mem_in);

  processor p3(.clk, .reset, .rw(rw3), .busy ,.valid(valid_aa3) , .A(A[3]), .B(B[3]), .op(op[3]), .start(start[3]), .address(address[3]), .done(done[3]), .result(result[3]), .address_m(address_aa3), .internal_data(data_in[3]), .req(req[3]), .ack(ack[3]), .data(data_out3), .valid_mem(valid), .data_mem_in);
  

  memory_controller mem_inst( .clk, .reset, .req_0(req[0]),.req_1(req[1]), .req_2(req[2]), .req_3(req[3]) , .ack_0(ack[0]),.ack_1(ack[1]), .ack_2(ack[2]), .ack_3(ack[3]), .busy, .address(address_m), .data_in(data_out_check), .data_out(data_mem_in), .valid(valid),  .rw);
  
   assign valid = valid_aa0 | valid_aa1 | valid_aa2 | valid_aa3;
   assign address_m = valid_aa0 ? address_aa0 : valid_aa1 ? address_aa1 : valid_aa2 ? address_aa2 :valid_aa3 ? address_aa3 :0;
  assign rw = rw0 | rw1 | rw2 | rw3;
  assign data_out_check = valid_aa0 ? data_out0 : valid_aa1 ? data_out1 : valid_aa2 ? data_out2 :valid_aa3 ? data_out3 :0;
  //assign data_out_mem = data_out_check;

endmodule
