module count_led(
	input clk,
	output wire [9:0] leds,
	input wire inter
);

logic [9:0] counter;
logic inter_ff;

initial begin
	leds <= 0;
end

initial begin
	counter <= 0;
end

always_ff @ (posedge clk)
begin
	inter_ff <= inter;
end

always_ff @ (posedge clk)
begin
	if (inter_ff)
	begin
		if (counter < 1024)
		begin
			counter <= counter + 1;
		end
		else
		begin
			counter <= 0;
		end
	end
	else
	begin
	end
end

assign leds = counter;

endmodule
