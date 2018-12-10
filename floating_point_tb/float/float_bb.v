
module float (
	clk_clk,
	reset_reset_n,
	s1_dataa,
	s1_datab,
	s1_n,
	s1_result,
	s2_clk,
	s2_clk_en,
	s2_dataa,
	s2_datab,
	s2_n,
	s2_reset,
	s2_reset_req,
	s2_start,
	s2_done,
	s2_result);	

	input		clk_clk;
	input		reset_reset_n;
	input	[31:0]	s1_dataa;
	input	[31:0]	s1_datab;
	input	[3:0]	s1_n;
	output	[31:0]	s1_result;
	input		s2_clk;
	input		s2_clk_en;
	input	[31:0]	s2_dataa;
	input	[31:0]	s2_datab;
	input	[2:0]	s2_n;
	input		s2_reset;
	input		s2_reset_req;
	input		s2_start;
	output		s2_done;
	output	[31:0]	s2_result;
endmodule
