	fir_16 u0 (
		.clk_clk                (<connected-to-clk_clk>),                //              clk.clk
		.reset_reset_n          (<connected-to-reset_reset_n>),          //            reset.reset_n
		.left_output_ready      (<connected-to-left_output_ready>),      //      left_output.ready
		.left_output_data       (<connected-to-left_output_data>),       //                 .data
		.left_output_valid      (<connected-to-left_output_valid>),      //                 .valid
		.right_output_ready     (<connected-to-right_output_ready>),     //     right_output.ready
		.right_output_data      (<connected-to-right_output_data>),      //                 .data
		.right_output_valid     (<connected-to-right_output_valid>),     //                 .valid
		.left_input_data        (<connected-to-left_input_data>),        //       left_input.data
		.left_input_valid       (<connected-to-left_input_valid>),       //                 .valid
		.left_input_ready       (<connected-to-left_input_ready>),       //                 .ready
		.ext_ADCDAT             (<connected-to-ext_ADCDAT>),             //              ext.ADCDAT
		.ext_ADCLRCK            (<connected-to-ext_ADCLRCK>),            //                 .ADCLRCK
		.ext_BCLK               (<connected-to-ext_BCLK>),               //                 .BCLK
		.ext_DACDAT             (<connected-to-ext_DACDAT>),             //                 .DACDAT
		.ext_DACLRCK            (<connected-to-ext_DACLRCK>),            //                 .DACLRCK
		.right_input_data       (<connected-to-right_input_data>),       //      right_input.data
		.right_input_valid      (<connected-to-right_input_valid>),      //                 .valid
		.right_input_ready      (<connected-to-right_input_ready>),      //                 .ready
		.ext_1_SDAT             (<connected-to-ext_1_SDAT>),             //            ext_1.SDAT
		.ext_1_SCLK             (<connected-to-ext_1_SCLK>),             //                 .SCLK
		.fir_left_input_data    (<connected-to-fir_left_input_data>),    //   fir_left_input.data
		.fir_left_input_valid   (<connected-to-fir_left_input_valid>),   //                 .valid
		.fir_left_input_error   (<connected-to-fir_left_input_error>),   //                 .error
		.fir_left_output_data   (<connected-to-fir_left_output_data>),   //  fir_left_output.data
		.fir_left_output_valid  (<connected-to-fir_left_output_valid>),  //                 .valid
		.fir_left_output_error  (<connected-to-fir_left_output_error>),  //                 .error
		.fir_right_input_data   (<connected-to-fir_right_input_data>),   //  fir_right_input.data
		.fir_right_input_valid  (<connected-to-fir_right_input_valid>),  //                 .valid
		.fir_right_input_error  (<connected-to-fir_right_input_error>),  //                 .error
		.fir_right_output_data  (<connected-to-fir_right_output_data>),  // fir_right_output.data
		.fir_right_output_valid (<connected-to-fir_right_output_valid>), //                 .valid
		.fir_right_output_error (<connected-to-fir_right_output_error>)  //                 .error
	);

