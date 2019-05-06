--////////////////////////////////////////////////////////////////////////
--////                                                                ////
--//// File name "tester_4xgth.vhd"                                   ////
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
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;


entity TESTER_4XGTH is
port(

  -- CLOCKS

  clk_156             : in std_logic;
  rx_clk161           : in std_logic;
  tx_clk161           : in std_logic;
  clk_250             : in std_logic;
  clk_312             : in std_logic;
  clk_312_n           : in  std_logic; -- Clock 312 MHz
  pkt_rx_avail_in     : in  std_logic;

  --reset

  rst_n               : in  std_logic; -- Reset (Active High);
  async_reset_n       : in std_logic;
  reset_tx_n          : in  std_logic; -- Reset (Active High);
  reset_rx_n          : in  std_logic; -- Reset (Active High);

  -- uPC interface

  xgeth_waddr         : in std_logic_vector(6 downto 0);
  xgeth_wdata         : in std_logic_vector(31 downto 0);
  xgeth_raddr         : in std_logic_vector(6 downto 0);
  xgeth_rdata         : out std_logic_vector(31 downto 0);
  xgeth_wen           : in std_logic;

  eth_rx_los          : in std_logic;

  on_frame_sent       : out std_logic;
  on_frame_received   : out std_logic;
  verify_system       : out std_logic;

  -- RX

--Labe Reorder
--INPUTS
  rx_data_in_0        : in std_logic_vector(63 downto 0);
  rx_data_in_1        : in std_logic_vector(63 downto 0);
  rx_data_in_2        : in std_logic_vector(63 downto 0);
  rx_data_in_3        : in std_logic_vector(63 downto 0);
  rx_header_in_0      : in std_logic_vector(1 downto 0);
  rx_header_in_1      : in std_logic_vector(1 downto 0);
  rx_header_in_2      : in std_logic_vector(1 downto 0);
  rx_header_in_3      : in std_logic_vector(1 downto 0);
  rx_valid_in_0       : in std_logic;
  rx_valid_in_1       : in std_logic;
  rx_valid_in_2       : in std_logic;
  rx_valid_in_3       : in std_logic;

  --PCS_RX
  --inputs
  RDEN_FIFO_PCS40     : in std_logic;
  start_fifo          : in std_logic;
  start_fifo_rd       : in std_logic;
  linkstatus_out      : out std_logic;

  -- TX

  tx_data_out_0       : out std_logic_vector (63 downto 0);
  tx_data_out_1       : out std_logic_vector (63 downto 0);
  tx_data_out_2       : out std_logic_vector (63 downto 0);
  tx_data_out_3       : out std_logic_vector (63 downto 0);
  tx_header_out_0     : out std_logic_vector (1 downto 0);
  tx_header_out_1     : out std_logic_vector (1 downto 0);
  tx_header_out_2     : out std_logic_vector (1 downto 0);
  tx_header_out_3     : out std_logic_vector (1 downto 0);
  tx_valid_out_0      : out std_logic;
  tx_valid_out_1      : out std_logic;
  tx_valid_out_2      : out std_logic;
  tx_valid_out_3      : out std_logic
);
end TESTER_4XGTH;

architecture arch_TESTER_4XGTH of TESTER_4XGTH is

--------------------------
-------------------------STD INPUTS-------------------------------------

 signal soft_reset              : std_logic;
 signal tester_reset            : std_logic;
------------------------------------------------------------------------
signal mac_source               : std_logic_vector(47 downto 0);
signal rec_mac_source_rx        : std_logic_vector(47 downto 0);
signal loop_select              : std_logic := '0';
signal rec_mac_destination_rx   : std_logic_vector(47 downto 0);
signal rec_ip_source_rx         : std_logic_vector(31 downto 0);
signal rec_ip_destination_rx    : std_logic_vector(31 downto 0);
signal start                    : std_logic;  -- Enable the pack
signal valid_seed               : std_logic :=  '1';
signal lfsr_polynomial          : std_logic_vector(1 downto 0);
signal mac_source_tx            : std_logic_vector(47 downto 0);
signal mac_destination_tx       : std_logic_vector(47 downto 0);
signal ip_source_tx             : std_logic_vector(31 downto 0);
signal ip_destination_tx        : std_logic_vector(31 downto 0);

