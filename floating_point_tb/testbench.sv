module testbench();

timeunit 10ns;
timeprecision 1ns;


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

logic s2_clk;
logic sample_ready;
logic [31:0] sample_aud;
logic [31:0] output_sample;
logic [31:0] float_val;

float_test top(.*);

always begin : CLOCK_GENERATION
#1  s2_clk = ~s2_clk;
end

initial begin : CLOCK_INITIALIZATION
	 s2_clk = 0;
end


initial begin : TEST_VECTORS
	sample_aud = 32'hFFFFF84C;
	float_val = 32'h3fb4ce08;
#5	sample_ready = 1'b1;
#2 sample_ready = 1'b0;
#20 sample_aud <= 32'hFFFFFF21B;
	float_val <= 32'h3ecbd4b4;
#1	sample_ready = 1'b1;
#1 sample_ready = 1'b0;

end

endmodule
