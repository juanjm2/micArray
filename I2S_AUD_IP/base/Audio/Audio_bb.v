
module Audio (
	clk_clk,
	external_ADCDAT,
	external_ADCLRCK,
	external_BCLK,
	external_DACDAT,
	external_DACLRCK,
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
	input		external_ADCDAT;
	input		external_ADCLRCK;
	input		external_BCLK;
	output		external_DACDAT;
	input		external_DACLRCK;
	input	[15:0]	left_input_data;
	input		left_input_valid;
	output		left_input_ready;
	input		left_output_ready;
	output	[15:0]	left_output_data;
	output		left_output_valid;
	input		reset_reset_n;
	input	[15:0]	right_input_data;
	input		right_input_valid;
	output		right_input_ready;
	input		right_output_ready;
	output	[15:0]	right_output_data;
	output		right_output_valid;
endmodule
