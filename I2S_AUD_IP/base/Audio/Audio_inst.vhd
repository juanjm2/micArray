	component Audio is
		port (
			clk_clk                            : in  std_logic := 'X'; -- clk
			reset_reset_n                      : in  std_logic := 'X'; -- reset_n
			audio_0_external_interface_ADCDAT  : in  std_logic := 'X'; -- ADCDAT
			audio_0_external_interface_ADCLRCK : in  std_logic := 'X'; -- ADCLRCK
			audio_0_external_interface_BCLK    : in  std_logic := 'X'; -- BCLK
			audio_0_external_interface_DACDAT  : out std_logic;        -- DACDAT
			audio_0_external_interface_DACLRCK : in  std_logic := 'X'  -- DACLRCK
		);
	end component Audio;

	u0 : component Audio
		port map (
			clk_clk                            => CONNECTED_TO_clk_clk,                            --                        clk.clk
			reset_reset_n                      => CONNECTED_TO_reset_reset_n,                      --                      reset.reset_n
			audio_0_external_interface_ADCDAT  => CONNECTED_TO_audio_0_external_interface_ADCDAT,  -- audio_0_external_interface.ADCDAT
			audio_0_external_interface_ADCLRCK => CONNECTED_TO_audio_0_external_interface_ADCLRCK, --                           .ADCLRCK
			audio_0_external_interface_BCLK    => CONNECTED_TO_audio_0_external_interface_BCLK,    --                           .BCLK
			audio_0_external_interface_DACDAT  => CONNECTED_TO_audio_0_external_interface_DACDAT,  --                           .DACDAT
			audio_0_external_interface_DACLRCK => CONNECTED_TO_audio_0_external_interface_DACLRCK  --                           .DACLRCK
		);

