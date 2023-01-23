package ALU593_pkg;
      typedef enum bit[3:0] {no_op  = 4'b0000,
                          add_op = 4'b0001, 
                          and_op = 4'b0010,
                          xor_op = 4'b0011,
                          mul_op = 4'b0100,
                          sp_func1= 4'b0101,
						  sp_func2= 4'b0110,
						  sp_func3= 4'b0111,
						  load=4'b1000,
						  store=4'b1001,
						  rsvd1=4'b1010,
						  rsvd2=4'b1011,
						  rsvd3=4'b1100,
						  rsvd4=4'b1101,
						  rsvd5=4'b1110,
						  no_op1 = 4'b1111} operation_t;

endpackage 