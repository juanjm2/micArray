module part1 (CLOCK_50, CLOCK2_50, KEY, FPGA_I2C_SCLK, FPGA_I2C_SDAT, AUD_XCK, 
		        AUD_DACLRCK, AUD_ADCLRCK, AUD_BCLK, AUD_DACDAT, GPIO_DIN, GPIO_DIN2, GPIO_DIN3, GPIO_DIN4, GPIO_DIN5, GPIO_BCLK, GPIO_LRCLK, AUD_ADCDAT);

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
	input GPIO_DIN2;
	input GPIO_DIN3;
	input GPIO_DIN4;
	input GPIO_DIN5;
	output GPIO_BCLK;
	output GPIO_LRCLK;
	input AUD_ADCDAT;
	
	// Local wires.
	wire read_ready, write_ready, read, write;
	wire [15:0] readdata_left, readdata_right;
	wire [15:0] writedata_left, writedata_right;

	wire reset = ~KEY[0];
	wire [15:0] mic_L1, mic_R1, mic_L2, mic_R2, mic_L3, mic_R3, mic_L4, mic_R4, mic_L5, mic_R5;

	/////////////////////////////////
	// Your code goes here 
	/////////////////////////////////
	
//	assign writedata_left = readdata_left;
//	assign writedata_right = readdata_right;
	assign writedata_left = mic_L1 + mic_L2 + mic_L3 + mic_L4 + mic_L5;
	assign writedata_right = mic_R1 + mic_R2 + mic_R3 + mic_R4 + mic_R5;
	assign read = read_ready;
	assign write = write_ready & read_ready;
	
	assign GPIO_BCLK = AUD_BCLK;
	assign GPIO_LRCLK = AUD_ADCLRCK;

	
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
	clock_generator my_clock_gen(
		// inputs
		CLOCK2_50,
		reset,

		// outputs
		AUD_XCK
	);

	audio_and_video_config cfg(
		// Inputs
		CLOCK_50,
		reset,

		// Bidirectionals
		FPGA_I2C_SDAT,
		FPGA_I2C_SCLK
	);
	

	i2s_receive rx1(
		.sck(AUD_BCLK),
		.ws(AUD_ADCLRCK),
		.sd(GPIO_DIN),
		.data_left(mic_L1),
		.data_right(mic_R1)
	);
	
		i2s_receive rx2(
		.sck(AUD_BCLK),
		.ws(AUD_ADCLRCK),
		.sd(GPIO_DIN2),
		.data_left(mic_L2),
		.data_right(mic_R2)
	);
	
		i2s_receive rx3(
		.sck(AUD_BCLK),
		.ws(AUD_ADCLRCK),
		.sd(GPIO_DIN3),
		.data_left(mic_L3),
		.data_right(mic_R3)
	);
	
		i2s_receive rx4(
		.sck(AUD_BCLK),
		.ws(AUD_ADCLRCK),
		.sd(GPIO_DIN4),
		.data_left(mic_L4),
		.data_right(mic_R4)
	);
	
		i2s_receive rx5(
		.sck(AUD_BCLK),
		.ws(AUD_ADCLRCK),
		.sd(GPIO_DIN5),
		.data_left(mic_L5),
		.data_right(mic_R5)
	);
	
	audio_codec codec(
		// Inputs
		CLOCK_50,
		reset,

		read,	write,
		writedata_left, writedata_right,

		AUD_ADCDAT,

		// Bidirectionals
		AUD_BCLK,
		AUD_ADCLRCK,
		AUD_DACLRCK,

		// Outputs
		read_ready, write_ready,
		readdata_left, readdata_right,
		AUD_DACDAT
	);

endmodule


