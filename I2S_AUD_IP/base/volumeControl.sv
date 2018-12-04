module volumeControl(
	input logic CLK,
	input logic key_up,
	input logic key_down,
	input logic [31:0] line_in_left,
	input logic [31:0] line_in_right,
	output logic [31:0] controlled_data_left,
	output logic [31:0] controlled_data_right
);


logic [31:0] left_channel_shift, right_channel_shift, current_left, current_right;

logic [5:0] counter, counter2;

assign counterOut = counter;

initial begin
	counter = 0;
	counter2 = 0;
end

logic key_up_SH, key_down_SH;
always_ff @ (posedge CLK)
begin
	key_up_SH <= ~key_up;
	key_down_SH <= ~key_down;
end

always_ff @ (posedge key_up_SH)
begin
	counter <= counter + 1;
end

always_ff @ (posedge key_down_SH)
begin
	counter2 <= counter2 + 1;
end

assign left_channel_shift = line_in_left << (counter - counter2);
assign right_channel_shift = line_in_right << (counter - counter2);

assign controlled_data_left = left_channel_shift;
assign controlled_data_right = right_channel_shift;

endmodule
