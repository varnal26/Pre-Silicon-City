module top;
 

typedef enum bit[3:0]{no_op=4'b0000,
add_op=4'b0001,
and_op =4'b0010,
xor_op=4'b0011,
mul_op=4'b0100,
sp_func1=4'b0101,
sp_func2=4'b0110,
sp_func3=4'b0111,
load=4'b1000,
store=4'b1001,
rsvd1=4'b1010,
rsvd2=4'b1011,
rsvd3=4'b1100,
rsvd4=4'b1101,
rsvd5=4'b1110,
no_op1=4'b1111}operation_t;

   byte         unsigned        A;
   byte         unsigned        B;
   bit          clk;
   bit          reset_n;
   wire [3:0]   op;
   bit          start;
   wire         done;
   wire [15:0]  result;
   operation_t  op_set;

   assign op = op_set;

 
  ALU593_bfm bfm();
  random_tester random_tester_i(bfm);
  //coverage coverage_i(bfm);
  scoreboard scoreboard_i(bfm);

  ALU593 DUT (
    .A(bfm.A), 
    .B(bfm.B),  
    .op(bfm.op), 
	.clk(bfm.clk),
    .reset_n(bfm.reset_n), 
    .start(bfm.start), 
    .done(bfm.done), 
    .result(bfm.result));



   initial begin
      clk = 0;
      forever begin
         #10;
         clk = ~clk;
      end
   end

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars();
  end

endmodule