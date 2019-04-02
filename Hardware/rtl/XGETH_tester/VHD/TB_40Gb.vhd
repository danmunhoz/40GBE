--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity Tb_40Gb is
end Tb_40Gb;

architecture arch_Tb_40Gb of Tb_40Gb is

--------------------------
-------------------------STD INPUTS-------------------------------------
 signal clk_156                : std_logic := '0'; -- Clock 156.25 MHz
 signal tx_clk161              : std_logic := '0';
 signal rx_clk161              : std_logic := '0';
 signal clk_312                : std_logic := '0'; -- Clock 312 MHz
 signal clk_312_n              : std_logic := '0';
 signal rst_n                  : std_logic; -- Reset (Active Hi
 signal async_reset_n          : std_logic;
 signal reset_tx_n             : std_logic;
 signal reset_rx_n             : std_logic;
------------------------------------------------------------------------
signal loop_select            : std_logic := '0';
signal mac_source             : std_logic_vector(47 downto 0) := x"00AA11BB22CC";
signal rec_mac_source_rx      : std_logic_vector(47 downto 0) := x"00AA11BB22CC";
signal rec_mac_destination_rx : std_logic_vector(47 downto 0) := x"AA00BB11CC22";
signal rec_ip_source_rx       : std_logic_vector(31 downto 0) := x"0ABCDE01";
signal rec_ip_destination_rx  : std_logic_vector(31 downto 0) := x"0ABCDE02";
signal start                  : std_logic;  -- Enable the pack
signal lfsr_seed              : std_logic_vector(255 downto 0) := x"0000000000000000000000000000000000000000000000000000000C00000003";
signal valid_seed             : std_logic :=  '1';
signal lfsr_polynomial        : std_logic_vector(1 downto 0) := "10";


signal mac_destination        : std_logic_vector(47 downto 0) := x"00AA11BB22CC";
signal ip_source              : std_logic_vector(31 downto 0) := x"0ABCDE01";
signal ip_destination         : std_logic_vector(31 downto 0) := x"0ABCDE02";
signal packet_length          : std_logic_vector(15 downto 0) := x"05EE";
signal timestamp_base         : std_logic_vector(47 downto 0) := x"000000000001";
signal time_stamp_flag        : std_logic := '0'; -- If the timestamp
signal pkt_tx_full            : std_logic;

signal payload_type           : std_logic_vector(1 downto 0) := "00";
signal payload_cycles         : std_logic_vector(31 downto 0) := x"0000002A";

signal pkt_rx_avail_in       : std_logic;
signal pkt_rx_eop_in         : std_logic;
signal pkt_rx_sop_in         : std_logic;
signal pkt_rx_val_in         : std_logic;
signal pkt_rx_err_in         : std_logic;
signal pkt_rx_data_in        : std_logic_vector(127 downto 0);
signal pkt_rx_mod_in         : std_logic_vector(3 downto 0);

signal mac_filter            : std_logic_vector(2 downto 0) := "000";

signal bypass_scram         : std_logic := '0';
signal bypass_66encoder     : std_logic := '0';

signal tx_jtm_en            : std_logic := '0';
signal jtm_dps_0            : std_logic := '0';
signal jtm_dps_1            : std_logic := '0';
signal seed_A               : std_logic_vector (57 downto 0) := (others=>'0');
signal seed_B               : std_logic_vector (57 downto 0) := (others=>'0');

signal start_fifo           : std_logic;
signal start_fifo_rd        : std_logic;
signal tx_fifo_spill        : std_logic;
signal fill_pcs_tx          : std_logic_vector(8 downto 0);

signal tx_data_out_0        : std_logic_vector (63 downto 0);
signal tx_data_out_1        : std_logic_vector (63 downto 0);
signal tx_data_out_2        : std_logic_vector (63 downto 0);
signal tx_data_out_3        : std_logic_vector (63 downto 0);
signal tx_header_out_0      : std_logic_vector (1 downto 0);
signal tx_header_out_1      : std_logic_vector (1 downto 0);
signal tx_header_out_2      : std_logic_vector (1 downto 0);
signal tx_header_out_3      : std_logic_vector (1 downto 0);
signal tx_valid_out_0       : std_logic;
signal tx_valid_out_1       : std_logic;
signal tx_valid_out_2       : std_logic;
signal tx_valid_out_3       : std_logic;

signal start_tx_begin_delay : std_logic;
signal start_tx_begin       : std_logic := '0';

------------------------------------=------------------
------------------RX SIGNALS---------------------------
---------------------------------=---------------------



--Labe Reorder
--INPUTS
 signal rx_data_in_0         : std_logic_vector(63 downto 0);
 signal rx_data_in_1         : std_logic_vector(63 downto 0);
 signal rx_data_in_2         : std_logic_vector(63 downto 0);
 signal rx_data_in_3         : std_logic_vector(63 downto 0);
 signal rx_header_in_0       : std_logic_vector(1 downto 0);
 signal rx_header_in_1       : std_logic_vector(1 downto 0);
 signal rx_header_in_2       : std_logic_vector(1 downto 0);
 signal rx_header_in_3       : std_logic_vector(1 downto 0);
 signal rx_valid_in_0        : std_logic;
 signal rx_valid_in_1        : std_logic;
 signal rx_valid_in_2        : std_logic;
 signal rx_valid_in_3        : std_logic;

 --rx_path_rx
 --inputs
 signal rx_jtm_en            : std_logic := '0';
 signal bypass_descram       : std_logic := '0';
 signal bypass_66decoder     : std_logic := '0';
 signal clear_errblk         : std_logic := '0';
 signal clear_ber_cnt        : std_logic := '0';
 signal RDEN_FIFO_PCS40      : std_logic;

 --Echo Receiver
 -- inputs

 signal rec_lfsr_seed_in        : std_logic_vector(127 downto 0) := x"00000000000000000000000C00000003";
 signal rec_lfsr_polynomial_in  : std_logic_vector(1 downto 0) := "10";
 signal verify_system_rec       : std_logic := '1';
 signal reset_test              : std_logic := '1';
 signal pkt_sequence_in         : std_logic_vector(31 downto 0) := x"00000000";
 signal pkt_rx_mod              : std_logic_vector(3 downto 0);
 signal rec_payload_type_in     : std_logic_vector(1 downto 0) := "00";

  --Echo Receiver
 --Outputs
 signal rec_mac_source_out          : std_logic_vector(47 downto 0);
 signal rec_mac_source_rx_out       : std_logic_vector(47 downto 0);
 signal rec_mac_destination_out     : std_logic_vector(47 downto 0);
 signal rec_ip_source_out           : std_logic_vector(31 downto 0);
 signal rec_ip_destination_out      : std_logic_vector(31 downto 0);
 signal rec_time_stamp_out          : std_logic_vector(47 downto 0);
 signal received_packet             : std_logic;
 signal end_latency                 : std_logic;
 signal packets_lost                : std_logic_vector(127 downto 0);
 signal RESET_done                  : std_logic;
 signal pkt_rx_ren                  : std_logic;
 signal pkt_sequence_error_flag     : std_logic;
 signal pkt_sequence_error          : std_logic;
 signal count_error                 : std_logic_vector(127 downto 0);
 signal IDLE_count                  : std_logic_vector(127 downto 0);

 --CRC
 --output
 signal crc_pkt_rx_eop_out       : std_logic_vector(4 downto 0);
 signal crc_pkt_rx_sop_out       : std_logic;
 signal crc_pkt_rx_val_out       : std_logic;
 signal crc_pkt_rx_data_out      : std_logic_vector(127 downto 0);
 signal crc_ok                   : std_logic;


--tbd
signal pkt_tx_eop           : std_logic;
signal contador_teste       : integer range 0 to 500 := 0;





--///////////////////////////////////////////////////////////////////////////////////////////////////
--//CLOCK AND AUX////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////





begin

  clk_156    <= not clk_156 after 3.20512821 ns;
  tx_clk161  <= not tx_clk161 after 3.10559006 ns;
  rx_clk161  <= not tx_clk161 after 3.10559006 ns;
  clk_312    <= not clk_312 after 1.602564105 ns;
  clk_312_n  <= not clk_312;

  rst_n          <= '0','1' after 35 ns;
  async_reset_n  <= '0','1' after 35 ns;
  reset_tx_n     <= '0','1' after 40 ns;
  reset_rx_n     <= '0','1' after 40 ns;
  pkt_rx_avail_in   <= '0','1' after 5000 ns;

  start_fifo <= '0', '1' after 65 ns;
  start_fifo_rd <= '0', '1' after 150 ns;  -- Tanauan, testando repeticao mii

  start_tx_begin_delay <= '0','1' after 200 ns;

  RDEN_FIFO_PCS40 <= '0', '1' after 4000 ns;

  start_gen : process
  begin
      wait until start_tx_begin_delay = '1';
      while 1 = 1 loop
        contador_teste <= contador_teste + 1;
        start_tx_begin <= '0';
      wait for 135 ns;
        start_tx_begin <= '1';
      wait until pkt_tx_eop = '0';
        start_tx_begin <= '0';
      end loop;
  end process;





--///////////////////////////////////////////////////////////////////////////////////////////////////
--//TX ARCH//////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////






Tb_TX_ARCH_INST  : entity work.TX_ARCH
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

      --FROM INTERFACE
      loop_select            => loop_select,
      mac_source             => mac_source, -- MAC source address

      --FROM REC
      rec_mac_source_rx      => rec_mac_source_rx,
      rec_mac_destination_rx => rec_mac_destination_rx,
      rec_ip_source_rx       => rec_ip_source_rx,
      rec_ip_destination_rx  => rec_ip_destination_rx,

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
      mac_destination        => mac_destination,  -- MAC destination address
      ip_source              => ip_source,  -- IP source address
      ip_destination         => ip_destination,  -- IP destination address
      packet_length          => packet_length,  -- Packet size:  "000" - 64B, "001" - 128B, "010" - 256B, "011" - 512B,
                                                               --               "100" - 768B, "101" - 1024B, "110" - 1280B, "111" - 1518B
      timestamp_base         => timestamp_base,
      time_stamp_flag        => time_stamp_flag,  -- If the timestamp is needed in the latency test, first bit of payload is '1'

      -- TX mac interface
      pkt_tx_full            => pkt_tx_full,                      -- Informs if xMAC tx buffer is full
      payload_type           => payload_type,
      payload_cycles         => payload_cycles,

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
      tx_valid_out_3   => tx_valid_out_3,

      pkt_tx_eop_batata => pkt_tx_eop
    );






