module memory_controller (
  input bit clk,
  input bit reset,
  input logic [7:0] address,
  input  [7:0] data_in,
  output [7:0] data_out,
  input bit rw,
  /*input   valid_0,
  input   valid_1,
  input   valid_2,
  input   valid_3,*/
  input  valid,
  input  req_0,
  input  req_1,
  input  req_2,
  input  req_3,
  output bit ack_0,
  output bit ack_1,
  output bit ack_2,
  output bit ack_3,
  output bit busy
  
  //output logic [7:0] data
);


	//----------------------------------------------------
// A four level, round-robin arbiter. This was
// orginally coded by WD Peterson in VHDL.
//----------------------------------------------------
module arbiter (
  clk,    
  rst,    
  req3,   
  req2,   
  req1,   
  req0,   
  gnt3,   
  gnt2,   
  gnt1,   
  gnt0   
);
// --------------Port Declaration----------------------- 
input           clk;    
input           rst;    
input           req3;   
input           req2;   
input           req1;   
input           req0;   
output          gnt3;   
output          gnt2;   
output          gnt1;   
output          gnt0;   

//--------------Internal Registers----------------------
wire    [1:0]   gnt       ;   
wire            comreq    ; 
wire            beg       ;
wire   [1:0]    lgnt      ;
wire            lcomreq   ;
reg             lgnt0     ;
reg             lgnt1     ;
reg             lgnt2     ;
reg             lgnt3     ;
reg             lasmask   ;
reg             lmask0    ;
reg             lmask1    ;
reg             ledge     ;

//--------------Code Starts Here----------------------- 
always @ (posedge clk)
if (rst) begin
  lgnt0 <= 0;
  lgnt1 <= 0;
  lgnt2 <= 0;
  lgnt3 <= 0;
end else begin                                     
  lgnt0 <=(~lcomreq & ~lmask1 & ~lmask0 & ~req3 & ~req2 & ~req1 & req0)
        | (~lcomreq & ~lmask1 &  lmask0 & ~req3 & ~req2 &  req0)
        | (~lcomreq &  lmask1 & ~lmask0 & ~req3 &  req0)
        | (~lcomreq &  lmask1 &  lmask0 & req0  )
        | ( lcomreq & lgnt0 );
  lgnt1 <=(~lcomreq & ~lmask1 & ~lmask0 &  req1)
        | (~lcomreq & ~lmask1 &  lmask0 & ~req3 & ~req2 &  req1 & ~req0)
        | (~lcomreq &  lmask1 & ~lmask0 & ~req3 &  req1 & ~req0)
        | (~lcomreq &  lmask1 &  lmask0 &  req1 & ~req0)
        | ( lcomreq &  lgnt1);
  lgnt2 <=(~lcomreq & ~lmask1 & ~lmask0 &  req2  & ~req1)
        | (~lcomreq & ~lmask1 &  lmask0 &  req2)
        | (~lcomreq &  lmask1 & ~lmask0 & ~req3 &  req2  & ~req1 & ~req0)
        | (~lcomreq &  lmask1 &  lmask0 &  req2 & ~req1 & ~req0)
        | ( lcomreq &  lgnt2);
  lgnt3 <=(~lcomreq & ~lmask1 & ~lmask0 & req3  & ~req2 & ~req1)
        | (~lcomreq & ~lmask1 &  lmask0 & req3  & ~req2)
        | (~lcomreq &  lmask1 & ~lmask0 & req3)
        | (~lcomreq &  lmask1 &  lmask0 & req3  & ~req2 & ~req1 & ~req0)
        | ( lcomreq & lgnt3);
end 

//----------------------------------------------------
// lasmask state machine.
//----------------------------------------------------
assign beg = (req3 | req2 | req1 | req0) & ~lcomreq;
always @ (posedge clk)
begin                                     
  lasmask <= (beg & ~ledge & ~lasmask);
  ledge   <= (beg & ~ledge &  lasmask) 
          |  (beg &  ledge & ~lasmask);
end 

//----------------------------------------------------
// comreq logic.
//----------------------------------------------------
assign lcomreq = ( req3 & lgnt3 )
                | ( req2 & lgnt2 )
                | ( req1 & lgnt1 )
                | ( req0 & lgnt0 );