signal mac_destination          : std_logic_vector(47 downto 0);
signal ip_source                : std_logic_vector(31 downto 0);
signal ip_destination           : std_logic_vector(31 downto 0);
signal packet_length            : std_logic_vector(15 downto 0);
signal timestamp_base           : std_logic_vector(47 downto 0);
signal time_stamp_flag          : std_logic; -- If the timestamp
signal pkt_tx_full              : std_logic;

signal payload_type             : std_logic_vector(1 downto 0);
signal payload_cycles           : std_logic_vector(31 downto 0);
signal payload_last_size        : std_logic_vector(7 downto 0);

signal pkt_rx_eop_in            : std_logic;
signal pkt_rx_sop_in            : std_logic;
signal pkt_rx_val_in            : std_logic;
signal pkt_rx_err_in            : std_logic;
signal pkt_rx_data_in           : std_logic_vector(127 downto 0);
signal pkt_rx_mod_in            : std_logic_vector(3 downto 0);

signal mac_filter               : std_logic_vector(2 downto 0) := "000";

signal bypass_scram             : std_logic := '0';
signal bypass_66encoder         : std_logic := '0';

signal tx_jtm_en                : std_logic := '0';
signal jtm_dps_0                : std_logic := '0';
signal jtm_dps_1                : std_logic := '0';
signal seed_A                   : std_logic_vector (57 downto 0) := (others=>'0');
signal seed_B                   : std_logic_vector (57 downto 0) := (others=>'0');


signal tx_fifo_spill            : std_logic;
signal fill_pcs_tx              : std_logic_vector(8 downto 0);




------------------------------------=------------------
------------------RX SIGNALS---------------------------
---------------------------------=---------------------


 --PCS_RX
 --inputs
 signal rx_jtm_en               : std_logic := '0';
 signal bypass_descram          : std_logic := '0';
 signal bypass_66decoder        : std_logic := '0';
 signal clear_errblk            : std_logic := '0';
 signal clear_ber_cnt           : std_logic := '0';
 signal linkstatus              : std_logic;

 --Echo Receiver
 -- inputs

 signal rec_lfsr_seed_in        : std_logic_vector(127 downto 0);
 signal rec_lfsr_polynomial_in  : std_logic_vector(1 downto 0) := "10";
 signal reset_test              : std_logic;
 signal pkt_sequence_in         : std_logic_vector(31 downto 0);
 signal pkt_rx_mod              : std_logic_vector(3 downto 0);

  --Echo Receiver
 --Outputs
 signal rec_mac_source_out      : std_logic_vector(47 downto 0);
 signal rec_mac_source_rx_out   : std_logic_vector(47 downto 0);
 signal rec_mac_destination_out : std_logic_vector(47 downto 0);
 signal rec_ip_source_out       : std_logic_vector(31 downto 0);
 signal rec_ip_destination_out  : std_logic_vector(31 downto 0);
 signal rec_time_stamp_out      : std_logic_vector(47 downto 0);
 signal received_packet         : std_logic;
 signal end_latency             : std_logic;
 signal packets_lost            : std_logic_vector(63 downto 0);
 signal RESET_done              : std_logic;
 signal pkt_rx_ren              : std_logic;
 signal pkt_sequence_error_flag : std_logic;
 signal pkt_sequence_error      : std_logic;
 signal count_error             : std_logic_vector(63 downto 0);
 signal IDLE_count              : std_logic_vector(63 downto 0);

 --CRC
 --output
 signal crc_pkt_rx_eop_out      : std_logic_vector(4 downto 0);
 signal crc_pkt_rx_sop_out      : std_logic;
 signal crc_pkt_rx_val_out      : std_logic;
 signal crc_pkt_rx_data_out     : std_logic_vector(127 downto 0);
 signal crc_ok                  : std_logic;
 signal pkt_tx_eop             : std_logic;

  ------------------------------------=------------------
  ------------------UPC AND RFC -------------------------
  ---------------------------------=---------------------

--UPC Signals
  signal initialize              : std_logic;
  signal RFC_end                 : std_logic;
  signal RFC_ack                 : std_logic;
  signal RFC_type                : std_logic_vector(2 downto 0);
  signal PKT_number              : std_logic_vector(63 downto 0);
  signal IDLE_number             : std_logic_vector(15 downto 0);
  signal TIMEOUT_number          : std_logic_vector(15 downto 0);
  signal RFC_running             : std_logic;
  signal check_reduce_frame_rate : std_logic;
  signal lfsr_seed               : std_logic_vector(255 downto 0);

