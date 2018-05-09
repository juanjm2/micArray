module part1 (CLOCK_50, CLOCK2_50, KEY, FPGA_I2C_SCLK, FPGA_I2C_SDAT, AUD_XCK, 
		        AUD_DACLRCK, AUD_ADCLRCK, AUD_BCLK, AUD_DACDAT, GPIO_DIN, GPIO_BCLK, GPIO_LRCLK, AUD_ADCDAT, GPIO_XCK);

	input CLOCK_50, CLOCK2_50;
	input [0:0] KEY;
	// I2C Audio/Video config interface
	output FPGA_I2C_SCLK;
	inout FPGA_I2C_SDAT;
	// Audio CODEC
	output AUD_XCK;
	input AUD_DACLRCK, AUD_ADCLRCK, AUD_BCLK;
	output AUD_DACDAT;
	input GPIO_DIN;
	output GPIO_BCLK;
	output GPIO_LRCLK;
	input AUD_ADCDAT;
	output GPIO_XCK;
	
	// Local wires.
	wire read_ready, write_ready, read, write;
	wire [15:0] readdata_left, readdata_right;
	wire [15:0] writedata_left, writedata_right;

	wire reset = ~KEY[0];
	wire [15:0] mic_L, mic_R;

	/////////////////////////////////
	// Your code goes here 
	/////////////////////////////////
	
//	assign writedata_left = readdata_left;
//	assign writedata_right = readdata_right;
//	assign writedata_left = mic_L;
//	assign writedata_right = mic_R;
//	assign read = read_ready;
//	assign write = write_ready & read_ready;
	
	assign GPIO_BCLK = AUD_BCLK;
	assign GPIO_LRCLK = AUD_ADCLRCK;
	assign GPIO_XCK = AUD_XCK;

	
/////////////////////////////////////////////////////////////////////////////////
// Audio CODEC interface. 
//
// The interface consists of the following wires:
// read_ready, write_ready - CODEC ready for read/write operation 
// readdata_left, readdata_right - left and right channel data from the CODEC
// read - send data from the CODEC (both channels)
// writedata_left, writedata_right - left and right channel data to the CODEC
// write - send data to the CODEC (both channels)
// AUD_* - should connect to top-level entity I/O of the same name.
//         These signals go directly to the Audio CODEC
// I2C_* - should connect to top-level entity I/O of the same name.
//         These signals go directly to the Audio/Video Config module
/////////////////////////////////////////////////////////////////////////////////

	audio_pll clock_gen(
		.audio_pll_0_audio_clk_clk(AUD_XCK),
		.audio_pll_0_ref_clk_clk(CLOCK2_50),
		.audio_pll_0_ref_reset_reset(reset),
		.audio_pll_0_ref_reset_source_reset()
	);
	
	
//module avalon_microphone (
//	// Avalon Clock Input
//	input logic CLK,
//	
//	// Avalon Reset Input
//	input logic RESET,
//	
//	// Avalon-MM Slave Signals
//	input  logic AVL_READ,					// Avalon-MM Read
//	input  logic AVL_WRITE,					// Avalon-MM Write
//	input  logic AVL_CS,						// Avalon-MM Chip Select
//	input  logic AVL_ADDR,					// Avalon-MM Address
//	input  logic [31:0] AVL_WRITEDATA,	// Avalon-MM Write Data
//	output logic [31:0] AVL_READDATA,	// Avalon-MM Read Data
//	
//	// Clock signals
//	input logic AUD_BCLK,
//	input logic AUD_ADCLRCK,
//
//	// Data lines from mics
//	input logic GPIO_DIN1,
//
//	// Output to codec
//	output logic [31:0] codec_stream,
//	output logic interrupt
//);


avalon_microphone inter(
	.CLK(CLOCK_50),
	.RESET(1'b0),
	.AVL_READ(),
	.AVL_WRITE(),
	.AVL_CS(),
	.AVL_ADDR(),
	.AVL_WRITEDATA(),
	.AVL_READDATA(),
	.AUD_BCLK(AUD_BCLK),
	.AUD_ADCLRCK(AUD_ADCLRCK),
	.GPIO_DIN1(GPIO_DIN),
	.codec_stream(inter_data),
	.interrupt()
);
	
wire [31:0] inter_data;
	
	audio_and_video_config cfg(
		// Inputs
		CLOCK_50,
		reset,

		// Bidirectionals
		FPGA_I2C_SDAT,
		FPGA_I2C_SCLK
	);
	

//	i2s_receive rx1(
//		.sck(AUD_BCLK),
//		.ws(AUD_ADCLRCK),
//		.sd(GPIO_DIN),
//		.data_left(mic_L),
//		.data_right(mic_R)
//	);
	
//	module Audio (
//		input  wire  audio_0_external_interface_ADCDAT,  // audio_0_external_interface.ADCDAT
//		input  wire  audio_0_external_interface_ADCLRCK, //                           .ADCLRCK
//		input  wire  audio_0_external_interface_BCLK,    //                           .BCLK
//		output wire  audio_0_external_interface_DACDAT,  //                           .DACDAT
//		input  wire  audio_0_external_interface_DACLRCK, //                           .DACLRCK
//		input  wire  clk_clk,                            //                        clk.clk
//		input  wire  reset_reset_n                       //                      reset.reset_n
//	);
	
	Audio aud_interface(
		.audio_0_external_interface_ADCDAT(AUD_ADCDAT),
		.audio_0_external_interface_ADCLRCK(AUD_ADCLRCK),
		.audio_0_external_interface_BCLK(AUD_BCLK),
		.audio_0_external_interface_DACDAT(AUD_DACDAT),
		.audio_0_external_interface_DACLRCK(AUD_DACLRCK),
		.clk_clk(CLOCK_50),
		.reset_reset_n(~reset),
		.left_data(inter_data[31:16]),
		.right_data(inter_data[15:0])
	);
	
//	audio_codec codec(
//		// Inputs
//		CLOCK_50,
//		reset,
//
//		read,	write,
//		writedata_left, writedata_right,
//
//		AUD_ADCDAT,
//
//		// Bidirectionals
//		AUD_BCLK,
//		AUD_ADCLRCK,
//		AUD_DACLRCK,
//
//		// Outputs
//		read_ready, write_ready,
//		readdata_left, readdata_right,
//		AUD_DACDAT
//	);

endmodule


