// ============================================================================
// Copyright (c) 2013 by Terasic Technologies Inc.
// ============================================================================
//
// Permission:
//
//   Terasic grants permission to use and modify this code for use
//   in synthesis for all Terasic Development Boards and Altera Development 
//   Kits made by Terasic.  Other use of this code, including the selling 
//   ,duplication, or modification of any portion is strictly prohibited.
//
// Disclaimer:
//
//   This VHDL/Verilog or C/C++ source code is intended as a design reference
//   which illustrates how these types of functions can be implemented.
//   It is the user's responsibility to verify their design for
//   consistency and functionality through the use of formal
//   verification methods.  Terasic provides no warranty regarding the use 
//   or functionality of this code.
//
// ============================================================================
//           
//  Terasic Technologies Inc
//  9F., No.176, Sec.2, Gongdao 5th Rd, East Dist, Hsinchu City, 30070. Taiwan
//  
//  
//                     web: http://www.terasic.com/  
//                     email: support@terasic.com
//
// ============================================================================
//Date:  Mon Jun 17 20:35:29 2013
// ============================================================================

`define ENABLE_HPS

module ghrd_top(

      
      ///////// ADC /////////
      inout              ADC_CS_N,
      output             ADC_DIN,
      input              ADC_DOUT,
      output             ADC_SCLK,

      ///////// AUD /////////
      input              AUD_ADCDAT,
      inout              AUD_ADCLRCK,
      inout              AUD_BCLK,
      output             AUD_DACDAT,
      inout              AUD_DACLRCK,
      output             AUD_XCK,
		
		///////// Mic Signals /////////
		input						GPIO_DIN,
		input						GPIO_DIN2,
		input						GPIO_DIN3,
		input						GPIO_DIN4,
		output					GPIO_BCLK,
		output					GPIO_LRCLK,

      ///////// CLOCK2 /////////
      input              CLOCK2_50,

      ///////// CLOCK3 /////////
      input              CLOCK3_50,

      ///////// CLOCK4 /////////
      input              CLOCK4_50,

      ///////// CLOCK /////////
      input              CLOCK_50,

      ///////// DRAM /////////
      output      [12:0] DRAM_ADDR,
      output      [1:0]  DRAM_BA,
      output             DRAM_CAS_N,
      output             DRAM_CKE,
      output             DRAM_CLK,
      output             DRAM_CS_N,
      inout       [15:0] DRAM_DQ,
      output             DRAM_LDQM,
      output             DRAM_RAS_N,
      output             DRAM_UDQM,
      output             DRAM_WE_N,

      ///////// FAN /////////
      output             FAN_CTRL,

      ///////// FPGA /////////
      output             FPGA_I2C_SCLK,
      inout              FPGA_I2C_SDAT,

      ///////// GPIO /////////
      inout     [35:0]         GPIO_0,
      inout     [35:0]         GPIO_1,
 

      ///////// HEX0 /////////
      output      [6:0]  HEX0,

      ///////// HEX1 /////////
      output      [6:0]  HEX1,

      ///////// HEX2 /////////
      output      [6:0]  HEX2,

      ///////// HEX3 /////////
      output      [6:0]  HEX3,

      ///////// HEX4 /////////
      output      [6:0]  HEX4,

      ///////// HEX5 /////////
      output      [6:0]  HEX5,

`ifdef ENABLE_HPS
      ///////// HPS /////////
      inout              HPS_CONV_USB_N,
      output      [14:0] HPS_DDR3_ADDR,
      output      [2:0]  HPS_DDR3_BA,
      output             HPS_DDR3_CAS_N,
      output             HPS_DDR3_CKE,
      output             HPS_DDR3_CK_N,
      output             HPS_DDR3_CK_P,
      output             HPS_DDR3_CS_N,
      output      [3:0]  HPS_DDR3_DM,
      inout       [31:0] HPS_DDR3_DQ,
      inout       [3:0]  HPS_DDR3_DQS_N,
      inout       [3:0]  HPS_DDR3_DQS_P,
      output             HPS_DDR3_ODT,
      output             HPS_DDR3_RAS_N,
      output             HPS_DDR3_RESET_N,
      input              HPS_DDR3_RZQ,
      output             HPS_DDR3_WE_N,
      output             HPS_ENET_GTX_CLK,
      inout              HPS_ENET_INT_N,
      output             HPS_ENET_MDC,
      inout              HPS_ENET_MDIO,
      input              HPS_ENET_RX_CLK,
      input       [3:0]  HPS_ENET_RX_DATA,
      input              HPS_ENET_RX_DV,
      output      [3:0]  HPS_ENET_TX_DATA,
      output             HPS_ENET_TX_EN,
      inout       [3:0]  HPS_FLASH_DATA,
      output             HPS_FLASH_DCLK,
      output             HPS_FLASH_NCSO,
      inout              HPS_GSENSOR_INT,
      inout              HPS_I2C1_SCLK,
      inout              HPS_I2C1_SDAT,
      inout              HPS_I2C2_SCLK,
      inout              HPS_I2C2_SDAT,
      inout              HPS_I2C_CONTROL,
      inout              HPS_KEY,
      inout              HPS_LED,
      inout              HPS_LTC_GPIO,
      output             HPS_SD_CLK,
      inout              HPS_SD_CMD,
      inout       [3:0]  HPS_SD_DATA,
      output             HPS_SPIM_CLK,
      input              HPS_SPIM_MISO,
      output             HPS_SPIM_MOSI,
      inout              HPS_SPIM_SS,
      input              HPS_UART_RX,
      output             HPS_UART_TX,
      input              HPS_USB_CLKOUT,
      inout       [7:0]  HPS_USB_DATA,
      input              HPS_USB_DIR,
      input              HPS_USB_NXT,
      output             HPS_USB_STP,
