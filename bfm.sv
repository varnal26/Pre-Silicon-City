


interface ALU593_bfm;

   import ALU593_pkg::*;

   byte         unsigned        A;
   byte         unsigned        B;
   bit          clk;
   bit          reset_n;
   wire [3:0]   op;
   bit          start;
   wire         done;
   wire [15:0]  result;
   operation_t  op_set;
   reg [4:0]address;		   
   reg [15:0]memory[31:0];

assign op = op_set;

   initial begin
      clk = 0;
      forever begin
         #10;
         clk = ~clk;

      end
   end

   task reset_alu();
      reset_n = 1'b0;
      @(negedge clk);
      @(negedge clk);
      reset_n = 1'b1;
      start = 1'b0;
   endtask
   
  task send_op(input byte iA, input byte iB, input operation_t iop, output shortint alu_result);
     
     op_set = iop;
     
     /*if (iop == rst_op) begin
         @(posedge clk);
         reset_n = 1'b0;
         start = 1'b0;
         @(posedge clk);
         #1;
         reset_n = 1'b1;
      end else begin*/
         @(negedge clk);
         A = iA;
         B = iB;
         start = 1'b1;
         if (iop == no_op) begin
            @(posedge clk);
            #1;
            start = 1'b0;           
         end else begin
            do
              @(negedge clk);
            while (done == 0);
            start = 1'b0;
         end
      
      
   endtask 
   
endinterface