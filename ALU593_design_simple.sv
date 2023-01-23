

module ALU593(input [7:0] A,
		   input [7:0] B,
		   input [3:0] op,
		   input clk,
		   input reset_n,
		   input start,
		   output logic done,
		   output logic [15:0] result);
		   
reg [4:0]address;		   
reg [15:0]memory[31:0];



  always @(posedge clk)begin
    if (!reset_n)
      result <= 0;
    else begin
      case(op)
		4'b0000 : result<=0;//NOP
		4'b0001 : result <= A + B;
		4'b0010 : result <= A & B;
		4'b0011 : result <= A ^ B;
		4'b0100 : result <= A*B;
		4'b0101 : result <= A+2*B;
		4'b0110 : result <= A*2;
		4'b0111 : result <= A*3;
		4'b1000 : result <= memory[address];//memory_read(); //Load
		4'b1001 : memory[address]<=result;//memory_write(); //Store
		4'b1010 : $display("entered debug mode");//reserved();
		4'b1011 : $display("entered debug mode");//reserved();
		4'b1100 : $display("entered debug mode");//reserved();
		4'b1101 : $display("entered debug mode");//reserved();
		4'b1110 : $display("entered debug mode");//reserved();
		4'b1111 : result<=0;//NOP
      endcase // case (op)
	end
  end

   always @(posedge clk) begin
     if (!reset_n)
       done <= 0;
     else begin
       done =  ((start == 1'b1) && ((op != 4'b0000)||(op != 4'b1111)));
	   
	/*function void memory_read();
		alu_reg = memory;
	endfunction
		
	
	function void memory_write();
		memory=alu_reg;
	endfunction	
	
	function void reserved();
		$display("entered debug mode");
	endfunction*/
end
end	

endmodule 



