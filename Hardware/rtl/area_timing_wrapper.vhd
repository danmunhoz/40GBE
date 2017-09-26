
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

library xil_defaultlib;
    use xil_defaultlib.common_pkg.all;

--***********************************Entity Declaration************************



entity area_timing_wrapper is
    port
    (
        -- Input Clocks
        Q8_CLK0_GTREFCLK_PAD_N_IN               : in   std_logic;                       -- 156.25 MHz SFP+ Clock N
        Q8_CLK0_GTREFCLK_PAD_P_IN               : in   std_logic;                       -- 156.25 MHz SFP+ Clock P
        SYSCLK_IN_N                             : in   std_logic;                       -- 200.00 MHz System Clock N
        SYSCLK_IN_P                             : in   std_logic                       -- 200.00 MHz System Clock P

    );

end area_timing_wrapper;

architecture top of GTH_tester is

    component xgeth_tester
    port(
        -- Clocks
        clk_156             : in std_logic;
        clk_250             : in std_logic;
        tx_clk_161_13       : in std_logic;
        rx_clk_161_13       : in std_logic;
        clk_xgmii_rx        : in std_logic;
        clk_xgmii_tx        : in std_logic;

        -- Resets
        reset_tx_n          : in std_logic;
        reset_rx_n          : in std_logic;
        reset_tx_done       : in std_logic;
        reset_rx_done       : in std_logic;

        async_reset_n       : in std_logic;

        linkstatus          : out std_logic;
        eth_rx_los          : in std_logic;
        rx_data_in          : in  std_logic_vector(63 downto 0); --phy_rx_dout
        rx_header_in        : in  std_logic_vector(1 downto 0);
        rx_data_valid_in    : in  std_logic;
        rx_header_valid_in  : in  std_logic;
        tx_data_out         : out  std_logic_vector(63 downto 0); --phy_tx_din
        tx_header_out       : out  std_logic_vector(1 downto 0);
        tx_sequence_out     : out  std_logic_vector(6 downto 0);
        rxgearboxslip_out   : out  std_logic;


         -- uPC interface
        xgeth_waddr         : in std_logic_vector(6 downto 0);
        xgeth_wdata         : in std_logic_vector(31 downto 0);

        xgeth_raddr         : in std_logic_vector(6 downto 0);
        xgeth_rdata         : out std_logic_vector(31 downto 0);

        xgeth_wen           : in std_logic;

        on_frame_sent             : out std_logic;
        on_frame_received        : out std_logic;

        verify_system_rec   : out std_logic
    );
    end component;

    --____________________________COMMON PORTS________________________________
    ---------------------- Common Block  - Ref Clock Ports ---------------------
    signal  gt0_gtrefclk1_common_i          : std_logic;
    ------------------------- Common Block - QPLL Ports ------------------------
    signal  gt0_qplllock_i                  : std_logic;
    signal  gt0_qpllrefclklost_i            : std_logic;
    signal  gt0_qpllreset_i                 : std_logic;

    ----------------------------- Reference Clocks ----------------------------

    -- RESET
    signal soft_reset_i    : std_logic;
    signal global_reset_i  : std_logic;

    ------------------------- Clock Input Signals ------------------------
    signal sysclk_i                        : std_logic;
    signal sysclk_g_i                      : std_logic;
    signal q8_clk0_refclk_g_i              : std_logic;
    signal q8_clk0_refclk_i                : std_logic;

    begin


    inst_xgeth_tester1 : xgeth_tester
    port map
    (
        -- Clocks
        clk_156             => q8_clk0_refclk_g_i,
        clk_250             => clk_250,
        tx_clk_161_13       => gt0_txusrclk2_i,
        rx_clk_161_13       => gt0_rxusrclk2_i,
        clk_xgmii_rx        => q8_clk0_refclk_g_i,
        clk_xgmii_tx        => q8_clk0_refclk_g_i
    );

    inst_wrapper_macpcs: wrapper_macpcs_rx port map(
      -- Clocks
      clk_156             => q8_clk0_refclk_g_i,
      tx_clk_161_13       => gt0_txusrclk2_i,
      rx_clk_161_13       => gt0_txusrclk2_i,
      clk_xgmii_rx        => q8_clk0_refclk_g_i,
      clk_xgmii_tx        => q8_clk0_refclk_g_i,
      clk_312             => clk_250,             // 250 POR ENQUANTO!!!!!

      -- Resets
      async_reset_n       => not soft_reset_i,
      reset_tx_n          => gt0_txresetdone_i,
      reset_rx_n          => gt0_txresetdone_i,
      reset_tx_done       => gt0_txfsmresetdone_i,
      reset_rx_done       => gt0_txfsmresetdone_i,

      -- For testbench use only
      start_fifo => '0',
      dump_xgmii_rxc_0 => open,
      dump_xgmii_rxd_0 => open,
      dump_xgmii_rxc_1 => open,
      dump_xgmii_rxd_1 => open,
      dump_xgmii_rxc_2 => open,
      dump_xgmii_rxd_2 => open,
      dump_xgmii_rxc_3 => open,
      dump_xgmii_rxd_3 => open,

      -- PCS IN
      rx_lane_0_header_valid_in    => (others=>'0'),
      rx_lane_0_data_valid_in      => (others=>'0'),
      rx_lane_0_header_in          => (others=>'0'),
      rx_lane_0_data_in            => (others=>'0'),

      rx_lane_1_header_valid_in    => (others=>'0'),
      rx_lane_1_data_valid_in      => (others=>'0'),
      rx_lane_1_header_in          => (others=>'0'),
      rx_lane_1_data_in            => (others=>'0'),

      rx_lane_2_header_valid_in    => (others=>'0'),
      rx_lane_2_data_valid_in      => (others=>'0'),
      rx_lane_2_header_in          => (others=>'0'),
      rx_lane_2_data_in            => (others=>'0'),

      rx_lane_3_header_valid_in    => (others=>'0'),
      rx_lane_3_data_valid_in      => (others=>'0'),
      rx_lane_3_header_in          => (others=>'0'),
      rx_lane_3_data_in            => (others=>'0'),

      -- PCS OUT
      tx_data_out        => open,
      tx_header_out      => open,
      rxgearboxslip_out  => open,
      tx_sequence_out    => open,

      -- MAC
      pkt_rx_data     => open,
      pkt_rx_avail    => open,
      pkt_rx_eop      => open,
      pkt_rx_err      => open,
      pkt_rx_mod      => open,
      pkt_rx_sop      => open,
      pkt_rx_val      => open,
      pkt_tx_full     => open,

     -- MAC Outputs
      pkt_rx_ren      => '0',
      pkt_tx_data     => (others=>'0'),
      pkt_tx_eop      => '0',
      pkt_tx_mod      => (others=>'0'),
      pkt_tx_sop      => '0',
      pkt_tx_val      => '0',

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

        BUFG_REFCLK : BUFG
        port map
        (
            I    => q8_clk0_refclk_i,
            O    => q8_clk0_refclk_g_i
        );

        IBUFDS_SYSCLK : IBUFDS
        port map
         (
            I  => SYSCLK_IN_P,
            IB => SYSCLK_IN_N,
            O  => sysclk_i
         );

        BUFG_SYSCLK : BUFG
         port map
         (
             I    => sysclk_i,
             O    => sysclk_g_i
         );

        -- Divisor de clock para geraÃ§Ã£o do DRP CLOCK de 100MHz

        process(sysclk_g_i)
        begin
            if rising_edge(sysclk_g_i) then
                drpclk_i <= not drpclk_i;
            end if;
        end process;



    global_reset : process(sysclk_g_i, global_reset_i)
        variable counter : integer;
        begin
            if global_reset_i = '1' then
                counter := 0;
                soft_reset_i  <= '1';
                reset_i2c   <= '1';
            elsif rising_edge(sysclk_g_i) then

                if counter < 800 then
                counter := counter + 1;
                end if;
                if counter = 400 then
                    soft_reset_i <= '0';
                elsif
                    counter = 800 then
                    reset_i2c <= '0';
                end if;
            end if;
        end process;
end top;
