


module scoreboard(ALU593_bfm bfm);

import ALU593_pkg::*;
 
   always @(posedge bfm.done)begin
      shortint predicted_result;
      case (bfm.op_set)
      	add_op: predicted_result = bfm.A + bfm.B;
        and_op: predicted_result = bfm.A & bfm.B;
        xor_op: predicted_result = bfm.A ^ bfm.B;
        mul_op: predicted_result = bfm.A * bfm.B;
		sp_func1:predicted_result = bfm.A +2* bfm.B;
		sp_func2:predicted_result = bfm.A * 2;
		sp_func3:predicted_result = bfm.A * 3;
		//load:predicted_result=bfm.memory;
		//store:bfm.memory=predicted_result;
		
      endcase
      
      if ((bfm.op_set != no_op)||(bfm.op_set != no_op1) ) begin
        if (predicted_result != bfm.result) begin
          $error ("FAILED: A: %0h  B: %0h  op: %s result: %0h", bfm.A, bfm.B, bfm.op_set.name(), bfm.result);
        end 
	else begin
	$info("passed: A: %0h  B: %0h  op: %s result: %0h",bfm.A, bfm.B, bfm.op_set.name(), bfm.result);
      end 
     end
    end 
 
endmodule