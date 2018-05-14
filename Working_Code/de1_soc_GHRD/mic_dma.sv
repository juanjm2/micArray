module mic_dma(
    	// Avalon Clock Input
	input logic CLK,
	
	// Avalon Reset Input
	input logic RESET,

	// Avalon-MM Master signals
	output logic [31:0] AM_ADDR,
	output logic [2:0]	AM_BURSTCOUNT,
	output logic		AM_WRITE,
	output logic [31:0] AM_WRITEDATA,
	output logic [3:0]	AM_BYTEENABLE,
	input logic			AM_WAITREQUEST,

    // Mic input
    input logic [31:0] mic_data,
	 output logic [1:0] select,

    // Avalon-MM Slave signals
    input logic start,
    input logic read_ready,
    input logic [31:0] start_address,
    input logic [31:0] number_samples,
	 
	 // Signal to slave
	 output logic FINISHED
);

logic done;
int unsigned starting_address, starting_address_2, starting_address_3, starting_address_4, num_samples;
logic finish_signal;
logic [1:0] mic_count, prev_mic_count;

int unsigned prev_starting_address, prev_starting_address_2, prev_starting_address_3, prev_starting_address_4, prev_num_samples;
logic [31:0] prev_AM_ADDR;
logic prev_AM_WRITE, prev_done;
logic prev_finish_signal;
assign FINISHED = finish_signal;

initial begin
	finish_signal = 1'b0;
end

enum logic [3:0]{
    IDLE = 4'd0,
    WAITDATA = 4'd1,
    WAITDATA2 = 4'd2,
    LOADDATA = 4'd3,
    WRITEDATA = 4'd4,
    LOADDATA2 = 4'd5,
    WRITEDATA2 = 4'd6,
	 LOADDATA3 = 4'd7,
	 WRITEDATA3 = 4'd8,
	 LOADDATA4 = 4'd9,
	 WRITEDATA4 = 4'd10,
    FIN       = 4'd11
} state, next_state;

always_ff @(posedge CLK)
begin
    if (RESET)
    begin
        state <= IDLE;
    end
    else
    begin
        state <= next_state;
    end
end


always_ff @(posedge CLK)
begin
	if (RESET)
	begin
		prev_starting_address <= 0;
		prev_starting_address_2 <= 0;
		prev_starting_address_3 <= 0;
		prev_starting_address_4 <= 0;
		prev_num_samples <= 0;
		prev_AM_ADDR <= 0;
		prev_AM_WRITE <= 0;
		prev_done <= 0;
		prev_finish_signal <= 0;
		prev_mic_count <= 0;
	end
	else
	begin
		prev_starting_address <= starting_address;
		prev_starting_address_2 <= starting_address_2;
		prev_starting_address_3 <= starting_address_3;
		prev_starting_address_4 <= starting_address_4;
		prev_num_samples <= num_samples;
		prev_AM_ADDR <= AM_ADDR;
		prev_AM_WRITE <= AM_WRITE;
		prev_done <= done;
		prev_finish_signal <= finish_signal;
		prev_mic_count <= mic_count;
	end
end


