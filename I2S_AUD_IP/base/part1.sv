module part1 (CLOCK_50, CLOCK2_50, KEY, FPGA_I2C_SCLK, FPGA_I2C_SDAT, AUD_XCK, 
		        AUD_DACLRCK, AUD_ADCLRCK, AUD_BCLK, AUD_DACDAT, GPIO_DIN, GPIO_BCLK, GPIO_LRCLK, AUD_ADCDAT, GPIO_XCK, SW);

	input CLOCK_50, CLOCK2_50;
	input [3:0] KEY;
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


logic saw_rise, saw_fall;
logic start;
logic ready_read_now;

logic [2:0] counter;
//////////////////////////////////////////////////
initial begin
	counter = 0;
end

always_ff @ (posedge CLOCK_50)
begin
	if (saw_rise)
	begin
		counter <= counter + 3'b1;
	end
	else if (saw_fall)
	begin
		counter <= counter + 3'b1;
	end
	
	if (counter == 3)
	begin
		counter <= 3'b1;
		ready_read_now <= 1'b1;
	end
	else
	begin
		ready_read_now <= 1'b0;
	end
end
//////////////////////////////////////////////////

	assign sample_capture_ready = ready_read_now;

	altera_up_clock_edge detect(
		.clk(CLOCK_50),
		.reset(1'b0),
		.test_clk(AUD_ADCLRCK),
		.rising_edge(saw_rise),
		.falling_edge(saw_fall),
	);

	audio_pll clock_gen(
		.audio_pll_0_audio_clk_clk(AUD_XCK),
		.audio_pll_0_ref_clk_clk(CLOCK2_50),
		.audio_pll_0_ref_reset_reset(reset),
		.audio_pll_0_ref_reset_source_reset()
	);

	i2s_receive rx1(
		.sck(AUD_BCLK),
		.ws(AUD_ADCLRCK),
		.sd(GPIO_DIN),
		.data_left(mic_L),
		.data_right(mic_R)
	);

	
	
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
		.left_input_data(vol_left_out),        //       left_input.data
		.left_input_valid(fir_left_out_valid),       //                 .valid
		.left_input_ready(left_ready),       //                 .ready
		.left_output_ready(left_ready),      //      left_output.ready
		.left_output_data(new_left_fuck),       //                 .data
		.left_output_valid(left_valid),      //                 .valid
		.reset_reset_n(1'b1),          //            reset.reset_n
		.right_input_data(vol_right_out),       //      right_input.data
		.right_input_valid(fir_right_out_valid),      //                 .valid
		.right_input_ready(right_ready),      	//                 .ready
		.right_output_ready(right_ready),     	//     right_output.ready
		.right_output_data(right_data),      	//                 .data
		.right_output_valid(right_valid)      //                 .valid
	);

wire [15:0] left_mux_out, right_mux_out;
//assign left_mux_out = SW[1] ? left_data[31:16] : mic_L;
//assign right_mux_out = SW[0] ? right_data[31:16] : mic_R;
assign left_mux_out = mic_L;
assign right_mux_out = mic_R;
wire [31:0] left_data, right_data, fir_left_data, fir_right_data;
wire left_valid, right_valid, left_ready, right_ready, fir_left_out_valid, fir_right_out_valid;
wire [31:0] new_left_fuck;
wire[31:0] vol_left_out, vol_right_out;

volumeControl vol(
	.CLK(CLOCK_50),
	.RESET(1'b0),
	.key(KEY[1]),
	.switch(SW[3]),
	.sample_ready(ready_read_now),
	.line_in_left(new_left_fuck),
	.line_in_right(right_data),
	.operand_out(),
	.volume_out(),
	.left_output(vol_left_out),
	.right_output(vol_right_out)
);

endmodule


