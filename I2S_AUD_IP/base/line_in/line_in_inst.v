	line_in u0 (
		.clk_clk                                          (<connected-to-clk_clk>),                                          //                                         clk.clk
		.reset_reset_n                                    (<connected-to-reset_reset_n>),                                    //                                       reset.reset_n
		.audio_0_avalon_left_channel_source_ready         (<connected-to-audio_0_avalon_left_channel_source_ready>),         //          audio_0_avalon_left_channel_source.ready
		.audio_0_avalon_left_channel_source_data          (<connected-to-audio_0_avalon_left_channel_source_data>),          //                                            .data
		.audio_0_avalon_left_channel_source_valid         (<connected-to-audio_0_avalon_left_channel_source_valid>),         //                                            .valid
		.audio_0_avalon_right_channel_source_ready        (<connected-to-audio_0_avalon_right_channel_source_ready>),        //         audio_0_avalon_right_channel_source.ready
		.audio_0_avalon_right_channel_source_data         (<connected-to-audio_0_avalon_right_channel_source_data>),         //                                            .data
		.audio_0_avalon_right_channel_source_valid        (<connected-to-audio_0_avalon_right_channel_source_valid>),        //                                            .valid
		.audio_0_avalon_left_channel_sink_data            (<connected-to-audio_0_avalon_left_channel_sink_data>),            //            audio_0_avalon_left_channel_sink.data
		.audio_0_avalon_left_channel_sink_valid           (<connected-to-audio_0_avalon_left_channel_sink_valid>),           //                                            .valid
		.audio_0_avalon_left_channel_sink_ready           (<connected-to-audio_0_avalon_left_channel_sink_ready>),           //                                            .ready
		.audio_0_avalon_right_channel_sink_data           (<connected-to-audio_0_avalon_right_channel_sink_data>),           //           audio_0_avalon_right_channel_sink.data
		.audio_0_avalon_right_channel_sink_valid          (<connected-to-audio_0_avalon_right_channel_sink_valid>),          //                                            .valid
		.audio_0_avalon_right_channel_sink_ready          (<connected-to-audio_0_avalon_right_channel_sink_ready>),          //                                            .ready
		.audio_0_external_interface_ADCDAT                (<connected-to-audio_0_external_interface_ADCDAT>),                //                  audio_0_external_interface.ADCDAT
		.audio_0_external_interface_ADCLRCK               (<connected-to-audio_0_external_interface_ADCLRCK>),               //                                            .ADCLRCK
		.audio_0_external_interface_BCLK                  (<connected-to-audio_0_external_interface_BCLK>),                  //                                            .BCLK
		.audio_0_external_interface_DACDAT                (<connected-to-audio_0_external_interface_DACDAT>),                //                                            .DACDAT
		.audio_0_external_interface_DACLRCK               (<connected-to-audio_0_external_interface_DACLRCK>),               //                                            .DACLRCK
		.audio_and_video_config_0_external_interface_SDAT (<connected-to-audio_and_video_config_0_external_interface_SDAT>), // audio_and_video_config_0_external_interface.SDAT
		.audio_and_video_config_0_external_interface_SCLK (<connected-to-audio_and_video_config_0_external_interface_SCLK>)  //                                            .SCLK
	);

