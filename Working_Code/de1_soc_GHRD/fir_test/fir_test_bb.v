
module fir_test (
	clk_clk,
	input_data,
	input_valid,
	input_error,
	output_data,
	output_valid,
	output_error,
	reset_reset_n);	

	input		clk_clk;
	input	[15:0]	input_data;
	input		input_valid;
	input	[1:0]	input_error;
	output	[16:0]	output_data;
	output		output_valid;
	output	[1:0]	output_error;
	input		reset_reset_n;
endmodule
