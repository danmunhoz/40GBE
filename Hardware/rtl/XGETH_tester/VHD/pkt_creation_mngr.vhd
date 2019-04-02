

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- TOP
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
library UNISIM;
  use UNISIM.vcomponents.all;
library UNIMACRO;
  use unimacro.Vcomponents.all;
--This entity is responsible for invert MACs and IPs from packet header, used in loopback mode.

entity pkt_creation_mngr is
  port
  (
  --###############################################
  --######STANDART PORTS###########################
  --###############################################

    clk_156                : in  std_logic; -- Clock 156.25 MHz
    clk_312                : in  std_logic; -- Clock 312 MHz
    clk_312_n              : in  std_logic;
    rst_n                  : in  std_logic; -- Reset (Active High);

    --FROM INTERFACE
    loop_select            : in std_logic;
    mac_source             : in  std_logic_vector(47 downto 0); -- MAC source address

    --FROM REC
    rec_mac_source_rx      : in  std_logic_vector(47 downto 0);
    rec_mac_destination_rx : in  std_logic_vector(47 downto 0);
    rec_ip_source_rx       : in  std_logic_vector(31 downto 0);
    rec_ip_destination_rx  : in  std_logic_vector(31 downto 0);

    --TO MAC
    pkt_tx_data            : out std_logic_vector(255 downto 0); -- Data bus
    pkt_tx_val             : out std_logic;                     -- Indicates if the data is valid
    pkt_tx_sop             : out std_logic_vector(1 downto 0);                     -- Start of packet flag (sent along with the first frame)
    pkt_tx_eop             : out std_logic;                     -- End of packet flag (sent along with the last frame)
    pkt_tx_mod             : out std_logic_vector(4 downto 0);   -- Module (frame size, only read when eop='1')

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

    --LOOPBACK PORTS
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

    --OUTPUT TO INTERFACE

    mac_source_out          : out  std_logic_vector(47 downto 0); -- MAC destination address
    mac_destination_out     : out  std_logic_vector(47 downto 0); -- MAC destination address
    ip_source_out           : out  std_logic_vector(31 downto 0); -- IP source address
    ip_destination_out      : out  std_logic_vector(31 downto 0) -- IP destination address

  );
end pkt_creation_mngr;

architecture arch_pkt_creation_mngr of pkt_creation_mngr is

 --LOOPBACK SIGNALS
 type   lb_type is (S_WRITE, S_READ, S_IDLE);
 signal lb_s                   : lb_type;
 signal lb_en                  :   std_logic;
 signal lb_pkt_start           :   std_logic;
 signal lb_pkt_tx_eop          :   std_logic;
 signal lb_pkt_tx_sop          :   std_logic_vector (1 downto 0);
 signal lb_pkt_tx_val_delay          :   std_logic;
 signal lb_pkt_tx_val          :   std_logic;
 signal lb_pkt_tx_data         :   std_logic_vector(255 downto 0);
 signal lb_pkt_tx_mod          :   std_logic_vector(4 downto 0);

 signal lb_mac_destination     :  std_logic_vector(47 downto 0);
 signal lb_mac_source          :  std_logic_vector(47 downto 0);
 signal lb_ip_destination      :  std_logic_vector(31 downto 0);
 signal lb_ip_source           :  std_logic_vector(31 downto 0);

--GEN SIGNALS

  signal gen_pkt_tx_data       :  std_logic_vector(255 downto 0); -- Data bus
  signal gen_pkt_tx_val        :  std_logic;                     -- Indicates if the data is valid
  signal gen_pkt_tx_sop        :  std_logic_vector(1 downto 0);                     -- Start of packet flag (sent along with the first frame)
  signal gen_pkt_tx_eop        :  std_logic;                     -- End of packet flag (sent along with the last frame)
  signal gen_pkt_tx_mod        :  std_logic_vector(4 downto 0);   -- Module (frame size, only read when eop='1')

