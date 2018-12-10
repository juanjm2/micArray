	aud_32 u0 (
		.clk_clk            (<connected-to-clk_clk>),            //          clk.clk
		.ext_ADCDAT         (<connected-to-ext_ADCDAT>),         //          ext.ADCDAT
		.ext_ADCLRCK        (<connected-to-ext_ADCLRCK>),        //             .ADCLRCK
		.ext_BCLK           (<connected-to-ext_BCLK>),           //             .BCLK
		.ext_DACDAT         (<connected-to-ext_DACDAT>),         //             .DACDAT
		.ext_DACLRCK        (<connected-to-ext_DACLRCK>),        //             .DACLRCK
		.ext_1_SDAT         (<connected-to-ext_1_SDAT>),         //        ext_1.SDAT
		.ext_1_SCLK         (<connected-to-ext_1_SCLK>),         //             .SCLK
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

