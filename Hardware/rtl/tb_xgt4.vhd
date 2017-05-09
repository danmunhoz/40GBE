library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

--library xil_defaultlib;
--    use xil_defaultlib.common_pkg.all;


entity tb_xgt4 is
  port (
    clock_in156   : in std_logic;
    clock_in161   : in std_logic;
    reset_in      : in std_logic;
    reset_in_mii_tx : in std_logic;
    reset_in_mii_rx : in std_logic;

    --pkt_tx_start  : in std_logic;
    data_out   : out std_logic_vector(63 downto 0);
    header_out : out std_logic_vector(1 downto 0)
  );
end tb_xgt4;

architecture behav of tb_xgt4 is
	signal	clk_156             : std_logic;
  signal	clk_161             : std_logic;
	signal	clk_250             : std_logic;
	signal	tx_clk_161_13       : std_logic;
	signal	rx_clk_161_13       : std_logic;
	signal	clk_xgmii_rx        : std_logic;
	signal	clk_xgmii_tx        : std_logic;

		-- Resets
  signal  reset 				      : std_logic;
	signal	async_reset_n       : std_logic;
	signal	reset_tx_n          : std_logic;
	signal	reset_rx_n          : std_logic;
	signal	reset_tx_done       : std_logic;
	signal	reset_rx_done       : std_logic;

		-- PCS Data Inputs
	signal	rx_header_in        : std_logic_vector(1 downto 0);
	signal	rx_data_in          : std_logic_vector(63 downto 0);
	signal	rx_data_valid_in    : std_logic;
	signal	rx_header_valid_in  : std_logic;

		-- PCS Data Outputs
	signal	tx_data_out         : std_logic_vector(63 downto 0);
	signal	tx_header_out       : std_logic_vector(1 downto 0);
	signal	rxgearboxslip_out   : std_logic;
	signal	tx_sequence_out     : std_logic_vector(6 downto 0);

  -- echo generator
  signal pkt_tx_data : std_logic_vector(63 downto 0);
  --signal pkt_tx_start, pkt_tx_val, pkt_tx_sop, pkt_tx_eop, pkt_tx_full : std_logic;
  signal pkt_tx_val, pkt_tx_sop, pkt_tx_eop, pkt_tx_full, pkt_tx_start : std_logic;
  signal pkt_tx_mod : std_logic_vector(2 downto 0);

  signal pkt_rx_ren   : std_logic;
  signal pkt_rx_data  : std_logic_vector(63 downto 0);
  signal pkt_rx_avail : std_logic;
  signal pkt_rx_eop   : std_logic;
  signal pkt_rx_err   : std_logic;
  signal pkt_rx_mod   : std_logic_vector(2 downto 0);
  signal pkt_rx_sop   : std_logic;
  signal pkt_rx_val   : std_logic;
  --signal pkt_rx_full  : std_logic;
  signal reset_in_pcs : std_logic;

  signal start_fifo : std_logic;

    component wrapper_macpcs port(
        -- Clocks
        clk_156             : in  std_logic;
        tx_clk_161_13       : in  std_logic;
        rx_clk_161_13       : in  std_logic;
        clk_xgmii_rx        : in  std_logic;
        clk_xgmii_tx        : in  std_logic;

        -- Resets
        async_reset_n       : in  std_logic;
        reset_tx_n          : in std_logic;
        reset_rx_n          : in std_logic;
        reset_tx_done       : in std_logic;
        reset_rx_done       : in std_logic;

        start_fifo          : in std_logic;

        -- PCS Inputs
        rx_jtm_en           : in  std_logic;
        bypass_descram      : in  std_logic;
        bypass_scram        : in  std_logic;
        bypass_66decoder    : in  std_logic;
        bypass_66encoder    : in  std_logic;
        clear_errblk        : in  std_logic;
        clear_ber_cnt       : in  std_logic;
        tx_jtm_en           : in  std_logic;
        jtm_dps_0           : in  std_logic;
        jtm_dps_1           : in  std_logic;
        seed_A              : in  std_logic_vector(57 downto 0);
        seed_B              : in  std_logic_vector(57 downto 0);

        rx_header_valid_in  : in  std_logic;
        rx_header_in        : in  std_logic_vector(1 downto 0);
        rx_data_valid_in    : in  std_logic;
        rx_data_in          : in  std_logic_vector(63 downto 0);

        -- PCS Outputs
        hi_ber              : out  std_logic;
        blk_lock            : out  std_logic;
        linkstatus          : out  std_logic;
        rx_fifo_spill       : out  std_logic;
        tx_fifo_spill       : out  std_logic;
        rxlf                : out  std_logic;
        txlf                : out  std_logic;
        ber_cnt             : out  std_logic_vector(5 downto 0);
        errd_blks           : out  std_logic_vector(7 downto 0);
        jtest_errc          : out  std_logic_vector(15 downto 0);

        tx_data_out         : out  std_logic_vector(63 downto 0);
        tx_header_out       : out  std_logic_vector(1 downto 0);
        rxgearboxslip_out   : out  std_logic;
        tx_sequence_out     : out  std_logic_vector(6 downto 0);

        -- MAC Inputs
        pkt_rx_ren          : in  std_logic;
        pkt_tx_data         : in  std_logic_vector(63 downto 0);
        pkt_tx_eop          : in  std_logic;
        pkt_tx_mod          : in  std_logic_vector(2 downto 0);
        pkt_tx_sop          : in  std_logic;
        pkt_tx_val          : in  std_logic;
            -- Wishbone (MAC)
        wb_adr_i            : in  std_logic_vector(7 downto 0);
        wb_clk_i            : in  std_logic;
        wb_cyc_i            : in  std_logic;
        wb_dat_i            : in  std_logic_vector(31 downto 0);
        wb_stb_i            : in  std_logic;
        wb_we_i             : in  std_logic;

        -- XMAC Outputs
        pkt_rx_avail        : out  std_logic;
        pkt_rx_data         : out  std_logic_vector(63 downto 0);
        pkt_rx_eop          : out  std_logic;
        pkt_rx_err          : out  std_logic;
        pkt_rx_mod          : out  std_logic_vector(2 downto 0);
        pkt_rx_sop          : out  std_logic;
        pkt_rx_val          : out  std_logic;
        pkt_tx_full         : out  std_logic;
            -- Wishbone (MAC)
        wb_ack_o            : out  std_logic;
        wb_dat_o            : out  std_logic_vector(31 downto 0);
        wb_int_o            : out  std_logic
        );
    end component;

