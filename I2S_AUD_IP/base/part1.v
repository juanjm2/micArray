module part1 (CLOCK_50, CLOCK2_50, KEY, FPGA_I2C_SCLK, FPGA_I2C_SDAT, AUD_XCK, 
		        AUD_DACLRCK, AUD_ADCLRCK, AUD_BCLK, AUD_DACDAT, GPIO_DIN, GPIO_BCLK, GPIO_LRCLK, AUD_ADCDAT, GPIO_XCK, SW);

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
	input [9:0] SW;
	
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
	
//	module line_in (
//		input  wire [23:0] audio_0_avalon_left_channel_sink_data,            //            audio_0_avalon_left_channel_sink.data
//		input  wire        audio_0_avalon_left_channel_sink_valid,           //                                            .valid
//		output wire        audio_0_avalon_left_channel_sink_ready,           //                                            .ready
//		input  wire        audio_0_avalon_left_channel_source_ready,         //          audio_0_avalon_left_channel_source.ready
//		output wire [23:0] audio_0_avalon_left_channel_source_data,          //                                            .data
//		output wire        audio_0_avalon_left_channel_source_valid,         //                                            .valid
//		input  wire [23:0] audio_0_avalon_right_channel_sink_data,           //           audio_0_avalon_right_channel_sink.data
//		input  wire        audio_0_avalon_right_channel_sink_valid,          //                                            .valid
//		output wire        audio_0_avalon_right_channel_sink_ready,          //                                            .ready
//		input  wire        audio_0_avalon_right_channel_source_ready,        //         audio_0_avalon_right_channel_source.ready
//		output wire [23:0] audio_0_avalon_right_channel_source_data,         //                                            .data
//		output wire        audio_0_avalon_right_channel_source_valid,        //                                            .valid
//		input  wire        audio_0_external_interface_ADCDAT,                //                  audio_0_external_interface.ADCDAT
//		input  wire        audio_0_external_interface_ADCLRCK,               //                                            .ADCLRCK
//		input  wire        audio_0_external_interface_BCLK,                  //                                            .BCLK
//		output wire        audio_0_external_interface_DACDAT,                //                                            .DACDAT
//		input  wire        audio_0_external_interface_DACLRCK,               //                                            .DACLRCK
//		inout  wire        audio_and_video_config_0_external_interface_SDAT, // audio_and_video_config_0_external_interface.SDAT
//		output wire        audio_and_video_config_0_external_interface_SCLK, //                                            .SCLK
//		input  wire        clk_clk,                                          //                                         clk.clk
//		input  wire        reset_reset_n                                     //                                       reset.reset_n
//	);

//wire [23:0] left_data, right_data;
//wire left_valid, right_valid, left_ready, right_ready;
//
//line_in line_set(
//		.audio_0_avalon_left_channel_sink_data(left_data),            //            audio_0_avalon_left_channel_sink.data
//		.audio_0_avalon_left_channel_sink_valid(left_valid),           //                                            .valid
//		.audio_0_avalon_left_channel_sink_ready(left_ready),           //                                            .ready
//		.audio_0_avalon_left_channel_source_ready(left_ready),         //          audio_0_avalon_left_channel_source.ready
//		.audio_0_avalon_left_channel_source_data(left_data),          //                                            .data
//		.audio_0_avalon_left_channel_source_valid(left_valid),         //                                            .valid
//		.audio_0_avalon_right_channel_sink_data(right_data),           //           audio_0_avalon_right_channel_sink.data
//		.audio_0_avalon_right_channel_sink_valid(right_valid),          //                                            .valid
//		.audio_0_avalon_right_channel_sink_ready(right_ready),          //                                            .ready
//		.audio_0_avalon_right_channel_source_ready(right_ready),        //         audio_0_avalon_right_channel_source.ready
//		.audio_0_avalon_right_channel_source_data(right_data),         //                                            .data
//		.audio_0_avalon_right_channel_source_valid(right_valid),        //                                            .valid
//		.audio_0_external_interface_ADCDAT(AUD_ADCDAT),                //                  audio_0_external_interface.ADCDAT
//		.audio_0_external_interface_ADCLRCK(AUD_ADCLRCK),               //                                            .ADCLRCK
//		.audio_0_external_interface_BCLK(AUD_BCLK),                  //                                            .BCLK
//		.audio_0_external_interface_DACDAT(AUD_DACDAT),                //                                            .DACDAT
//		.audio_0_external_interface_DACLRCK(AUD_DACLRCK),               //                                            .DACLRCK
//		.audio_and_video_config_0_external_interface_SDAT(FPGA_I2C_SDAT), // audio_and_video_config_0_external_interface.SDAT
//		.audio_and_video_config_0_external_interface_SCLK(FPGA_I2C_SCLK), //                                            .SCLK
//		.clk_clk(CLOCK_50),                                          //                                         clk.clk
//		.reset_reset_n(1'b1)                                     //                                       reset.reset_n
//);
//	
	
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


