--////////////////////////////////////////////////////////////////////////
--////                                                                ////
--//// File name "tx_arch.vhd"                                        ////
--////                                                                ////
--//// This file is part of "Testset X40G" project                    ////
--////                                                                ////
--//// Author(s):                                                     ////
--//// - Matheus Lemes Ferronato                                      ////
--//// - Gabriel Susin                                                ////
--////                                                                ////
--////////////////////////////////////////////////////////////////////////

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity TX_ARCH is
    port
    (
    --###############################################
    --######STANDART PORTS###########################
    --###############################################

      clk_156                : in  std_logic; -- Clock 156.25 MHz
      tx_clk161              : in std_logic;
      clk_312                : in  std_logic; -- Clock 312 MHz
      clk_312_n              : in  std_logic; -- Clock 312 MHz
      rst_n                  : in  std_logic; -- Reset (Active High);
      async_reset_n          : in  std_logic; -- Reset (Active High);
      reset_tx_n             : in  std_logic; -- Reset (Active High);
      reset_rx_n             : in  std_logic; -- Reset (Active High);
      tester_reset           : in std_logic;

      --FROM INTERFACE
      loop_select            : in std_logic;
      mac_source             : in  std_logic_vector(47 downto 0); -- MAC source address

      --FROM REC
      rec_mac_source_rx      : in  std_logic_vector(47 downto 0);
      rec_mac_destination_rx : in  std_logic_vector(47 downto 0);
      rec_ip_source_rx       : in  std_logic_vector(31 downto 0);
      rec_ip_destination_rx  : in  std_logic_vector(31 downto 0);

      --###############################################
      --######GEN PORTS################################
      --###############################################
      -- Control Signals
      start                  : in  std_logic;  -- Enable the packet generation

      --LFSR Initialization
      lfsr_seed              : in std_logic_vector(255 downto 0);
      valid_seed             : in std_logic;
      lfsr_polynomial        : in std_logic_vector(1 downto 0);

      -- Settings
      mac_destination        : in  std_logic_vector(47 downto 0); -- MAC destination address
      ip_source              : in  std_logic_vector(31 downto 0); -- IP source address
      ip_destination         : in  std_logic_vector(31 downto 0); -- IP destination address
      packet_length          : in  std_logic_vector(15 downto 0); -- Packet size:  "000" - 64B, "001" - 128B, "010" - 256B, "011" - 512B,
                                                               --               "100" - 768B, "101" - 1024B, "110" - 1280B, "111" - 1518B
      timestamp_base         : in  std_logic_vector(47 downto 0);
      time_stamp_flag        : in  std_logic; -- If the timestamp is needed in the latency test, first bit of payload is '1'

      -- TX mac interface
      pkt_tx_full            : in  std_logic;                     -- Informs if xMAC tx buffer is full
      payload_type           : in std_logic_vector(1 downto 0);
      payload_cycles         : in std_logic_vector(31 downto 0);

      --###############################################
      --######LOOPBACK PORTS###########################
      --###############################################    -- When asserted, the packet transfer will begin on next cycle. Should remain asserted until EOP.
      pkt_rx_avail_in       : in  std_logic;
      pkt_rx_eop_in         : in  std_logic;
      pkt_rx_sop_in         : in  std_logic;
      pkt_rx_val_in         : in  std_logic;
      pkt_rx_err_in         : in  std_logic;
      pkt_rx_data_in        : in  std_logic_vector(127 downto 0);
      pkt_rx_mod_in         : in  std_logic_vector(3 downto 0);

      mac_filter            : in  std_logic_vector(2 downto 0);
      -- 000 inverts mac source and mac target and receives just packets in broadcast or intended for its mac
      -- 001 does not invert mac source and mac target and receives just packets in broadcast or intended for its mac
      -- 010 inverts mac source and mac target and operates in promiscous mode
      -- 011 does not invert mac source and mac target and operates in promiscous mode


      --###############################################
      --######TX_PATH##################################
      --###############################################
  -- PCS CORE
    --INPUTS
      seed_A           : in std_logic_vector(57 downto 0);
      seed_B           : in std_logic_vector(57 downto 0);
      bypass_66encoder : in std_logic;
      bypass_scram     : in std_logic;
      tx_jtm_en        : in std_logic;
      jtm_dps_0        : in std_logic;
      jtm_dps_1        : in std_logic;
      start_fifo       : in std_logic;
      start_fifo_rd    : in std_logic;

    --OUTPUTS

      fill_pcs_tx      : out std_logic_vector(8 downto 0);
      tx_fifo_spill    : out std_logic;

  -- PCS ALIGNMENT
    --OUTPUTS
      tx_data_out_0    : out std_logic_vector (63 downto 0);
      tx_data_out_1    : out std_logic_vector (63 downto 0);
      tx_data_out_2    : out std_logic_vector (63 downto 0);
      tx_data_out_3    : out std_logic_vector (63 downto 0);
      tx_header_out_0  : out std_logic_vector (1 downto 0);
      tx_header_out_1  : out std_logic_vector (1 downto 0);
      tx_header_out_2  : out std_logic_vector (1 downto 0);
      tx_header_out_3  : out std_logic_vector (1 downto 0);
      tx_valid_out_0   : out std_logic;
      tx_valid_out_1   : out std_logic;
      tx_valid_out_2   : out std_logic;
      tx_valid_out_3   : out std_logic;

      pkt_tx_eop_out   : out std_logic;

  -- PKT CREATION
    --OUTPUTS
      mac_source_tx      : out  std_logic_vector(47 downto 0);
      mac_destination_tx : out  std_logic_vector(47 downto 0);
      ip_source_tx       : out  std_logic_vector(31 downto 0);
      ip_destination_tx  : out  std_logic_vector(31 downto 0)

    );
