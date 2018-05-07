module avalon_microphone (
	// Avalon Clock Input
	input logic CLK,
	
	// Avalon Reset Input
	input logic RESET,
	
	// Avalon-MM Slave Signals
	input  logic AVL_READ,					// Avalon-MM Read
	input  logic AVL_WRITE,					// Avalon-MM Write
	input  logic AVL_CS,						// Avalon-MM Chip Select
	input  logic [3:0]AVL_ADDR,					// Avalon-MM Address
	input  logic [31:0] AVL_WRITEDATA,	// Avalon-MM Write Data
	output logic [31:0] AVL_READDATA,	// Avalon-MM Read Data
	
	//clock
	input logic sck,
	input logic ws,
	//conduit
	input logic GPIO_DIN1,
	input logic GPIO_DIN2,
	input logic GPIO_DIN3,
	input logic GPIO_DIN4,
	/*
	input logic GPIO_DIN5,
	input logic GPIO_DIN6,
	input logic GPIO_DIN7,
	input logic GPIO_DIN8,
	input logic GPIO_DIN9,
	input logic GPIO_DIN10,
	*/
	//export
	output logic [35:0] lrout
);


logic [35:0] lr_read;
logic [17:0] mic1_l, mic1_r, mic2_l, mic2_r,  mic3_l, mic3_r, mic4_l, mic4_r;

//hps to fpga
logic control_read;

always_comb
	begin
	if(control_read)
		begin
		lrout = lr_read;
		end
	else
		begin
		lrout[35:18] = mic1_l;
		lrout[17:0] = mic1_r;
		end
	end
	
always_ff @ (posedge CLK)
begin

    if(RESET) 
	 begin
      lr_read <= 36'b0;
		control_read <= 0;
    end 

	 else if (AVL_CS && AVL_WRITE)
		begin
			if (AVL_ADDR == 4'd0)
				begin
				control_read <= AVL_WRITEDATA[0];
				end
			else if (AVL_ADDR == 4'd1)
				begin
				lr_read[31:0] <= AVL_WRITEDATA;
				end
			else if (AVL_ADDR == 4'd2)
				begin
				lr_read[35:32] <= AVL_WRITEDATA[3:0];
				end		
	
		end
end

assign codec_control = control_read;
assign lrout = lr_read;

//wire [15:0] mic_FL, mic_FR, mic_L1, mic_L2, mic_L3, mic_R1, mic_R2, mic_R3, mic_R4, mic_L4;

i2s_master m1(
	.sck(sck),
	.ws(ws),
	.sd(GPIO_DIN1),
	.data_left(mic1_l),
	.data_right(mic1_r)
);

i2s_master m2(
	.sck(sck),
	.ws(ws),
	.sd(GPIO_DIN2),
	.data_left(mic2_l),
	.data_right(mic2r)
);

i2s_master m3(
	.sck(sck),
	.ws(ws),
	.sd(GPIO_DIN3),
	.data_left(mic3_l),
	.data_right(mic3_r)
);

i2s_master m4(
	.sck(sck),
	.ws(ws),
	.sd(GPIO_DIN4),
	.data_left(mic4_l),
	.data_right(mic4_r)
);


always_comb
	begin
		  if (AVL_CS && AVL_READ)
		  begin
				if (AVL_ADDR == 4'd0)
					begin
					AVL_READDATA = {31'b0,ws};
					end
				else if (AVL_ADDR == 4'd1)
					begin
					AVL_READDATA = {mic1_l[13:0], mic1_r};
					end
				else if (AVL_ADDR == 4'd2)
					begin
					AVL_READDATA = {mic2_l[13:0], mic2_r};
					end
				else if (AVL_ADDR == 4'd3)
					begin
					AVL_READDATA = {mic3_l[13:0], mic3_r};
					end
				else if (AVL_ADDR == 4'd4)
					begin
					AVL_READDATA = {mic4_l[13:0], mic4_r};
					end
				else if(AVL_ADDR == 4'd5)
					begin
					AVL_READDATA = {16'b0, mic1_l[17:14], mic2_l[17:14], mic3_l[17:14], mic4_l[17:14]};
					end
				else 
					AVL_READDATA = 32'b0;
		  end
		  else
				AVL_READDATA = 32'b0;

	end	
endmodule