//avalon_microphone inter(
//	.CLK(CLOCK_50),
//	.RESET(1'b0),
//	.AVL_READ(),
//	.AVL_WRITE(),
//	.AVL_CS(),
//	.AVL_ADDR(),
//	.AVL_WRITEDATA(),
//	.AVL_READDATA(),
//	.AUD_BCLK(AUD_BCLK),
//	.AUD_ADCLRCK(AUD_ADCLRCK),
//	.GPIO_DIN1(GPIO_DIN),
//	.codec_stream(inter_data),
//	.interrupt()
//);
//	
//wire [31:0] inter_data;
	
//	audio_and_video_config cfg(
//		// Inputs
//		CLOCK_50,
//		reset,
//
//		// Bidirectionals
//		FPGA_I2C_SDAT,
//		FPGA_I2C_SCLK
//	);

//module aud_setup (
//		input  wire        clk_clk,            //          clk.clk
//		input  wire        ext_ADCDAT,         //          ext.ADCDAT
//		input  wire        ext_ADCLRCK,        //             .ADCLRCK
//		input  wire        ext_BCLK,           //             .BCLK
//		output wire        ext_DACDAT,         //             .DACDAT
//		input  wire        ext_DACLRCK,        //             .DACLRCK
//		inout  wire        ext_1_SDAT,         //        ext_1.SDAT
//		output wire        ext_1_SCLK,         //             .SCLK
//		input  wire [31:0] left_sink_data,     //    left_sink.data
//		input  wire        left_sink_valid,    //             .valid
//		output wire        left_sink_ready,    //             .ready
//		input  wire        left_source_ready,  //  left_source.ready
//		output wire [31:0] left_source_data,   //             .data
//		output wire        left_source_valid,  //             .valid
//		input  wire        reset_reset_n,      //        reset.reset_n
//		input  wire [31:0] right_sink_data,    //   right_sink.data
//		input  wire        right_sink_valid,   //             .valid
//		output wire        right_sink_ready,   //             .ready
//		input  wire        right_source_ready, // right_source.ready
//		output wire [31:0] right_source_data,  //             .data
//		output wire        right_source_valid  //             .valid
//	);

//aud_setup aud_sys (
//		.clk_clk(CLOCK_50),            //          clk.clk
//		.ext_ADCDAT(AUD_ADCDAT),         //          ext.ADCDAT
//		.ext_ADCLRCK(AUD_ADCLRCK),        //             .ADCLRCK
//		.ext_BCLK(AUD_BCLK),           //             .BCLK
//		.ext_DACDAT(AUD_DACDAT),         //             .DACDAT
//		.ext_DACLRCK(AUD_DACLRCK),        //             .DACLRCK
//		.ext_1_SDAT(FPGA_I2C_SDAT),         //        ext_1.SDAT
//		.ext_1_SCLK(FPGA_I2C_SCLK),         //             .SCLK
//		.left_sink_data(left_data),     //    left_sink.data
//		.left_sink_valid(left_valid),    //             .valid
//		.left_sink_ready(left_ready),    //             .ready
//		.left_source_ready(left_ready),  //  left_source.ready
//		.left_source_data(left_data),   //             .data
//		.left_source_valid(left_valid),  //             .valid
//		.reset_reset_n(1'b1),      //        reset.reset_n
//		.right_sink_data(right_data),    //   right_sink.data
//		.right_sink_valid(right_valid),   //             .valid
//		.right_sink_ready(right_ready),   //             .ready
//		.right_source_ready(right_ready), // right_source.ready
//		.right_source_data(right_data),  //             .data
//		.right_source_valid(right_valid)  //             .valid
//	);


	i2s_receive rx1(
		.sck(AUD_BCLK),
		.ws(AUD_ADCLRCK),
		.sd(GPIO_DIN),
		.data_left(mic_L),
		.data_right(mic_R)
	);

	