--///////////////////////////////////////////////////////////////////////////////////////////////////
--//RX ARCH//////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////




    Tb_RX_ARCH_INST  : entity work.RX_ARCH
    port map
  (
     rx_clk161        => rx_clk161,
     clk_312          => clk_312,
     clk_156          => clk_156,

   --reset
     reset_rx_n       => reset_rx_n,
     async_reset_n    => async_reset_n,

   --Labe Reorder
   --INPUTS
     rx_data_in_0     => tx_data_out_0,
     rx_data_in_1     => tx_data_out_1,
     rx_data_in_2     => tx_data_out_2,
     rx_data_in_3     => tx_data_out_3,
     rx_header_in_0   => tx_header_out_0,
     rx_header_in_1   => tx_header_out_1,
     rx_header_in_2   => tx_header_out_2,
     rx_header_in_3   => tx_header_out_3,
     rx_valid_in_0    => tx_valid_out_0,
     rx_valid_in_1    => tx_valid_out_1,
     rx_valid_in_2    => tx_valid_out_2,
     rx_valid_in_3    => tx_valid_out_3,

     --rx_path_rx
     --inputs
     rx_jtm_en        => rx_jtm_en,
     bypass_descram   => bypass_descram,
     bypass_66decoder => bypass_66decoder,
     clear_errblk     => clear_errblk,
     clear_ber_cnt    => clear_ber_cnt,
     RDEN_FIFO_PCS40  => RDEN_FIFO_PCS40,
     start_fifo       => start_fifo,

     --Echo Receiver
     -- inputs
     mac_source          => mac_source,
     lfsr_seed           => rec_lfsr_seed_in,
     valid_seed          => valid_seed,
     lfsr_polynomial     => rec_lfsr_polynomial_in,
     pkt_rx_avail        => pkt_rx_avail_in,
     verify_system_rec   => verify_system_rec,
     reset_test          => reset_test,
     pkt_sequence_in     => pkt_sequence_in,
     pkt_rx_mod          => pkt_rx_mod,
     payload_type        => rec_payload_type_in,
     timestamp_base      => timestamp_base,

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
     crc_ok                   => crc_ok
  );


end arch_Tb_40Gb;