begin

    clk_156 <= clock_in156;
    clk_161 <= clock_in161;

    reset_in_pcs <= '0', '1' after 35 ns;

    start_fifo <= '0', '1' after 65 ns;

    rx_data_valid_in <= '0','1' after 65 ns;
    rx_header_valid_in <= '0','1' after 65 ns;

-- INST WRAPPER
    inst_wrapper_macpcs : wrapper_macpcs port map(
        -- Clocks
        clk_156             => clk_156,
        tx_clk_161_13       => clk_161,
        rx_clk_161_13       => clk_161,
        clk_xgmii_rx        => clk_156,
        clk_xgmii_tx        => clk_156,
        -- clk_xgmii_rx        => clk_xgmii_rx,
        -- clk_xgmii_tx        => clk_xgmii_tx,

        -- Resets
        --async_reset_n       => async_reset_n,
        -- reset_tx_n          => reset_tx_n,
        -- reset_rx_n          => reset_rx_n,
        -- reset_tx_done       => reset_tx_done,
        -- reset_rx_done       => reset_rx_done,
        async_reset_n       => reset_in,
        reset_tx_n          => reset_in_pcs,
        reset_rx_n          => reset_in_pcs,
        --reset_tx_done       => reset_in,
        reset_tx_done       => reset_in_mii_tx,
        reset_rx_done       => reset_in_mii_rx,
        --reset_rx_done       => reset_in,

        start_fifo => start_fifo,

        -- PCS IN
        rx_header_valid_in  => rx_header_valid_in,
        rx_header_in        => rx_header_in,
        rx_data_valid_in    => rx_data_valid_in,
        rx_data_in          => rx_data_in,

        -- PCS OUT
        -- tx_data_out        => tx_data_out,
        -- tx_header_out      => tx_header_out,
        tx_data_out        => data_out,
        tx_header_out      => header_out,
        rxgearboxslip_out  => rxgearboxslip_out,
        tx_sequence_out    => tx_sequence_out,

        -- MAC
        pkt_rx_avail    => pkt_rx_avail,
        pkt_rx_err      => pkt_rx_err,

        pkt_rx_data     => pkt_rx_data,
        pkt_rx_eop      => pkt_rx_eop,
        pkt_rx_mod      => pkt_rx_mod,
        pkt_rx_sop      => pkt_rx_sop,
        pkt_rx_val      => pkt_rx_val,

        -- MAC Outputs
        pkt_rx_ren      => pkt_rx_ren,

        pkt_tx_data     => pkt_tx_data,
        pkt_tx_eop      => pkt_tx_eop,
        pkt_tx_mod      => pkt_tx_mod,
        pkt_tx_sop      => pkt_tx_sop,
        pkt_tx_val      => pkt_tx_val,
        pkt_tx_full     => pkt_tx_full,

        -- PCS Inputs
        rx_jtm_en           => '0',
        bypass_descram      => '0',
        bypass_scram        => '0',
        bypass_66decoder    => '0',
        bypass_66encoder    => '0',
        clear_errblk        => '0',
        clear_ber_cnt       => '0',
        tx_jtm_en           => '0',
        jtm_dps_0           => '0',
        jtm_dps_1           => '0',
        seed_A              => (others=>'0'),
        seed_B              => (others=>'0'),

        -- PCS Outputs
        hi_ber              => open,
        blk_lock            => open,
        linkstatus          => open,
        rx_fifo_spill       => open,
        tx_fifo_spill       => open,
        rxlf                => open,
        txlf                => open,
        ber_cnt             => open,
        errd_blks           => open,
        jtest_errc          => open,

        -- Wishbone Inputs (MAC)
        wb_adr_i            => (others=>'0'),
        wb_clk_i            => '0',
        wb_cyc_i            => '0',
        wb_dat_i            => (others=>'0'),
        wb_stb_i            => '0',
        wb_we_i             => '0',

        -- Wishbone Outputs (MAC)
        wb_ack_o            => open,
        wb_dat_o            => open,
        wb_int_o            => open
    );
