	component Audio is
		port (
			clk_clk            : in  std_logic                     := 'X';             -- clk
			external_ADCDAT    : in  std_logic                     := 'X';             -- ADCDAT
			external_ADCLRCK   : in  std_logic                     := 'X';             -- ADCLRCK
			external_BCLK      : in  std_logic                     := 'X';             -- BCLK
			external_DACDAT    : out std_logic;                                        -- DACDAT
			external_DACLRCK   : in  std_logic                     := 'X';             -- DACLRCK
			left_input_data    : in  std_logic_vector(15 downto 0) := (others => 'X'); -- data
			left_input_valid   : in  std_logic                     := 'X';             -- valid
			left_input_ready   : out std_logic;                                        -- ready
			left_output_ready  : in  std_logic                     := 'X';             -- ready
			left_output_data   : out std_logic_vector(15 downto 0);                    -- data
			left_output_valid  : out std_logic;                                        -- valid
			reset_reset_n      : in  std_logic                     := 'X';             -- reset_n
			right_input_data   : in  std_logic_vector(15 downto 0) := (others => 'X'); -- data
			right_input_valid  : in  std_logic                     := 'X';             -- valid
			right_input_ready  : out std_logic;                                        -- ready
			right_output_ready : in  std_logic                     := 'X';             -- ready
			right_output_data  : out std_logic_vector(15 downto 0);                    -- data
			right_output_valid : out std_logic                                         -- valid
		);
	end component Audio;

	u0 : component Audio
		port map (
			clk_clk            => CONNECTED_TO_clk_clk,            --          clk.clk
			external_ADCDAT    => CONNECTED_TO_external_ADCDAT,    --     external.ADCDAT
			external_ADCLRCK   => CONNECTED_TO_external_ADCLRCK,   --             .ADCLRCK
			external_BCLK      => CONNECTED_TO_external_BCLK,      --             .BCLK
			external_DACDAT    => CONNECTED_TO_external_DACDAT,    --             .DACDAT
			external_DACLRCK   => CONNECTED_TO_external_DACLRCK,   --             .DACLRCK
			left_input_data    => CONNECTED_TO_left_input_data,    --   left_input.data
			left_input_valid   => CONNECTED_TO_left_input_valid,   --             .valid
			left_input_ready   => CONNECTED_TO_left_input_ready,   --             .ready
			left_output_ready  => CONNECTED_TO_left_output_ready,  --  left_output.ready
			left_output_data   => CONNECTED_TO_left_output_data,   --             .data
			left_output_valid  => CONNECTED_TO_left_output_valid,  --             .valid
			reset_reset_n      => CONNECTED_TO_reset_reset_n,      --        reset.reset_n
			right_input_data   => CONNECTED_TO_right_input_data,   --  right_input.data
			right_input_valid  => CONNECTED_TO_right_input_valid,  --             .valid
			right_input_ready  => CONNECTED_TO_right_input_ready,  --             .ready
			right_output_ready => CONNECTED_TO_right_output_ready, -- right_output.ready
			right_output_data  => CONNECTED_TO_right_output_data,  --             .data
			right_output_valid => CONNECTED_TO_right_output_valid  --             .valid
		);

