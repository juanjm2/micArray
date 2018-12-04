
module float (
	clk_clk,
	reset_reset_n,
	nios_custom_instr_floating_point_2_0_s1_dataa,
	nios_custom_instr_floating_point_2_0_s1_datab,
	nios_custom_instr_floating_point_2_0_s1_n,
	nios_custom_instr_floating_point_2_0_s1_result,
	nios_custom_instr_floating_point_2_0_s2_clk,
	nios_custom_instr_floating_point_2_0_s2_clk_en,
	nios_custom_instr_floating_point_2_0_s2_dataa,
	nios_custom_instr_floating_point_2_0_s2_datab,
	nios_custom_instr_floating_point_2_0_s2_n,
	nios_custom_instr_floating_point_2_0_s2_reset,
	nios_custom_instr_floating_point_2_0_s2_reset_req,
	nios_custom_instr_floating_point_2_0_s2_start,
	nios_custom_instr_floating_point_2_0_s2_done,
	nios_custom_instr_floating_point_2_0_s2_result);	

	input		clk_clk;
	input		reset_reset_n;
	input	[31:0]	nios_custom_instr_floating_point_2_0_s1_dataa;
	input	[31:0]	nios_custom_instr_floating_point_2_0_s1_datab;
	input	[3:0]	nios_custom_instr_floating_point_2_0_s1_n;
	output	[31:0]	nios_custom_instr_floating_point_2_0_s1_result;
	input		nios_custom_instr_floating_point_2_0_s2_clk;
	input		nios_custom_instr_floating_point_2_0_s2_clk_en;
	input	[31:0]	nios_custom_instr_floating_point_2_0_s2_dataa;
	input	[31:0]	nios_custom_instr_floating_point_2_0_s2_datab;
	input	[2:0]	nios_custom_instr_floating_point_2_0_s2_n;
	input		nios_custom_instr_floating_point_2_0_s2_reset;
	input		nios_custom_instr_floating_point_2_0_s2_reset_req;
	input		nios_custom_instr_floating_point_2_0_s2_start;
	output		nios_custom_instr_floating_point_2_0_s2_done;
	output	[31:0]	nios_custom_instr_floating_point_2_0_s2_result;
endmodule
