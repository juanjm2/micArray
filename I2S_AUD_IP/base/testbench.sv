module testbench();

timeunit 10ns;
timeprecision 1ns;

//module temp_top(
//	// Avalon Clock Input
//	input logic CLK,
//	
//	// Avalon Reset Input
//	input logic RESET,
//
//	// Avalon-MM Master signals
//	output logic [31:0] AM_ADDR,
//	output logic [2:0]	AM_BURSTCOUNT,
//	output logic		AM_WRITE,
//	output logic [31:0] AM_WRITEDATA,
//	output logic [3:0]	AM_BYTEENABLE,
//	input logic			AM_WAITREQUEST,
//
//    // Mic input
//    input logic [31:0] mic_data,
//
//    // Avalon-MM Slave signals
//    input logic start,
//    input logic read_ready,
//    input logic [31:0] start_address,
//    input logic [31:0] number_samples
//);

logic CLK;
logic RESET;
logic [31:0] AM_ADDR;
logic [2:0] AM_BURSTCOUNT;
logic AM_WRITE;
logic [31:0] AM_WRITEDATA;
logic [3:0] AM_BYTEENABLE;
logic AM_WAITREQUEST;
logic [31:0] mic_data;
logic start;
logic read_ready;
logic [31:0] start_address;
logic [31:0] number_samples;
logic FINISHED;

temp_top top(.*);

initial begin : CLOCK_INITIALIZATION
	CLK = 0;
end

initial begin : INIT_VARS
	RESET <= 0;
	mic_data <= 32'hA5A5A5A5;
	start <= 0;
	read_ready <= 0;
	start_address <= 0;
	number_samples <= 0;
end

always begin :	CLOCK_GENERATION
#1	CLK = ~CLK;
end

initial begin : TEST_VECTORS
	#2 start <= 1;
	#10 start <= 0;
	#20 read_ready <= 1;
	#22 read_ready <= 0;
	#28 read_ready <= 1;
	#32 read_ready <= 0;
	#46 read_ready <= 1;
	#50 read_ready <= 0;
	#54 read_ready <= 1;
	#58 read_ready <= 0;
	#62 read_ready <= 1;
	#64 read_ready <= 0;
end

endmodule