always_comb 
begin
    next_state = state;
    unique case (state)
        IDLE:
            if (start)
            begin
                next_state = WAITDATA;
            end
            else
            begin
                next_state = IDLE;
            end
        WAITDATA:
            next_state = WAITDATA2;
        WAITDATA2:
            next_state = LOADDATA;
        LOADDATA:
				if (!AM_WAITREQUEST)
				begin
					if (read_ready)
					begin
						next_state = WRITEDATA;
					end
					else
					begin
						next_state = LOADDATA;
					end
				end
				else
				begin
					next_state = LOADDATA;
				end
			WRITEDATA:
				if (!AM_WAITREQUEST)
				begin
					next_state = LOADDATA2;
				end
				else
            begin
                next_state = WRITEDATA;
            end
			LOADDATA2:
				if (!AM_WAITREQUEST)
				begin
					next_state = WRITEDATA2;
				end
				else
				begin
					next_state = LOADDATA2;
				end
			WRITEDATA2:
				if (!AM_WAITREQUEST)
				begin
					next_state = LOADDATA3;
				end
				else
            begin
                next_state = WRITEDATA2;
            end
			LOADDATA3:
				if (!AM_WAITREQUEST)
				begin
					next_state = WRITEDATA3;
				end
				else
				begin
					next_state = LOADDATA3;
				end
			WRITEDATA3:
				if (!AM_WAITREQUEST)
				begin
					next_state = LOADDATA4;
				end
				else
				begin
					next_state = WRITEDATA3;
				end
			LOADDATA4:
				if (!AM_WAITREQUEST)
				begin
					next_state = WRITEDATA4;
				end
				else
				begin
					next_state = LOADDATA4;
				end
			WRITEDATA4:
				begin
					if (!AM_WAITREQUEST)
					begin
						 if (done)
						 begin
							next_state = FIN;
						 end
						 else
						 begin
							next_state = LOADDATA;
						 end
					end
					else
					begin
						 next_state = WRITEDATA4;
					end
				end
			FIN:
            if (start)
            begin
                next_state = FIN;
            end
            else
            begin
                next_state = IDLE;
            end
        default: next_state = IDLE; 
    endcase
	 
	 AM_WRITE = prev_AM_WRITE;
	 AM_ADDR = prev_AM_ADDR;
	 starting_address = prev_starting_address;
	 starting_address_2 = prev_starting_address_2;
	 starting_address_3 = prev_starting_address_3;
	 starting_address_4 = prev_starting_address_4;
	 num_samples = prev_num_samples;
	 done = prev_done;
	 finish_signal = prev_finish_signal;
	 mic_count = prev_mic_count;
	 AM_BURSTCOUNT = 3'b001;
	 AM_BYTEENABLE = 4'hF;
	 
    case(state)
        IDLE:
				begin
				if (start)
				begin
					 num_samples <= number_samples;
					 starting_address = start_address;
					 starting_address_2 = starting_address + (number_samples * 4);
					 starting_address_3 = starting_address_2 + (number_samples * 4);
					 starting_address_4 = starting_address_3 + (number_samples * 4);
					 mic_count <= 2'b10;
				end
				else
				begin
					 AM_ADDR <= 32'd0;
					 AM_WRITE <= 1'b0;
					 num_samples <= 32'd0;
					 starting_address <= 32'd0;
					 starting_address_2 <= 32'd0;
				end
				done <= 1'b0;
				end	
        WAITDATA: 
		  begin
				finish_signal <= 1'b0;
		  end
        WAITDATA2:
		  begin
				 starting_address = start_address;
				 starting_address_2 = starting_address + (number_samples * 4);
				 starting_address_3 = starting_address_2 + (number_samples * 4);
				 starting_address_4 = starting_address_3 + (number_samples * 4);
		  end
		  LOADDATA:
		  begin
				mic_count <= 3'b001;
				if (read_ready)
				begin
				if (!AM_WAITREQUEST)
					begin
						AM_WRITE <= 1'b1;
						AM_ADDR <= starting_address;
						AM_BYTEENABLE <= 4'hF;
						AM_BURSTCOUNT <= 3'b001;
					end
				end
				else
				begin
					AM_WRITE <= 1'b0;
					AM_ADDR <= 32'b0;
					AM_BYTEENABLE <= 4'hF;
					AM_BURSTCOUNT <= 3'd0;
				end
		  end
		  WRITEDATA:
		  begin
				mic_count <= 3'b001;
				if (!AM_WAITREQUEST)
				begin
					if (num_samples > 0)
					begin
						starting_address <= starting_address + 4;
						AM_BYTEENABLE <= 4'hF;
					end
					else
					begin
					end
				end
				else
				begin
				end
		  end
		  LOADDATA2:
		  begin
				mic_count <= 3'b010;
				if (!AM_WAITREQUEST)
				begin
					AM_WRITE <= 1'b1;
					AM_ADDR <= starting_address_2;
					AM_BYTEENABLE <= 4'hF;
					AM_BURSTCOUNT <= 3'b001;
				end
				else
				begin
					AM_WRITE <= 1'b0;
					AM_ADDR <= 32'b0;
					AM_BYTEENABLE <= 4'hF;
					AM_BURSTCOUNT <= 3'd0;
				end
		  end
		  WRITEDATA2:
		  begin
				mic_count <= 3'b010;
				if (!AM_WAITREQUEST)
				begin
					if (num_samples > 0)
					begin
						starting_address_2 <= starting_address_2 + 4;
						num_samples <= num_samples - 1;
						AM_BYTEENABLE <= 4'hF;
					end
					else if (num_samples == 0)
					begin
						done <= 1'b1;
						AM_WRITE <= 1'b0;
						AM_ADDR <= 32'd0;
						AM_BYTEENABLE <= 4'hF;
						AM_BURSTCOUNT <= 3'd0;
					end
				end
		  end
		  LOADDATA3:
		  begin
				mic_count <= 3'b011;
				if (!AM_WAITREQUEST)
				begin
					AM_WRITE <= 1'b1;
					AM_ADDR <= starting_address_3;
					AM_BYTEENABLE <= 4'hF;
					AM_BURSTCOUNT <= 3'b001;
				end
				else
				begin
					AM_WRITE <= 1'b0;
					AM_ADDR <= 32'b0;
					AM_BYTEENABLE <= 4'hF;
					AM_BURSTCOUNT <= 3'd0;
				end
		  end
		  WRITEDATA3:
		  begin
				mic_count <= 3'b011;
				if (!AM_WAITREQUEST)
				begin
					if (num_samples > 0)
					begin
						starting_address <= starting_address_3 + 4;
						AM_BYTEENABLE <= 4'hF;
					end
					else
					begin
					end
				end
				else
				begin
				end
		  end
		  LOADDATA4:
		  begin
		  		mic_count <= 3'b100;
				if (!AM_WAITREQUEST)
				begin
					AM_WRITE <= 1'b1;
					AM_ADDR <= starting_address_4;
					AM_BYTEENABLE <= 4'hF;
					AM_BURSTCOUNT <= 3'b001;
				end
				else
				begin
					AM_WRITE <= 1'b0;
					AM_ADDR <= 32'b0;
					AM_BYTEENABLE <= 4'hF;
					AM_BURSTCOUNT <= 3'd0;
				end
		  end
		  WRITEDATA4:
		  begin
		  		mic_count <= 3'b100;
				if (!AM_WAITREQUEST)
				begin
					if (num_samples > 0)
					begin
						starting_address_4 <= starting_address_4 + 4;
						num_samples <= num_samples - 1;
						AM_BYTEENABLE <= 4'hF;
					end
					else if (num_samples == 0)
					begin
						done <= 1'b1;
						AM_WRITE <= 1'b0;
						AM_ADDR <= 32'd0;
						AM_BYTEENABLE <= 4'hF;
						AM_BURSTCOUNT <= 3'd0;
					end
				end
		  end
        FIN:
		  begin
		  		num_samples <= number_samples;
				starting_address <= start_address;
				done <= 1'b0;
				finish_signal <= 1'b1;
            AM_WRITE <= 1'b0;
            AM_ADDR <= start_address;
			end
        default: ;
    endcase
end

assign select = mic_count;
assign AM_WRITEDATA = mic_data;

endmodule
