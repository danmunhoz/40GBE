library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

library UNISIM;
  use UNISIM.VCOMPONENTS.ALL;


entity rx_xgt4 is
  port(

      clock_in156   : in std_logic;
      clock_in161   : in std_logic;
      clock_in312   : in std_logic;
      reset_in      : in  std_logic;

      reset_in_mii_tx : in std_logic;
      reset_in_mii_rx : in std_logic;

      --entrada do PCS
      rx_lane_0_header_valid_in  : in  std_logic;
      rx_lane_0_header_in        : in  std_logic_vector(1 downto 0);
      rx_lane_0_data_valid_in    : in  std_logic;
      rx_lane_0_data_in          : in  std_logic_vector(63 downto 0);

      rx_lane_1_header_valid_in  : in  std_logic;
      rx_lane_1_header_in        : in  std_logic_vector(1 downto 0);
      rx_lane_1_data_valid_in    : in  std_logic;
      rx_lane_1_data_in          : in  std_logic_vector(63 downto 0);

      rx_lane_2_header_valid_in  : in  std_logic;
      rx_lane_2_header_in        : in  std_logic_vector(1 downto 0);
      rx_lane_2_data_valid_in    : in  std_logic;
      rx_lane_2_data_in          : in  std_logic_vector(63 downto 0);

      rx_lane_3_header_valid_in  : in  std_logic;
      rx_lane_3_header_in        : in  std_logic_vector(1 downto 0);
      rx_lane_3_data_valid_in    : in  std_logic;
      rx_lane_3_data_in          : in  std_logic_vector(63 downto 0);
      --entrada MAC
      pkt_tx_data                : in  std_logic_vector(255 downto 0);
      pkt_tx_eop                 : in  std_logic;
      pkt_tx_mod                 : in  std_logic_vector(4 downto 0);
      pkt_tx_sop                 : in  std_logic_vector(1 downto 0);
      pkt_tx_val                 : in  std_logic;

      -- XMAC Outputs
      pkt_rx_avail        : out  std_logic;
      pkt_rx_data         : out  std_logic_vector(63 downto 0);
      pkt_rx_eop          : out  std_logic;
      pkt_rx_err          : out  std_logic;
      pkt_rx_mod          : out  std_logic_vector(2 downto 0);
      pkt_rx_sop          : out  std_logic;
      pkt_rx_val          : out  std_logic;
      --pkt_tx_full         : out  std_logic;

      dump_xgmii_rxc_0 : out std_logic_vector(7 downto 0);
      dump_xgmii_rxd_0 : out std_logic_vector(63 downto 0);
      dump_xgmii_rxc_1 : out std_logic_vector(7 downto 0);
      dump_xgmii_rxd_1 : out std_logic_vector(63 downto 0);
      dump_xgmii_rxc_2 : out std_logic_vector(7 downto 0);
      dump_xgmii_rxd_2 : out std_logic_vector(63 downto 0);
      dump_xgmii_rxc_3 : out std_logic_vector(7 downto 0);
      dump_xgmii_rxd_3 : out std_logic_vector(63 downto 0);

      mac_data : out std_logic_vector(127 downto 0);
      mac_sop  : out std_logic;
      mac_val  : out std_logic;
      mac_eop  : out std_logic_vector(4 downto 0)

      );
end rx_xgt4;