//module Audio (
//		input  wire  audio_0_external_interface_ADCDAT,  // audio_0_external_interface.ADCDAT
//		input  wire  audio_0_external_interface_ADCLRCK, //                           .ADCLRCK
//		input  wire  audio_0_external_interface_BCLK,    //                           .BCLK
//		output wire  audio_0_external_interface_DACDAT,  //                           .DACDAT
//		input  wire  audio_0_external_interface_DACLRCK, //                           .DACLRCK
//		input  wire  clk_clk,                            //                        clk.clk
//		input  wire  reset_reset_n,                       //                      reset.reset_n
//		input [31:0] left_data,
//		input [31:0] right_data,
//		output [63:0] adc_data
//	);


	
//Audio aud_interface(
//	.audio_0_external_interface_ADCDAT(AUD_ADCDAT),
//	.audio_0_external_interface_ADCLRCK(AUD_ADCLRCK),
//	.audio_0_external_interface_BCLK(AUD_BCLK),
//	.audio_0_external_interface_DACDAT(AUD_DACDAT),
//	.audio_0_external_interface_DACLRCK(AUD_DACLRCK),
//	.clk_clk(CLOCK_50),
//	.reset_reset_n(1'b1),
//	.left_data(adc_mic_data[63:32]),
//	.right_data(adc_mic_data[31:0]),
//	.adc_data(adc_mic_data)
//);
//
//
//wire [63:0] adc_mic_data;
//wire [16:0] fir_left, fir_right;




//module Audio (
//		input  wire        clk_clk,            //          clk.clk
//		input  wire        external_ADCDAT,    //     external.ADCDAT
//		input  wire        external_ADCLRCK,   //             .ADCLRCK
//		input  wire        external_BCLK,      //             .BCLK
//		output wire        external_DACDAT,    //             .DACDAT
//		input  wire        external_DACLRCK,   //             .DACLRCK
//		input  wire [15:0] left_input_data,    //   left_input.data
//		input  wire        left_input_valid,   //             .valid
//		output wire        left_input_ready,   //             .ready
//		input  wire        left_output_ready,  //  left_output.ready
//		output wire [15:0] left_output_data,   //             .data
//		output wire        left_output_valid,  //             .valid
//		input  wire        reset_reset_n,      //        reset.reset_n
//		input  wire [15:0] right_input_data,   //  right_input.data
//		input  wire        right_input_valid,  //             .valid
//		output wire        right_input_ready,  //             .ready
//		input  wire        right_output_ready, // right_output.ready
//		output wire [15:0] right_output_data,  //             .data
//		output wire        right_output_valid  //             .valid
//	);

//Audio aud_sys(
//	.clk_clk(CLOCK_50),
//	.external_ADCDAT(AUD_ADCDAT),
//	.external_ADCLRCK(AUD_ADCLRCK),
//	.external_BCLK(AUD_BCLK),
//	.external_DACDAT(AUD_DACDAT),
//	.external_DACLRCK(AUD_DACLRCK),
//	.left_input_data(mic_L),
//	.left_input_valid(left_valid),
//	.left_input_ready(left_ready),
//	.left_output_ready(left_ready),
//	.left_output_data(left_data),
//	.left_output_valid(left_valid),
//	.reset_reset_n(1'b1),
//	.right_input_data(mic_R),
//	.right_input_valid(right_valid),
//	.right_input_ready(right_ready),
//	.right_output_ready(right_ready),
//	.right_output_data(right_data),
//	.right_output_valid(right_valid)
//);


