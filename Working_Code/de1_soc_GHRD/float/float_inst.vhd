	component float is
		port (
			s1_dataa     : in  std_logic_vector(31 downto 0) := (others => 'X'); -- dataa
			s1_datab     : in  std_logic_vector(31 downto 0) := (others => 'X'); -- datab
			s1_n         : in  std_logic_vector(3 downto 0)  := (others => 'X'); -- n
			s1_result    : out std_logic_vector(31 downto 0);                    -- result
			s2_clk       : in  std_logic                     := 'X';             -- clk
			s2_clk_en    : in  std_logic                     := 'X';             -- clk_en
			s2_dataa     : in  std_logic_vector(31 downto 0) := (others => 'X'); -- dataa
			s2_datab     : in  std_logic_vector(31 downto 0) := (others => 'X'); -- datab
			s2_n         : in  std_logic_vector(2 downto 0)  := (others => 'X'); -- n
			s2_reset     : in  std_logic                     := 'X';             -- reset
			s2_reset_req : in  std_logic                     := 'X';             -- reset_req
			s2_start     : in  std_logic                     := 'X';             -- start
			s2_done      : out std_logic;                                        -- done
			s2_result    : out std_logic_vector(31 downto 0)                     -- result
		);
	end component float;

	u0 : component float
		port map (
			s1_dataa     => CONNECTED_TO_s1_dataa,     -- s1.dataa
			s1_datab     => CONNECTED_TO_s1_datab,     --   .datab
			s1_n         => CONNECTED_TO_s1_n,         --   .n
			s1_result    => CONNECTED_TO_s1_result,    --   .result
			s2_clk       => CONNECTED_TO_s2_clk,       -- s2.clk
			s2_clk_en    => CONNECTED_TO_s2_clk_en,    --   .clk_en
			s2_dataa     => CONNECTED_TO_s2_dataa,     --   .dataa
			s2_datab     => CONNECTED_TO_s2_datab,     --   .datab
			s2_n         => CONNECTED_TO_s2_n,         --   .n
			s2_reset     => CONNECTED_TO_s2_reset,     --   .reset
			s2_reset_req => CONNECTED_TO_s2_reset_req, --   .reset_req
			s2_start     => CONNECTED_TO_s2_start,     --   .start
			s2_done      => CONNECTED_TO_s2_done,      --   .done
			s2_result    => CONNECTED_TO_s2_result     --   .result
		);

