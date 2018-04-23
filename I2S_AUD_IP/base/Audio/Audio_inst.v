	Audio u0 (
		.clk_clk                            (<connected-to-clk_clk>),                            //                        clk.clk
		.reset_reset_n                      (<connected-to-reset_reset_n>),                      //                      reset.reset_n
		.audio_0_external_interface_ADCDAT  (<connected-to-audio_0_external_interface_ADCDAT>),  // audio_0_external_interface.ADCDAT
		.audio_0_external_interface_ADCLRCK (<connected-to-audio_0_external_interface_ADCLRCK>), //                           .ADCLRCK
		.audio_0_external_interface_BCLK    (<connected-to-audio_0_external_interface_BCLK>),    //                           .BCLK
		.audio_0_external_interface_DACDAT  (<connected-to-audio_0_external_interface_DACDAT>),  //                           .DACDAT
		.audio_0_external_interface_DACLRCK (<connected-to-audio_0_external_interface_DACLRCK>)  //                           .DACLRCK
	);