--

-- INST ECHO GEN
    echo_gen_inst : entity work.echo_generator port map (
        clock             => clk_156,
        --reset         	=> reset,
        reset         		=> reset_in,

        -- Control Signals
        start               => pkt_tx_start,

        -- Settings
        mac_source          => x"00AA11BB22CC",
        mac_destination     => x"AA00BB11CC22",
        ip_source           => x"0ABCDE01",
        ip_destination      => x"0ABCDE02",
        packet_length       => x"05EE",

        timestamp_base      => (others=>'0'),
        time_stamp_flag     => '0',

        -- TX mac interface
        pkt_tx_full         => pkt_tx_full,
        pkt_tx_data         => pkt_tx_data,
        pkt_tx_val          => pkt_tx_val,
        pkt_tx_sop          => pkt_tx_sop,
        pkt_tx_eop          => pkt_tx_eop,
        pkt_tx_mod          => pkt_tx_mod,

        --LFSR settings
        lfsr_seed           => (others=>'1'),
        lfsr_polynomial     => (others=>'0'),
        valid_seed          => '1',

        payload_type        => (others=>'0'),
        payload_cycles      => (others=>'0'),
        payload_last_size   => (others=>'0'),
        pkt_lost_counter    => open
    );
--
    process
    begin

      -- wait for 144 ns;
      --
      -- for i in 0 to 4 loop
        wait for 48 ns;
        pkt_tx_start <= '1';
        wait until pkt_tx_eop = '1';
        pkt_tx_start <= '0';
        wait;
        -- wait for 18 ns;
      -- end loop;

    end process;

end behav;
