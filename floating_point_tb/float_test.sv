module float_test(
	input logic 			s2_clk,
	input logic				sample_ready,
	input logic  [31:0]	sample_aud,
	output logic [31:0]	output_sample,
	input logic  [31:0]	float_val
);

logic [31:0] s2_result_wire, s2_dataa_wire, s2_datab_wire;
logic [2:0] s2_n_wire;
logic s2_start_wire, s2_done_wire;


gain_dma fsm(
	.CLK(s2_clk),
	.RESET(s2_reset),
	.READY(sample_ready),
	.sample(sample_aud),
	.float_multiplier(float_val),
	.modified_sample(output_sample),
	.s2_result(s2_result_wire),
	.s2_dataa(s2_dataa_wire),
	.s2_datab(s2_datab_wire),
	.s2_n(s2_n_wire),
	.s2_start(s2_start_wire),
	.s2_done(s2_done_wire)
);

//module float (
//		input  wire        clk_clk,       //   clk.clk
//		input  wire        reset_reset_n, // reset.reset_n
//		input  wire [31:0] s1_dataa,      //    s1.dataa
//		input  wire [31:0] s1_datab,      //      .datab
//		input  wire [3:0]  s1_n,          //      .n
//		output wire [31:0] s1_result,     //      .result
//		input  wire        s2_clk,        //    s2.clk
//		input  wire        s2_clk_en,     //      .clk_en
//		input  wire [31:0] s2_dataa,      //      .dataa
//		input  wire [31:0] s2_datab,      //      .datab
//		input  wire [2:0]  s2_n,          //      .n
//		input  wire        s2_reset,      //      .reset
//		input  wire        s2_reset_req,  //      .reset_req
//		input  wire        s2_start,      //      .start
//		output wire        s2_done,       //      .done
//		output wire [31:0] s2_result      //      .result
//	);

float inst(
	.s2_clk(s2_clk),
	.s2_clk_en(1'b1),
	.s2_dataa(s2_dataa_wire),
	.s2_datab(s2_datab_wire),
	.s2_n(s2_n_wire),
	.s2_reset(1'b0),
	.s2_reset_req(1'b0),
	.s2_start(s2_start_wire),
	.s2_done(s2_done_wire),
	.s2_result(s2_result_wire)
);



endmodule
