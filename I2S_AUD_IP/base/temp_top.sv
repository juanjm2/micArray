module temp_top(
	// Avalon Clock Input
	input logic CLK,
	
	// Avalon Reset Input
	input logic RESET,

	// Avalon-MM Master signals
	output logic [31:0] AM_ADDR,
	output logic [2:0]	AM_BURSTCOUNT,
	output logic		AM_WRITE,
	output logic [31:0] AM_WRITEDATA,
	output logic [3:0]	AM_BYTEENABLE,
	input logic			AM_WAITREQUEST,

    // Mic input
    input logic [31:0] mic_data,

    // Avalon-MM Slave signals
    input logic start,
    input logic read_ready,
    input logic [31:0] start_address,
    input logic [31:0] number_samples,
	 output logic FINISHED
);

mic_dma dma_dude(
	.CLK(CLK),
	.RESET(RESET),
	.AM_ADDR(AM_ADDR),
	.AM_BURSTCOUNT(AM_BURSTCOUNT),
	.AM_WRITE(AM_WRITE),
	.AM_WRITEDATA(AM_WRITEDATA),
	.AM_BYTEENABLE(AM_BYTEENABLE),
	.AM_WAITREQUEST(1'b0),
	.mic_data(mic_data),
	.start(start),
	.read_ready(read_ready),
	.start_address(32'hDEADBEEF),
	.number_samples(32'd5),
	.FINISHED(FINISHED)
);


endmodule