architecture behav of rx_xgt4 is

  	signal	clk_156             : std_logic;
    signal	clk_161             : std_logic;
    signal	clk_312             : std_logic;
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

  		-- PCS Data Outputs
  	signal	tx_data_out         : std_logic_vector(63 downto 0);
  	signal	tx_header_out       : std_logic_vector(1 downto 0);
  	signal	rxgearboxslip_out   : std_logic;
  	signal	tx_sequence_out     : std_logic_vector(6 downto 0);

    signal pkt_tx_full :std_logic;

    signal reset_in_pcs : std_logic;

    signal start_fifo : std_logic;
    signal read_fifo  : std_logic;

    signal lane_0_header_valid_in  : std_logic;
    signal lane_0_header_in        : std_logic_vector(1 downto 0);
    signal lane_0_data_valid_in    : std_logic;
    signal lane_0_data_in          : std_logic_vector(63 downto 0);

    signal lane_1_header_valid_in  : std_logic;
    signal lane_1_header_in        : std_logic_vector(1 downto 0);
    signal lane_1_data_valid_in    : std_logic;
    signal lane_1_data_in          : std_logic_vector(63 downto 0);

    signal lane_2_header_valid_in  : std_logic;
    signal lane_2_header_in        : std_logic_vector(1 downto 0);
    signal lane_2_data_valid_in    : std_logic;
    signal lane_2_data_in          : std_logic_vector(63 downto 0);

    signal lane_3_header_valid_in  : std_logic;
    signal lane_3_header_in        : std_logic_vector(1 downto 0);
    signal lane_3_data_valid_in    : std_logic;
    signal lane_3_data_in          : std_logic_vector(63 downto 0);

    signal pcs_0_data_out : std_logic_vector(63 downto 0);
    signal pcs_1_data_out : std_logic_vector(63 downto 0);
    signal pcs_2_data_out : std_logic_vector(63 downto 0);
    signal pcs_3_data_out : std_logic_vector(63 downto 0);

    signal pcs_1_header_out : std_logic_vector(1 downto 0);
    signal pcs_0_header_out : std_logic_vector(1 downto 0);
    signal pcs_2_header_out : std_logic_vector(1 downto 0);
    signal pcs_3_header_out : std_logic_vector(1 downto 0);

    signal valid_in : std_logic;

    signal fifo_saida_empty : std_logic;
    signal fifo_saida_full : std_logic;
    signal fifo_saida_almost_f : std_logic;
    signal fifo_saida_almost_e : std_logic;

    signal read_as_mac  : std_logic;
    signal pause_read   : std_logic;
    signal mac_eop_wire : std_logic_vector(4 downto 0);
    signal mac_data_wire: std_logic_vector(127 downto 0);
    signal mac_sop_wire: std_logic;
    signal mac_val_wire: std_logic;

    -- signal rx_lane_skew_0 : std_logic;
    -- signal rx_lane_skew_1 : std_logic;
    -- signal rx_lane_skew_2 : std_logic;
    -- signal rx_lane_skew_3 : std_logic;
