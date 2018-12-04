	component line_in is
		port (
			clk_clk                                          : in    std_logic                     := 'X';             -- clk
			reset_reset_n                                    : in    std_logic                     := 'X';             -- reset_n
			audio_0_avalon_left_channel_source_ready         : in    std_logic                     := 'X';             -- ready
			audio_0_avalon_left_channel_source_data          : out   std_logic_vector(23 downto 0);                    -- data
			audio_0_avalon_left_channel_source_valid         : out   std_logic;                                        -- valid
			audio_0_avalon_right_channel_source_ready        : in    std_logic                     := 'X';             -- ready
			audio_0_avalon_right_channel_source_data         : out   std_logic_vector(23 downto 0);                    -- data
			audio_0_avalon_right_channel_source_valid        : out   std_logic;                                        -- valid
			audio_0_avalon_left_channel_sink_data            : in    std_logic_vector(23 downto 0) := (others => 'X'); -- data
			audio_0_avalon_left_channel_sink_valid           : in    std_logic                     := 'X';             -- valid
			audio_0_avalon_left_channel_sink_ready           : out   std_logic;                                        -- ready
			audio_0_avalon_right_channel_sink_data           : in    std_logic_vector(23 downto 0) := (others => 'X'); -- data
			audio_0_avalon_right_channel_sink_valid          : in    std_logic                     := 'X';             -- valid
			audio_0_avalon_right_channel_sink_ready          : out   std_logic;                                        -- ready
			audio_0_external_interface_ADCDAT                : in    std_logic                     := 'X';             -- ADCDAT
			audio_0_external_interface_ADCLRCK               : in    std_logic                     := 'X';             -- ADCLRCK
			audio_0_external_interface_BCLK                  : in    std_logic                     := 'X';             -- BCLK
			audio_0_external_interface_DACDAT                : out   std_logic;                                        -- DACDAT
			audio_0_external_interface_DACLRCK               : in    std_logic                     := 'X';             -- DACLRCK
			audio_and_video_config_0_external_interface_SDAT : inout std_logic                     := 'X';             -- SDAT
			audio_and_video_config_0_external_interface_SCLK : out   std_logic                                         -- SCLK
		);
	end component line_in;

	u0 : component line_in
		port map (
			clk_clk                                          => CONNECTED_TO_clk_clk,                                          --                                         clk.clk
			reset_reset_n                                    => CONNECTED_TO_reset_reset_n,                                    --                                       reset.reset_n
			audio_0_avalon_left_channel_source_ready         => CONNECTED_TO_audio_0_avalon_left_channel_source_ready,         --          audio_0_avalon_left_channel_source.ready
			audio_0_avalon_left_channel_source_data          => CONNECTED_TO_audio_0_avalon_left_channel_source_data,          --                                            .data
			audio_0_avalon_left_channel_source_valid         => CONNECTED_TO_audio_0_avalon_left_channel_source_valid,         --                                            .valid
			audio_0_avalon_right_channel_source_ready        => CONNECTED_TO_audio_0_avalon_right_channel_source_ready,        --         audio_0_avalon_right_channel_source.ready
			audio_0_avalon_right_channel_source_data         => CONNECTED_TO_audio_0_avalon_right_channel_source_data,         --                                            .data
			audio_0_avalon_right_channel_source_valid        => CONNECTED_TO_audio_0_avalon_right_channel_source_valid,        --                                            .valid
			audio_0_avalon_left_channel_sink_data            => CONNECTED_TO_audio_0_avalon_left_channel_sink_data,            --            audio_0_avalon_left_channel_sink.data
			audio_0_avalon_left_channel_sink_valid           => CONNECTED_TO_audio_0_avalon_left_channel_sink_valid,           --                                            .valid
			audio_0_avalon_left_channel_sink_ready           => CONNECTED_TO_audio_0_avalon_left_channel_sink_ready,           --                                            .ready
			audio_0_avalon_right_channel_sink_data           => CONNECTED_TO_audio_0_avalon_right_channel_sink_data,           --           audio_0_avalon_right_channel_sink.data
			audio_0_avalon_right_channel_sink_valid          => CONNECTED_TO_audio_0_avalon_right_channel_sink_valid,          --                                            .valid
			audio_0_avalon_right_channel_sink_ready          => CONNECTED_TO_audio_0_avalon_right_channel_sink_ready,          --                                            .ready
			audio_0_external_interface_ADCDAT                => CONNECTED_TO_audio_0_external_interface_ADCDAT,                --                  audio_0_external_interface.ADCDAT
			audio_0_external_interface_ADCLRCK               => CONNECTED_TO_audio_0_external_interface_ADCLRCK,               --                                            .ADCLRCK
			audio_0_external_interface_BCLK                  => CONNECTED_TO_audio_0_external_interface_BCLK,                  --                                            .BCLK
			audio_0_external_interface_DACDAT                => CONNECTED_TO_audio_0_external_interface_DACDAT,                --                                            .DACDAT
			audio_0_external_interface_DACLRCK               => CONNECTED_TO_audio_0_external_interface_DACLRCK,               --                                            .DACLRCK
			audio_and_video_config_0_external_interface_SDAT => CONNECTED_TO_audio_and_video_config_0_external_interface_SDAT, -- audio_and_video_config_0_external_interface.SDAT
			audio_and_video_config_0_external_interface_SCLK => CONNECTED_TO_audio_and_video_config_0_external_interface_SCLK  --                                            .SCLK
		);

