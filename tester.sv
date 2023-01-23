
module random_tester(ALU593_bfm bfm);

import ALU593_pkg::*;

byte unsigned iA;
byte unsigned iB;
operation_t op_set;
//bit clk;
shortint result;

   function operation_t get_op();
      bit [3:0] op_choice;
      op_choice = $random;
      case (op_choice)
        4'b0000 : return no_op;
        4'b0001 : return add_op;
        4'b0010 : return and_op;
        4'b0011 : return xor_op;
        4'b0100 : return mul_op;
        4'b0101 : return sp_func1;
	  4'b0110 : return sp_func2;
	  4'b0111 : return sp_func3;
	  4'b1000 : return load;
	  4'b1001 : return store;
	  4'b1010 : return rsvd1;
	  4'b1011 : return rsvd2;
	  4'b1100 : return rsvd3;
	  4'b1101 : return rsvd4;
	  4'b1110 : return rsvd5;
        4'b1111 : return no_op1;
      endcase // case (op_choice)
   endfunction : get_op

   function byte get_data();
      bit [1:0] zero_ones;
      zero_ones = $random;
      if (zero_ones == 2'b00)
        return 8'h00;
      else if (zero_ones == 2'b11)
        return 8'hFF;
      else
        return $random;
   endfunction : get_data


initial begin : tester
	bfm.reset_alu();
      repeat (1000) begin
         @(negedge bfm.clk);
         op_set = get_op();
         iA = get_data();
         iB = get_data();
         bfm.send_op(iA,iB,op_set,result);
      end
      $stop;
   end : tester
   
endmodule