--RFC Signals
  signal RFC_pkt_rx_out          : std_logic_vector(63 downto 0);
  signal latency                 : std_logic_vector(47 downto 0);
  signal TX_count                : std_logic_vector(63 downto 0);
  signal IDLE_count_receiver_out : std_logic_vector(63 downto 0);
  signal start_tx_begin          : std_logic := '0';

  signal eop_156                 : std_logic;
  signal sop_156                 : std_logic;
  signal val_156                 : std_logic;
  signal crc_ok_156              : std_logic;


begin

  on_frame_sent <= RFC_running;
  on_frame_received <= pkt_rx_avail_in;

--///////////////////////////////////////////////////////////////////////////////////////////////////
--//TX ARCH//////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////



TX_ARCH_INST  : entity work.TX_ARCH
    port map
    (
    --###############################################
    --######STANDART PORTS###########################
    --###############################################

      clk_156                => clk_156, -- Clock 156.25 MHz
      tx_clk161              => tx_clk161,
      clk_312                => clk_312,  -- Clock 312 MHz
      clk_312_n              => clk_312_n,  -- Clock 312 MHz
      rst_n                  => rst_n,  -- Reset (Active High);
      async_reset_n          => async_reset_n, -- Reset (Active High);
      reset_tx_n             => reset_tx_n,  -- Reset (Active High);
      reset_rx_n             => reset_rx_n,  -- Reset (Active High);
      tester_reset           => tester_reset,

      --FROM INTERFACE
      loop_select            => loop_select,--loop_select,

      --FROM REC
      rec_mac_source_rx      => rec_mac_source_rx_out,
      rec_mac_destination_rx => rec_mac_destination_out,
      rec_ip_source_rx       => rec_ip_source_out,
      rec_ip_destination_rx  => rec_ip_destination_out,

      --###############################################
      --######GEN PORTS################################
      --###############################################
      -- Control Signals
      start                  => start_tx_begin,  -- Enable the packet generation

      --LFSR Initialization
      lfsr_seed              => lfsr_seed,
      valid_seed             => valid_seed,
      lfsr_polynomial        => lfsr_polynomial,

      -- Settings
      mac_source             => mac_source, -- MAC source address
      mac_destination        => mac_destination,  -- MAC destination address
      ip_source              => ip_source,  -- IP source address
      ip_destination         => ip_destination,  -- IP destination address
      packet_length          => packet_length,  -- Packet size:  "000" - 64B, "001" - 128B, "010" - 256B, "011" - 512B,
                                                               --               "100" - 768B, "101" - 1024B, "110" - 1280B, "111" - 1518B
      timestamp_base         => timestamp_base,
      time_stamp_flag        => time_stamp_flag,  -- If the timestamp is needed in the latency test, first bit of payload is '1'

      -- TX mac interface
      pkt_tx_full            => pkt_tx_full,                      -- Informs if xMAC tx buffer is full
      payload_type           => payload_type, --payload_type,
      payload_cycles         => payload_cycles,
      payload_last_size      => payload_last_size,

      --###############################################
      --######LOOPBACK PORTS###########################
      --###############################################    -- When asserted, the packet transfer will begin on next cycle. Should remain asserted until EOP.
      pkt_rx_avail_in       => pkt_rx_avail_in,
      pkt_rx_eop_in         => crc_pkt_rx_eop_out(4),
      pkt_rx_sop_in         => crc_pkt_rx_sop_out,
      pkt_rx_val_in         => crc_pkt_rx_val_out,
      pkt_rx_err_in         => crc_ok,
      pkt_rx_data_in        => crc_pkt_rx_data_out,
      pkt_rx_mod_in         => crc_pkt_rx_eop_out(3 downto 0),

      mac_filter            => mac_filter,
      -- 000 inverts mac source and mac target and receives just packets in broadcast or intended for its mac
      -- 001 does not invert mac source and mac target and receives just packets in broadcast or intended for its mac
      -- 010 inverts mac source and mac target and operates in promiscous mode
      -- 011 does not invert mac source and mac target and operates in promiscous mode

      --###############################################
      --######TX_PATH##################################
      --###############################################
  -- PCS CORE
    --INPUTS
      seed_A                 => seed_A,
      seed_B                 => seed_B,
      bypass_66encoder       => bypass_66encoder,
      bypass_scram           => bypass_scram,
      tx_jtm_en              => tx_jtm_en,
      jtm_dps_0              => jtm_dps_0,
      jtm_dps_1              => jtm_dps_1,
      start_fifo             => start_fifo,
      start_fifo_rd          => start_fifo_rd,

    --OUTPUTS

      fill_pcs_tx            => fill_pcs_tx,
      tx_fifo_spill          => tx_fifo_spill,

  -- PCS ALIGNMENT
    --OUTPUTS
      tx_data_out_0          => tx_data_out_0,
      tx_data_out_1          => tx_data_out_1,
      tx_data_out_2          => tx_data_out_2,
      tx_data_out_3          => tx_data_out_3,
      tx_header_out_0        => tx_header_out_0,
      tx_header_out_1        => tx_header_out_1,
      tx_header_out_2        => tx_header_out_2,
      tx_header_out_3        => tx_header_out_3,
      tx_valid_out_0         => tx_valid_out_0,
      tx_valid_out_1         => tx_valid_out_1,
      tx_valid_out_2         => tx_valid_out_2,
      tx_valid_out_3         => tx_valid_out_3,

      pkt_tx_eop_out         => pkt_tx_eop,

  -- PKT CREATION
    --OUTPUTS
      mac_source_tx          => mac_source_tx,
      mac_destination_tx     => mac_destination_tx,
      ip_source_tx           => ip_source_tx,
      ip_destination_tx      => ip_destination_tx
    );


