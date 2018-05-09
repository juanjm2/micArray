module avalon_microphone (
	// Avalon Clock Input
	input logic CLK,
	
	// Avalon Reset Input
	input logic RESET,
	
	// Avalon-MM Slave Signals
	input  logic AVL_READ,					// Avalon-MM Read
	input  logic AVL_WRITE,					// Avalon-MM Write
	input  logic AVL_CS,						// Avalon-MM Chip Select
	input  logic AVL_ADDR,					// Avalon-MM Address
	input  logic [31:0] AVL_WRITEDATA,	// Avalon-MM Write Data
	output logic [31:0] AVL_READDATA,	// Avalon-MM Read Data
	
	// Clock signals
	input logic AUD_BCLK,
	input logic AUD_ADCLRCK,

	// Data lines from mics
	input logic GPIO_DIN1,

	// Output to codec
	output logic [31:0] codec_stream,
	output logic interrupt
);

logic saw_rise, saw_fall;

assign interrupt = (saw_rise) | (saw_fall);

logic stream_control;

initial begin
	stream_control = 1;
end

altera_up_clock_edge detect(
	.clk(CLK),
	.reset(RESET),
	.test_clk(AUD_ADCLRCK),
	.rising_edge(saw_rise),
	.falling_edge(saw_fall),
);

logic [31:0] linux_data;
logic [15:0] mic_l, mic_r;
//hps to fpga

always_comb
	begin
	if(stream_control)
		begin
		codec_stream = {mic_l, mic_r};
		end
	else
		begin
		codec_stream = linux_data;
		end
	end
	
always_ff @ (posedge CLK)
begin
    if(RESET) 
	begin
		stream_control = 1'b1;
	end 
	else if (AVL_CS && AVL_WRITE)
	begin
		if (AVL_ADDR == 1'b0)
		begin
			stream_control <= AVL_WRITEDATA[0];
		end
		else if (AVL_ADDR == 1'b1)
		begin
			linux_data = AVL_WRITEDATA;
		end
	end
end

i2s_master m1(
	.sck(AUD_BCLK),
	.ws(AUD_ADCLRCK),
	.sd(GPIO_DIN1),
	.data_left(mic_l),
	.data_right(mic_r)
);

always_comb
	begin
		  if (AVL_CS && AVL_READ)
		  begin
				if (AVL_ADDR == 1'b0)
					begin
					AVL_READDATA = {30'd0,saw_rise,saw_fall};
					end
				else if (AVL_ADDR == 1'b1)
					begin
					AVL_READDATA = {mic_l, mic_r};
					end
				else
					begin
					AVL_READDATA = 32'b0;
					end
		  end
		  else
		  begin
				AVL_READDATA = 32'b0;
		  end
	end	
endmodule
