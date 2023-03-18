module top();
bit clock, RESETn;
import pkgs::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
parallel_processor_if intf(clock, RESETn);
//wire [7:0]A[3:0];
DUT DUT0(/*.A[0](intf.A[0]),.A[1](intf.A[1]),.A[2](intf.A[2]),.A[3](intf.A[3]),
	 .B[0](intf.B[0]),.B[1](intf.B[1]),.B[2](intf.B[2]),.B[3](intf.B[3])*/
	.A(intf.A) /*.A1(intf.A1),.A2(intf.A2),.A3(intf.A3),.A4(intf.A4)*/, .B(intf.B),
	/*.op1(intf.OPCODE1),.op2(intf.OPCODE2),.op3(intf.OPCODE3),.op4(intf.OPCODE4)*/
	.op(intf.OPCODE),
	.clk(clock), .reset(RESETn), 
	/*.start[0](intf.START1), .start[1](intf.START2),.start[2](intf.START3),.start[3](intf.START4)*/
	.start(intf.START),
	/*.DONE[0](intf.DONE1),.DONE[1](intf.DONE2),.DONE[2](intf.DONE3),.DONE[3](intf.DONE4)*/
	.done(intf.DONE), 
	/*.result[0](intf.RESULT1), .result[1](intf.RESULT2), .result[2](intf.RESULT3), .result[3](intf.RESULT4)*/
	.result(intf.RESULT),
	/*.address[0](intf.ADDRESS1), .address[1](intf.ADDRESS2), .address[2](intf.ADDRESS3), .address[3](intf.ADDRESS4)*/
	.address(intf.ADDRESS),
	/*.address_m(intf.ADDRESS_1), .busy(intf.BUSY1), 
	/*.ack[0](intf.ACK1), .ack[1](intf.ACK2), .ack[2](intf.ACK3), .ack[3](intf.ACK4)
	.ack(intf.ACK),
	/*.req[0](intf.REQ1), .req[1](intf.REQ2), .req[2](intf.REQ3), .req[3](intf.REQ4)
	.req(intf.REQ), .valid(intf.VALID1),*/ .data_in(intf.data_in)/*, .data_out(intf.data_out), .rw(intf.RW1)*/ ) ;
//assign intf.A=logic'(A);
always 
#10 clock = ~clock;

initial
begin
RESETn=1'b1;
#20 RESETn=1'b0;
end



initial
begin
uvm_config_db#(virtual parallel_processor_if)::set(null, "*", "vif", intf);
$display("%p", intf);
run_test();
end

initial begin
  $dumpfile("dump.vcd");  
 $dumpvars();
end
endmodule
