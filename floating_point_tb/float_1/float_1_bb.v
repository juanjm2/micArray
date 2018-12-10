
module float_1 (
	s1_clk,
	s1_clk_en,
	s1_dataa,
	s1_datab,
	s1_n,
	s1_reset,
	s1_start,
	s1_done,
	s1_result);	

	input		s1_clk;
	input		s1_clk_en;
	input	[31:0]	s1_dataa;
	input	[31:0]	s1_datab;
	input	[1:0]	s1_n;
	input		s1_reset;
	input		s1_start;
	output		s1_done;
	output	[31:0]	s1_result;
endmodule