--CONTROL SIGNALS

  type   build_type is (S_IDLE, S_REBUILD, S_STOP);
  signal build_s                 : build_type;
  
  signal parity_stop_156         : std_logic;
  signal parity_start_156         : std_logic;
  signal data_pkt_start          : std_logic;
  signal data_delay_coutner      : std_logic_vector(1 downto 0);
  signal data_ctrl_in_reg_312    : std_logic_vector(7 downto 0);
  signal data_ctrl_in_reg_312_n  : std_logic_vector(7 downto 0);
  signal data_ctrl_312_reg_312_n : std_logic_vector(7 downto 0);
  signal data_ctrl_delay         : std_logic_vector(7 downto 0);
  signal data_ctrl_delay_2       : std_logic_vector(7 downto 0);
  signal data_ctrl_in_wire      : std_logic_vector(7 downto 0);
  signal data_wire_out          : std_logic_vector(7 downto 0);
  signal data_buffer_out        : std_logic_vector(7 downto 0);
  signal data_ctrl_out          : std_logic_vector(7 downto 0);
  signal data_buffer_312_n      : std_logic_vector(127 downto 0);
  signal data_hold_312          : std_logic_vector(135 downto 0);
  signal data_buffer_312        : std_logic_vector(135 downto 0);
  signal data_156_h             :  std_logic;
  signal data_wire_156          : std_logic_vector (255 downto 0);
  signal data_buffer_156        : std_logic_vector (255 downto 0);
  signal data_rebuild           : std_logic_vector (255 downto 0);


  type   rebuild_type is (S_IDLE, S_REBUILD, S_STOP);
  signal rebuild_s_156             : rebuild_type;
  signal rebuild_s_312             : rebuild_type;
  signal rebuild_s_312_n           : rebuild_type;

  signal rebuild_start_h           : std_logic;
  signal rebuild_stop_h            : std_logic;
  signal rebuild_ctrl_in           : std_logic_vector(7 downto 0);
  signal rebuild_ctrl_in_reg_156   : std_logic_vector(7 downto 0);
  signal rebuild_ctrl_in_reg_312   : std_logic_vector(7 downto 0);
  signal rebuild_ctrl_in_reg_312_n : std_logic_vector(7 downto 0);
  signal rebuild_ctrl_312_delay    : std_logic_vector(7 downto 0);
  signal rebuild_ctrl_312_n_delay  : std_logic_vector(7 downto 0);
  signal rebuild_data_in_reg_156   : std_logic_vector(255 downto 0);
  signal rebuild_data_in_reg_312   : std_logic_vector(127 downto 0);
  signal rebuild_data_in_reg_312_n : std_logic_vector(127 downto 0);
  signal rebuild_data_312_delay    : std_logic_vector(127 downto 0);
  signal rebuild_data_312_n_delay  : std_logic_vector(127 downto 0);

  signal teste : std_logic_vector(2 downto 0);
  signal fifo_en : std_logic;

begin

