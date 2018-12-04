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
int unsigned starting_address, num_samples;
logic finish_signal;
logic [1:0] mic_count, prev_mic_count;

int unsigned prev_starting_address, prev_num_samples;
logic [31:0] prev_AM_ADDR;
logic prev_AM_WRITE, prev_done;
logic prev_finish_signal;
assign FINISHED = finish_signal;

enum logic [2:0]{
    IDLE = 3'd0,
    WAITDATA = 3'd1,
    WRITEDATA = 3'd2,
    LOADDATA = 3'd3,
    WAITDATA2 = 3'd4,
    WAITDATA3 = 3'd5,
    WAITDATA4 = 3'd6,
    FIN       = 3'd7
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
            next_state = WAITDATA3;
        WAITDATA3:
            if (!AM_WAITREQUEST)
            begin
                next_state = WAITDATA4;
            end
            else
            begin
                next_state = WAITDATA3;
            end
        WAITDATA4:
            next_state = LOADDATA;
        LOADDATA:
				if (!AM_WAITREQUEST)
				begin
					if (read_ready || mic_count == 2'b01)
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
					 if (done)
					 begin
						next_state = FIN;
					 end
					 else
					 begin
						next_state = WAITDATA4;
					 end
				end
				else
            begin
                next_state = WRITEDATA;
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
					 starting_address <= start_address;
					 mic_count <= 2'b10;
				end
				else
				begin
					 AM_ADDR <= 32'd0;
					 AM_WRITE <= 1'b0;
					 num_samples <= 32'd0;
					 starting_address <= 32'd0;
				end
				done <= 1'b0;
				end
				
        WAITDATA: 
		  begin
				finish_signal <= 1'b1;
		  end
        WAITDATA2: 
		  begin
				num_samples <= number_samples;
			   starting_address <= start_address;
				mic_count <= 2'b11;
        end
		  WAITDATA3: ;
        WAITDATA4: 
		  begin
				AM_BURSTCOUNT <= 3'b000;
				AM_WRITE <= 1'b0;
				if (mic_count == 2'b01)
				begin
					mic_count <= 2'b10;
				end
				else
				begin
					mic_count <= mic_count - 2'b01;
				end
		  end
        LOADDATA:
				begin
					if (read_ready || mic_count == 2'b01)
					begin
						if (mic_count == 2'b10)
						begin
							AM_WRITE <= 1'b1;
							AM_ADDR <= starting_address;
							AM_BYTEENABLE <= 4'hF;
							AM_BURSTCOUNT <= 3'b001;
						end
						else if (mic_count == 2'b01)
						begin
							AM_WRITE <= 1'b1;
							AM_ADDR <= starting_address + number_samples;
							AM_BYTEENABLE <= 4'hF;
							AM_BURSTCOUNT <= 3'b001;
//							mic_count <= 2'b10;
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
					//AM_BURSTCOUNT <= 3'd0;
					if (!AM_WAITREQUEST)
					begin
						if (num_samples > 0)
						begin
							starting_address <= starting_address + 1;
							num_samples <= num_samples - 1;
							AM_BYTEENABLE <= 4'hF;
							//AM_BURSTCOUNT <= 3'd0;
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
					else
					begin
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
