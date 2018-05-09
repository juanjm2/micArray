	component Audio_config is
		port (
			audio_and_video_config_0_clk_clk                 : in    std_logic := 'X'; -- clk
			audio_and_video_config_0_reset_reset             : in    std_logic := 'X'; -- reset
			audio_and_video_config_0_external_interface_SDAT : inout std_logic := 'X'; -- SDAT
			audio_and_video_config_0_external_interface_SCLK : out   std_logic         -- SCLK
		);
	end component Audio_config;

	u0 : component Audio_config
		port map (
			audio_and_video_config_0_clk_clk                 => CONNECTED_TO_audio_and_video_config_0_clk_clk,                 --                audio_and_video_config_0_clk.clk
			audio_and_video_config_0_reset_reset             => CONNECTED_TO_audio_and_video_config_0_reset_reset,             --              audio_and_video_config_0_reset.reset
			audio_and_video_config_0_external_interface_SDAT => CONNECTED_TO_audio_and_video_config_0_external_interface_SDAT, -- audio_and_video_config_0_external_interface.SDAT
			audio_and_video_config_0_external_interface_SCLK => CONNECTED_TO_audio_and_video_config_0_external_interface_SCLK  --                                            .SCLK
		);

