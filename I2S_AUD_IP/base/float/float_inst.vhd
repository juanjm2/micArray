	component float is
		port (
			clk_clk                                           : in  std_logic                     := 'X';             -- clk
			reset_reset_n                                     : in  std_logic                     := 'X';             -- reset_n
			nios_custom_instr_floating_point_2_0_s1_dataa     : in  std_logic_vector(31 downto 0) := (others => 'X'); -- dataa
			nios_custom_instr_floating_point_2_0_s1_datab     : in  std_logic_vector(31 downto 0) := (others => 'X'); -- datab
			nios_custom_instr_floating_point_2_0_s1_n         : in  std_logic_vector(3 downto 0)  := (others => 'X'); -- n
			nios_custom_instr_floating_point_2_0_s1_result    : out std_logic_vector(31 downto 0);                    -- result
			nios_custom_instr_floating_point_2_0_s2_clk       : in  std_logic                     := 'X';             -- clk
			nios_custom_instr_floating_point_2_0_s2_clk_en    : in  std_logic                     := 'X';             -- clk_en
			nios_custom_instr_floating_point_2_0_s2_dataa     : in  std_logic_vector(31 downto 0) := (others => 'X'); -- dataa
			nios_custom_instr_floating_point_2_0_s2_datab     : in  std_logic_vector(31 downto 0) := (others => 'X'); -- datab
			nios_custom_instr_floating_point_2_0_s2_n         : in  std_logic_vector(2 downto 0)  := (others => 'X'); -- n
			nios_custom_instr_floating_point_2_0_s2_reset     : in  std_logic                     := 'X';             -- reset
			nios_custom_instr_floating_point_2_0_s2_reset_req : in  std_logic                     := 'X';             -- reset_req
			nios_custom_instr_floating_point_2_0_s2_start     : in  std_logic                     := 'X';             -- start
			nios_custom_instr_floating_point_2_0_s2_done      : out std_logic;                                        -- done
			nios_custom_instr_floating_point_2_0_s2_result    : out std_logic_vector(31 downto 0)                     -- result
		);
	end component float;

	u0 : component float
		port map (
			clk_clk                                           => CONNECTED_TO_clk_clk,                                           --                                     clk.clk
			reset_reset_n                                     => CONNECTED_TO_reset_reset_n,                                     --                                   reset.reset_n
			nios_custom_instr_floating_point_2_0_s1_dataa     => CONNECTED_TO_nios_custom_instr_floating_point_2_0_s1_dataa,     -- nios_custom_instr_floating_point_2_0_s1.dataa
			nios_custom_instr_floating_point_2_0_s1_datab     => CONNECTED_TO_nios_custom_instr_floating_point_2_0_s1_datab,     --                                        .datab
			nios_custom_instr_floating_point_2_0_s1_n         => CONNECTED_TO_nios_custom_instr_floating_point_2_0_s1_n,         --                                        .n
			nios_custom_instr_floating_point_2_0_s1_result    => CONNECTED_TO_nios_custom_instr_floating_point_2_0_s1_result,    --                                        .result
			nios_custom_instr_floating_point_2_0_s2_clk       => CONNECTED_TO_nios_custom_instr_floating_point_2_0_s2_clk,       -- nios_custom_instr_floating_point_2_0_s2.clk
			nios_custom_instr_floating_point_2_0_s2_clk_en    => CONNECTED_TO_nios_custom_instr_floating_point_2_0_s2_clk_en,    --                                        .clk_en
			nios_custom_instr_floating_point_2_0_s2_dataa     => CONNECTED_TO_nios_custom_instr_floating_point_2_0_s2_dataa,     --                                        .dataa
			nios_custom_instr_floating_point_2_0_s2_datab     => CONNECTED_TO_nios_custom_instr_floating_point_2_0_s2_datab,     --                                        .datab
			nios_custom_instr_floating_point_2_0_s2_n         => CONNECTED_TO_nios_custom_instr_floating_point_2_0_s2_n,         --                                        .n
			nios_custom_instr_floating_point_2_0_s2_reset     => CONNECTED_TO_nios_custom_instr_floating_point_2_0_s2_reset,     --                                        .reset
			nios_custom_instr_floating_point_2_0_s2_reset_req => CONNECTED_TO_nios_custom_instr_floating_point_2_0_s2_reset_req, --                                        .reset_req
			nios_custom_instr_floating_point_2_0_s2_start     => CONNECTED_TO_nios_custom_instr_floating_point_2_0_s2_start,     --                                        .start
			nios_custom_instr_floating_point_2_0_s2_done      => CONNECTED_TO_nios_custom_instr_floating_point_2_0_s2_done,      --                                        .done
			nios_custom_instr_floating_point_2_0_s2_result    => CONNECTED_TO_nios_custom_instr_floating_point_2_0_s2_result     --                                        .result
		);

