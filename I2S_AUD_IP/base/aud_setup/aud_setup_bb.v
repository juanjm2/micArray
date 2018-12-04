
module aud_setup (
	clk_clk,
	ext_ADCDAT,
	ext_ADCLRCK,
	ext_BCLK,
	ext_DACDAT,
	ext_DACLRCK,
	ext_1_SDAT,
	ext_1_SCLK,
	fir_left_input_data,
	fir_left_input_valid,
	fir_left_input_error,
	fir_left_output_data,
	fir_left_output_valid,
	fir_left_output_error,
	fir_right_input_data,
	fir_right_input_valid,
	fir_right_input_error,
	fir_right_output_data,
	fir_right_output_valid,
	fir_right_output_error,
	left_input_data,
	left_input_valid,
	left_input_ready,
	left_output_ready,
	left_output_data,
	left_output_valid,
	reset_reset_n,
	right_input_data,
	right_input_valid,
	right_input_ready,
	right_output_ready,
	right_output_data,
	right_output_valid);	

	input		clk_clk;
	input		ext_ADCDAT;
	input		ext_ADCLRCK;
	input		ext_BCLK;
	output		ext_DACDAT;
	input		ext_DACLRCK;
	inout		ext_1_SDAT;
	output		ext_1_SCLK;
	input	[15:0]	fir_left_input_data;
	input		fir_left_input_valid;
	input	[1:0]	fir_left_input_error;
	output	[31:0]	fir_left_output_data;
	output		fir_left_output_valid;
	output	[1:0]	fir_left_output_error;
	input	[15:0]	fir_right_input_data;
	input		fir_right_input_valid;
	input	[1:0]	fir_right_input_error;
	output	[31:0]	fir_right_output_data;
	output		fir_right_output_valid;
	output	[1:0]	fir_right_output_error;
	input	[31:0]	left_input_data;
	input		left_input_valid;
	output		left_input_ready;
	input		left_output_ready;
	output	[31:0]	left_output_data;
	output		left_output_valid;
	input		reset_reset_n;
	input	[31:0]	right_input_data;
	input		right_input_valid;
	output		right_input_ready;
	input		right_output_ready;
	output	[31:0]	right_output_data;
	output		right_output_valid;
endmodule