//module aud_setup (
//		input  wire        clk_clk,                //              clk.clk
//		input  wire        ext_ADCDAT,             //              ext.ADCDAT
//		input  wire        ext_ADCLRCK,            //                 .ADCLRCK
//		input  wire        ext_BCLK,               //                 .BCLK
//		output wire        ext_DACDAT,             //                 .DACDAT
//		input  wire        ext_DACLRCK,            //                 .DACLRCK
//		inout  wire        ext_1_SDAT,             //            ext_1.SDAT
//		output wire        ext_1_SCLK,             //                 .SCLK
//		input  wire [15:0] fir_left_input_data,    //   fir_left_input.data
//		input  wire        fir_left_input_valid,   //                 .valid
//		input  wire [1:0]  fir_left_input_error,   //                 .error
//		output wire [31:0] fir_left_output_data,   //  fir_left_output.data
//		output wire        fir_left_output_valid,  //                 .valid
//		output wire [1:0]  fir_left_output_error,  //                 .error
//		input  wire [15:0] fir_right_input_data,   //  fir_right_input.data
//		input  wire        fir_right_input_valid,  //                 .valid
//		input  wire [1:0]  fir_right_input_error,  //                 .error
//		output wire [31:0] fir_right_output_data,  // fir_right_output.data
//		output wire        fir_right_output_valid, //                 .valid
//		output wire [1:0]  fir_right_output_error, //                 .error
//		input  wire [31:0] left_input_data,        //       left_input.data
//		input  wire        left_input_valid,       //                 .valid
//		output wire        left_input_ready,       //                 .ready
//		input  wire        left_output_ready,      //      left_output.ready
//		output wire [31:0] left_output_data,       //                 .data
//		output wire        left_output_valid,      //                 .valid
//		input  wire        reset_reset_n,          //            reset.reset_n
//		input  wire [31:0] right_input_data,       //      right_input.data
//		input  wire        right_input_valid,      //                 .valid
//		output wire        right_input_ready,      //                 .ready
//		input  wire        right_output_ready,     //     right_output.ready
//		output wire [31:0] right_output_data,      //                 .data
//		output wire        right_output_valid      //                 .valid
//	);

