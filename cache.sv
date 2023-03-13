//TO-DO :cache_full logic missing(can add LRU or replace random line)

module cache
    #(
        parameter int cache_size = 16, // size of the cache
        parameter int data_width = 8, // size of data in each cache line
        parameter int addr_width = 8   // size of address coming from processor
    )
    (
        input logic clk,
        input logic reset,
        input logic [addr_width-1:0] address, // input address coming from processor
        //input logic [data_width-1:0] data, //input data coming from local register
        input logic [3:0]op, // opcode to see if the instruction is load or store
        input logic [data_width-1:0] input_data, // output data to processor
		//input ack, // signal to check the access to bus
		input busy, // signal to indicate the bus is occupied with other requests
		//input logic valid, // signal to indicate valid address or data on bus
		//output logic req, // request signal for bus access
		input logic rw, //  signal to indicate read or write operations to memory
		output logic miss,
		output logic [data_width-1:0] data
    );
	
	reg hit; // variable to indicate if the cache line is hit
        //logic miss, // variable to indicate if the cache line is miss
        //reg cache_full; // to indicate the status of cache is full
        //reg cache_empty; // to indicate the status of cache is empty
	//reg ack; // signal to check the access to bus
	//reg busy; // signal to indicate the bus is occupied with other requests
		
	reg [15:0]local_reg;
		
	localparam cache_line_size = 4;
	localparam cache_line_count = cache_size / cache_line_size;
	localparam tag_width = 4;
		
	reg [1:0]index;
	reg [3:0]tag;
		
	reg [3:0]tag_array[0:cache_line_count-1];
	reg [7:0]data_array[0:cache_line_count-1]; // cache data array
		

	assign index = address[3:2];
	assign tag = address[7:4];	

	
	// Cache read operation
	always @(posedge clk) begin
		if (reset) begin
			hit <= 0;
			data <= 0;
			for(int i=0; i<cache_line_count-1; i=i+1)begin
				data_array[i] = 8'b0;
			end
			//cache_empty <= 1;
		end
		else if(rw ==1) begin
			if (tag_array[index] == tag) begin
				hit <= 1;
				data <= data_array[index];
			end
			else begin
				hit <= 0;
				//data <= input_data; // this is not read operation but write
				tag_array[index] <= tag;
				data_array[index] <= input_data;
			end
		end

	// Cache write operation
		else begin
			if (reset) begin
				hit <= 0;
			end
			else begin
				if (tag_array[index] == tag) begin
					hit <= 1;
					data_array[index] <= input_data;
				end
				else begin
					hit <= 0;
				end
			end
		end
	end	
	assign miss = ~hit;
	
endmodule