--///////////////////////////////////////////////////////////////////////////////////////////////////
--//RX ARCH//////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////

    rec_lfsr_seed_in <= lfsr_seed(127 downto 0);
    linkstatus_out   <= linkstatus;

    RX_ARCH_INST  : entity work.RX_ARCH
    port map
  (
     rx_clk161                => rx_clk161,
     clk_312                  => clk_312,
     clk_156                  => clk_156,

   --reset
     reset_rx_n               => reset_rx_n,
     async_reset_n            => async_reset_n,
     tester_reset             => tester_reset,

   --Labe Reorder
   --INPUTS
     rx_data_in_0             => rx_data_in_0,
     rx_data_in_1             => rx_data_in_1,
     rx_data_in_2             => rx_data_in_2,
     rx_data_in_3             => rx_data_in_3,
     rx_header_in_0           => rx_header_in_0,
     rx_header_in_1           => rx_header_in_1,
     rx_header_in_2           => rx_header_in_2,
     rx_header_in_3           => rx_header_in_3,
     rx_valid_in_0            => rx_valid_in_0,
     rx_valid_in_1            => rx_valid_in_1,
     rx_valid_in_2            => rx_valid_in_2,
     rx_valid_in_3            => rx_valid_in_3,

     --PCS_RX
     --inputs
     rx_jtm_en                => rx_jtm_en,
     bypass_descram           => bypass_descram,
     bypass_66decoder         => bypass_66decoder,
     clear_errblk             => clear_errblk,
     clear_ber_cnt            => clear_ber_cnt,
     RDEN_FIFO_PCS40          => RDEN_FIFO_PCS40,
     start_fifo               => start_fifo,
     linkstatus               => linkstatus,

     --Echo Receiver
     -- inputs
     mac_source               => mac_source,
     lfsr_seed                => rec_lfsr_seed_in,
     valid_seed               => valid_seed,
     lfsr_polynomial          => rec_lfsr_polynomial_in,
     pkt_rx_avail             => pkt_rx_avail_in,
     verify_system_rec        => check_reduce_frame_rate,
     reset_test               => reset_test,
     pkt_sequence_in          => pkt_sequence_in,
     payload_type             => payload_type,
     timestamp_base           => timestamp_base,

     --Echo Receiver
     --Outputs

     mac_source_rx            => rec_mac_source_rx_out,
     mac_destination          => rec_mac_destination_out,
     ip_source                => rec_ip_source_out,
     ip_destination           => rec_ip_destination_out,
     time_stamp_out           => rec_time_stamp_out,
     received_packet          => received_packet,
     end_latency              => end_latency,
     packets_lost             => packets_lost,
     RESET_done               => RESET_done,
     pkt_rx_ren               => pkt_rx_ren,
     pkt_sequence_error_flag  => pkt_sequence_error_flag,
     pkt_sequence_error       => pkt_sequence_error,
     count_error              => count_error,
     IDLE_count               => IDLE_count,

     --CRC
     --output
     pkt_rx_eop               => crc_pkt_rx_eop_out,
     pkt_rx_sop               => crc_pkt_rx_sop_out,
     pkt_rx_val               => crc_pkt_rx_val_out,
     pkt_rx_data              => crc_pkt_rx_data_out,
     crc_ok                   => crc_ok,

     eop_156                  => eop_156,
     sop_156                  => sop_156,
     val_156                  => val_156,
     crc_ok_156               => crc_ok_156
  );


  --///////////////////////////////////////////////////////////////////////////////////////////////////
  --//INTERFACE UDP////////////////////////////////////////////////////////////////////////////////////
  --///////////////////////////////////////////////////////////////////////////////////////////////////


  tester_reset  <=  async_reset_n and soft_reset;
  on_frame_sent <= RFC_running;

  inst_interface_upc : entity work.interface_upc_xgeth port map(
      clk_156                 => clk_156,
      clk_250                 => clk_250,
      reset                   => async_reset_n,

      xgeth_waddr             => xgeth_waddr,
      xgeth_raddr             => xgeth_raddr,
      xgeth_wdata             => xgeth_wdata,
      xgeth_wen               => xgeth_wen,

      xgeth_rdata             => xgeth_rdata,

      RFC_end                 => RFC_end,
      PKT_rx                  => RFC_pkt_rx_out,
      latency                 => latency,
      packets_lost			      => packets_lost,
      RFC_ack                 => RFC_ack,
      reset_test			       	=> reset_test,

      initialize              => initialize,

      lfsr_seed               => lfsr_seed,
      lfsr_polynomial         => lfsr_polynomial,
      valid_seed              => valid_seed,

      PKT_type                => loop_select,
      RFC_type                => RFC_type,
      IDLE_number             => IDLE_number,
      PKT_length              => packet_length,
      PKT_number              => PKT_number,
      TIMEOUT_number          => TIMEOUT_number,
      PKT_sequence_in         => PKT_sequence_in,
      mac_source              => mac_source,
      mac_destination         => mac_destination,
      ip_source               => ip_source,
      ip_destination          => ip_destination,
      soft_reset              => soft_reset,
      RFC_running             => RFC_running,
      time_stamp_flag          => time_stamp_flag,
      check_reduce_frame_rate => check_reduce_frame_rate,
      TX_count                => TX_count,
      linkstatus              => linkstatus,
      eth_rx_los              => eth_rx_los,
      IDLE_count_receiver_out => IDLE_count_receiver_out,
      mac_source_rx           => mac_source_tx,
      mac_destination_rx      => mac_destination_tx,
      ip_source_rx            => ip_source_tx,
      ip_destination_rx       => ip_destination_tx,
      cont_error              => count_error,
      payload_type            => payload_type,
      payload_cycles          => payload_cycles,
      loopback_filter         => mac_filter,
      payload_last_size       => payload_last_size
  );


  --   --///////////////////////////////////////////////////////////////////////////////////////////////////
  --   --//RFC2544//////////////////////////////////////////////////////////////////////////////////////////
  --   --///////////////////////////////////////////////////////////////////////////////////////////////////


  RFC2544_inst : entity work.rfc2544 port map (
      -- STANDARD INPUTS
      clock                   => clk_156,
      reset                   => tester_reset,
      initialize              => initialize,

      RFC_type                => RFC_type,

      IDLE_number             => IDLE_number,
      TIMEOUT_number          => TIMEOUT_number,
      PKT_number              => PKT_number,

      -- FROM Receiver
      PKT_timestamp           => rec_time_stamp_out,
      PKT_timestamp_val       => end_latency,
      PKT_sequence_error_flag => pkt_sequence_error_flag,
      PKT_sequence_error      => pkt_sequence_error,
      RESET_done			        => RESET_done,

      -- TO echo generator and receiver
      timestamp_base          => timestamp_base,

      -- FROM MAC
      PKT_TX_EOP              => pkt_tx_eop,
      PKT_RX_EOP              => crc_pkt_rx_eop_out(4),

      IDLE_count_receiver     => IDLE_count,
      latency                 => latency,
      verify_system_rec       => verify_system,
      PKT_rx                  => RFC_pkt_rx_out,
      PKT_gen                 => start_tx_begin,
      RFC_end                 => RFC_end,
      RFC_ack                 => RFC_ack,
      RFC_running             => RFC_running,
      check_reduce_frame_rate => check_reduce_frame_rate,
      TX_count                => TX_count,
      echo_received_packet    => received_packet,
      IDLE_count_receiver_out => IDLE_count_receiver_out,
      payload_last_size       => payload_last_size
  );

end arch_TESTER_4XGTH;