aud_setup fir_setup(
		.clk_clk(CLOCK_50),                //              clk.clk
		.ext_ADCDAT(AUD_ADCDAT),             //              ext.ADCDAT
		.ext_ADCLRCK(AUD_ADCLRCK),            //                 .ADCLRCK
		.ext_BCLK(AUD_BCLK),               //                 .BCLK
		.ext_DACDAT(AUD_DACDAT),             //                 .DACDAT
		.ext_DACLRCK(AUD_DACLRCK),            //                 .DACLRCK
		.ext_1_SDAT(FPGA_I2C_SDAT),             //            ext_1.SDAT
		.ext_1_SCLK(FPGA_I2C_SCLK),             //                 .SCLK
		.fir_left_input_data(left_mux_out),    //   fir_left_input.data
		.fir_left_input_valid(left_valid),   //                 .valid
		.fir_left_input_error(),   //                 .error
		.fir_left_output_data(fir_left_data),   //  fir_left_output.data
		.fir_left_output_valid(fir_left_out_valid),  //                 .valid
		.fir_left_output_error(),  //                 .error
		.fir_right_input_data(right_mux_out),   //  fir_right_input.data
		.fir_right_input_valid(right_valid),  //                 .valid
		.fir_right_input_error(),  //                 .error
		.fir_right_output_data(fir_right_data),  // fir_right_output.data
		.fir_right_output_valid(fir_right_out_valid), //                 .valid
		.fir_right_output_error(), //                 .error
		.left_input_data(fir_left_data),        //       left_input.data
		.left_input_valid(fir_left_out_valid),       //                 .valid
		.left_input_ready(left_ready),       //                 .ready
		.left_output_ready(left_ready),      //      left_output.ready
		.left_output_data(left_data),       //                 .data
		.left_output_valid(left_valid),      //                 .valid
		.reset_reset_n(1'b1),          //            reset.reset_n
		.right_input_data(fir_right_data),       //      right_input.data
		.right_input_valid(fir_right_out_valid),      //                 .valid
		.right_input_ready(right_ready),      	//                 .ready
		.right_output_ready(right_ready),     	//     right_output.ready
		.right_output_data(right_data),      	//                 .data
		.right_output_valid(right_valid)      //                 .valid
	);

wire [15:0] left_mux_out, right_mux_out;
assign left_mux_out = SW[1] ? left_data : mic_L;
assign right_mux_out = SW[0] ? right_data : mic_R;
wire [15:0] left_data, right_data, fir_left_data, fir_right_data;
wire left_valid, right_valid, left_ready, right_ready, fir_left_out_valid, fir_right_out_valid;



//fir_16 fir_setup(
//		.clk_clk(CLOCK_50),                //              clk.clk
//		.ext_ADCDAT(AUD_ADCDAT),             //              ext.ADCDAT
//		.ext_ADCLRCK(AUD_ADCLRCK),            //                 .ADCLRCK
//		.ext_BCLK(AUD_BCLK),               //                 .BCLK
//		.ext_DACDAT(AUD_DACDAT),             //                 .DACDAT
//		.ext_DACLRCK(AUD_DACLRCK),            //                 .DACLRCK
//		.ext_1_SDAT(FPGA_I2C_SDAT),             //            ext_1.SDAT
//		.ext_1_SCLK(FPGA_I2C_SCLK),             //                 .SCLK
//		.fir_left_input_data(left_data),    //   fir_left_input.data
//		.fir_left_input_valid(left_valid),   //                 .valid
//		.fir_left_input_error(),   //                 .error
//		.fir_left_output_data(fir_left_data),   //  fir_left_output.data
//		.fir_left_output_valid(fir_left_out_valid),  //                 .valid
//		.fir_left_output_error(),  //                 .error
//		.fir_right_input_data(right_data),   //  fir_right_input.data
//		.fir_right_input_valid(right_valid),  //                 .valid
//		.fir_right_input_error(),  //                 .error
//		.fir_right_output_data(fir_right_data),  // fir_right_output.data
//		.fir_right_output_valid(fir_right_out_valid), //                 .valid
//		.fir_right_output_error(), //                 .error
//		.left_input_data(fir_left_data),        //       left_input.data
//		.left_input_valid(fir_left_out_valid),       //                 .valid
//		.left_input_ready(left_ready),       //                 .ready
//		.left_output_ready(left_ready),      //      left_output.ready
//		.left_output_data(left_data),       //                 .data
//		.left_output_valid(left_valid),      //                 .valid
//		.reset_reset_n(1'b1),          //            reset.reset_n
//		.right_input_data(fir_right_data),       //      right_input.data
//		.right_input_valid(fir_right_out_valid),      //                 .valid
//		.right_input_ready(right_ready),      	//                 .ready
//		.right_output_ready(right_ready),     	//     right_output.ready
//		.right_output_data(right_data),      	//                 .data
//		.right_output_valid(right_valid)      //                 .valid
//	);
//
//
//wire [15:0] left_data, right_data, fir_left_data, fir_right_data;
//wire left_valid, right_valid, left_ready, right_ready, fir_left_out_valid, fir_right_out_valid;

//module aud_24 (
//		input  wire        clk_clk,                //              clk.clk
//		input  wire        ext_ADCDAT,             //              ext.ADCDAT
//		input  wire        ext_ADCLRCK,            //                 .ADCLRCK
//		input  wire        ext_BCLK,               //                 .BCLK
//		output wire        ext_DACDAT,             //                 .DACDAT
//		input  wire        ext_DACLRCK,            //                 .DACLRCK
//		inout  wire        ext_1_SDAT,             //            ext_1.SDAT
//		output wire        ext_1_SCLK,             //                 .SCLK
//		input  wire [15:0] fir_left_input_data,    //   fir_left_input.data
//		input  wire        fir_left_input_valid,   //                 .valid
//		input  wire [1:0]  fir_left_input_error,   //                 .error
//		output wire [23:0] fir_left_output_data,   //  fir_left_output.data
//		output wire        fir_left_output_valid,  //                 .valid
//		output wire [1:0]  fir_left_output_error,  //                 .error
//		input  wire [15:0] fir_right_input_data,   //  fir_right_input.data
//		input  wire        fir_right_input_valid,  //                 .valid
//		input  wire [1:0]  fir_right_input_error,  //                 .error
//		output wire [23:0] fir_right_output_data,  // fir_right_output.data
//		output wire        fir_right_output_valid, //                 .valid
//		output wire [1:0]  fir_right_output_error, //                 .error
//		input  wire [23:0] left_input_data,        //       left_input.data
//		input  wire        left_input_valid,       //                 .valid
//		output wire        left_input_ready,       //                 .ready
//		input  wire        left_output_ready,      //      left_output.ready
//		output wire [23:0] left_output_data,       //                 .data
//		output wire        left_output_valid,      //                 .valid
//		input  wire        reset_reset_n,          //            reset.reset_n
//		input  wire [23:0] right_input_data,       //      right_input.data
//		input  wire        right_input_valid,      //                 .valid
//		output wire        right_input_ready,      //                 .ready
//		input  wire        right_output_ready,     //     right_output.ready
//		output wire [23:0] right_output_data,      //                 .data
//		output wire        right_output_valid      //                 .valid
//	);

//aud_24 twentyfour (
//	   .clk_clk(CLOCK_50),                //              clk.clk
//		.ext_ADCDAT(AUD_ADCDAT),             //              ext.ADCDAT
//		.ext_ADCLRCK(AUD_ADCLRCK),            //                 .ADCLRCK
//		.ext_BCLK(AUD_BCLK),               //                 .BCLK
//		.ext_DACDAT(AUD_DACDAT),             //                 .DACDAT
//		.ext_DACLRCK(AUD_DACLRCK),            //                 .DACLRCK
//		.ext_1_SDAT(FPGA_I2C_SDAT),             //            ext_1.SDAT
//		.ext_1_SCLK(FPGA_I2C_SCLK),             //                 .SCLK
//		.fir_left_input_data(left_data[23:8]),    //   fir_left_input.data
//		.fir_left_input_valid(left_valid),   //                 .valid
//		.fir_left_input_error(),   //                 .error
//		.fir_left_output_data(fir_left_data),   //  fir_left_output.data
//		.fir_left_output_valid(fir_left_out_valid),  //                 .valid
//		.fir_left_output_error(),  //                 .error
//		.fir_right_input_data(right_data[23:8]),   //  fir_right_input.data
//		.fir_right_input_valid(right_valid),  //                 .valid
//		.fir_right_input_error(),  //                 .error
//		.fir_right_output_data(fir_right_data),  // fir_right_output.data
//		.fir_right_output_valid(fir_right_out_valid), //                 .valid
//		.fir_right_output_error(), //                 .error
//		.left_input_data(fir_left_data),        //       left_input.data
//		.left_input_valid(fir_left_out_valid),       //                 .valid
//		.left_input_ready(left_ready),       //                 .ready
//		.left_output_ready(left_ready),      //      left_output.ready
//		.left_output_data(left_data),       //                 .data
//		.left_output_valid(left_valid),      //                 .valid
//		.reset_reset_n(1'b1),          //            reset.reset_n
//		.right_input_data(fir_right_data),       //      right_input.data
//		.right_input_valid(fir_right_out_valid),      //                 .valid
//		.right_input_ready(right_ready),      //                 .ready
//		.right_output_ready(right_ready),     //     right_output.ready
//		.right_output_data(right_data),      //                 .data
//		.right_output_valid(right_valid)      //                 .valid
//);
//
//wire [23:0] left_data, right_data, fir_left_data, fir_right_data;
//wire left_valid, right_valid, left_ready, right_ready, fir_left_out_valid, fir_right_out_valid;


//wire [15:0] left_data, right_data;
//wire left_valid, right_valid, left_ready, right_ready;



//module fir_test (
//		input  wire        clk_clk,       //    clk.clk
//		input  wire [15:0] input_data,    //  input.data
//		input  wire        input_valid,   //       .valid
//		input  wire [1:0]  input_error,   //       .error
//		output wire [15:0] output_data,   // output.data
//		output wire        output_valid,  //       .valid
//		output wire [1:0]  output_error,  //       .error
//		input  wire        reset_reset_n  //  reset.reset_n
//	);

//fir_test fir_L(
//	.clk_clk(CLOCK_50),
//	.input_data(adc_mic_data[31:16]),
//	.input_valid(1'b1),
//	.input_error(),
//	.output_data(fir_left),
//	.output_valid(1'b1),
//	.output_error(),
//	.reset_reset_n(1'b1)
//);
//
//fir_test fir_R(
//	.clk_clk(CLOCK_50),
//	.input_data(adc_mic_data[15:0]),
//	.input_valid(1'b1),
//	.input_error(),
//	.output_data(fir_right),
//	.output_valid(1'b1),
//	.output_error(),
//	.reset_reset_n(1'b1)
//);

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


