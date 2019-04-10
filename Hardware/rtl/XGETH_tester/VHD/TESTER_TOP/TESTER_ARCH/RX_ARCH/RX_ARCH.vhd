--////////////////////////////////////////////////////////////////////////
--////                                                                ////
--//// File name "rx_arch.vhd"                                        ////
--////                                                                ////
--//// This file is part of "Testset X40G" project                    ////
--////                                                                ////
--//// Author(s):                                                     ////
--//// - Gabriel Susin                                                ////
--////                                                                ////
--////////////////////////////////////////////////////////////////////////

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity RX_ARCH is
    port
    (
       rx_clk161                : in std_logic;
       clk_312                  : in std_logic;
       clk_156                  : in std_logic;

     --reset
       reset_rx_n               : in std_logic;
       async_reset_n            : in std_logic;
       tester_reset             : in std_logic;

     --Labe Reorder
     --INPUTS
       rx_data_in_0             : in std_logic_vector(63 downto 0);
       rx_data_in_1             : in std_logic_vector(63 downto 0);
       rx_data_in_2             : in std_logic_vector(63 downto 0);
       rx_data_in_3             : in std_logic_vector(63 downto 0);
       rx_header_in_0           : in std_logic_vector(1 downto 0);
       rx_header_in_1           : in std_logic_vector(1 downto 0);
       rx_header_in_2           : in std_logic_vector(1 downto 0);
       rx_header_in_3           : in std_logic_vector(1 downto 0);
       rx_valid_in_0            : in std_logic;
       rx_valid_in_1            : in std_logic;
       rx_valid_in_2            : in std_logic;
       rx_valid_in_3            : in std_logic;

       --PCS_RX
       --inputs
       rx_jtm_en                : in std_logic;
       bypass_descram           : in std_logic;
       bypass_66decoder         : in std_logic;
       clear_errblk             : in std_logic;
       clear_ber_cnt            : in std_logic;
       RDEN_FIFO_PCS40          : in std_logic;
       start_fifo               : in std_logic;
       linkstatus               : out std_logic;

       --CRC
       --output
       pkt_rx_eop               : out std_logic_vector(4 downto 0);
       pkt_rx_sop               : out std_logic;
       pkt_rx_val               : out std_logic;
       pkt_rx_data              : out std_logic_vector(127 downto 0);
       crc_ok                   : out std_logic;

       --Echo Receiver
       -- inputs
       lfsr_seed                : in std_logic_vector(127 downto 0);
       valid_seed               : in std_logic;
       lfsr_polynomial          : in std_logic_vector(1 downto 0);
       pkt_rx_avail             : in std_logic;
       verify_system_rec        : in std_logic;
       reset_test               : in std_logic;
       pkt_sequence_in          : in std_logic_vector(31 downto 0);
       payload_type             : in std_logic_vector(1 downto 0);
       timestamp_base           : in std_logic_vector(47 downto 0);

        --Echo Receiver
       --Outputs
       mac_source               : in std_logic_vector(47 downto 0);
       mac_source_rx            : out std_logic_vector(47 downto 0);
       mac_destination          : out std_logic_vector(47 downto 0);
       ip_source                : out std_logic_vector(31 downto 0);
       ip_destination           : out std_logic_vector(31 downto 0);
       time_stamp_out           : out std_logic_vector(47 downto 0);
       received_packet          : out std_logic;
       end_latency              : out std_logic;
       packets_lost             : out std_logic_vector(63 downto 0);
       RESET_done               : out std_logic;
       pkt_rx_ren               : out std_logic;
       pkt_sequence_error_flag  : out std_logic; -- to RFC254|
       pkt_sequence_error       : out std_logic;                -- '0' if sequence is ok, '1' if error in sequence and not recovered -- to RFC254|
       count_error              : out std_logic_vector(63 downto 0);
       IDLE_count               : out std_logic_vector(63 downto 0)
    );
  end RX_ARCH;

  architecture RX_ARCH of RX_ARCH is
    --###############################################
    --######COMPONENT DECLARATION####################
    --###############################################
  component RX_PATHWAY port(
     rx_clk161 : in std_logic;
     clk_312    : in std_logic;
     clk_156    :in std_logic;

    --reset
    reset_rx_n  : in std_logic;
    async_reset_n : in std_logic;

    --Labe Reorder
    --INPUTS
    rx_data_in_0     : in std_logic_vector(63 downto 0);
    rx_data_in_1     : in std_logic_vector(63 downto 0);
    rx_data_in_2     : in std_logic_vector(63 downto 0);
    rx_data_in_3     : in std_logic_vector(63 downto 0);
    rx_header_in_0   : in std_logic_vector(1 downto 0);
    rx_header_in_1   : in std_logic_vector(1 downto 0);
    rx_header_in_2   : in std_logic_vector(1 downto 0);
    rx_header_in_3   : in std_logic_vector(1 downto 0);
    rx_valid_in_0    : in std_logic;
    rx_valid_in_1    : in std_logic;
    rx_valid_in_2    : in std_logic;
    rx_valid_in_3    : in std_logic;

    --PCS_RX
    --inputs
    rx_jtm_en        : in std_logic;
    bypass_descram   : in std_logic;
    bypass_66decoder : in std_logic;
    clear_errblk     : in std_logic;
    clear_ber_cnt    : in std_logic;
    RDEN_FIFO_PCS40  : in std_logic;
    start_fifo       : in std_logic;
    linkstatus       : out std_logic;
    --CRC
    --output
    pkt_rx_eop       : out std_logic_vector(4 downto 0);
    pkt_rx_sop       : out std_logic;
    pkt_rx_val       : out std_logic;
    pkt_rx_data      : out std_logic_vector(127 downto 0);
    crc_ok           : out std_logic
    );
  end component;
  --###############################################
  --######SIGNALS DECLARATION######################
  --###############################################

  signal crc_pkt_rx_eop_out      : std_logic_vector(4 downto 0);
  signal crc_pkt_rx_sop_out      : std_logic;
  signal crc_pkt_rx_val_out      : std_logic;
  signal crc_pkt_rx_data_out     : std_logic_vector(127 downto 0);
  signal crc_ok_out              : std_logic;