---------------------------------------------------------
-- SHIFTED CLOCK DATA REBUILD
--------------------------------------------------------

    rebuild_ctrl_in <= pkt_rx_avail_in & pkt_rx_val_in & pkt_rx_sop_in &
                     pkt_rx_mod_in   & pkt_rx_eop_in;

    data_rebuild  <= rebuild_data_in_reg_156;
    data_ctrl_out <= rebuild_ctrl_in_reg_156;



  data_concatenation_312 : process (clk_312, rst_n)
  begin
      if (rst_n = '0') then
      rebuild_stop_h           <= '0';
      rebuild_start_h           <= '0';
      rebuild_ctrl_in_reg_312   <= (others => '0');
      rebuild_data_in_reg_312   <= (others => '0');
      rebuild_ctrl_312_delay    <= (others => '0');
      rebuild_data_312_delay    <= (others => '0');
      rebuild_s_312             <= S_IDLE;
    elsif (clk_312'event and clk_312 = '1') then
      rebuild_ctrl_in_reg_312   <= rebuild_ctrl_in;
      rebuild_data_in_reg_312   <= pkt_rx_data_in;
      rebuild_ctrl_312_delay <= rebuild_ctrl_in_reg_312;
      rebuild_data_312_delay <= rebuild_data_in_reg_312;
      case rebuild_s_312 is
        when S_IDLE =>
          rebuild_stop_h   <= '0';
          if (pkt_rx_sop_in = '1' and pkt_rx_avail_in = '1') then
            rebuild_s_312 <= S_REBUILD;
            if (clk_156 = '1') then
              rebuild_start_h   <= '1';
            else
              rebuild_start_h   <= '0';
            end if;
          end if;
        when S_REBUILD =>
          if (pkt_rx_eop_in = '1') then
            rebuild_s_312 <= S_STOP;
            if (clk_156 = '1') then
              rebuild_stop_h   <= '1';
            else
              rebuild_stop_h   <= '0';
            end if;
          end if;
        when S_STOP =>
          rebuild_s_312 <= S_IDLE;
      end case;
    end if;
  end process;

  data_concatenation_312_n : process (clk_312_n, rst_n)
  begin
    if (rst_n = '0') then
      rebuild_ctrl_in_reg_312_n <= (others => '0');
      rebuild_data_in_reg_312_n <= (others => '0');
      rebuild_ctrl_312_n_delay  <= (others => '0');
      rebuild_data_312_n_delay  <= (others => '0');
    elsif (clk_312_n'event and clk_312_n = '1') then
      rebuild_ctrl_in_reg_312_n   <= rebuild_ctrl_in;
      rebuild_data_in_reg_312_n   <= pkt_rx_data_in;
      rebuild_ctrl_312_n_delay <= rebuild_ctrl_in_reg_312_n;
      rebuild_data_312_n_delay <= rebuild_data_in_reg_312_n;
    end if;
  end process;

  data_concatenation_156 : process (clk_156, rst_n)
  begin
    if (rst_n = '0') then
      rebuild_s_156 <= S_IDLE;
      parity_stop_156                    <= '0';
      parity_start_156                    <= '0';
      rebuild_data_in_reg_156   <= (others => '0');
      rebuild_ctrl_in_reg_156   <= (others => '0');
    elsif (clk_156'event and clk_156 = '1') then
      parity_stop_156 <= rebuild_stop_h;
      parity_start_156 <= rebuild_start_h;
      if rebuild_start_h = '1' then
        rebuild_data_in_reg_156   <= rebuild_data_in_reg_312 & rebuild_data_312_delay;
        if rebuild_ctrl_in_reg_312(0) = '1' then
          rebuild_ctrl_in_reg_156   <= rebuild_ctrl_in_reg_312;
        else
          rebuild_ctrl_in_reg_156   <= rebuild_ctrl_312_delay;
        end if;
      else
        rebuild_data_in_reg_156   <= pkt_rx_data_in & rebuild_data_in_reg_312;
        if rebuild_stop_h = '1' then
          rebuild_ctrl_in_reg_156   <= rebuild_ctrl_312_delay;
        else
          rebuild_ctrl_in_reg_156   <= rebuild_ctrl_in_reg_312_n;
        end if;
      end if;
    end if;
  end process;


---------------------------------------------------------
-- MUX to select ECHO GEN or LOOPBACK  -> MAC bus
---------------------------------------------------------

  mac_source_out       <= lb_mac_source when loop_select = '1' else rec_mac_source_rx;
  mac_destination_out  <= lb_mac_destination when loop_select = '1' else rec_mac_destination_rx;
  ip_source_out        <= lb_ip_source when loop_select = '1' else rec_ip_source_rx;
  ip_destination_out   <= lb_ip_destination when loop_select = '1' else rec_ip_destination_rx;


  pkt_tx_data <= lb_pkt_tx_data when loop_select = '1' else
              gen_pkt_tx_data;

  pkt_tx_val  <= lb_pkt_tx_val when loop_select = '1' else
              gen_pkt_tx_val;

  pkt_tx_sop  <= lb_pkt_tx_sop when loop_select = '1' else
              gen_pkt_tx_sop;

  pkt_tx_eop  <= lb_pkt_tx_eop when loop_select = '1' else
              gen_pkt_tx_eop;

  pkt_tx_mod  <= lb_pkt_tx_mod when loop_select = '1' else
              gen_pkt_tx_mod;

  ---------------------------------------------------------
  -- MUX to select ECHO GEN or LOOPBACK  -> MAC bus
  ---------------------------------------------------------

  loopback_inst : entity work.loopback port map (
      -- STANDARD INPUTS
      clk_156                => clk_156,
      reset                  => rst_n,
      parity_stop            => parity_stop_156,
      parity_start           => parity_start_156,
      pkt_start              => lb_pkt_start,
      mac_source_in          => mac_source,

      pkt_rx_avail_in        => data_ctrl_out(7),--FROM INTERFACE
      pkt_rx_eop_in          => data_ctrl_out(0),
      pkt_rx_sop_in          => data_ctrl_out(5),
      pkt_rx_val_in          => data_ctrl_out(6),
      pkt_rx_err_in          => pkt_rx_err_in,
      pkt_rx_data_in         => data_rebuild,
      pkt_rx_mod_in          => data_ctrl_out(4 downto 1),
      mac_filter_in          => mac_filter,

      pkt_tx_eop_out       => lb_pkt_tx_eop,
      pkt_tx_sop_out       => lb_pkt_tx_sop,
      pkt_tx_val_out       => lb_pkt_tx_val,
      pkt_tx_data_out      => lb_pkt_tx_data,
      pkt_tx_mod_out       => lb_pkt_tx_mod,

      mac_destination_out  => lb_mac_destination,
      mac_source_out       => lb_mac_source,
      ip_destination_out   => lb_ip_destination,
      ip_source_out        => lb_ip_source

  );

  echo_gen_inst : entity work.echo_generator port map (
      clock         => clk_156,
      reset         => rst_n,

      -- Control Signals
      start               => start,
      time_stamp_flag     => time_stamp_flag,
      --LFSR settings
      lfsr_seed           => lfsr_seed,
      lfsr_polynomial     => lfsr_polynomial,--FROM INTERFACE
      valid_seed          => valid_seed,

      -- Settings: in  std_logic_vector(31 downto 0);
      mac_source          => mac_source,
      mac_destination     => mac_destination,
      ip_source           => ip_source,
      ip_destination      => ip_destination,
      packet_length       => packet_length,
      timestamp_base      => timestamp_base,

      -- TX mac interface
      pkt_tx_full         => pkt_tx_full,
      pkt_tx_data         => gen_pkt_tx_data,
      pkt_tx_val          => gen_pkt_tx_val,
      pkt_tx_sop          => gen_pkt_tx_sop,
      pkt_tx_eop          => gen_pkt_tx_eop,
      pkt_tx_mod          => gen_pkt_tx_mod,
      payload_type        => payload_type,
      payload_cycles      => payload_cycles
  );



end arch_pkt_creation_mngr;
