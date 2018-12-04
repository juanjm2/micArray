
module line_in (
	clk_clk,
	reset_reset_n,
	audio_0_avalon_left_channel_source_ready,
	audio_0_avalon_left_channel_source_data,
	audio_0_avalon_left_channel_source_valid,
	audio_0_avalon_right_channel_source_ready,
	audio_0_avalon_right_channel_source_data,
	audio_0_avalon_right_channel_source_valid,
	audio_0_avalon_left_channel_sink_data,
	audio_0_avalon_left_channel_sink_valid,
	audio_0_avalon_left_channel_sink_ready,
	audio_0_avalon_right_channel_sink_data,
	audio_0_avalon_right_channel_sink_valid,
	audio_0_avalon_right_channel_sink_ready,
	audio_0_external_interface_ADCDAT,
	audio_0_external_interface_ADCLRCK,
	audio_0_external_interface_BCLK,
	audio_0_external_interface_DACDAT,
	audio_0_external_interface_DACLRCK,
	audio_and_video_config_0_external_interface_SDAT,
	audio_and_video_config_0_external_interface_SCLK);	

	input		clk_clk;
	input		reset_reset_n;
	input		audio_0_avalon_left_channel_source_ready;
	output	[23:0]	audio_0_avalon_left_channel_source_data;
	output		audio_0_avalon_left_channel_source_valid;
	input		audio_0_avalon_right_channel_source_ready;
	output	[23:0]	audio_0_avalon_right_channel_source_data;
	output		audio_0_avalon_right_channel_source_valid;
	input	[23:0]	audio_0_avalon_left_channel_sink_data;
	input		audio_0_avalon_left_channel_sink_valid;
	output		audio_0_avalon_left_channel_sink_ready;
	input	[23:0]	audio_0_avalon_right_channel_sink_data;
	input		audio_0_avalon_right_channel_sink_valid;
	output		audio_0_avalon_right_channel_sink_ready;
	input		audio_0_external_interface_ADCDAT;
	input		audio_0_external_interface_ADCLRCK;
	input		audio_0_external_interface_BCLK;
	output		audio_0_external_interface_DACDAT;
	input		audio_0_external_interface_DACLRCK;
	inout		audio_and_video_config_0_external_interface_SDAT;
	output		audio_and_video_config_0_external_interface_SCLK;
endmodule
