module processor (input logic [7:0] A,
		input logic [7:0] B, //operands
		input logic [3:0] op, //opcodes for the operations
		input clk, // positive edge triggered clock 
		input reset, //synchronous reset
		input start, // start signal for the operations
		input [7:0]address, //input address to the processor
		output done, // done signal to indicate the result updation
		output logic[15:0] result, // result of the operations performed
		// to mem
		output logic [7:0]address_m, // output address from the processor
		input [7:0]internal_data , // data input and output from each processor
		output logic  valid, // signal to indicate there is a valid address and data on the bus
        input valid_mem,
		output logic req, // request signal for bus access
		input ack, // acknowledgment signal from memory contorller 
		input busy, // busy signal to indicate bus busy
		output bit rw, //read write signal to memory
        input [7:0]data_mem_in, // memory to processor input data
		output logic [7:0]data);  
		
	wire [15:0] result_aax, result_mult; // results of single and multi cycle operations
    wire  start_single, start_mult, start_load_store; // start signals of single and multi cycle operations
	reg [15:0] local_reg; // local register to store previous data
	reg complete; // signal to indicate that the load operation is done from memory side
 	 wire valid_check;
	

	reg cache_miss; // signal to check if there is cache miss for load operation
	reg [7:0] data_cache; // data that goes to cache from memory in load/ store operations
	//logic [15:0] result_temp;
	bit done_load_store;  // done signal for load operation
	reg [7:0]data_load;
  	wire [15:0]result_load_store;
	

   assign start_single = start && (op == 4'b0000 || op == 4'b0001 || op == 4'b0010 || op == 4'b0011 || op == 4'b1010 || op == 4'b1011 || op == 4'b1100 || op == 4'b1101 || op ==4'b1110|| op == 4'b1111);
   assign start_mult   = start & op[2] & ~op[3];
   assign start_load_store   = start & op[3] & ~op[2] & ~op[1];
   
   
   //assign data_cache = (load_complete == 1) ? data_load : 0;
   assign result_load_store = (op == 4'b1000 && complete ==1) ?  data : data_cache;
  
    

   //single cycle instantiation
   single_cycle and_add_xor (.A, .B, .op, .clk, .reset, .start(start_single),
			     .done(done_aax), .result(result_aax));
   
   //multi cycle instantiation
   multi_cycle mult (.A, .B, .op, .clk, .reset, .start(start_mult),
		    .done(done_mult), .result(result_mult));
			
			
   assign done = (op == 4'b0100 || op == 4'b0101 || op == 4'b0110 || op == 4'b0111 ) ? done_mult : (((op == 4'b1000 || op == 4'b1001) ? done_load_store : done_aax)); 

   assign result = (op == 4'b0100 || op == 4'b0101 || op == 4'b0110 || op == 4'b0111) ? result_mult : (((op == 4'b1000 || op == 4'b1001) ? result_load_store :result_aax));
   
	//cache instantiation
	cache cache_inst(.clk, .reset, .address, .op, .input_data(internal_data), .data(data_cache), .rw, .busy, .miss(cache_miss));  
	
	//load_store operation instantiation
  load_store load_store_inst(.A, .B, .clk, .reset, .start(start_load_store), .address, .op, .done(done_load_store), .cache_miss, .address_m, .valid(valid_check), .req, .ack, .busy,.complete, .rw, .input_data(internal_data), .data, .valid_mem);
  
  assign valid = valid_check;

endmodule 


// module for load_store operations wrt to memory side
 module load_store (input [7:0] A,
		input [7:0] B, //operands
		input [3:0] op, //opcodes for the operations
		input clk, // positive edge triggered clock 
		input reset, //synchronous reset
		input start, // start signal for the operations
		input [7:0]address, //input address to the processor
		output done, // done signal to indicate the result updation
		//output logic[15:0] result_temp, // result of the operations performed
		output logic [7:0]address_m, // output address from the processor
		input logic [7:0]input_data , // data input and output from each processor
		output logic valid, // signal to indicate there is a valid address and data on the bus
        input valid_mem,
		output bit req, // request signal for bus access
		input ack, // acknowledgment signal from memory controller 
		input busy, // busy signal to indicate bus busy
		input bit cache_miss,
		//input bit load_store, //read write signal to memory
		output logic [7:0]data,
		output bit complete,// to indicate the completion of load operation from memory side
		output bit rw);
		//output bit [15:0]result);  
		
   typedef enum {IDLE_S, REQ_S, ACK_S, ADDR_LOAD_S, RESULT_STATE_S, VALID_SET}load_store_states;
	load_store_states state_load_store, next_state_load_store;
	
	
   //if (op == 4'b1000 || op == 4'b1001) begin // check for load, store operations
     always @(*) begin
		//valid <=0;
       case (state_load_store) 
			IDLE_S: begin
	if(start)begin
              if (cache_miss && (op == 4'b1000)) begin
					next_state_load_store = REQ_S;
			    end
				else if(op == 4'b1001)begin
					next_state_load_store = REQ_S;
					
				end
	end
			
         		 //valid = 0;
            end

			REQ_S: if (!busy) begin
				req = 1;
				next_state_load_store = ACK_S;
			     end
			ACK_S: if(ack) begin
				next_state_load_store = ADDR_LOAD_S;		
			     end
			ADDR_LOAD_S: begin address_m = address; 
						//rw = 0;
						req=0;
						if(op == 4'b1001)begin
							data = input_data;
						end
						//data = internal_data; this is for store operation
				      rw = (op == 4'b1001) ? 0 : 1;
				      //data = (op == 4'b1001) ? internal_data : 0; //store operations moved to seperate module
					  //valid = 1'b1;
				      next_state_load_store = RESULT_STATE_S;
				     end
          //VALID_SET : valid =1;
			RESULT_STATE_S: begin //result_temp = internal_data;
					//$display("result_temp=%0d",result_temp);
					//Update to cache 
					 //data_cache = internal_data;
					 //done_load = 1;
              		//valid = 1;
              		/*if(op == 4'b1001)begin
						data = input_data;
					end*/
					 complete = 1;
					rw=0;
			//result = (rw==0)? data_in : data_mem_in;
			//else result = data_mem_in;
			next_state_load_store = IDLE_S;
              		 //done = 1;
             //next_state_store = VALID_SET;
				    end
          	//VALID_SET : begin end
			//default: next_state_load = IDLE;				
		endcase
	//$display("result_temp=%0d",result_temp);
	end

	always @(posedge clk) begin
		if (reset) begin
			state_load_store<= IDLE_S;
			next_state_load_store <= IDLE_S;
          		//done <= 0;
		end
		else begin
			state_load_store <= next_state_load_store;
          	//done <= 1;
		end
	end  
   
   //assign valid = (state_store == VALID_SET ) ? 0 : (state_store == ADDR_LOAD_S || state_store == RESULT_STATE_S ) ? 1 : 0;
   
   assign valid = (state_load_store == ADDR_LOAD_S) ? 1 : 0; 
   assign done = (state_load_store == RESULT_STATE_S) ? 1 : 0;
   
endmodule

module single_cycle(input [7:0] A, //operands
		   input [7:0] B,
		   input [3:0] op, //opcodes for the operations
		   input clk, //synchronous clock
		   input reset, //synchronous reset
		   input start, // start signal for the operations
		   output logic done, // done signal to indicate the result updation
		   output logic [15:0] result); // result of the operations performed

parameter address_size = 'd64; // parameters for address and memory
reg [address_size-1:0]address;		   
reg [15:0]memory[63:0];  // need to update for memory controller *TODO

  always @(posedge clk) begin
    if (reset) begin
      result <= 0;
	address <= 5'b0;
      memory[address]<= 16'b0;
      done <= 0;
    end else if(start) begin
      case(op)
	  	4'b0000 : result <= 0;//NOP
		4'b0001 : begin
			 result <= A + B;
			 $display("A:%0d,B:%0d,result:%0d",A,B,result);
			end
		4'b0010 : result <= A & B;//  and operation
		4'b0011 : result <= A ^ B; //XOR
		//4'b1000 : result <= memory[address];//memory read or Load
		//4'b1001 : memory[address]<=result;//memory write or Store
		4'b1010 : begin
			  result <= A << 2 ; //Shift A left by 3 bits   
			  $display("A:%b,B:%b,result:%b",A,B,result);
			  end
		4'b1011 : result <= B >> 3 ; //Shift B right by 3 bits   
		4'b1100 : $display("entered debug mode");//reserved();
		4'b1101 : $display("entered debug mode");//reserved();
		4'b1110 : $display("entered debug mode");//reserved();
		4'b1111 : result <= 0;//NOP
      endcase // case (op)
      done <= 1;
     end
     else begin
	done <= 0;
     end
  end

   /*always @(posedge clk)
     if (reset)
       done <= 0;
     else
       done <=  ((start == 1'b1) && (op != 4'b0000) && (op != 4'b1111)&& (op != 4'b1010) &&(op != 4'b1011)&& (op != 4'b1100) &&(op != 4'b1101)&&(op != 4'b1110)); // done signal updation
*/
endmodule : single_cycle 


/*module multi_cycle(input [7:0] A,  //operands
		   input [7:0] B,
		   input [3:0] op,//opcodes for the operations
		   input clk,//synchronous clock
		   input reset, //synchronous reset
		   input start,// start signal for the operations
		   output logic done, // done signal to indicate the result updation
		   output logic [15:0] result); // result of the operations performed

   logic [7:0] 			   a_int, b_int;
   logic [15:0] 		   mult0, mult1, mult2;
   logic 			       done1, done2, done3;

   always @(posedge clk)
     if (reset) begin //reset logic and initialization of all signals
		done  <= 0;
		/*done3 <= 0;
		done2 <= 0;
		done1 <= 0;
		a_int <= 0;
		b_int <= 0;
		mult0 <= 0;
		mult1 <= 0;
		mult2 <= 0;
		result<= 0;
     end else if(start) begin // if (!reset)
		a_int  <= A;
		b_int  <= B;
		case(op)
	  		4'b0100 : mult1 <= a_int * b_int; // multiplication operation
			4'b0101 : begin
					mult0 <= 2* b_int; //special function1
					mult1 <= mult0 + a_int; 
					end
			4'b0110 : mult1<= a_int*2; //special function2
			4'b0111 : mult1<= a_int*3; //special function3
		endcase
	
		mult2  <= mult1;
		result <= mult2;
		/*done3  <= start & !done;
		done2  <= done3 & !done;
		done1  <= done2 & !done;
		done   <= done1 & !done;
       	done <= 1;
     end // else: !if(!reset)
     else begin
	done <=0;
     end
endmodule : multi_cycle*/

module multi_cycle(input [7:0] A,
		   input [7:0] B,
		   input [3:0] op,
		   input clk,
		   input reset,
		   input start,
		   output logic done,
		   output logic [15:0] result);

   logic [7:0] 			       a_int, b_int;
   logic [15:0] 		       mult0,mult1, mult2;
   logic 			       done1, done2, done3, done4;

   always @(posedge clk)
     if (reset) begin
	done  <= 0;
	done4 <=0;
	done3 <= 0;
	done2 <= 0;
	done1 <= 0;
	a_int <= 0;
	b_int <= 0;
	mult0 <=0;
	mult1 <= 0;
	mult2 <= 0;
	result<= 0;
     end else if(start)begin // if (!reset_n)
	a_int  <= A;
	b_int  <= B;
	case(op)
	  	4'b0100 : mult1 <= a_int * b_int; // multiplication operation
		4'b0101 : begin
				mult0 <= 2* b_int; //special function1
				mult1 <= mult0 + a_int; 
				end
		4'b0110 : mult1<= a_int*2; //special function2
		4'b0111 : mult1<= a_int*3; //special function3
	endcase
	mult2  <= mult1;
	result <= mult2;
	if(op == 4'b0101)begin
	done4 <= start & !done;
	done3 <= done4 & !done;
	done2  <= done3 & !done;
	done1  <= done2 & !done;
	done   <= done1 & !done;
	end	else begin
	done3  <= start & !done;
	done2  <= done3 & !done;
	done1  <= done2 & !done;
	done   <= done1 & !done;
	end
     end // else: !if(!reset_n)
     else begin
	done <=0;
	done4 <=0;
	done3 <=0;
	done2 <=0;
	done1 <=0;
	mult1<=0;
	mult0<=0;
	mult2 <=0;
     end
endmodule 
