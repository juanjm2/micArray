	Audio u0 (
		.clk_clk            (<connected-to-clk_clk>),            //          clk.clk
		.external_ADCDAT    (<connected-to-external_ADCDAT>),    //     external.ADCDAT
		.external_ADCLRCK   (<connected-to-external_ADCLRCK>),   //             .ADCLRCK
		.external_BCLK      (<connected-to-external_BCLK>),      //             .BCLK
		.external_DACDAT    (<connected-to-external_DACDAT>),    //             .DACDAT
		.external_DACLRCK   (<connected-to-external_DACLRCK>),   //             .DACLRCK
		.left_input_data    (<connected-to-left_input_data>),    //   left_input.data
		.left_input_valid   (<connected-to-left_input_valid>),   //             .valid
		.left_input_ready   (<connected-to-left_input_ready>),   //             .ready
		.left_output_ready  (<connected-to-left_output_ready>),  //  left_output.ready
		.left_output_data   (<connected-to-left_output_data>),   //             .data
		.left_output_valid  (<connected-to-left_output_valid>),  //             .valid
		.reset_reset_n      (<connected-to-reset_reset_n>),      //        reset.reset_n
		.right_input_data   (<connected-to-right_input_data>),   //  right_input.data
		.right_input_valid  (<connected-to-right_input_valid>),  //             .valid
		.right_input_ready  (<connected-to-right_input_ready>),  //             .ready
		.right_output_ready (<connected-to-right_output_ready>), // right_output.ready
		.right_output_data  (<connected-to-right_output_data>),  //             .data
		.right_output_valid (<connected-to-right_output_valid>)  //             .valid
	);