`endif /*ENABLE_HPS*/

      ///////// IRDA /////////
      input              IRDA_RXD,
      output             IRDA_TXD,

      ///////// KEY /////////
      input       [3:0]  KEY,

      ///////// LEDR /////////
      output      [9:0]  LEDR,

      ///////// PS2 /////////
      inout              PS2_CLK,
      inout              PS2_CLK2,
      inout              PS2_DAT,
      inout              PS2_DAT2,

      ///////// SW /////////
      input       [9:0]  SW,

      ///////// TD /////////
      input              TD_CLK27,
      input      [7:0]  TD_DATA,
      input             TD_HS,
      output             TD_RESET_N,
      input             TD_VS,


      ///////// VGA /////////
      output      [7:0]  VGA_B,
      output             VGA_BLANK_N,
      output             VGA_CLK,
      output      [7:0]  VGA_G,
      output             VGA_HS,
      output      [7:0]  VGA_R,
      output             VGA_SYNC_N,
      output             VGA_VS
);

//=======================================================
//  REG/WIRE declarations
//=======================================================
//  wire  hps_fpga_reset_n;
//  wire [3:0] fpga_debounced_buttons;
//  wire [8:0]  fpga_led_internal;
//  wire [2:0]  hps_reset_req;
//  wire        hps_cold_reset;
//  wire        hps_warm_reset;
//  wire        hps_debug_reset;
//  wire [27:0] stm_hw_events;
//  wire        fpga_clk_50;
//// connection of internal logics
//  assign LEDR[9:1] = fpga_led_internal;
//  assign stm_hw_events    = {{4{1'b0}}, SW, fpga_led_internal, fpga_debounced_buttons};
//  assign fpga_clk_50=CLOCK_50;
//=======================================================
//  Structural coding
//=======================================================
soc_system u0 (      
		  .clk_clk                               (CLOCK_50),                             //                clk.clk
		  .reset_reset_n                         (1'b1),                                 //                reset.reset_n
		  //HPS ddr3
		  .hps_0_addr_mem_a                          ( HPS_DDR3_ADDR),                       //                memory.mem_a
        .hps_0_addr_mem_ba                         ( HPS_DDR3_BA),                         //                .mem_ba
        .hps_0_addr_mem_ck                         ( HPS_DDR3_CK_P),                       //                .mem_ck
        .hps_0_addr_mem_ck_n                       ( HPS_DDR3_CK_N),                       //                .mem_ck_n
        .hps_0_addr_mem_cke                        ( HPS_DDR3_CKE),                        //                .mem_cke
        .hps_0_addr_mem_cs_n                       ( HPS_DDR3_CS_N),                       //                .mem_cs_n
        .hps_0_addr_mem_ras_n                      ( HPS_DDR3_RAS_N),                      //                .mem_ras_n
        .hps_0_addr_mem_cas_n                      ( HPS_DDR3_CAS_N),                      //                .mem_cas_n
        .hps_0_addr_mem_we_n                       ( HPS_DDR3_WE_N),                       //                .mem_we_n
        .hps_0_addr_mem_reset_n                    ( HPS_DDR3_RESET_N),                    //                .mem_reset_n
        .hps_0_addr_mem_dq                         ( HPS_DDR3_DQ),                         //                .mem_dq
        .hps_0_addr_mem_dqs                        ( HPS_DDR3_DQS_P),                      //                .mem_dqs
        .hps_0_addr_mem_dqs_n                      ( HPS_DDR3_DQS_N),                      //                .mem_dqs_n
        .hps_0_addr_mem_odt                        ( HPS_DDR3_ODT),                        //                .mem_odt
        .hps_0_addr_mem_dm                         ( HPS_DDR3_DM),                         //                .mem_dm
        .hps_0_addr_oct_rzqin                      ( HPS_DDR3_RZQ),                        //                .oct_rzqin
       //HPS ethernet		
	     .hps_io_hps_io_emac1_inst_TX_CLK ( HPS_ENET_GTX_CLK),       //                             hps_0_hps_io.hps_io_emac1_inst_TX_CLK
        .hps_io_hps_io_emac1_inst_TXD0   ( HPS_ENET_TX_DATA[0] ),   //                             .hps_io_emac1_inst_TXD0
        .hps_io_hps_io_emac1_inst_TXD1   ( HPS_ENET_TX_DATA[1] ),   //                             .hps_io_emac1_inst_TXD1
        .hps_io_hps_io_emac1_inst_TXD2   ( HPS_ENET_TX_DATA[2] ),   //                             .hps_io_emac1_inst_TXD2
        .hps_io_hps_io_emac1_inst_TXD3   ( HPS_ENET_TX_DATA[3] ),   //                             .hps_io_emac1_inst_TXD3
        .hps_io_hps_io_emac1_inst_RXD0   ( HPS_ENET_RX_DATA[0] ),   //                             .hps_io_emac1_inst_RXD0
        .hps_io_hps_io_emac1_inst_MDIO   ( HPS_ENET_MDIO ),         //                             .hps_io_emac1_inst_MDIO
        .hps_io_hps_io_emac1_inst_MDC    ( HPS_ENET_MDC  ),         //                             .hps_io_emac1_inst_MDC
        .hps_io_hps_io_emac1_inst_RX_CTL ( HPS_ENET_RX_DV),         //                             .hps_io_emac1_inst_RX_CTL
        .hps_io_hps_io_emac1_inst_TX_CTL ( HPS_ENET_TX_EN),         //                             .hps_io_emac1_inst_TX_CTL
        .hps_io_hps_io_emac1_inst_RX_CLK ( HPS_ENET_RX_CLK),        //                             .hps_io_emac1_inst_RX_CLK
        .hps_io_hps_io_emac1_inst_RXD1   ( HPS_ENET_RX_DATA[1] ),   //                             .hps_io_emac1_inst_RXD1
        .hps_io_hps_io_emac1_inst_RXD2   ( HPS_ENET_RX_DATA[2] ),   //                             .hps_io_emac1_inst_RXD2
        .hps_io_hps_io_emac1_inst_RXD3   ( HPS_ENET_RX_DATA[3] ),   //                             .hps_io_emac1_inst_RXD3
       //HPS QSPI  
		  .hps_io_hps_io_qspi_inst_IO0     ( HPS_FLASH_DATA[0]    ),     //                               .hps_io_qspi_inst_IO0
        .hps_io_hps_io_qspi_inst_IO1     ( HPS_FLASH_DATA[1]    ),     //                               .hps_io_qspi_inst_IO1
        .hps_io_hps_io_qspi_inst_IO2     ( HPS_FLASH_DATA[2]    ),     //                               .hps_io_qspi_inst_IO2
        .hps_io_hps_io_qspi_inst_IO3     ( HPS_FLASH_DATA[3]    ),     //                               .hps_io_qspi_inst_IO3
        .hps_io_hps_io_qspi_inst_SS0     ( HPS_FLASH_NCSO    ),        //                               .hps_io_qspi_inst_SS0
        .hps_io_hps_io_qspi_inst_CLK     ( HPS_FLASH_DCLK    ),        //                               .hps_io_qspi_inst_CLK
       //HPS SD card 
		  .hps_io_hps_io_sdio_inst_CMD     ( HPS_SD_CMD    ),           //                               .hps_io_sdio_inst_CMD
        .hps_io_hps_io_sdio_inst_D0      ( HPS_SD_DATA[0]     ),      //                               .hps_io_sdio_inst_D0
        .hps_io_hps_io_sdio_inst_D1      ( HPS_SD_DATA[1]     ),      //                               .hps_io_sdio_inst_D1
        .hps_io_hps_io_sdio_inst_CLK     ( HPS_SD_CLK   ),            //                               .hps_io_sdio_inst_CLK
        .hps_io_hps_io_sdio_inst_D2      ( HPS_SD_DATA[2]     ),      //                               .hps_io_sdio_inst_D2
        .hps_io_hps_io_sdio_inst_D3      ( HPS_SD_DATA[3]     ),      //                               .hps_io_sdio_inst_D3
       //HPS USB 		  
		  .hps_io_hps_io_usb1_inst_D0      ( HPS_USB_DATA[0]    ),      //                               .hps_io_usb1_inst_D0
        .hps_io_hps_io_usb1_inst_D1      ( HPS_USB_DATA[1]    ),      //                               .hps_io_usb1_inst_D1
        .hps_io_hps_io_usb1_inst_D2      ( HPS_USB_DATA[2]    ),      //                               .hps_io_usb1_inst_D2
        .hps_io_hps_io_usb1_inst_D3      ( HPS_USB_DATA[3]    ),      //                               .hps_io_usb1_inst_D3
        .hps_io_hps_io_usb1_inst_D4      ( HPS_USB_DATA[4]    ),      //                               .hps_io_usb1_inst_D4
        .hps_io_hps_io_usb1_inst_D5      ( HPS_USB_DATA[5]    ),      //                               .hps_io_usb1_inst_D5
        .hps_io_hps_io_usb1_inst_D6      ( HPS_USB_DATA[6]    ),      //                               .hps_io_usb1_inst_D6
        .hps_io_hps_io_usb1_inst_D7      ( HPS_USB_DATA[7]    ),      //                               .hps_io_usb1_inst_D7
        .hps_io_hps_io_usb1_inst_CLK     ( HPS_USB_CLKOUT    ),       //                               .hps_io_usb1_inst_CLK
        .hps_io_hps_io_usb1_inst_STP     ( HPS_USB_STP    ),          //                               .hps_io_usb1_inst_STP
        .hps_io_hps_io_usb1_inst_DIR     ( HPS_USB_DIR    ),          //                               .hps_io_usb1_inst_DIR
        .hps_io_hps_io_usb1_inst_NXT     ( HPS_USB_NXT    ),          //                               .hps_io_usb1_inst_NXT
       //HPS SPI 		  
		  .hps_io_hps_io_spim1_inst_CLK    ( HPS_SPIM_CLK  ),           //                               .hps_io_spim1_inst_CLK
        .hps_io_hps_io_spim1_inst_MOSI   ( HPS_SPIM_MOSI ),           //                               .hps_io_spim1_inst_MOSI
        .hps_io_hps_io_spim1_inst_MISO   ( HPS_SPIM_MISO ),           //                               .hps_io_spim1_inst_MISO
        .hps_io_hps_io_spim1_inst_SS0    ( HPS_SPIM_SS ),             //                               .hps_io_spim1_inst_SS0
      //HPS UART		
		  .hps_io_hps_io_uart0_inst_RX     ( HPS_UART_RX    ),          //                               .hps_io_uart0_inst_RX
        .hps_io_hps_io_uart0_inst_TX     ( HPS_UART_TX    ),          //                               .hps_io_uart0_inst_TX
		//HPS I2C1
		  .hps_io_hps_io_i2c0_inst_SDA     ( HPS_I2C1_SDAT    ),        //                               .hps_io_i2c0_inst_SDA
        .hps_io_hps_io_i2c0_inst_SCL     ( HPS_I2C1_SCLK    ),        //                               .hps_io_i2c0_inst_SCL
		//HPS I2C2
		  .hps_io_hps_io_i2c1_inst_SDA     ( HPS_I2C2_SDAT    ),        //                               .hps_io_i2c1_inst_SDA
        .hps_io_hps_io_i2c1_inst_SCL     ( HPS_I2C2_SCLK    ),        //                               .hps_io_i2c1_inst_SCL
      //HPS GPIO  
		  .hps_io_hps_io_gpio_inst_GPIO09  ( HPS_CONV_USB_N),           //                               .hps_io_gpio_inst_GPIO09
        .hps_io_hps_io_gpio_inst_GPIO35  ( HPS_ENET_INT_N),           //                               .hps_io_gpio_inst_GPIO35
        .hps_io_hps_io_gpio_inst_GPIO40  ( HPS_LTC_GPIO),              //                               .hps_io_gpio_inst_GPIO40
        //.hps_0_hps_io_hps_io_gpio_inst_GPIO41  ( HPS_GPIO[1]),              //                               .hps_io_gpio_inst_GPIO41
        .hps_io_hps_io_gpio_inst_GPIO48  ( HPS_I2C_CONTROL),          //                               .hps_io_gpio_inst_GPIO48
        .hps_io_hps_io_gpio_inst_GPIO53  ( HPS_LED),                  //                               .hps_io_gpio_inst_GPIO53
        .hps_io_hps_io_gpio_inst_GPIO54  ( HPS_KEY),                  //                               .hps_io_gpio_inst_GPIO54
        .hps_io_hps_io_gpio_inst_GPIO61  ( HPS_GSENSOR_INT),          //                               .hps_io_gpio_inst_GPIO61
		  

//		input  wire [31:0] mic_system_0_adc_data_new_signal,       //           mic_system_0_adc_data.new_signal
//		input  wire        mic_system_0_aud_adclrck_new_signal,    //        mic_system_0_aud_adclrck.new_signal
//		input  wire        mic_system_0_aud_bclk_new_signal,       //           mic_system_0_aud_bclk.new_signal
//		output wire [31:0] mic_system_0_codec_stream_new_signal,   //       mic_system_0_codec_stream.new_signal
//		input  wire [31:0] mic_system_0_fir_left_data_new_signal,  //      mic_system_0_fir_left_data.new_signal
//		input  wire [31:0] mic_system_0_fir_right_data_new_signal, //     mic_system_0_fir_right_data.new_signal
//		input  wire        mic_system_0_gpio_din1_new_signal,      //          mic_system_0_gpio_din1.new_signal
//		input  wire        mic_system_0_gpio_din2_new_signal,      //          mic_system_0_gpio_din2.new_signal
//		input  wire        mic_system_0_gpio_din3_new_signal,      //          mic_system_0_gpio_din3.new_signal
//		input  wire        mic_system_0_gpio_din4_new_signal,      //          mic_system_0_gpio_din4.new_signal
//		output wire        mic_system_0_sample_ready_new_signal,   //       mic_system_0_sample_ready.new_signal
//		output wire [31:0] mic_system_0_volume_level_new_signal,   //       mic_system_0_volume_level.new_signal

		  
			// Audio signals
			.mic_system_0_adc_data_new_signal({new_left_fuck[31:16], new_right_fuck[31:16]}),
			.mic_system_0_aud_adclrck_new_signal(AUD_ADCLRCK),
			.mic_system_0_aud_bclk_new_signal(AUD_BCLK),
		   .mic_system_0_codec_stream_new_signal(inter_data),
			.mic_system_0_fir_left_data_new_signal(fir_left_data),
			.mic_system_0_fir_right_data_new_signal(fir_right_data),
			.mic_system_0_gpio_din1_new_signal(GPIO_DIN),
			.mic_system_0_gpio_din2_new_signal(GPIO_DIN2),
			.mic_system_0_gpio_din3_new_signal(GPIO_DIN3),
			.mic_system_0_gpio_din4_new_signal(GPIO_DIN4),
			.mic_system_0_sample_ready_new_signal(sample_ready),
			.mic_system_0_volume_level_new_signal(volume_level),
			.pushbuttons_external_connection_export(~KEY[3:0])
    );
	 
wire [31:0] inter_data, volume_level;
wire sample_ready;

wire [31:0] left_vol_out;
wire [31:0] right_vol_out;

volumeControl vol(
	.CLK(CLOCK_50),
	.RESET(~KEY[0]),
	.sample_ready(sample_ready),
	.hps_vol_level(volume_level),
	.line_in_left(new_left_fuck),
	.line_in_right(new_right_fuck),
	.left_output(left_vol_out),
	.right_output(right_vol_out)
);

audio_pll clock_gen(
	.audio_pll_0_audio_clk_clk(AUD_XCK),
	.audio_pll_0_ref_clk_clk(CLOCK2_50),
	.audio_pll_0_ref_reset_reset(1'b0),
	.audio_pll_0_ref_reset_source_reset()
);


//aud_setup fir_setup(
//		.clk_clk(CLOCK_50),                //              clk.clk
//		.ext_ADCDAT(AUD_ADCDAT),             //              ext.ADCDAT
//		.ext_ADCLRCK(AUD_ADCLRCK),            //                 .ADCLRCK
//		.ext_BCLK(AUD_BCLK),               //                 .BCLK
//		.ext_DACDAT(AUD_DACDAT),             //                 .DACDAT
//		.ext_DACLRCK(AUD_DACLRCK),            //                 .DACLRCK
//		.ext_1_SDAT(FPGA_I2C_SDAT),             //            ext_1.SDAT
//		.ext_1_SCLK(FPGA_I2C_SCLK),             //                 .SCLK
//		.fir_left_input_data(left_mux_out),    //   fir_left_input.data
//		.fir_left_input_valid(left_valid),   //                 .valid
//		.fir_left_input_error(),   //                 .error
//		.fir_left_output_data(fir_left_data),   //  fir_left_output.data
//		.fir_left_output_valid(fir_left_out_valid),  //                 .valid
//		.fir_left_output_error(),  //                 .error
//		.fir_right_input_data(right_mux_out),   //  fir_right_input.data
//		.fir_right_input_valid(right_valid),  //                 .valid
//		.fir_right_input_error(),  //                 .error
//		.fir_right_output_data(fir_right_data),  // fir_right_output.data
//		.fir_right_output_valid(fir_right_out_valid), //                 .valid
//		.fir_right_output_error(), //                 .error
//		.left_input_data(left_vol_out),        //       left_input.data
//		.left_input_valid(fir_left_out_valid),       //                 .valid
//		.left_input_ready(left_ready),       //                 .ready
//		.left_output_ready(left_ready),      //      left_output.ready
//		.left_output_data(left_data),       //                 .data
//		.left_output_valid(left_valid),      //                 .valid
//		.reset_reset_n(1'b1),          //            reset.reset_n
//		.right_input_data(right_vol_out),       //      right_input.data
//		.right_input_valid(fir_right_out_valid),      //                 .valid
//		.right_input_ready(right_ready),      	//                 .ready
//		.right_output_ready(right_ready),     	//     right_output.ready
//		.right_output_data(new_right_fuck),      	//                 .data
//		.right_output_valid(right_valid)      //                 .valid
//	);

//module aud_32 (
//		input  wire        clk_clk,            //          clk.clk
//		input  wire        ext_ADCDAT,         //          ext.ADCDAT
//		input  wire        ext_ADCLRCK,        //             .ADCLRCK
//		input  wire        ext_BCLK,           //             .BCLK
//		output wire        ext_DACDAT,         //             .DACDAT
//		input  wire        ext_DACLRCK,        //             .DACLRCK
//		inout  wire        ext_1_SDAT,         //        ext_1.SDAT
//		output wire        ext_1_SCLK,         //             .SCLK
//		input  wire [31:0] left_input_data,    //   left_input.data
//		input  wire        left_input_valid,   //             .valid
//		output wire        left_input_ready,   //             .ready
//		input  wire        left_output_ready,  //  left_output.ready
//		output wire [31:0] left_output_data,   //             .data
//		output wire        left_output_valid,  //             .valid
//		input  wire        reset_reset_n,      //        reset.reset_n
//		input  wire [31:0] right_input_data,   //  right_input.data
//		input  wire        right_input_valid,  //             .valid
//		output wire        right_input_ready,  //             .ready
//		input  wire        right_output_ready, // right_output.ready
//		output wire [31:0] right_output_data,  //             .data
//		output wire        right_output_valid  //             .valid
//	);

aud_32 line32(
	.clk_clk(CLOCK_50),
	.ext_ADCDAT(AUD_ADCDAT),
	.ext_ADCLRCK(AUD_ADCLRCK),
	.ext_BCLK(AUD_BCLK),
	.ext_DACDAT(AUD_DACDAT),
	.ext_DACLRCK(AUD_DACLRCK),
	.ext_1_SDAT(FPGA_I2C_SDAT),
	.ext_1_SCLK(FPGA_I2C_SCLK),
	.left_input_data(left_vol_out),
	.left_input_valid(left_valid),
	.left_input_ready(left_ready),
	.left_output_ready(left_ready),
	.left_output_data(new_left_fuck),
	.left_output_valid(left_valid),
	.reset_reset_n(1'b1),
	.right_input_data(new_right_fuck),
	.right_input_valid(right_valid),
	.right_input_ready(right_ready),
	.right_output_ready(right_ready),
	.right_output_data(new_right_fuck),
	.right_output_valid(right_valid)
);

wire [31:0] left_data, right_data, fir_left_data, fir_right_data;
wire left_valid, right_valid, left_ready, right_ready, fir_left_out_valid, fir_right_out_valid;
	
wire [31:0] adc_mic_data;

wire [31:0] new_left_fuck;

wire [31:0] new_right_fuck;

assign GPIO_LRCLK = AUD_ADCLRCK;
assign GPIO_BCLK = AUD_BCLK;


wire [15:0] left_mux_out, right_mux_out;
assign left_mux_out = SW[1] ? left_data[31:16] : mic_l;
assign right_mux_out = SW[0] ? right_data[31:16] : mic_r;


wire [15:0] mic_l, mic_r;

i2s_master m1(
	.sck(AUD_BCLK),
	.ws(AUD_ADCLRCK),
	.sd(GPIO_DIN),
	.data_left(mic_l),
	.data_right(mic_r)
);

//audio_and_video_config cfg(
//	// Inputs
//	.clk(CLOCK_50),
//	.reset(1'b0),
//
//	// Bidirectionals
//	.I2C_SDAT(FPGA_I2C_SDAT),
//	.I2C_SCLK(FPGA_I2C_SCLK)
//);

endmodule

  