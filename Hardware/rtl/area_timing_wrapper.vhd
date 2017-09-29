
library ieee;
use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

library xil_defaultlib;
    use xil_defaultlib.common_pkg.all;

entity area_timing_wrapper is
    port
    (
        -- Input Clocks
        Q8_CLK0_GTREFCLK_PAD_N_IN               : in   std_logic;                       -- 156.25 MHz SFP+ Clock N
        Q8_CLK0_GTREFCLK_PAD_P_IN               : in   std_logic;                       -- 156.25 MHz SFP+ Clock P
        SYSCLK_IN_N                             : in   std_logic;                       -- 200.00 MHz System Clock N
        SYSCLK_IN_P                             : in   std_logic;                       -- 200.00 MHz System Clock P

        hi_ber                                  : out  std_logic;
        blk_lock                                : out  std_logic;
        linkstatus                              : out  std_logic;
        rx_fifo_spill                           : out  std_logic;
        tx_fifo_spill                           : out  std_logic;
        rxlf                                    : out  std_logic;
        txlf                                    : out  std_logic;
        ber_cnt                                 : out  std_logic_vector(5 downto 0);
        errd_blks                               : out  std_logic_vector(7 downto 0);
        jtest_errc                              : out  std_logic_vector(15 downto 0);

        tx_data_out                             : out  std_logic_vector(63 downto 0);
        tx_header_out                           : out  std_logic_vector(1 downto 0);
        rxgearboxslip_out                       : out  std_logic;
        tx_sequence_out                         : out  std_logic_vector(6 downto 0);

        mac_sop                                 : out std_logic;
        mac_data                                : out std_logic_vector(127 downto 0);
        mac_eop                                 : out std_logic_vector(4 downto 0);

        -- Wishbone (MAC)
        wb_adr_i                                : in  std_logic_vector(7 downto 0);
        wb_clk_i                                : in  std_logic;
        wb_cyc_i                                : in  std_logic;
        wb_dat_i                                : in  std_logic_vector(31 downto 0);
        wb_stb_i                                : in  std_logic;
        wb_we_i                                 : in  std_logic;

        -- XMAC Outputs
        pkt_rx_avail                            : out  std_logic;
        pkt_rx_data                             : out  std_logic_vector(63 downto 0);
        pkt_rx_eop                              : out  std_logic;
        pkt_rx_err                              : out  std_logic;
        pkt_rx_mod                              : out  std_logic_vector(2 downto 0);
        pkt_rx_sop                              : out  std_logic;
        pkt_rx_val                              : out  std_logic;
        pkt_tx_full                             : out  std_logic
    );

end area_timing_wrapper;