//----------------------------------------------------
// Encoder logic.
//----------------------------------------------------
assign  lgnt =  {(lgnt3 | lgnt2),(lgnt3 | lgnt1)};

//----------------------------------------------------
// lmask register.
//----------------------------------------------------
always @ (posedge clk )
if( rst ) begin
  lmask1 <= 0;
  lmask0 <= 0;
end else if(lasmask) begin
  lmask1 <= lgnt[1];
  lmask0 <= lgnt[0];
end else begin
  lmask1 <= lmask1;
  lmask0 <= lmask0;
end 

assign comreq = lcomreq;
assign gnt    = lgnt;
//----------------------------------------------------
// Drive the outputs
//----------------------------------------------------
assign gnt3   = lgnt3;
assign gnt2   = lgnt2;
assign gnt1   = lgnt1;
assign gnt0   = lgnt0;

endmodule



arbiter U (
 .clk,    
 .rst(reset),    
 .req3(req_3),   
 .req2(req_2),   
  .req1(req_1),   
  .req0(req_0),   
 .gnt3(ack_3),   
 .gnt2(ack_2),   
 .gnt1(ack_1),   
 .gnt0(ack_0)   
);




  reg [2:0] round_robin_counter;
  reg [3:0] grant;
  //reg busy;
  logic [7:0] mem [0:255]; //memory array
  
  
  /*always @(negedge clk) begin
    if (reset) begin
      //round_robin_counter <= 0;
      //grant <= 0;
	  //busy <= 0;
	  for (int i=0;i<64;i=i+1)begin
	  	mem[i] <= 8'b0;
	  end
    end else begin
      if(valid) begin
			if (!rw) begin
              mem[address] <= data_in; // write operation
              $display("[%0t] memory lookup : %0d, address : %0d, data : %0d",$time, mem[address], address, data_in);
			end
		end
	end
    $display(" [%0t] memory lookup : %0d, address : %0d, data : %0d", $time,mem[address], address, data_in);
   end*/
  
  always_comb begin
    if(reset) begin
    	for(int i=0;i<64;i=i+1)begin
      		mem[i] <= data_in;
    	end
  	end else begin
      if(valid) begin
		if (!rw) begin
           mem[address] = data_in; // write operation
           $info("[%0t] memory lookup : %0d, address : %0d, data : %0d",$time, mem[address], address, data_in);
		end
      end
    end
  end
  
  //assign mem[address] = (valid && !rw) ? data_in : 0;
    
   
   assign busy = ({ack_3, ack_2, ack_1, ack_0} == 4'b1000 || {ack_3, ack_2, ack_1, ack_0} == 4'b0100 ||{ack_3, ack_2, ack_1, ack_0} == 4'b00010 ||{ack_3, ack_2, ack_1, ack_0} == 4'b0001)? 1: 0;
  assign data_out = rw ? mem[address] : data_in;
  //$info("data out : %0d", data_out);
  //assign data = (!rw) ? data : mem[address]; 
  //assign mem[address] = (!rw) ? data_in : 0 ;
   
endmodule
		
      /*if (valid && !busy) begin
        round_robin_counter <= round_robin_counter + 1;
        if (round_robin_counter == 3) begin
          round_robin_counter <= 0;
        end
      end

      if ({req_3, req_2, req_1, req_0}[round_robin_counter] && !grant[round_robin_counter]) begin
        grant[round_robin_counter] <= 1;
        busy <= 1;
      end

      if (!valid || (valid && grant[round_robin_counter] && {req_3, req_2, req_1, req_0}[round_robin_counter])) begin
        case (round_robin_counter)
          0: ack_0 <= 1;
          1: ack_1 <= 1;
          2: ack_2 <= 1;
          3: ack_3 <= 1;
        endcase
      end else begin
        case (round_robin_counter)
          0: ack_0 <= 0;
          1: ack_1 <= 0;
          2: ack_2 <= 0;
          3: ack_3 <= 0;
        endcase
      end

      if ({ack_3, ack_2, ack_1, ack_0}[round_robin_counter] == 1'b1) begin
        grant[round_robin_counter] <= 0;
        busy <= 0;
      end
	end
  end*/
	
	
	
  //always@ (posedge clk) begin
// operations on memory array for memory read/write	  
	  /*if (rw) begin
        data <= mem[address]; // read operation*/

 // end