begin
          clk_156 <= clock_in156;
          clk_161 <= clock_in161;
          clk_312 <= clock_in312;

          mac_eop <= mac_eop_wire;
          mac_data <= mac_data_wire;
          mac_sop <= mac_sop_wire;
          mac_val <= mac_val_wire;

          reset_in_pcs <= '0', '1' after 40 ns;

          start_fifo <= '0', '1' after 600 ns;

          -- read_fifo <= '0', '1' after 400 ns; -- original
          read_fifo <= '0', '1' after 600 ns;

          -- read_as_mac <= read_fifo when fifo_saida_empty = '0' else '0';
          read_as_mac <= '1' when pause_read = '0' else '0';

          fake_consumer: process(reset_in_pcs, clk_312)
          begin
            if reset_in_pcs = '0' then
                pause_read <= '0';
            elsif clk_312'event and clk_312 = '1' then
              if fifo_saida_almost_e = '1' then
                if mac_eop_wire /= "00000" then
                  pause_read <= '1';
                end if;
              else
                pause_read <= '0';
              end if;

            end if;
          end process;

          valid_in <= '0', '1' after 127 ns;

          lane_0_header_valid_in  <= rx_lane_0_header_valid_in;
          lane_0_data_valid_in    <= rx_lane_0_data_valid_in;
          lane_1_header_valid_in  <= rx_lane_1_header_valid_in;
          lane_1_data_valid_in    <= rx_lane_1_data_valid_in;
          lane_2_header_valid_in  <= rx_lane_2_header_valid_in;
          lane_2_data_valid_in    <= rx_lane_2_data_valid_in;
          lane_3_header_valid_in  <= rx_lane_3_header_valid_in;
          lane_3_data_valid_in    <= rx_lane_3_data_valid_in;

          -- INST WRAPPER
          inst_wrapper_macpcs: entity work.wrapper_macpcs_rx port map(
            -- Clocks
            clk_156             => clk_156,
            tx_clk_161_13       => clk_161,
            rx_clk_161_13       => clk_161,
            clk_xgmii_rx        => clk_156,
            clk_xgmii_tx        => clk_156,
            clk_312             => clk_312,

            -- Resets
            async_reset_n       => reset_in,
            reset_tx_n          => reset_in_pcs,
            reset_rx_n          => reset_in_pcs,
            reset_tx_done       => reset_in_mii_tx,
            reset_rx_done       => reset_in_mii_rx,

            -- For testbench use only
            start_fifo => start_fifo,

            dump_xgmii_rxc_0 => dump_xgmii_rxc_0,
            dump_xgmii_rxd_0 => dump_xgmii_rxd_0,
            dump_xgmii_rxc_1 => dump_xgmii_rxc_1,
            dump_xgmii_rxd_1 => dump_xgmii_rxd_1,
            dump_xgmii_rxc_2 => dump_xgmii_rxc_2,
            dump_xgmii_rxd_2 => dump_xgmii_rxd_2,
            dump_xgmii_rxc_3 => dump_xgmii_rxc_3,
            dump_xgmii_rxd_3 => dump_xgmii_rxd_3,

            -- PCS IN
            rx_lane_0_header_valid_in    => lane_0_header_valid_in,
            rx_lane_0_data_valid_in      => lane_0_data_valid_in,
            rx_lane_0_header_in          => rx_lane_0_header_in,
            rx_lane_0_data_in            => rx_lane_0_data_in,

            rx_lane_1_header_valid_in    => lane_1_header_valid_in,
            rx_lane_1_data_valid_in      => lane_1_data_valid_in,
            rx_lane_1_header_in          => rx_lane_1_header_in,
            rx_lane_1_data_in            => rx_lane_1_data_in,

            rx_lane_2_header_valid_in    => lane_2_header_valid_in,
            rx_lane_2_data_valid_in      => lane_2_data_valid_in,
            rx_lane_2_header_in          => rx_lane_2_header_in,
            rx_lane_2_data_in            => rx_lane_2_data_in,

            rx_lane_3_header_valid_in    => lane_3_header_valid_in,
            rx_lane_3_data_valid_in      => lane_3_data_valid_in,
            rx_lane_3_header_in          => rx_lane_3_header_in,
            rx_lane_3_data_in            => rx_lane_3_data_in,

            read_fifo                    => read_as_mac,
            empty_fifo                   => fifo_saida_empty,
            full_fifo                    => fifo_saida_full,
            fifo_almost_f                => fifo_saida_almost_f,
            fifo_almost_e                => fifo_saida_almost_e,
            mac_sop                      => mac_sop_wire,
            mac_data                     => mac_data_wire,
            mac_val                      => mac_val_wire,
            mac_eop                      => mac_eop_wire,

            -- PCS OUT
            tx_data_out        => tx_data_out,
            tx_header_out      => tx_header_out,
            rxgearboxslip_out  => rxgearboxslip_out,
            tx_sequence_out    => tx_sequence_out,

            -- MAC
            pkt_rx_data     => pkt_rx_data,
            pkt_rx_avail    => pkt_rx_avail,
            pkt_rx_eop      => pkt_rx_eop,
            pkt_rx_err      => pkt_rx_err,
            pkt_rx_mod      => pkt_rx_mod,
            pkt_rx_sop      => pkt_rx_sop,
            pkt_rx_val      => pkt_rx_val,
            pkt_tx_full     => pkt_tx_full,

           -- MAC Outputs
            pkt_rx_ren      => '0',
            pkt_tx_data     => pkt_tx_data,
            pkt_tx_eop      => pkt_tx_eop,
            pkt_tx_mod      => pkt_tx_mod,
            pkt_tx_sop      => pkt_tx_sop,
            pkt_tx_val      => pkt_tx_val,

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

end behav;