architecture top of area_timing_wrapper is

  CONSTANT BIT_0  : STD_LOGIC:= '0';

  component wrapper_macpcs_rx port(
          -- Clocks
          clk_156             : in  std_logic;
          tx_clk_161_13       : in  std_logic;
          rx_clk_161_13       : in  std_logic;
          clk_xgmii_rx        : in  std_logic;
          clk_xgmii_tx        : in  std_logic;
          clk_312             : in  std_logic;

          -- Resets
          async_reset_n       : in  std_logic;
          reset_tx_n          : in std_logic;
          reset_rx_n          : in std_logic;
          reset_tx_done       : in std_logic;
          reset_rx_done       : in std_logic;

          start_fifo          : in std_logic;
          dump_xgmii_rxc_0    : out std_logic_vector(7 downto 0);
          dump_xgmii_rxd_0    : out std_logic_vector(63 downto 0);
          dump_xgmii_rxc_1    : out std_logic_vector(7 downto 0);
          dump_xgmii_rxd_1    : out std_logic_vector(63 downto 0);
          dump_xgmii_rxc_2    : out std_logic_vector(7 downto 0);
          dump_xgmii_rxd_2    : out std_logic_vector(63 downto 0);
          dump_xgmii_rxc_3    : out std_logic_vector(7 downto 0);
          dump_xgmii_rxd_3    : out std_logic_vector(63 downto 0);

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

          rx_lane_0_header_valid_in    : in  std_logic;
          rx_lane_0_header_in          : in  std_logic_vector(1 downto 0);
          rx_lane_0_data_valid_in      : in  std_logic;
          rx_lane_0_data_in            : in  std_logic_vector(63 downto 0);

          rx_lane_1_header_valid_in    : in  std_logic;
          rx_lane_1_header_in          : in  std_logic_vector(1 downto 0);
          rx_lane_1_data_valid_in      : in  std_logic;
          rx_lane_1_data_in            : in  std_logic_vector(63 downto 0);

          rx_lane_2_header_valid_in    : in  std_logic;
          rx_lane_2_header_in          : in  std_logic_vector(1 downto 0);
          rx_lane_2_data_valid_in      : in  std_logic;
          rx_lane_2_data_in            : in  std_logic_vector(63 downto 0);

          rx_lane_3_header_valid_in    : in  std_logic;
          rx_lane_3_header_in          : in  std_logic_vector(1 downto 0);
          rx_lane_3_data_valid_in      : in  std_logic;
          rx_lane_3_data_in            : in  std_logic_vector(63 downto 0);

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
          --
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

          mac_sop             : out std_logic;
          mac_data            : out std_logic_vector(127 downto 0);
          mac_eop             : out std_logic_vector(4 downto 0);

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

  component gtwizard_0_support
      generic
      (
          -- Simulation attributes
          EXAMPLE_SIM_GTRESET_SPEEDUP    : string    := "FALSE";    -- Set to TRUE to speed up sim reset
          STABLE_CLOCK_PERIOD            : integer   := 10
      );
      port
      (
          SOFT_RESET_TX_IN                        : in   std_logic;
          SOFT_RESET_RX_IN                        : in   std_logic;
          DONT_RESET_ON_DATA_ERROR_IN             : in   std_logic;
          Q8_CLK0_GTREFCLK_PAD_N_IN               : in   std_logic;
          Q8_CLK0_GTREFCLK_PAD_P_IN               : in   std_logic;

          Q8_CLK0_GTREFCLK_OUT                    : out  std_logic;
          GT0_TX_FSM_RESET_DONE_OUT               : out  std_logic;
          GT0_RX_FSM_RESET_DONE_OUT               : out  std_logic;
          GT0_DATA_VALID_IN                       : in   std_logic;
          GT0_TX_MMCM_LOCK_OUT                    : out  std_logic;
          GT0_RX_MMCM_LOCK_OUT                    : out  std_logic;
          GT1_TX_FSM_RESET_DONE_OUT               : out  std_logic;
          GT1_RX_FSM_RESET_DONE_OUT               : out  std_logic;
          GT1_DATA_VALID_IN                       : in   std_logic;
          GT1_TX_MMCM_LOCK_OUT                    : out  std_logic;
          GT1_RX_MMCM_LOCK_OUT                    : out  std_logic;
          GT2_TX_FSM_RESET_DONE_OUT               : out  std_logic;
          GT2_RX_FSM_RESET_DONE_OUT               : out  std_logic;
          GT2_DATA_VALID_IN                       : in   std_logic;
          GT2_TX_MMCM_LOCK_OUT                    : out  std_logic;
          GT2_RX_MMCM_LOCK_OUT                    : out  std_logic;
          GT3_TX_FSM_RESET_DONE_OUT               : out  std_logic;
          GT3_RX_FSM_RESET_DONE_OUT               : out  std_logic;
          GT3_DATA_VALID_IN                       : in   std_logic;
          GT3_TX_MMCM_LOCK_OUT                    : out  std_logic;
          GT3_RX_MMCM_LOCK_OUT                    : out  std_logic;

          GT0_TXUSRCLK_OUT                        : out  std_logic;
          GT0_TXUSRCLK2_OUT                       : out  std_logic;
          GT0_RXUSRCLK_OUT                        : out  std_logic;
          GT0_RXUSRCLK2_OUT                       : out  std_logic;

          GT1_TXUSRCLK_OUT                        : out  std_logic;
          GT1_TXUSRCLK2_OUT                       : out  std_logic;
          GT1_RXUSRCLK_OUT                        : out  std_logic;
          GT1_RXUSRCLK2_OUT                       : out  std_logic;

          GT2_TXUSRCLK_OUT                        : out  std_logic;
          GT2_TXUSRCLK2_OUT                       : out  std_logic;
          GT2_RXUSRCLK_OUT                        : out  std_logic;
          GT2_RXUSRCLK2_OUT                       : out  std_logic;

          GT3_TXUSRCLK_OUT                        : out  std_logic;
          GT3_TXUSRCLK2_OUT                       : out  std_logic;
          GT3_RXUSRCLK_OUT                        : out  std_logic;
          GT3_RXUSRCLK2_OUT                       : out  std_logic;
          --_________________________________________________________________________
          --_________________________________________________________________________
          --GT0  (X1Y36)
          --____________________________CHANNEL PORTS________________________________
          ------------------------------- Loopback Ports -----------------------------
          gt0_loopback_in                         : in   std_logic_vector(2 downto 0);
          --------------------- RX Initialization and Reset Ports --------------------
          gt0_eyescanreset_in                     : in   std_logic;
          gt0_rxuserrdy_in                        : in   std_logic;
          -------------------------- RX Margin Analysis Ports ------------------------
          gt0_eyescandataerror_out                : out  std_logic;
          gt0_eyescantrigger_in                   : in   std_logic;
          ------------------- Receive Ports - Digital Monitor Ports ------------------
          gt0_dmonitorout_out                     : out  std_logic_vector(14 downto 0);
          ------------------ Receive Ports - FPGA RX interface Ports -----------------
          gt0_rxdata_out                          : out  std_logic_vector(63 downto 0);
          ------------------- Receive Ports - Pattern Checker Ports ------------------
          gt0_rxprbserr_out                       : out  std_logic;
          gt0_rxprbssel_in                        : in   std_logic_vector(2 downto 0);
          ------------------- Receive Ports - Pattern Checker ports ------------------
          gt0_rxprbscntreset_in                   : in   std_logic;
          ------------------------ Receive Ports - RX AFE Ports ----------------------
          gt0_gthrxn_in                           : in   std_logic;
          --------------------- Receive Ports - RX Equalizer Ports -------------------
          gt0_rxmonitorout_out                    : out  std_logic_vector(6 downto 0);
          gt0_rxmonitorsel_in                     : in   std_logic_vector(1 downto 0);
          ---------------------- Receive Ports - RX Gearbox Ports --------------------
          gt0_rxdatavalid_out                     : out  std_logic;
          gt0_rxheader_out                        : out  std_logic_vector(1 downto 0);
          gt0_rxheadervalid_out                   : out  std_logic;
          --------------------- Receive Ports - RX Gearbox Ports  --------------------
          gt0_rxgearboxslip_in                    : in   std_logic;
          ------------- Receive Ports - RX Initialization and Reset Ports ------------
          gt0_gtrxreset_in                        : in   std_logic;
          ------------------------ Receive Ports -RX AFE Ports -----------------------
          gt0_gthrxp_in                           : in   std_logic;
          -------------- Receive Ports -RX Initialization and Reset Ports ------------
          gt0_rxresetdone_out                     : out  std_logic;
          --------------------- TX Initialization and Reset Ports --------------------
          gt0_gttxreset_in                        : in   std_logic;
          gt0_txuserrdy_in                        : in   std_logic;
          -------------- Transmit Ports - 64b66b and 64b67b Gearbox Ports ------------
          gt0_txheader_in                         : in   std_logic_vector(1 downto 0);
          ------------------ Transmit Ports - Pattern Generator Ports ----------------
          gt0_txprbsforceerr_in                   : in   std_logic;
          ------------------ Transmit Ports - TX Data Path interface -----------------
          gt0_txdata_in                           : in   std_logic_vector(63 downto 0);
          ---------------- Transmit Ports - TX Driver and OOB signaling --------------
          gt0_gthtxn_out                          : out  std_logic;
          gt0_gthtxp_out                          : out  std_logic;
          ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
          gt0_txoutclkfabric_out                  : out  std_logic;
          gt0_txoutclkpcs_out                     : out  std_logic;
          --------------------- Transmit Ports - TX Gearbox Ports --------------------
          gt0_txsequence_in                       : in   std_logic_vector(6 downto 0);
          ------------- Transmit Ports - TX Initialization and Reset Ports -----------
          gt0_txresetdone_out                     : out  std_logic;
          ------------------ Transmit Ports - pattern Generator Ports ----------------
          gt0_txprbssel_in                        : in   std_logic_vector(2 downto 0);

          --_________________________________________________________________________
          --_________________________________________________________________________
          --GT1  (X1Y37)
          --____________________________CHANNEL PORTS________________________________
          ------------------------------- Loopback Ports -----------------------------
          gt1_loopback_in                         : in   std_logic_vector(2 downto 0);
          --------------------- RX Initialization and Reset Ports --------------------
          gt1_eyescanreset_in                     : in   std_logic;
          gt1_rxuserrdy_in                        : in   std_logic;
          -------------------------- RX Margin Analysis Ports ------------------------
          gt1_eyescandataerror_out                : out  std_logic;
          gt1_eyescantrigger_in                   : in   std_logic;
          ------------------- Receive Ports - Digital Monitor Ports ------------------
          gt1_dmonitorout_out                     : out  std_logic_vector(14 downto 0);
          ------------------ Receive Ports - FPGA RX interface Ports -----------------
          gt1_rxdata_out                          : out  std_logic_vector(63 downto 0);
          ------------------- Receive Ports - Pattern Checker Ports ------------------
          gt1_rxprbserr_out                       : out  std_logic;
          gt1_rxprbssel_in                        : in   std_logic_vector(2 downto 0);
          ------------------- Receive Ports - Pattern Checker ports ------------------
          gt1_rxprbscntreset_in                   : in   std_logic;
          ------------------------ Receive Ports - RX AFE Ports ----------------------
          gt1_gthrxn_in                           : in   std_logic;
          --------------------- Receive Ports - RX Equalizer Ports -------------------
          gt1_rxmonitorout_out                    : out  std_logic_vector(6 downto 0);
          gt1_rxmonitorsel_in                     : in   std_logic_vector(1 downto 0);
          ---------------------- Receive Ports - RX Gearbox Ports --------------------
          gt1_rxdatavalid_out                     : out  std_logic;
          gt1_rxheader_out                        : out  std_logic_vector(1 downto 0);
          gt1_rxheadervalid_out                   : out  std_logic;
          --------------------- Receive Ports - RX Gearbox Ports  --------------------
          gt1_rxgearboxslip_in                    : in   std_logic;
          ------------- Receive Ports - RX Initialization and Reset Ports ------------
          gt1_gtrxreset_in                        : in   std_logic;
          ------------------------ Receive Ports -RX AFE Ports -----------------------
          gt1_gthrxp_in                           : in   std_logic;
          -------------- Receive Ports -RX Initialization and Reset Ports ------------
          gt1_rxresetdone_out                     : out  std_logic;
          --------------------- TX Initialization and Reset Ports --------------------
          gt1_gttxreset_in                        : in   std_logic;
          gt1_txuserrdy_in                        : in   std_logic;
          -------------- Transmit Ports - 64b66b and 64b67b Gearbox Ports ------------
          gt1_txheader_in                         : in   std_logic_vector(1 downto 0);
          ------------------ Transmit Ports - Pattern Generator Ports ----------------
          gt1_txprbsforceerr_in                   : in   std_logic;
          ------------------ Transmit Ports - TX Data Path interface -----------------
          gt1_txdata_in                           : in   std_logic_vector(63 downto 0);
          ---------------- Transmit Ports - TX Driver and OOB signaling --------------
          gt1_gthtxn_out                          : out  std_logic;
          gt1_gthtxp_out                          : out  std_logic;
          ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
          gt1_txoutclkfabric_out                  : out  std_logic;
          gt1_txoutclkpcs_out                     : out  std_logic;
          --------------------- Transmit Ports - TX Gearbox Ports --------------------
          gt1_txsequence_in                       : in   std_logic_vector(6 downto 0);
          ------------- Transmit Ports - TX Initialization and Reset Ports -----------
          gt1_txresetdone_out                     : out  std_logic;
          ------------------ Transmit Ports - pattern Generator Ports ----------------
          gt1_txprbssel_in                        : in   std_logic_vector(2 downto 0);

             --_________________________________________________________________________
          --_________________________________________________________________________
          --GT3  (X1Y38)
          --____________________________CHANNEL PORTS________________________________
          ------------------------------- Loopback Ports -----------------------------
          gt2_loopback_in                         : in   std_logic_vector(2 downto 0);
          --------------------- RX Initialization and Reset Ports --------------------
          gt2_eyescanreset_in                     : in   std_logic;
          gt2_rxuserrdy_in                        : in   std_logic;
          -------------------------- RX Margin Analysis Ports ------------------------
          gt2_eyescandataerror_out                : out  std_logic;
          gt2_eyescantrigger_in                   : in   std_logic;
          ------------------- Receive Ports - Digital Monitor Ports ------------------
          gt2_dmonitorout_out                     : out  std_logic_vector(14 downto 0);
          ------------------ Receive Ports - FPGA RX interface Ports -----------------
          gt2_rxdata_out                          : out  std_logic_vector(63 downto 0);
          ------------------- Receive Ports - Pattern Checker Ports ------------------
          gt2_rxprbserr_out                       : out  std_logic;
          gt2_rxprbssel_in                        : in   std_logic_vector(2 downto 0);
          ------------------- Receive Ports - Pattern Checker ports ------------------
          gt2_rxprbscntreset_in                   : in   std_logic;
          ------------------------ Receive Ports - RX AFE Ports ----------------------
          gt2_gthrxn_in                           : in   std_logic;
          --------------------- Receive Ports - RX Equalizer Ports -------------------
          gt2_rxmonitorout_out                    : out  std_logic_vector(6 downto 0);
          gt2_rxmonitorsel_in                     : in   std_logic_vector(1 downto 0);
          ---------------------- Receive Ports - RX Gearbox Ports --------------------
          gt2_rxdatavalid_out                     : out  std_logic;
          gt2_rxheader_out                        : out  std_logic_vector(1 downto 0);
          gt2_rxheadervalid_out                   : out  std_logic;
          --------------------- Receive Ports - RX Gearbox Ports  --------------------
          gt2_rxgearboxslip_in                    : in   std_logic;
          ------------- Receive Ports - RX Initialization and Reset Ports ------------
          gt2_gtrxreset_in                        : in   std_logic;
          ------------------------ Receive Ports -RX AFE Ports -----------------------
          gt2_gthrxp_in                           : in   std_logic;
          -------------- Receive Ports -RX Initialization and Reset Ports ------------
          gt2_rxresetdone_out                     : out  std_logic;
          --------------------- TX Initialization and Reset Ports --------------------
          gt2_gttxreset_in                        : in   std_logic;
          gt2_txuserrdy_in                        : in   std_logic;
          -------------- Transmit Ports - 64b66b and 64b67b Gearbox Ports ------------
          gt2_txheader_in                         : in   std_logic_vector(1 downto 0);
          ------------------ Transmit Ports - Pattern Generator Ports ----------------
          gt2_txprbsforceerr_in                   : in   std_logic;
          ------------------ Transmit Ports - TX Data Path interface -----------------
          gt2_txdata_in                           : in   std_logic_vector(63 downto 0);
          ---------------- Transmit Ports - TX Driver and OOB signaling --------------
          gt2_gthtxn_out                          : out  std_logic;
          gt2_gthtxp_out                          : out  std_logic;
          ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
          gt2_txoutclkfabric_out                  : out  std_logic;
          gt2_txoutclkpcs_out                     : out  std_logic;
          --------------------- Transmit Ports - TX Gearbox Ports --------------------
          gt2_txsequence_in                       : in   std_logic_vector(6 downto 0);
          ------------- Transmit Ports - TX Initialization and Reset Ports -----------
          gt2_txresetdone_out                     : out  std_logic;
          ------------------ Transmit Ports - pattern Generator Ports ----------------
          gt2_txprbssel_in                        : in   std_logic_vector(2 downto 0);
          --_________________________________________________________________________
          --_________________________________________________________________________
          --GT3  (X1Y39)
          --____________________________CHANNEL PORTS________________________________
          ------------------------------- Loopback Ports -----------------------------
          gt3_loopback_in                         : in   std_logic_vector(2 downto 0);
          --------------------- RX Initialization and Reset Ports --------------------
          gt3_eyescanreset_in                     : in   std_logic;
          gt3_rxuserrdy_in                        : in   std_logic;
          -------------------------- RX Margin Analysis Ports ------------------------
          gt3_eyescandataerror_out                : out  std_logic;
          gt3_eyescantrigger_in                   : in   std_logic;
          ------------------- Receive Ports - Digital Monitor Ports ------------------
          gt3_dmonitorout_out                     : out  std_logic_vector(14 downto 0);
          ------------------ Receive Ports - FPGA RX interface Ports -----------------
          gt3_rxdata_out                          : out  std_logic_vector(63 downto 0);
          ------------------- Receive Ports - Pattern Checker Ports ------------------
          gt3_rxprbserr_out                       : out  std_logic;
          gt3_rxprbssel_in                        : in   std_logic_vector(2 downto 0);
          ------------------- Receive Ports - Pattern Checker ports ------------------
          gt3_rxprbscntreset_in                   : in   std_logic;
          ------------------------ Receive Ports - RX AFE Ports ----------------------
          gt3_gthrxn_in                           : in   std_logic;
          --------------------- Receive Ports - RX Equalizer Ports -------------------
          gt3_rxmonitorout_out                    : out  std_logic_vector(6 downto 0);
          gt3_rxmonitorsel_in                     : in   std_logic_vector(1 downto 0);
          ---------------------- Receive Ports - RX Gearbox Ports --------------------
          gt3_rxdatavalid_out                     : out  std_logic;
          gt3_rxheader_out                        : out  std_logic_vector(1 downto 0);
          gt3_rxheadervalid_out                   : out  std_logic;
          --------------------- Receive Ports - RX Gearbox Ports  --------------------
          gt3_rxgearboxslip_in                    : in   std_logic;
          ------------- Receive Ports - RX Initialization and Reset Ports ------------
          gt3_gtrxreset_in                        : in   std_logic;
          ------------------------ Receive Ports -RX AFE Ports -----------------------
          gt3_gthrxp_in                           : in   std_logic;
          -------------- Receive Ports -RX Initialization and Reset Ports ------------
          gt3_rxresetdone_out                     : out  std_logic;
          --------------------- TX Initialization and Reset Ports --------------------
          gt3_gttxreset_in                        : in   std_logic;
          gt3_txuserrdy_in                        : in   std_logic;
          -------------- Transmit Ports - 64b66b and 64b67b Gearbox Ports ------------
          gt3_txheader_in                         : in   std_logic_vector(1 downto 0);
          ------------------ Transmit Ports - Pattern Generator Ports ----------------
          gt3_txprbsforceerr_in                   : in   std_logic;
          ------------------ Transmit Ports - TX Data Path interface -----------------
          gt3_txdata_in                           : in   std_logic_vector(63 downto 0);
          ---------------- Transmit Ports - TX Driver and OOB signaling --------------
          gt3_gthtxn_out                          : out  std_logic;
          gt3_gthtxp_out                          : out  std_logic;
          ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
          gt3_txoutclkfabric_out                  : out  std_logic;
          gt3_txoutclkpcs_out                     : out  std_logic;
          --------------------- Transmit Ports - TX Gearbox Ports --------------------
          gt3_txsequence_in                       : in   std_logic_vector(6 downto 0);
          ------------- Transmit Ports - TX Initialization and Reset Ports -----------
          gt3_txresetdone_out                     : out  std_logic;
          ------------------ Transmit Ports - pattern Generator Ports ----------------
          gt3_txprbssel_in                        : in   std_logic_vector(2 downto 0);


          --____________________________COMMON PORTS________________________________
          GT0_QPLLLOCK_OUT : out std_logic;
          GT0_QPLLREFCLKLOST_OUT  : out std_logic;
          GT0_QPLLOUTCLK_OUT  : out std_logic;
          GT0_QPLLOUTREFCLK_OUT : out std_logic;
          sysclk_in : in std_logic
      );
      end component;

      --**************************** Wire Declarations ******************************
          -------------------------- GT Wrapper Wires ------------------------------
          --________________________________________________________________________
          --________________________________________________________________________
          --GT0  (X1Y36)

          ------------------------------- Loopback Ports -----------------------------
          signal  gt0_loopback_i                  : std_logic_vector(2 downto 0);
          --------------------- RX Initialization and Reset Ports --------------------
          signal  gt0_eyescanreset_i              : std_logic;
          signal  gt0_rxuserrdy_i                 : std_logic;
          -------------------------- RX Margin Analysis Ports ------------------------
          signal  gt0_eyescandataerror_i          : std_logic;
          signal  gt0_eyescantrigger_i            : std_logic;
          ------------------- Receive Ports - Digital Monitor Ports ------------------
          signal  gt0_dmonitorout_i               : std_logic_vector(14 downto 0);
          ------------------ Receive Ports - FPGA RX interface Ports -----------------
          signal  gt0_rxdata_i                    : std_logic_vector(63 downto 0);
          ------------------- Receive Ports - Pattern Checker Ports ------------------
          signal  gt0_rxprbserr_i                 : std_logic;
          signal  gt0_rxprbssel_i                 : std_logic_vector(2 downto 0);
          ------------------- Receive Ports - Pattern Checker ports ------------------
          signal  gt0_rxprbscntreset_i            : std_logic;
          ------------------------ Receive Ports - RX AFE Ports ----------------------
          signal  gt0_gthrxn_i                    : std_logic;
          --------------------- Receive Ports - RX Equalizer Ports -------------------
          signal  gt0_rxmonitorout_i              : std_logic_vector(6 downto 0);
          signal  gt0_rxmonitorsel_i              : std_logic_vector(1 downto 0);
          --------------- Receive Ports - RX Fabric Output Control Ports -------------
          signal  gt0_rxoutclk_i                  : std_logic;
          ---------------------- Receive Ports - RX Gearbox Ports --------------------
          signal  gt0_rxdatavalid_i               : std_logic;
          signal  gt0_rxheader_i                  : std_logic_vector(1 downto 0);
          signal  gt0_rxheadervalid_i             : std_logic;
          --------------------- Receive Ports - RX Gearbox Ports  --------------------
          signal  gt0_rxgearboxslip_i             : std_logic;
          ------------- Receive Ports - RX Initialization and Reset Ports ------------
          signal  gt0_gtrxreset_i                 : std_logic;
          ------------------------ Receive Ports -RX AFE Ports -----------------------
          signal  gt0_gthrxp_i                    : std_logic;
          -------------- Receive Ports -RX Initialization and Reset Ports ------------
          signal  gt0_rxresetdone_i               : std_logic;
          --------------------- TX Initialization and Reset Ports --------------------
          signal  gt0_gttxreset_i                 : std_logic;
          signal  gt0_txuserrdy_i                 : std_logic;
          -------------- Transmit Ports - 64b66b and 64b67b Gearbox Ports ------------
          signal  gt0_txheader_i                  : std_logic_vector(1 downto 0);
          ------------------ Transmit Ports - Pattern Generator Ports ----------------
          signal  gt0_txprbsforceerr_i            : std_logic;
          ------------------ Transmit Ports - TX Data Path interface -----------------
          signal  gt0_txdata_i                    : std_logic_vector(63 downto 0);
          ---------------- Transmit Ports - TX Driver and OOB signaling --------------
          signal  gt0_gthtxn_i                    : std_logic;
          signal  gt0_gthtxp_i                    : std_logic;
          ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
          signal  gt0_txoutclk_i                  : std_logic;
          signal  gt0_txoutclkfabric_i            : std_logic;
          signal  gt0_txoutclkpcs_i               : std_logic;
          --------------------- Transmit Ports - TX Gearbox Ports --------------------
          signal  gt0_txsequence_i                : std_logic_vector(6 downto 0);
          ------------- Transmit Ports - TX Initialization and Reset Ports -----------
          signal  gt0_txresetdone_i               : std_logic;
          ------------------ Transmit Ports - pattern Generator Ports ----------------
          signal  gt0_txprbssel_i                 : std_logic_vector(2 downto 0);


          --________________________________________________________________________
          --________________________________________________________________________
          --GT1  (X1Y37)

          ------------------------------- Loopback Ports -----------------------------
          signal  gt1_loopback_i                  : std_logic_vector(2 downto 0);
          --------------------- RX Initialization and Reset Ports --------------------
          signal  gt1_eyescanreset_i              : std_logic;
          signal  gt1_rxuserrdy_i                 : std_logic;
          -------------------------- RX Margin Analysis Ports ------------------------
          signal  gt1_eyescandataerror_i          : std_logic;
          signal  gt1_eyescantrigger_i            : std_logic;
          ------------------- Receive Ports - Digital Monitor Ports ------------------
          signal  gt1_dmonitorout_i               : std_logic_vector(14 downto 0);
          ------------------ Receive Ports - FPGA RX interface Ports -----------------
          signal  gt1_rxdata_i                    : std_logic_vector(63 downto 0);
          ------------------- Receive Ports - Pattern Checker Ports ------------------
          signal  gt1_rxprbserr_i                 : std_logic;
          signal  gt1_rxprbssel_i                 : std_logic_vector(2 downto 0);
          ------------------- Receive Ports - Pattern Checker ports ------------------
          signal  gt1_rxprbscntreset_i            : std_logic;
          ------------------------ Receive Ports - RX AFE Ports ----------------------
          signal  gt1_gthrxn_i                    : std_logic;
          --------------------- Receive Ports - RX Equalizer Ports -------------------
          signal  gt1_rxmonitorout_i              : std_logic_vector(6 downto 0);
          signal  gt1_rxmonitorsel_i              : std_logic_vector(1 downto 0);
          --------------- Receive Ports - RX Fabric Output Control Ports -------------
          signal  gt1_rxoutclk_i                  : std_logic;
          ---------------------- Receive Ports - RX Gearbox Ports --------------------
          signal  gt1_rxdatavalid_i               : std_logic;
          signal  gt1_rxheader_i                  : std_logic_vector(1 downto 0);
          signal  gt1_rxheadervalid_i             : std_logic;
          --------------------- Receive Ports - RX Gearbox Ports  --------------------
          signal  gt1_rxgearboxslip_i             : std_logic;
          ------------- Receive Ports - RX Initialization and Reset Ports ------------
          signal  gt1_gtrxreset_i                 : std_logic;
          ------------------------ Receive Ports -RX AFE Ports -----------------------
          signal  gt1_gthrxp_i                    : std_logic;
          -------------- Receive Ports -RX Initialization and Reset Ports ------------
          signal  gt1_rxresetdone_i               : std_logic;
          --------------------- TX Initialization and Reset Ports --------------------
          signal  gt1_gttxreset_i                 : std_logic;
          signal  gt1_txuserrdy_i                 : std_logic;
          -------------- Transmit Ports - 64b66b and 64b67b Gearbox Ports ------------
          signal  gt1_txheader_i                  : std_logic_vector(1 downto 0);
          ------------------ Transmit Ports - Pattern Generator Ports ----------------
          signal  gt1_txprbsforceerr_i            : std_logic;
          ------------------ Transmit Ports - TX Data Path interface -----------------
          signal  gt1_txdata_i                    : std_logic_vector(63 downto 0);
          ---------------- Transmit Ports - TX Driver and OOB signaling --------------
          signal  gt1_gthtxn_i                    : std_logic;
          signal  gt1_gthtxp_i                    : std_logic;
          ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
          signal  gt1_txoutclk_i                  : std_logic;
          signal  gt1_txoutclkfabric_i            : std_logic;
          signal  gt1_txoutclkpcs_i               : std_logic;
          --------------------- Transmit Ports - TX Gearbox Ports --------------------
          signal  gt1_txsequence_i                : std_logic_vector(6 downto 0);
          ------------- Transmit Ports - TX Initialization and Reset Ports -----------
          signal  gt1_txresetdone_i               : std_logic;
          ------------------ Transmit Ports - pattern Generator Ports ----------------
          signal  gt1_txprbssel_i                 : std_logic_vector(2 downto 0);


          --________________________________________________________________________
          --________________________________________________________________________
          --GT2  (X1Y38)

          ------------------------------- Loopback Ports -----------------------------
          signal  gt2_loopback_i                  : std_logic_vector(2 downto 0);
          --------------------- RX Initialization and Reset Ports --------------------
          signal  gt2_eyescanreset_i              : std_logic;
          signal  gt2_rxuserrdy_i                 : std_logic;
          -------------------------- RX Margin Analysis Ports ------------------------
          signal  gt2_eyescandataerror_i          : std_logic;
          signal  gt2_eyescantrigger_i            : std_logic;
          ------------------- Receive Ports - Digital Monitor Ports ------------------
          signal  gt2_dmonitorout_i               : std_logic_vector(14 downto 0);
          ------------------ Receive Ports - FPGA RX interface Ports -----------------
          signal  gt2_rxdata_i                    : std_logic_vector(63 downto 0);
          ------------------- Receive Ports - Pattern Checker Ports ------------------
          signal  gt2_rxprbserr_i                 : std_logic;
          signal  gt2_rxprbssel_i                 : std_logic_vector(2 downto 0);
          ------------------- Receive Ports - Pattern Checker ports ------------------
          signal  gt2_rxprbscntreset_i            : std_logic;
          ------------------------ Receive Ports - RX AFE Ports ----------------------
          signal  gt2_gthrxn_i                    : std_logic;
          --------------------- Receive Ports - RX Equalizer Ports -------------------
          signal  gt2_rxmonitorout_i              : std_logic_vector(6 downto 0);
          signal  gt2_rxmonitorsel_i              : std_logic_vector(1 downto 0);
          --------------- Receive Ports - RX Fabric Output Control Ports -------------
          signal  gt2_rxoutclk_i                  : std_logic;
          ---------------------- Receive Ports - RX Gearbox Ports --------------------
          signal  gt2_rxdatavalid_i               : std_logic;
          signal  gt2_rxheader_i                  : std_logic_vector(1 downto 0);
          signal  gt2_rxheadervalid_i             : std_logic;
          --------------------- Receive Ports - RX Gearbox Ports  --------------------
          signal  gt2_rxgearboxslip_i             : std_logic;
          ------------- Receive Ports - RX Initialization and Reset Ports ------------
          signal  gt2_gtrxreset_i                 : std_logic;
          ------------------------ Receive Ports -RX AFE Ports -----------------------
          signal  gt2_gthrxp_i                    : std_logic;
          -------------- Receive Ports -RX Initialization and Reset Ports ------------
          signal  gt2_rxresetdone_i               : std_logic;
          --------------------- TX Initialization and Reset Ports --------------------
          signal  gt2_gttxreset_i                 : std_logic;
          signal  gt2_txuserrdy_i                 : std_logic;
          -------------- Transmit Ports - 64b66b and 64b67b Gearbox Ports ------------
          signal  gt2_txheader_i                  : std_logic_vector(1 downto 0);
          ------------------ Transmit Ports - Pattern Generator Ports ----------------
          signal  gt2_txprbsforceerr_i            : std_logic;
          ------------------ Transmit Ports - TX Data Path interface -----------------
          signal  gt2_txdata_i                    : std_logic_vector(63 downto 0);
          ---------------- Transmit Ports - TX Driver and OOB signaling --------------
          signal  gt2_gthtxn_i                    : std_logic;
          signal  gt2_gthtxp_i                    : std_logic;
          ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
          signal  gt2_txoutclk_i                  : std_logic;
          signal  gt2_txoutclkfabric_i            : std_logic;
          signal  gt2_txoutclkpcs_i               : std_logic;
          --------------------- Transmit Ports - TX Gearbox Ports --------------------
          signal  gt2_txsequence_i                : std_logic_vector(6 downto 0);
          ------------- Transmit Ports - TX Initialization and Reset Ports -----------
          signal  gt2_txresetdone_i               : std_logic;
          ------------------ Transmit Ports - pattern Generator Ports ----------------
          signal  gt2_txprbssel_i                 : std_logic_vector(2 downto 0);


          --________________________________________________________________________
          --________________________________________________________________________
          --GT3  (X1Y39)

          ------------------------------- Loopback Ports -----------------------------
          signal  gt3_loopback_i                  : std_logic_vector(2 downto 0);
          --------------------- RX Initialization and Reset Ports --------------------
          signal  gt3_eyescanreset_i              : std_logic;
          signal  gt3_rxuserrdy_i                 : std_logic;
          -------------------------- RX Margin Analysis Ports ------------------------
          signal  gt3_eyescandataerror_i          : std_logic;
          signal  gt3_eyescantrigger_i            : std_logic;
          ------------------- Receive Ports - Digital Monitor Ports ------------------
          signal  gt3_dmonitorout_i               : std_logic_vector(14 downto 0);
          ------------------ Receive Ports - FPGA RX interface Ports -----------------
          signal  gt3_rxdata_i                    : std_logic_vector(63 downto 0);
          ------------------- Receive Ports - Pattern Checker Ports ------------------
          signal  gt3_rxprbserr_i                 : std_logic;
          signal  gt3_rxprbssel_i                 : std_logic_vector(2 downto 0);
          ------------------- Receive Ports - Pattern Checker ports ------------------
          signal  gt3_rxprbscntreset_i            : std_logic;
          ------------------------ Receive Ports - RX AFE Ports ----------------------
          signal  gt3_gthrxn_i                    : std_logic;
          --------------------- Receive Ports - RX Equalizer Ports -------------------
          signal  gt3_rxmonitorout_i              : std_logic_vector(6 downto 0);
          signal  gt3_rxmonitorsel_i              : std_logic_vector(1 downto 0);
          --------------- Receive Ports - RX Fabric Output Control Ports -------------
          signal  gt3_rxoutclk_i                  : std_logic;
          ---------------------- Receive Ports - RX Gearbox Ports --------------------
          signal  gt3_rxdatavalid_i               : std_logic;
          signal  gt3_rxheader_i                  : std_logic_vector(1 downto 0);
          signal  gt3_rxheadervalid_i             : std_logic;
          --------------------- Receive Ports - RX Gearbox Ports  --------------------
          signal  gt3_rxgearboxslip_i             : std_logic;
          ------------- Receive Ports - RX Initialization and Reset Ports ------------
          signal  gt3_gtrxreset_i                 : std_logic;
          ------------------------ Receive Ports -RX AFE Ports -----------------------
          signal  gt3_gthrxp_i                    : std_logic;
          -------------- Receive Ports -RX Initialization and Reset Ports ------------
          signal  gt3_rxresetdone_i               : std_logic;
          --------------------- TX Initialization and Reset Ports --------------------
          signal  gt3_gttxreset_i                 : std_logic;
          signal  gt3_txuserrdy_i                 : std_logic;
          -------------- Transmit Ports - 64b66b and 64b67b Gearbox Ports ------------
          signal  gt3_txheader_i                  : std_logic_vector(1 downto 0);
          ------------------ Transmit Ports - Pattern Generator Ports ----------------
          signal  gt3_txprbsforceerr_i            : std_logic;
          ------------------ Transmit Ports - TX Data Path interface -----------------
          signal  gt3_txdata_i                    : std_logic_vector(63 downto 0);
          ---------------- Transmit Ports - TX Driver and OOB signaling --------------
          signal  gt3_gthtxn_i                    : std_logic;
          signal  gt3_gthtxp_i                    : std_logic;
          ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
          signal  gt3_txoutclk_i                  : std_logic;
          signal  gt3_txoutclkfabric_i            : std_logic;
          signal  gt3_txoutclkpcs_i               : std_logic;
          --------------------- Transmit Ports - TX Gearbox Ports --------------------
          signal  gt3_txsequence_i                : std_logic_vector(6 downto 0);
          ------------- Transmit Ports - TX Initialization and Reset Ports -----------
          signal  gt3_txresetdone_i               : std_logic;
          ------------------ Transmit Ports - pattern Generator Ports ----------------
          signal  gt3_txprbssel_i                 : std_logic_vector(2 downto 0);


          --____________________________COMMON PORTS________________________________
          ---------------------- Common Block  - Ref Clock Ports ---------------------
          signal  gt0_gtrefclk1_common_i          : std_logic;
          ------------------------- Common Block - QPLL Ports ------------------------
          signal  gt0_qplllock_i                  : std_logic;
          signal  gt0_qpllrefclklost_i            : std_logic;
          signal  gt0_qpllreset_i                 : std_logic;


          signal gt0_txdata_r : std_logic_vector(63 downto 0);
          signal gt0_rxdata_r : std_logic_vector(63 downto 0);

          signal gt1_txdata_r : std_logic_vector(63 downto 0);
          signal gt1_rxdata_r : std_logic_vector(63 downto 0);

          signal gt2_txdata_r : std_logic_vector(63 downto 0);
          signal gt2_rxdata_r : std_logic_vector(63 downto 0);

          signal gt3_txdata_r : std_logic_vector(63 downto 0);
          signal gt3_rxdata_r : std_logic_vector(63 downto 0);

          signal gt0_txheader_r           :   std_logic_vector(1 downto 0);
          signal gt0_rxheader_r           :   std_logic_vector(1 downto 0);

          signal gt1_txheader_r           :   std_logic_vector(1 downto 0);
          signal gt1_rxheader_r           :   std_logic_vector(1 downto 0);

          signal gt2_txheader_r           :   std_logic_vector(1 downto 0);
          signal gt2_rxheader_r           :   std_logic_vector(1 downto 0);

          signal gt3_txheader_r           :   std_logic_vector(1 downto 0);
          signal gt3_rxheader_r           :   std_logic_vector(1 downto 0);


          ------------------------------- User Clocks ---------------------------------
          signal gt0_txusrclk_i                  : std_logic;
          signal gt0_txusrclk2_i                 : std_logic;
          signal gt0_rxusrclk_i                  : std_logic;
          signal gt0_rxusrclk2_i                 : std_logic;
          signal gt1_txusrclk_i                  : std_logic;
          signal gt1_txusrclk2_i                 : std_logic;
          signal gt1_rxusrclk_i                  : std_logic;
          signal gt1_rxusrclk2_i                 : std_logic;

          signal gt2_txusrclk_i                  : std_logic;
          signal gt2_txusrclk2_i                 : std_logic;
          signal gt2_rxusrclk_i                  : std_logic;
          signal gt2_rxusrclk2_i                 : std_logic;
          signal gt3_txusrclk_i                  : std_logic;
          signal gt3_txusrclk2_i                 : std_logic;
          signal gt3_rxusrclk_i                  : std_logic;
          signal gt3_rxusrclk2_i                 : std_logic;

          signal gt0_txmmcm_lock_i               : std_logic;
          signal gt0_txmmcm_reset_i              : std_logic;
          signal gt0_rxmmcm_lock_i               : std_logic;
          signal gt0_rxmmcm_reset_i              : std_logic;
          signal gt1_txmmcm_lock_i               : std_logic;
          signal gt1_txmmcm_reset_i              : std_logic;
          signal gt1_rxmmcm_lock_i               : std_logic;
          signal gt1_rxmmcm_reset_i              : std_logic;
          signal gt2_txmmcm_lock_i               : std_logic;
          signal gt2_txmmcm_reset_i              : std_logic;
          signal gt2_rxmmcm_lock_i               : std_logic;
          signal gt2_rxmmcm_reset_i              : std_logic;
          signal gt3_txmmcm_lock_i               : std_logic;
          signal gt3_txmmcm_reset_i              : std_logic;
          signal gt3_rxmmcm_lock_i               : std_logic;
          signal gt3_rxmmcm_reset_i              : std_logic;


          --************************** Register Declarations ****************************
          signal  gt0_txfsmresetdone_i            : std_logic;
          signal  gt0_rxfsmresetdone_i            : std_logic;

          signal  gt1_txfsmresetdone_i            : std_logic;
          signal  gt1_rxfsmresetdone_i            : std_logic;

          signal  gt2_txfsmresetdone_i            : std_logic;
          signal  gt2_rxfsmresetdone_i            : std_logic;

          signal  gt3_txfsmresetdone_i            : std_logic;
          signal  gt3_rxfsmresetdone_i            : std_logic;


          ----------------------------- Link Status --------------------------------
          signal  gt0_linkstatus_i                : std_logic;
          signal  gt1_linkstatus_i                : std_logic;
          signal  gt2_linkstatus_i                : std_logic;
          signal  gt3_linkstatus_i                : std_logic;

          ----------------------------- Reference Clocks ----------------------------

          -- RESET
          signal soft_reset_i    : std_logic;
          signal global_reset_i  : std_logic;
          signal reset_i2c, reset_r, reset_r2 : std_logic;

          -- XGETH TESTER SIGNALS
          signal xgeth_waddr       : vector7_type(3 downto 0);
          signal xgeth_wdata       : vector32_type(3 downto 0);
          signal xgeth_raddr       : vector7_type(3 downto 0);
          signal xgeth_rdata       : vector32_type(3 downto 0);
          signal xgeth_wen         : std_logic_vector(3 downto 0);


          -- UART SIGNALS
          signal uart_rxdata_i     : std_logic_vector(7 downto 0);
          signal uart_txdata_i     : std_logic_vector(7 downto 0);
          signal uart_start_i      : std_logic;
          signal uart_busy_i       : std_logic;
          signal uart_available_i  : std_logic;


          --____________________________COMMON PORTS________________________________

          ------------------------- Clock Input Signals ------------------------
          signal sysclk_i                        : std_logic;
          signal sysclk_g_i                      : std_logic;
          signal q8_clk0_refclk_g_i              : std_logic;
          signal q8_clk0_refclk_i                : std_logic;



          ------------------------------- Global Signals -----------------------------
          signal tied_to_ground_i                : std_logic;
          signal tied_to_ground_vec_i            : std_logic_vector(63 downto 0);
          signal tied_to_vcc_i                   : std_logic;
          signal tied_to_vcc_vec_i               : std_logic_vector(7 downto 0);


          signal blink                           : std_logic;
          signal on_frame_sent_1, on_frame_sent_2, on_frame_sent_3, on_frame_sent_4  : std_logic;
          signal on_frame_received_1, on_frame_received_2, on_frame_received_3, on_frame_received_4  : std_logic;
          signal drpclk_i : std_logic;
          signal rd_addr:  std_logic_vector(10 downto 0);
          signal rd_be:  std_logic_vector(3 downto 0);
          signal rd_data:  std_logic_vector(31 downto 0);

          signal wr_addr:  std_logic_vector(10 downto 0);
          signal wr_be:  std_logic_vector(7 downto 0);
          signal wr_data:  std_logic_vector(63 downto 0);
          signal wr_en:  std_logic;
          signal clk_250: std_logic;

          --Interface PCIe - XGETH
          signal wr_addr_inc_out :  std_logic_vector(8 downto 0);
          signal rd_addr_out :  std_logic_vector(8 downto 0);
          signal write_en_out:  std_logic;
          signal post_wr_data_out:  std_logic_vector(31 downto 0);
          signal rd_data_raw_o_in:  std_logic_vector(31 downto 0);
    begin

    inst_wrapper_macpcs: wrapper_macpcs_rx port map(
      -- Clocks
      clk_156             => q8_clk0_refclk_g_i,
      tx_clk_161_13       => gt0_txusrclk2_i,
      rx_clk_161_13       => gt0_txusrclk2_i,
      clk_xgmii_rx        => q8_clk0_refclk_g_i,
      clk_xgmii_tx        => q8_clk0_refclk_g_i,
      -- clk_312             => clk_250,             -- 250 POR ENQUANTO!!!!!
      clk_312             => q8_clk0_refclk_g_i,             -- 250 POR ENQUANTO!!!!!

      -- Resets
      async_reset_n       => not soft_reset_i,
      reset_tx_n          => gt0_txresetdone_i,
      reset_rx_n          => gt0_txresetdone_i,
      reset_tx_done       => gt0_txfsmresetdone_i,
      reset_rx_done       => gt0_txfsmresetdone_i,

      -- For testbench use only
      start_fifo       => BIT_0,
      dump_xgmii_rxc_0 => open,
      dump_xgmii_rxd_0 => open,
      dump_xgmii_rxc_1 => open,
      dump_xgmii_rxd_1 => open,
      dump_xgmii_rxc_2 => open,
      dump_xgmii_rxd_2 => open,
      dump_xgmii_rxc_3 => open,
      dump_xgmii_rxd_3 => open,

      -- PCS IN
      rx_lane_0_header_valid_in    => gt0_rxheadervalid_i,
      rx_lane_0_data_valid_in      => gt0_rxdatavalid_i,
      rx_lane_0_header_in          => gt0_rxheader_i,
      rx_lane_0_data_in            => gt0_rxdata_i,

      rx_lane_1_header_valid_in    => gt1_rxheadervalid_i,
      rx_lane_1_data_valid_in      => gt1_rxdatavalid_i,
      rx_lane_1_header_in          => gt1_rxheader_i,
      rx_lane_1_data_in            => gt1_rxdata_i,

      rx_lane_2_header_valid_in    => gt2_rxheadervalid_i,
      rx_lane_2_data_valid_in      => gt2_rxdatavalid_i,
      rx_lane_2_header_in          => gt2_rxheader_i,
      rx_lane_2_data_in            => gt2_rxdata_i,

      rx_lane_3_header_valid_in    => gt3_rxheadervalid_i,
      rx_lane_3_data_valid_in      => gt3_rxdatavalid_i,
      rx_lane_3_header_in          => gt3_rxheader_i,
      rx_lane_3_data_in            => gt3_rxdata_i,

      -- PCS OUT
      tx_data_out        => tx_data_out,
      tx_header_out      => tx_header_out,
      rxgearboxslip_out  => rxgearboxslip_out,
      tx_sequence_out    => tx_sequence_out,

      -- MAC
      pkt_rx_data     => pkt_rx_data ,
      pkt_rx_avail    => pkt_rx_avail,
      pkt_rx_eop      => pkt_rx_eop  ,
      pkt_rx_err      => pkt_rx_err  ,
      pkt_rx_mod      => pkt_rx_mod  ,
      pkt_rx_sop      => pkt_rx_sop  ,
      pkt_rx_val      => pkt_rx_val  ,
      pkt_tx_full     => pkt_tx_full ,

     -- MAC Outputs
      pkt_rx_ren      => BIT_0,
      pkt_tx_data     => (others=>'0'),
      pkt_tx_eop      => BIT_0,
      pkt_tx_mod      => (others=>'0'),
      pkt_tx_sop      => BIT_0,
      pkt_tx_val      => BIT_0,

      -- PCS Inputs
      rx_jtm_en           => BIT_0,
      bypass_descram      => BIT_0,
      bypass_scram        => BIT_0,
      bypass_66decoder    => BIT_0,
      bypass_66encoder    => BIT_0,
      clear_errblk        => BIT_0,
      clear_ber_cnt       => BIT_0,
      tx_jtm_en           => BIT_0,
      jtm_dps_0           => BIT_0,
      jtm_dps_1           => BIT_0,
      seed_A              => (others=>'0'),
      seed_B              => (others=>'0'),

      -- PCS Outputs
      hi_ber              => hi_ber       ,
      blk_lock            => blk_lock     ,
      linkstatus          => linkstatus   ,
      rx_fifo_spill       => rx_fifo_spill,
      tx_fifo_spill       => tx_fifo_spill,
      rxlf                => rxlf         ,
      txlf                => txlf         ,
      ber_cnt             => ber_cnt      ,
      errd_blks           => errd_blks    ,
      jtest_errc          => jtest_errc   ,

      -- Wishbone Inputs (MAC)
      wb_adr_i            => (others=>'0'),
      wb_clk_i            => BIT_0,
      wb_cyc_i            => BIT_0,
      wb_dat_i            => (others=>'0'),
      wb_stb_i            => BIT_0,
      wb_we_i             => BIT_0,

      -- Wishbone Outputs (MAC)
      wb_ack_o            => open,
      wb_dat_o            => open,
      wb_int_o            => open,

      mac_data => mac_data,
      mac_sop  => mac_sop,
      mac_eop  => mac_eop

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
            elsif rising_edge(sysclk_g_i) then

                if counter < 800 then
                counter := counter + 1;
                end if;
                if counter = 400 then
                    soft_reset_i <= '0';
                elsif
                    counter = 800 then
                end if;
            end if;
        end process;

      gtwizard_0_support_i : gtwizard_0_support
      generic map
      (
          EXAMPLE_SIM_GTRESET_SPEEDUP     =>      "FALSE",
          STABLE_CLOCK_PERIOD             =>      10
      )
      port map
      (
      SOFT_RESET_TX_IN                =>      soft_reset_i,
      SOFT_RESET_RX_IN                =>      soft_reset_i,
      DONT_RESET_ON_DATA_ERROR_IN     =>      tied_to_ground_i,
      Q8_CLK0_GTREFCLK_PAD_N_IN       =>      Q8_CLK0_GTREFCLK_PAD_N_IN,
      Q8_CLK0_GTREFCLK_PAD_P_IN       =>      Q8_CLK0_GTREFCLK_PAD_P_IN,

      Q8_CLK0_GTREFCLK_OUT            =>      q8_clk0_refclk_i,

      GT0_TX_MMCM_LOCK_OUT            =>      gt0_txmmcm_lock_i,
      GT0_RX_MMCM_LOCK_OUT            =>      gt0_rxmmcm_lock_i,
      GT0_TX_FSM_RESET_DONE_OUT       =>      gt0_txfsmresetdone_i,
      GT0_RX_FSM_RESET_DONE_OUT       =>      gt0_rxfsmresetdone_i,
      GT0_DATA_VALID_IN               =>      gt0_linkstatus_i,

      GT1_TX_MMCM_LOCK_OUT            =>      gt1_txmmcm_lock_i,
      GT1_RX_MMCM_LOCK_OUT            =>      gt1_rxmmcm_lock_i,
      GT1_TX_FSM_RESET_DONE_OUT       =>      gt1_txfsmresetdone_i,
      GT1_RX_FSM_RESET_DONE_OUT       =>      gt1_rxfsmresetdone_i,
      GT1_DATA_VALID_IN               =>      gt1_linkstatus_i,

      GT2_TX_MMCM_LOCK_OUT            =>      gt2_txmmcm_lock_i,
      GT2_RX_MMCM_LOCK_OUT            =>      gt2_rxmmcm_lock_i,
      GT2_TX_FSM_RESET_DONE_OUT       =>      gt2_txfsmresetdone_i,
      GT2_RX_FSM_RESET_DONE_OUT       =>      gt2_rxfsmresetdone_i,
      GT2_DATA_VALID_IN               =>      gt2_linkstatus_i,

      GT3_TX_MMCM_LOCK_OUT            =>      gt3_txmmcm_lock_i,
      GT3_RX_MMCM_LOCK_OUT            =>      gt3_rxmmcm_lock_i,
      GT3_TX_FSM_RESET_DONE_OUT       =>      gt3_txfsmresetdone_i,
      GT3_RX_FSM_RESET_DONE_OUT       =>      gt3_rxfsmresetdone_i,
      GT3_DATA_VALID_IN               =>      gt3_linkstatus_i,

      GT0_TXUSRCLK_OUT                =>      gt0_txusrclk_i,
      GT0_TXUSRCLK2_OUT               =>      gt0_txusrclk2_i,
      GT0_RXUSRCLK_OUT                =>      gt0_rxusrclk_i,
      GT0_RXUSRCLK2_OUT               =>      gt0_rxusrclk2_i,

      GT1_TXUSRCLK_OUT                =>      gt1_txusrclk_i,
      GT1_TXUSRCLK2_OUT               =>      gt1_txusrclk2_i,
      GT1_RXUSRCLK_OUT                =>      gt1_rxusrclk_i,
      GT1_RXUSRCLK2_OUT               =>      gt1_rxusrclk2_i,

      GT2_TXUSRCLK_OUT                =>      gt2_txusrclk_i,
      GT2_TXUSRCLK2_OUT               =>      gt2_txusrclk2_i,
      GT2_RXUSRCLK_OUT                =>      gt2_rxusrclk_i,
      GT2_RXUSRCLK2_OUT               =>      gt2_rxusrclk2_i,

      GT3_TXUSRCLK_OUT                =>      gt3_txusrclk_i,
      GT3_TXUSRCLK2_OUT               =>      gt3_txusrclk2_i,
      GT3_RXUSRCLK_OUT                =>      gt3_rxusrclk_i,
      GT3_RXUSRCLK2_OUT               =>      gt3_rxusrclk2_i,

      --_____________________________________________________________________
      --_____________________________________________________________________
      --GT0  (X1Y36)

      ------------------------------- Loopback Ports -----------------------------
      gt0_loopback_in                 =>      gt0_loopback_i,
      --------------------- RX Initialization and Reset Ports --------------------
      gt0_eyescanreset_in             =>      tied_to_ground_i,
      gt0_rxuserrdy_in                =>      tied_to_ground_i,
      -------------------------- RX Margin Analysis Ports ------------------------
      gt0_eyescandataerror_out        =>      gt0_eyescandataerror_i,
      gt0_eyescantrigger_in           =>      tied_to_ground_i,
      ------------------- Receive Ports - Digital Monitor Ports ------------------
      gt0_dmonitorout_out             =>      gt0_dmonitorout_i,
      ------------------ Receive Ports - FPGA RX interface Ports -----------------
      gt0_rxdata_out                  =>      gt0_rxdata_r,
      ------------------- Receive Ports - Pattern Checker Ports ------------------
      gt0_rxprbserr_out               =>      gt0_rxprbserr_i,
      gt0_rxprbssel_in                =>      gt0_rxprbssel_i,
      ------------------- Receive Ports - Pattern Checker ports ------------------
      gt0_rxprbscntreset_in           =>      gt0_rxprbscntreset_i,
      ------------------------ Receive Ports - RX AFE Ports ----------------------
      -- gt0_gthrxn_in                   =>      ETH1_RX_N,
      gt0_gthrxn_in                   =>      '0',
      --------------------- Receive Ports - RX Equalizer Ports -------------------
      gt0_rxmonitorout_out            =>      gt0_rxmonitorout_i,
      gt0_rxmonitorsel_in             =>      gt0_rxmonitorsel_i,
      ---------------------- Receive Ports - RX Gearbox Ports --------------------
      gt0_rxdatavalid_out             =>      gt0_rxdatavalid_i,
      gt0_rxheader_out                =>      gt0_rxheader_r,
      gt0_rxheadervalid_out           =>      gt0_rxheadervalid_i,
      --------------------- Receive Ports - RX Gearbox Ports  --------------------
      gt0_rxgearboxslip_in            =>      gt0_rxgearboxslip_i,
      ------------- Receive Ports - RX Initialization and Reset Ports ------------
      gt0_gtrxreset_in                =>      soft_reset_i,
      ------------------------ Receive Ports -RX AFE Ports -----------------------
      -- gt0_gthrxp_in                   =>      ETH1_RX_P,
      gt0_gthrxp_in                   =>      '0',
      -------------- Receive Ports -RX Initialization and Reset Ports ------------
      gt0_rxresetdone_out             =>      gt0_rxresetdone_i,
      --------------------- TX Initialization and Reset Ports --------------------
      gt0_gttxreset_in                =>      soft_reset_i,
      gt0_txuserrdy_in                =>      tied_to_ground_i,
      -------------- Transmit Ports - 64b66b and 64b67b Gearbox Ports ------------
      gt0_txheader_in                 =>      gt0_txheader_r,
      ------------------ Transmit Ports - Pattern Generator Ports ----------------
      gt0_txprbsforceerr_in           =>      gt0_txprbsforceerr_i,
      ------------------ Transmit Ports - TX Data Path interface -----------------
      gt0_txdata_in                   =>      gt0_txdata_r,
      ---------------- Transmit Ports - TX Driver and OOB signaling --------------
      -- gt0_gthtxn_out                  =>      ETH1_TX_N  ,
      -- gt0_gthtxp_out                  =>      ETH1_TX_P  ,
      gt0_gthtxn_out                  =>      open,
      gt0_gthtxp_out                  =>      open,
      ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
      gt0_txoutclkfabric_out          =>      gt0_txoutclkfabric_i,
      gt0_txoutclkpcs_out             =>      gt0_txoutclkpcs_i,
      --------------------- Transmit Ports - TX Gearbox Ports --------------------
      gt0_txsequence_in               =>      gt0_txsequence_i,
      ------------- Transmit Ports - TX Initialization and Reset Ports -----------
      gt0_txresetdone_out             =>      gt0_txresetdone_i,
      ------------------ Transmit Ports - pattern Generator Ports ----------------
      gt0_txprbssel_in                =>      gt0_txprbssel_i,


      --_____________________________________________________________________
      --_____________________________________________________________________
      --GT1  (X1Y37)

      ------------------------------- Loopback Ports -----------------------------
      gt1_loopback_in                 =>      gt1_loopback_i,
      --------------------- RX Initialization and Reset Ports --------------------
      gt1_eyescanreset_in             =>      tied_to_ground_i,
      gt1_rxuserrdy_in                =>      tied_to_ground_i,
      -------------------------- RX Margin Analysis Ports ------------------------
      gt1_eyescandataerror_out        =>      gt1_eyescandataerror_i,
      gt1_eyescantrigger_in           =>      tied_to_ground_i,
      ------------------- Receive Ports - Digital Monitor Ports ------------------
      gt1_dmonitorout_out             =>      gt1_dmonitorout_i,
      ------------------ Receive Ports - FPGA RX interface Ports -----------------
      gt1_rxdata_out                  =>      gt1_rxdata_r,
      ------------------- Receive Ports - Pattern Checker Ports ------------------
      gt1_rxprbserr_out               =>      gt1_rxprbserr_i,
      gt1_rxprbssel_in                =>      gt1_rxprbssel_i,
      ------------------- Receive Ports - Pattern Checker ports ------------------
      gt1_rxprbscntreset_in           =>      gt1_rxprbscntreset_i,
      ------------------------ Receive Ports - RX AFE Ports ----------------------
      -- gt1_gthrxn_in                   =>      ETH2_RX_N,
      gt1_gthrxn_in                   =>      '0',
      --------------------- Receive Ports - RX Equalizer Ports -------------------
      gt1_rxmonitorout_out            =>      gt1_rxmonitorout_i,
      gt1_rxmonitorsel_in             =>      gt1_rxmonitorsel_i,
      ---------------------- Receive Ports - RX Gearbox Ports --------------------
      gt1_rxdatavalid_out             =>      gt1_rxdatavalid_i,
      gt1_rxheader_out                =>      gt1_rxheader_r,
      gt1_rxheadervalid_out           =>      gt1_rxheadervalid_i,
      --------------------- Receive Ports - RX Gearbox Ports  --------------------
      gt1_rxgearboxslip_in            =>      gt1_rxgearboxslip_i,
      ------------- Receive Ports - RX Initialization and Reset Ports ------------
      gt1_gtrxreset_in                =>      soft_reset_i,
      ------------------------ Receive Ports -RX AFE Ports -----------------------
      -- gt1_gthrxp_in                   =>      ETH2_RX_P,
      gt1_gthrxp_in                   =>      '0',
      -------------- Receive Ports -RX Initialization and Reset Ports ------------
      gt1_rxresetdone_out             =>      gt1_rxresetdone_i,
      --------------------- TX Initialization and Reset Ports --------------------
      gt1_gttxreset_in                =>      soft_reset_i,
      gt1_txuserrdy_in                =>      tied_to_ground_i,
      -------------- Transmit Ports - 64b66b and 64b67b Gearbox Ports ------------
      gt1_txheader_in                 =>      gt1_txheader_r,
      ------------------ Transmit Ports - Pattern Generator Ports ----------------
      gt1_txprbsforceerr_in           =>      gt1_txprbsforceerr_i,
      ------------------ Transmit Ports - TX Data Path interface -----------------
      gt1_txdata_in                   =>      gt1_txdata_r,
      ---------------- Transmit Ports - TX Driver and OOB signaling --------------
      -- gt1_gthtxn_out                  =>      ETH2_TX_N,
      -- gt1_gthtxp_out                  =>      ETH2_TX_P,
      gt1_gthtxn_out                  =>      open,
      gt1_gthtxp_out                  =>      open,
      ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
      gt1_txoutclkfabric_out          =>      gt1_txoutclkfabric_i,
      gt1_txoutclkpcs_out             =>      gt1_txoutclkpcs_i,
      --------------------- Transmit Ports - TX Gearbox Ports --------------------
      gt1_txsequence_in               =>      gt1_txsequence_i,
      ------------- Transmit Ports - TX Initialization and Reset Ports -----------
      gt1_txresetdone_out             =>      gt1_txresetdone_i,
      ------------------ Transmit Ports - pattern Generator Ports ----------------
      gt1_txprbssel_in                =>      gt1_txprbssel_i,


      --_____________________________________________________________________
      --_____________________________________________________________________
      --GT2  (X1Y38)

      ------------------------------- Loopback Ports -----------------------------
      gt2_loopback_in                 =>      gt2_loopback_i,
      --------------------- RX Initialization and Reset Ports --------------------
      gt2_eyescanreset_in             =>      tied_to_ground_i,
      gt2_rxuserrdy_in                =>      tied_to_ground_i,
      -------------------------- RX Margin Analysis Ports ------------------------
      gt2_eyescandataerror_out        =>      gt2_eyescandataerror_i,
      gt2_eyescantrigger_in           =>      tied_to_ground_i,
      ------------------- Receive Ports - Digital Monitor Ports ------------------
      gt2_dmonitorout_out             =>      gt2_dmonitorout_i,
      ------------------ Receive Ports - FPGA RX interface Ports -----------------
      gt2_rxdata_out                  =>      gt2_rxdata_r,
      ------------------- Receive Ports - Pattern Checker Ports ------------------
      gt2_rxprbserr_out               =>      gt2_rxprbserr_i,
      gt2_rxprbssel_in                =>      gt2_rxprbssel_i,
      ------------------- Receive Ports - Pattern Checker ports ------------------
      gt2_rxprbscntreset_in           =>      gt2_rxprbscntreset_i,
      ------------------------ Receive Ports - RX AFE Ports ----------------------
      -- gt2_gthrxn_in                   =>      ETH3_RX_N,
      gt2_gthrxn_in                   =>      '0',
      --------------------- Receive Ports - RX Equalizer Ports -------------------
      gt2_rxmonitorout_out            =>      gt2_rxmonitorout_i,
      gt2_rxmonitorsel_in             =>      gt2_rxmonitorsel_i,
      ---------------------- Receive Ports - RX Gearbox Ports --------------------
      gt2_rxdatavalid_out             =>      gt2_rxdatavalid_i,
      gt2_rxheader_out                =>      gt2_rxheader_r,
      gt2_rxheadervalid_out           =>      gt2_rxheadervalid_i,
      --------------------- Receive Ports - RX Gearbox Ports  --------------------
      gt2_rxgearboxslip_in            =>      gt2_rxgearboxslip_i,
      ------------- Receive Ports - RX Initialization and Reset Ports ------------
      gt2_gtrxreset_in                =>      soft_reset_i,
      ------------------------ Receive Ports -RX AFE Ports -----------------------
      -- gt2_gthrxp_in                   =>      ETH3_RX_P,
      gt2_gthrxp_in                   =>      '0',
      -------------- Receive Ports -RX Initialization and Reset Ports ------------
      gt2_rxresetdone_out             =>      gt2_rxresetdone_i,
      --------------------- TX Initialization and Reset Ports --------------------
      gt2_gttxreset_in                =>      soft_reset_i,
      gt2_txuserrdy_in                =>      tied_to_ground_i,
      -------------- Transmit Ports - 64b66b and 64b67b Gearbox Ports ------------
      gt2_txheader_in                 =>      gt2_txheader_r,
      ------------------ Transmit Ports - Pattern Generator Ports ----------------
      gt2_txprbsforceerr_in           =>      gt2_txprbsforceerr_i,
      ------------------ Transmit Ports - TX Data Path interface -----------------
      gt2_txdata_in                   =>      gt2_txdata_r,
      ---------------- Transmit Ports - TX Driver and OOB signaling --------------
      -- gt2_gthtxn_out                  =>      ETH3_TX_N,
      -- gt2_gthtxp_out                  =>      ETH3_TX_P,
      gt2_gthtxn_out                  =>      open,
      gt2_gthtxp_out                  =>      open,
      ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
      gt2_txoutclkfabric_out          =>      gt2_txoutclkfabric_i,
      gt2_txoutclkpcs_out             =>      gt2_txoutclkpcs_i,
      --------------------- Transmit Ports - TX Gearbox Ports --------------------
      gt2_txsequence_in               =>      gt2_txsequence_i,
      ------------- Transmit Ports - TX Initialization and Reset Ports -----------
      gt2_txresetdone_out             =>      gt2_txresetdone_i,
      ------------------ Transmit Ports - pattern Generator Ports ----------------
      gt2_txprbssel_in                =>      gt2_txprbssel_i,


      --_____________________________________________________________________
      --_____________________________________________________________________
      --GT3  (X1Y39)

      ------------------------------- Loopback Ports -----------------------------
      gt3_loopback_in                 =>      gt3_loopback_i,
      --------------------- RX Initialization and Reset Ports --------------------
      gt3_eyescanreset_in             =>      tied_to_ground_i,
      gt3_rxuserrdy_in                =>      tied_to_ground_i,
      -------------------------- RX Margin Analysis Ports ------------------------
      gt3_eyescandataerror_out        =>      gt3_eyescandataerror_i,
      gt3_eyescantrigger_in           =>      tied_to_ground_i,
      ------------------- Receive Ports - Digital Monitor Ports ------------------
      --gt3_dmonitorout_out             =>      gt3_dmonitorout_i,
      ------------------ Receive Ports - FPGA RX interface Ports -----------------
      gt3_rxdata_out                  =>      gt3_rxdata_r,
      ------------------- Receive Ports - Pattern Checker Ports ------------------
      gt3_rxprbserr_out               =>      gt3_rxprbserr_i,
      gt3_rxprbssel_in                =>      gt3_rxprbssel_i,
      ------------------- Receive Ports - Pattern Checker ports ------------------
      gt3_rxprbscntreset_in           =>      gt3_rxprbscntreset_i,
      ------------------------ Receive Ports - RX AFE Ports ----------------------
      -- gt3_gthrxn_in                   =>      ETH4_RX_N,
      gt3_gthrxn_in                   =>      '0',
      --------------------- Receive Ports - RX Equalizer Ports -------------------
      gt3_rxmonitorout_out            =>      gt3_rxmonitorout_i,
      gt3_rxmonitorsel_in             =>      gt3_rxmonitorsel_i,
      ---------------------- Receive Ports - RX Gearbox Ports --------------------
      gt3_rxdatavalid_out             =>      gt3_rxdatavalid_i,
      gt3_rxheader_out                =>      gt3_rxheader_r,
      gt3_rxheadervalid_out           =>      gt3_rxheadervalid_i,
      --------------------- Receive Ports - RX Gearbox Ports  --------------------
      gt3_rxgearboxslip_in            =>      gt3_rxgearboxslip_i,
      ------------- Receive Ports - RX Initialization and Reset Ports ------------
      gt3_gtrxreset_in                =>      soft_reset_i,
      ------------------------ Receive Ports -RX AFE Ports -----------------------
      -- gt3_gthrxp_in                   =>      ETH4_RX_P,
      gt3_gthrxp_in                   =>      '0',
      -------------- Receive Ports -RX Initialization and Reset Ports ------------
      gt3_rxresetdone_out             =>      gt3_rxresetdone_i,
      --------------------- TX Initialization and Reset Ports --------------------
      gt3_gttxreset_in                =>      soft_reset_i,
      gt3_txuserrdy_in                =>      tied_to_ground_i,
      -------------- Transmit Ports - 64b66b and 64b67b Gearbox Ports ------------
      gt3_txheader_in                 =>      gt3_txheader_r,
      ------------------ Transmit Ports - Pattern Generator Ports ----------------
      gt3_txprbsforceerr_in           =>      gt3_txprbsforceerr_i,
      ------------------ Transmit Ports - TX Data Path interface -----------------
      gt3_txdata_in                   =>      gt3_txdata_r,
      ---------------- Transmit Ports - TX Driver and OOB signaling --------------
      -- gt3_gthtxn_out                  =>      ETH4_TX_N,
      -- gt3_gthtxp_out                  =>      ETH4_TX_P,
      gt3_gthtxn_out                  =>      open,
      gt3_gthtxp_out                  =>      open,
      ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
      gt3_txoutclkfabric_out          =>      gt3_txoutclkfabric_i,
      gt3_txoutclkpcs_out             =>      gt3_txoutclkpcs_i,
      --------------------- Transmit Ports - TX Gearbox Ports --------------------
      gt3_txsequence_in               =>      gt3_txsequence_i,
      ------------- Transmit Ports - TX Initialization and Reset Ports -----------
      gt3_txresetdone_out             =>      gt3_txresetdone_i,
      ------------------ Transmit Ports - pattern Generator Ports ----------------
      gt3_txprbssel_in                =>      gt3_txprbssel_i,


          GT0_QPLLLOCK_OUT => open,
          GT0_QPLLREFCLKLOST_OUT  => open,
          GT0_QPLLOUTCLK_OUT  => open,
          GT0_QPLLOUTREFCLK_OUT => open,
          sysclk_in => q8_clk0_refclk_g_i

      );
end top;