end TX_ARCH;

architecture TX_ARCH of TX_ARCH is
  --###############################################
  --######COMPONENT DECLARATION####################
  --###############################################
component TX_PATHWAY port(
-- Clocks
    clk_156          : in std_logic;
    tx_clk161        : in std_logic;

-- Resets
    async_reset_n    : in std_logic;
    reset_tx_n       : in std_logic;
    reset_rx_n       : in std_logic;

-- MAC
  --INPUTS
    pkt_tx_data      : in std_logic_vector(255 downto 0);
    pkt_tx_mod       : in std_logic_vector(4 downto 0);
    pkt_tx_sop       : in std_logic_vector(1 downto 0);
    pkt_tx_eop       : in std_logic;
    pkt_tx_val       : in std_logic;

-- PCS CORE
  --INPUTS
    seed_A           : in std_logic_vector(57 downto 0);
    seed_B           : in std_logic_vector(57 downto 0);
    bypass_66encoder : in std_logic;
    bypass_scram     : in std_logic;
    tx_jtm_en        : in std_logic;
    jtm_dps_0        : in std_logic;
    jtm_dps_1        : in std_logic;
    start_fifo       : in std_logic;
    start_fifo_rd    : in std_logic;

  --OUTPUTS

    fill_pcs_tx      : out std_logic_vector(8 downto 0);
    tx_fifo_spill    : out std_logic;

-- PCS ALIGNMENT
  --OUTPUTS
    tx_data_out_0    : out std_logic_vector (63 downto 0);
    tx_data_out_1    : out std_logic_vector (63 downto 0);
    tx_data_out_2    : out std_logic_vector (63 downto 0);
    tx_data_out_3    : out std_logic_vector (63 downto 0);
    tx_header_out_0  : out std_logic_vector (1 downto 0);
    tx_header_out_1  : out std_logic_vector (1 downto 0);
    tx_header_out_2  : out std_logic_vector (1 downto 0);
    tx_header_out_3  : out std_logic_vector (1 downto 0);
    tx_valid_out_0   : out std_logic;
    tx_valid_out_1   : out std_logic;
    tx_valid_out_2   : out std_logic;
    tx_valid_out_3   : out std_logic


);
    end component;

    --###############################################
    --######SIGNALS DECLARATION######################
    --###############################################

    signal pkt_tx_data            : std_logic_vector(255 downto 0);
    signal mac_source_out         : std_logic_vector(47 downto 0);
    signal mac_destination_out    : std_logic_vector(47 downto 0);
    signal ip_source_out          : std_logic_vector(31 downto 0);
    signal ip_destination_out     : std_logic_vector(31 downto 0);
    signal pkt_tx_mod             : std_logic_vector(4 downto 0);
    signal pkt_tx_sop             : std_logic_vector(1 downto 0);
    signal pkt_tx_eop             : std_logic;
    signal pkt_tx_val             : std_logic;