begin









    --###############################################
    --######RX PATH INSTANTIATION####################
    --###############################################

    pkt_rx_eop <= crc_pkt_rx_eop_out;
    pkt_rx_sop  <= crc_pkt_rx_sop_out;
    pkt_rx_val  <= crc_pkt_rx_val_out;
    pkt_rx_data  <= crc_pkt_rx_data_out;
    crc_ok      <= crc_ok_out;

  inst_rx_pathway: RX_PATHWAY port map(
     rx_clk161       =>   rx_clk161,
     clk_312         =>   clk_312,
     clk_156         =>   clk_156,

     --reset
     reset_rx_n       => reset_rx_n,
     async_reset_n    => async_reset_n,

     --Labe Reorder
     --INPUTS
     rx_data_in_0     => rx_data_in_0,
     rx_data_in_1     => rx_data_in_1,
     rx_data_in_2     => rx_data_in_2,
     rx_data_in_3     => rx_data_in_3,
     rx_header_in_0   => rx_header_in_0,
     rx_header_in_1   => rx_header_in_1,
     rx_header_in_2   => rx_header_in_2,
     rx_header_in_3   => rx_header_in_3,
     rx_valid_in_0    => rx_valid_in_0,
     rx_valid_in_1    => rx_valid_in_1,
     rx_valid_in_2    => rx_valid_in_2,
     rx_valid_in_3    => rx_valid_in_3,

     --PCS_RX
     --inputs
     rx_jtm_en         => rx_jtm_en,
     bypass_descram    => bypass_descram,
     bypass_66decoder  => bypass_66decoder,
     clear_errblk      => clear_errblk,
     clear_ber_cnt     => clear_ber_cnt,
     RDEN_FIFO_PCS40   => RDEN_FIFO_PCS40,
     start_fifo        => start_fifo,
     linkstatus        => linkstatus,
     --CRC
     --output
     pkt_rx_eop       => crc_pkt_rx_eop_out,
     pkt_rx_sop       => crc_pkt_rx_sop_out,
     pkt_rx_val       => crc_pkt_rx_val_out,
     pkt_rx_data      => crc_pkt_rx_data_out,
     crc_ok           => crc_ok_out
  );











  --###############################################
  --######ECHO RECEIVER INSTANTIATION####################
  --###############################################

  inst_echo_receiver : entity work.echo_receiver port map(
    clk_312                   =>  clk_312,
    reset                     =>  tester_reset,

    --LFSR Initialization
    lfsr_seed                 =>  lfsr_seed,
    lfsr_polynomial           =>  lfsr_polynomial,
    valid_seed                =>  valid_seed,
    -------------------------------------------------------------------------------
    -- Packet Info
    -------------------------------------------------------------------------------
    timestamp_base            =>  timestamp_base,
    mac_source                =>  mac_source,
    mac_source_rx             =>  mac_source_rx,
    mac_destination           =>  mac_destination,
    ip_source                 =>  ip_source,
    ip_destination            =>  ip_destination,
    time_stamp_out            =>  time_stamp_out,
    received_packet           =>  received_packet,
    end_latency               =>  end_latency,
    packets_lost              =>  packets_lost,
    RESET_done                =>  RESET_done,
    -------------------------------------------------------------------------------
    -- RX mac interface
    -------------------------------------------------------------------------------

    pkt_rx_ren                =>  pkt_rx_ren,
    pkt_rx_avail              =>  pkt_rx_avail,
    pkt_rx_eop                =>  crc_pkt_rx_eop_out(4),
    pkt_rx_sop                =>  crc_pkt_rx_sop_out,
    pkt_rx_val                =>  crc_pkt_rx_val_out,
    pkt_rx_err                =>  crc_ok_out,
    pkt_rx_data               =>  crc_pkt_rx_data_out,
    pkt_rx_mod                =>  crc_pkt_rx_eop_out(3 downto 0),
    payload_type              =>  payload_type,
    verify_system_rec         =>  verify_system_rec,
    reset_test                =>  reset_test,
    pkt_sequence_in           =>  pkt_sequence_in,
    pkt_sequence_error_flag   =>  pkt_sequence_error_flag,
    pkt_sequence_error        =>  pkt_sequence_error,
    count_error               =>  count_error,
    IDLE_count                =>  IDLE_count

  );
end RX_ARCH;
