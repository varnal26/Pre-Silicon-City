interface parallel_processor_if(input bit clock, RESETn);
logic [7:0] DATA; //Memory
//logic [4:0] ADDRESS;
//CPU1
logic [7:0] A[3:0]; 
logic [7:0] B[3:0];
//logic [7:0]A1,A2,A3,A4;
logic [3:0]OPCODE[3:0];
logic START[3:0];
logic [7:0] ADDRESS[3:0];
logic [15:0] RESULT[3:0];
logic DONE[3:0];
logic VALID1;
logic REQ[3:0];
logic RW1;
logic ACK[3:0];
logic [7:0]DATA1;
logic [7:0] ADDRESS_1;   // ?
logic [7:0]data_in[3:0];
logic [7:0]data_out;
logic BUSY1;
//logic RESETn;


//CPU2
//logic [7:0] A2, B2;
//logic [3:0] OPCODE2;
//logic START2;
//logic [7:0] ADDRESS2;
//logic [15:0] RESULT2;
//logic DONE2;
logic VALID2;   // ?
//logic REQ2;
logic RW2;
//logic ACK2;
logic [7:0]DATA2;
logic [4:0] ADDRESS_2;   // ?
logic BUSY2;


//CPU3
//logic [7:0] A3, B3;
//logic [3:0] OPCODE3;
//logic START3;
//logic [7:0] ADDRESS3;
//logic [15:0] RESULT3;
//logic DONE3;
logic VALID3;
//logic REQ3;
logic RW3;
//logic ACK3;
logic [7:0]DATA3;
logic [4:0] ADDRESS_3;   // ?
logic BUSY3;


//CPU4
//logic [7:0] A4, B4;
//logic [3:0] OPCODE4;
//logic START4;
//logic [7:0] ADDRESS4;
//logic [15:0] RESULT4;
//logic DONE4;
logic VALID4;
//logic REQ4;
logic RW4;
//logic ACK4;
logic [7:0]DATA4;
logic [4:0] ADDRESS_4;   // ?
logic BUSY4;

clocking driver1_cb @(negedge clock);
default input #1 output #1; 
output RESETn;
output A, B;
//output A1,A2,A3,A4;
output OPCODE;
output START;
output ADDRESS;
output data_in;
input BUSY1;
input ACK;
input REQ;
input RW1;
input DONE;
input RESULT;
//output A2, B2;
//output OPCODE2;
//output START2;
//output ADDRESS2;
input BUSY2;
//input ACK2;
//input REQ2;
input RW2;
//input DONE2;
//output A3, B4;
//output OPCODE3;
//output START3;
//output ADDRESS3;
input BUSY3;
//input ACK3;
//input REQ3;
input RW3;
//input DONE3;
//output A4, B4;
//output OPCODE4;
//output START4;
//output ADDRESS4;
input BUSY4;
//input ACK4;
//input REQ4;
input RW4;
//input DONE4;
//inout data_out;
endclocking

clocking monitor1_cb @(posedge clock);
default input #1 output #1; 
input RESETn;
input A, B;
//input A1,A2,A3,A4;
input OPCODE;
//input OPCODE2;
//input OPCODE3;
//input OPCODE4;
input START;
input ADDRESS;
input BUSY1;
input ACK;
input REQ;
input RW1;
input DONE;
input RESULT;
//input DATA1;
input data_in;
input data_out;
endclocking

/*clocking driver2_cb @(posedge clock);
default input #1 output #1;
output A2, B2;
output OPCODE2;
output START2;
output ADDRESS2;
input BUSY2;
input ACK2;
input REQ2;
input RW2;
input DONE2;
endclocking

clocking driver3_cb @(posedge clock);
default input #1 output #1;
output A3, B4;
output OPCODE3;
output START3;
output ADDRESS3;
input BUSY3;
input ACK3;
input REQ3;
input RW3;
input DONE3;
endclocking

clocking driver4_cb @(posedge clock);
default input #1 output #1;
output A4, B4;
output OPCODE4;
output START4;
output ADDRESS4;
input BUSY4;
input ACK4;
input REQ4;
input RW4;
input DONE4;
endclocking*/

clocking mem_driver_cb @(posedge clock);
default input #1 output #1;
output DATA;
output ADDRESS;
endclocking

modport DRIVER1_MP(clocking driver1_cb);
/*modport DRIVER2_MP(clocking driver2_cb);
modport DRIVER3_MP(clocking driver3_cb);
modport DRIVER4_MP(clocking driver4_cb);*/

modport MONITOR1_MP(clocking monitor1_cb);
modport MEM_DRIVER_MP(clocking mem_driver_cb);

endinterface