begin
    pkt_tx_eop_out <= pkt_tx_eop;

  --###############################################
  --######TX PATH INSTANTIATION####################
  --###############################################
  inst_tx_pathway: TX_PATHWAY port map(
  -- Clocks
      clk_156          => clk_156,
      tx_clk161        => tx_clk161,

  -- Resets
      async_reset_n    => async_reset_n,
      reset_tx_n       => reset_tx_n,
      reset_rx_n       => reset_rx_n,

  -- MAC
    --INPUTS
      pkt_tx_data      => pkt_tx_data,
      pkt_tx_mod       => pkt_tx_mod,
      pkt_tx_sop       => pkt_tx_sop,
      pkt_tx_eop       => pkt_tx_eop,
      pkt_tx_val       => pkt_tx_val,

  -- PCS CORE
    --INPUTS
      seed_A           => seed_A,
      seed_B           => seed_B,
      bypass_66encoder => bypass_66encoder,
      bypass_scram     => bypass_scram,
      tx_jtm_en        => tx_jtm_en,
      jtm_dps_0        => jtm_dps_0,
      jtm_dps_1        => jtm_dps_1,
      start_fifo       => start_fifo,
      start_fifo_rd    => start_fifo_rd,

    --OUTPUTS

      fill_pcs_tx      => fill_pcs_tx,
      tx_fifo_spill    => tx_fifo_spill,

  -- PCS ALIGNMENT
    --OUTPUTS
      tx_data_out_0    => tx_data_out_0,
      tx_data_out_1    => tx_data_out_1,
      tx_data_out_2    => tx_data_out_2,
      tx_data_out_3    => tx_data_out_3,
      tx_header_out_0  => tx_header_out_0,
      tx_header_out_1  => tx_header_out_1,
      tx_header_out_2  => tx_header_out_2,
      tx_header_out_3  => tx_header_out_3,
      tx_valid_out_0   => tx_valid_out_0,
      tx_valid_out_1   => tx_valid_out_1,
      tx_valid_out_2   => tx_valid_out_2,
      tx_valid_out_3   => tx_valid_out_3

  );

  --###############################################
  --######PKT_GENERATION INSTANTIATION#############
  --###############################################

    mac_source_tx      <= mac_source_out;
    mac_destination_tx <= mac_destination_out;
    ip_source_tx       <= ip_source_out;
    ip_destination_tx  <= ip_destination_out;



  inst_pkt_creation_mngr : entity work.pkt_creation_mngr port map (
  --###############################################
  --######STANDART PORTS###########################
  --###############################################

    clk_156                => clk_156,   -- Clock 156.25 MHz
    clk_312                => clk_312,   -- Clock 312 MHz
    clk_312_n              => clk_312_n, -- Clock 312 MHz
    rst_n                  => tester_reset,     -- Reset (Active High);

    --FROM INTERFACE
    loop_select            => loop_select,
    mac_source             => mac_source, -- MAC source address

    --FROM REC
    rec_mac_source_rx      => rec_mac_source_rx,
    rec_mac_destination_rx => rec_mac_destination_rx,
    rec_ip_source_rx       => rec_ip_source_rx,
    rec_ip_destination_rx  => rec_ip_destination_rx,

    --TO MAC
    pkt_tx_data            => pkt_tx_data,   -- Data bus
    pkt_tx_val             => pkt_tx_val,   -- Indicates if the data is valid
    pkt_tx_sop             => pkt_tx_sop,   -- Start of packet flag (sent along with the first frame)
    pkt_tx_eop             => pkt_tx_eop,   -- End of packet flag (sent along with the last frame)
    pkt_tx_mod             => pkt_tx_mod,   -- Module (frame size, only read when eop='1')

    --###############################################
    --######GEN PORTS################################
    --###############################################
    -- Control Signals
    start                  => start,  -- Enable the packet generation

    --LFSR Initialization
    lfsr_seed              => lfsr_seed,
    valid_seed             => valid_seed,
    lfsr_polynomial        => lfsr_polynomial,

    -- Settings
    mac_destination        => mac_destination,  -- MAC destination address
    ip_source              => ip_source,  -- IP source address
    ip_destination         => ip_destination,  -- IP destination address
    packet_length          => packet_length,  -- Packet size:  "000" - 64B, "001" - 128B, "010" - 256B, "011" - 512B,
                                                             --               "100" - 768B, "101" - 1024B, "110" - 1280B, "111" - 1518B
    timestamp_base         => timestamp_base,
    time_stamp_flag        => time_stamp_flag,  -- If the timestamp is needed in the latency test, first bit of payload is '1'

    -- TX mac interface
    pkt_tx_full            => pkt_tx_full,  -- Informs if xMAC tx buffer is full
    payload_type           => payload_type,
    payload_cycles         => payload_cycles,

    --LOOPBACK PORTS
    --###############################################
    --######LOOPBACK PORTS###########################
    --###############################################    -- When asserted,
    pkt_rx_avail_in        => pkt_rx_avail_in,
    pkt_rx_eop_in          => pkt_rx_eop_in,
    pkt_rx_sop_in          => pkt_rx_sop_in,
    pkt_rx_val_in          => pkt_rx_val_in,
    pkt_rx_err_in          => pkt_rx_err_in,
    pkt_rx_data_in         => pkt_rx_data_in,
    pkt_rx_mod_in          => pkt_rx_mod_in,

    mac_filter             => mac_filter,
    -- 000 inverts mac source and mac target and receives just packets in broadcast or intended for its mac
    -- 001 does not invert mac source and mac target and receives just packets in broadcast or intended for its mac
    -- 010 inverts mac source and mac target and operates in promiscous mode
    -- 011 does not invert mac source and mac target and operates in promiscous mode

    --OUTPUT TO INTERFACE

    mac_source_out          => mac_source_out,
    mac_destination_out     => mac_destination_out,
    ip_source_out           => ip_source_out,
    ip_destination_out      => ip_destination_out

  );
end TX_ARCH;
