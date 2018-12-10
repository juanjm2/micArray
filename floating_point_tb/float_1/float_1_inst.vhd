	component float_1 is
		port (
			s1_clk    : in  std_logic                     := 'X';             -- clk
			s1_clk_en : in  std_logic                     := 'X';             -- clk_en
			s1_dataa  : in  std_logic_vector(31 downto 0) := (others => 'X'); -- dataa
			s1_datab  : in  std_logic_vector(31 downto 0) := (others => 'X'); -- datab
			s1_n      : in  std_logic_vector(1 downto 0)  := (others => 'X'); -- n
			s1_reset  : in  std_logic                     := 'X';             -- reset
			s1_start  : in  std_logic                     := 'X';             -- start
			s1_done   : out std_logic;                                        -- done
			s1_result : out std_logic_vector(31 downto 0)                     -- result
		);
	end component float_1;

	u0 : component float_1
		port map (
			s1_clk    => CONNECTED_TO_s1_clk,    -- s1.clk
			s1_clk_en => CONNECTED_TO_s1_clk_en, --   .clk_en
			s1_dataa  => CONNECTED_TO_s1_dataa,  --   .dataa
			s1_datab  => CONNECTED_TO_s1_datab,  --   .datab
			s1_n      => CONNECTED_TO_s1_n,      --   .n
			s1_reset  => CONNECTED_TO_s1_reset,  --   .reset
			s1_start  => CONNECTED_TO_s1_start,  --   .start
			s1_done   => CONNECTED_TO_s1_done,   --   .done
			s1_result => CONNECTED_TO_s1_result  --   .result
		);

