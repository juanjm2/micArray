	component fir_test is
		port (
			clk_clk       : in  std_logic                     := 'X';             -- clk
			input_data    : in  std_logic_vector(15 downto 0) := (others => 'X'); -- data
			input_valid   : in  std_logic                     := 'X';             -- valid
			input_error   : in  std_logic_vector(1 downto 0)  := (others => 'X'); -- error
			output_data   : out std_logic_vector(15 downto 0);                    -- data
			output_valid  : out std_logic;                                        -- valid
			output_error  : out std_logic_vector(1 downto 0);                     -- error
			reset_reset_n : in  std_logic                     := 'X'              -- reset_n
		);
	end component fir_test;

	u0 : component fir_test
		port map (
			clk_clk       => CONNECTED_TO_clk_clk,       --    clk.clk
			input_data    => CONNECTED_TO_input_data,    --  input.data
			input_valid   => CONNECTED_TO_input_valid,   --       .valid
			input_error   => CONNECTED_TO_input_error,   --       .error
			output_data   => CONNECTED_TO_output_data,   -- output.data
			output_valid  => CONNECTED_TO_output_valid,  --       .valid
			output_error  => CONNECTED_TO_output_error,  --       .error
			reset_reset_n => CONNECTED_TO_reset_reset_n  --  reset.reset_n
		);

