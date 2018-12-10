module gain_dma(
	input logic CLK,
	input logic RESET,
	input logic READY,
	input logic [31:0] sample,
	input logic [31:0] float_multiplier,
	output logic [31:0] modified_sample,
	input logic [31:0] s2_result,
	output logic [31:0] s2_dataa,
	output logic [31:0] s2_datab,
	output logic [2:0] s2_n,
	output logic s2_start,
	input logic s2_done
);

logic [31:0] prev_modified_sample, prev_dataa, prev_datab;

enum logic [2:0]{
	IDLE 			 = 3'd0,
	FLOATIS_WAIT = 3'd1,
	INTER_1 		 = 3'd2,
	FMULS_WAIT	 = 3'd3,
	INTER_2	 	 = 3'd4,
	FIXSI_WAIT	 = 3'd5,
	FIN	 		 = 3'd6
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
		prev_modified_sample <= 32'd0;
		prev_dataa <= 32'd0;
		prev_datab <= 32'd0;
	end
	else
	begin
		prev_modified_sample <= modified_sample;
		prev_dataa <= s2_dataa;
		prev_datab <= s2_datab;
	end
end

always_comb
begin
	next_state = state;
	unique case (state)
		IDLE:
			if (READY)
			begin
				next_state = FLOATIS_WAIT;
			end
			else
			begin
				next_state = IDLE;
			end
		FLOATIS_WAIT:
			begin
				if (s2_done)
				begin
					next_state = INTER_1;
				end
				else
				begin
					next_state = FLOATIS_WAIT;
				end
			end
		INTER_1:
			next_state = FMULS_WAIT;
		FMULS_WAIT:
			if (s2_done)
			begin
				next_state = INTER_2;
			end
			else
			begin
				next_state = FMULS_WAIT;
			end
		INTER_2:
			next_state = FIXSI_WAIT;
		FIXSI_WAIT:
			if (s2_done)
			begin
				next_state = FIN;
			end
			else
			begin
				next_state = FIXSI_WAIT;
			end
		FIN:
			next_state = IDLE;
		default	:	next_state = IDLE;
	endcase
	
	modified_sample = prev_modified_sample;
	s2_dataa = prev_dataa;
	s2_datab = prev_datab;

	case(state)
		IDLE:
			begin
				s2_dataa <= sample;
				s2_datab <= float_multiplier;
				s2_n <= 3'b010;
				if (READY)
				begin
					s2_start <= 1'b1;
				end
				else
				begin
					s2_start <= 1'b0;
				end
			end
		FLOATIS_WAIT:
			begin
				s2_start <= 1'b0;
				s2_n <= 3'b010;
				if (s2_done)
				begin
					s2_dataa <= s2_result;
				end
				else
				begin
				end
			end
		INTER_1:
			begin
				s2_datab <= float_multiplier;
				s2_n <= 3'b100;
				s2_start <= 1'b1;
			end
		FMULS_WAIT:
			begin
				s2_start <= 1'b0;
				s2_n <= 3'b100;
				if (s2_done)
				begin
					s2_dataa <= s2_result;
				end
				else
				begin
				end
			end
		INTER_2:
			begin
				s2_start <= 1'b1;
				s2_n <= 3'b001;
			end
		FIXSI_WAIT:
			begin
				s2_start <= 1'b0;
				s2_n <= 3'b001;
				if (s2_done)
				begin
					modified_sample <= s2_result;
				end
				else
				begin
				end
			end
		FIN:
			begin
				s2_dataa <= sample;
				s2_datab <= float_multiplier;
				s2_n <= 3'b010;
				s2_start <= 1'b0;
			end
		default: ;
	endcase
end

endmodule

























