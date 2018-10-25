
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
use ieee.numeric_std.all;
-- MUDAR BARRAMENTO 256b
-- MUDAR CLOCK 312.5 Mhz
entity echo_receiver_128_v2 is
  port
    (
        clock : in std_logic;             -- Clock 156.25 MHz ---> mudar 312.5 Mhz
        reset : in std_logic;             -- Reset (Active High)

        --LFSR Initialization
        lfsr_seed       : in std_logic_vector(127 downto 0);
        lfsr_polynomial : in std_logic_vector(1 downto 0);
        valid_seed      : in std_logic;
        -------------------------------------------------------------------------------
        -- Packet Info
        -------------------------------------------------------------------------------
        timestamp_base  : in std_logic_vector(47 downto 0);
        mac_source      : in std_logic_vector(47 downto 0);  -- MAC source address
        mac_source_rx   : out std_logic_vector(47 downto 0);  -- MAC source address
        mac_destination : out std_logic_vector(47 downto 0);  -- MAC destination address
        ip_source       : out std_logic_vector(31 downto 0);  -- IP source address
        ip_destination  : out std_logic_vector(31 downto 0);  -- IP destination address
        time_stamp_out  : out std_logic_vector(47 downto 0);  -- Packet timestamp
        received_packet : out std_logic;  -- Asserted when a valid UDP packet is received
        end_latency     : out std_logic;
        packets_lost    : out std_logic_vector(63 downto 0);
        RESET_done      : out std_logic; -- to RFC254|
        -------------------------------------------------------------------------------
        -- RX mac interface
        -------------------------------------------------------------------------------
        -- Should only be asserted when a packet is available in the receive FIFO.
        -- When asserted, the packet transfer will begin on next cycle. Should remain asserted until EOP.
        pkt_rx_ren               : out std_logic;
        pkt_rx_avail             : in  std_logic;  -- Asserted when a packet is available in for reading in receive FIFO
        pkt_rx_eop               : in  std_logic;  -- Receive data is the first word of the packet
        pkt_rx_sop               : in  std_logic;  -- Receive data is the last word of the packet
        pkt_rx_val               : in  std_logic;  -- Indicates that valid data is present on the bus
        pkt_rx_err               : in  std_logic;  -- Current packet is bad and should be discarded
        pkt_rx_data              : in  std_logic_vector(127 downto 0);  -- Receive data
        pkt_rx_mod               : in  std_logic_vector(3 downto 0);  -- Indicates valid bytes during last word -- added 0 in all pkt_rx_mod most val bit position
        payload_type             : in std_logic_vector(1 downto 0);
        verify_system_rec        : in std_logic;
        reset_test             : in std_logic;       -- activates reset test
        pkt_sequence_in          : in std_logic_vector(15 downto 0);   -- number of packets to define if recovery is completed
        pkt_sequence_error_flag  : out std_logic; -- to RFC254|
        pkt_sequence_error       : out std_logic;                -- '0' if sequence is ok, '1' if error in sequence and not recovered -- to RFC254|
        cont_error               : out std_logic_vector(127 downto 0);
        IDLE_count               : out std_logic_vector(127 downto 0)
    );
end echo_receiver_128_v2;

architecture arch_echo_receiver_128_v2 of echo_receiver_128_v2 is
    -------------------------------------------------------------------------------
    -- Debug
    -------------------------------------------------------------------------------
    attribute mark_debug : string;

    -------------------------------------------------------------------------------
    -- State
    -------------------------------------------------------------------------------
    type   state_type is (S_ETHERNET,S_IP, S_PAYLOAD, S_REST_IP ,S_IDLE, S_START_PAYLOAD);
    signal current_s, next_s : state_type;


    --------------------------------------------------------------------------------
    -- DATA regs
    signal pkt_rx_data_N : std_logic_vector(127 downto 0);  -- Receive data


    --------------------------------------------------------------------------------
    -- MAC n IP reg
    signal reg_mac_source, reg_mac_destination : std_logic_vector(47 downto 0);
    signal reg_ip_source, reg_ip_destination   : std_logic_vector(31 downto 0);
    signal reg_ethernet_type                   : std_logic_vector(15 downto 0);
    signal reg_ip_protocol                     : std_logic_vector(7 downto 0);
    signal reg_ip_message_length               : std_logic_vector(15 downto 0);
    signal ip_low, ip_high                     : std_logic_vector(15 downto 0);


    --------------------------------------------------------------------------------
    --Registers
    signal IDLE_count_reg : std_logic_vector(127 downto 0) := (OTHERS => '0');
    signal pkt_id_counter : std_logic_vector(127 downto 0) := (OTHERS => '0');




    function invert_bytes_127(bytes : std_logic_vector(127 DOWNTO 0))
                     return std_logic_vector
      is
        variable bytes_N : std_logic_vector(127 downto 0) := (others => '0');
        variable i_N : integer range 0 to 127;
        begin
          for i in 1 to 16 loop
            bytes_N(((i*8)-1) downto ((i-1)*8)) := bytes((127-(8*(i-1))) downto (127-((8*(i-1))+7)));
        end loop;
        return bytes_N;
    end function invert_bytes_127;

begin
  -------------------------------------------------------------------------------
  -- Combinational Logic
  -------------------------------------------------------------------------------
  -- Updates the current state
    next_updater : process(current_s, reset, clock, pkt_rx_avail, pkt_rx_sop, pkt_rx_eop)
    begin
      if reset = '0' then
        next_s <= S_IDLE;
      else
        case current_s is
            when S_IDLE => if pkt_rx_avail = '1' and pkt_rx_sop = '1' then next_s <= S_ETHERNET; end if;
            when S_ETHERNET => next_s <= S_IP;
            when S_IP => next_s <= S_REST_IP;
            when S_REST_IP => next_s <= S_START_PAYLOAD;
            when S_START_PAYLOAD => next_s <= S_PAYLOAD;
            when S_PAYLOAD => if pkt_rx_eop = '1' then next_s <= S_IDLE; end if;
            when others => next_s <= S_IDLE;
        end case;
      end if;
    end process;

    current_updater : process(reset, clock, pkt_rx_avail, pkt_rx_sop, pkt_rx_eop)
    begin
      if reset = '0' then
          current_s <= S_IDLE;
      elsif rising_edge(pkt_rx_eop) and pkt_rx_avail = '1' then
          current_s <= S_IDLE;
      elsif rising_edge(pkt_rx_sop) and pkt_rx_avail = '1'  then
          current_s <= S_ETHERNET;
      elsif rising_edge(clock)  then
          current_s <= next_s;
      end if;
    end process;

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

    pkt_rx_data_N <= invert_bytes_127(pkt_rx_data);
    IDLE_count <= IDLE_count_reg;
    package_updater_1:  process(current_s, pkt_rx_avail, pkt_rx_sop)
    begin
      case current_s is
        when S_IDLE =>
        reg_mac_source <= (others => '0');
        reg_mac_destination <= (others => '0');
        reg_ethernet_type <= (others => '0');
        reg_ip_source <= (others => '0');
        ip_high <= (others => '0');
        reg_ip_protocol <= (others => '0');
        reg_ip_message_length <= (others => '0');
        ip_low <= (others => '0');
        reg_ip_destination <= (others => '0');
        when S_ETHERNET =>
          reg_mac_source <= pkt_rx_data_N (127 downto 80);
          reg_mac_destination <= pkt_rx_data_N (79 downto 32);
          reg_ethernet_type <= pkt_rx_data_N (31 downto 16);
        when S_IP =>
          reg_ip_source <= pkt_rx_data_N (47 downto 16);
          ip_high <= pkt_rx_data_N (15 downto 0);
          reg_ip_protocol <= pkt_rx_data_N (71 downto 64);
          reg_ip_message_length <= pkt_rx_data_N (127 downto 112);
        when S_REST_IP =>
          ip_low <= pkt_rx_data_N (127 downto 112);
          reg_ip_destination <= ip_high & ip_low;

        when S_PAYLOAD => null;

        when others => null;
      end case;
    end process;

    package_updater_2 : process(reset, clock)
    begin
      if reset = '0' then
        IDLE_count_reg <= (others => '0');
        pkt_id_counter <= (others => '0');
      elsif rising_edge(clock) then
        case current_s is
          when S_IDLE =>
            if pkt_rx_avail = '1' then
              IDLE_count_reg <= IDLE_count_reg + '1';
            end if;
          when S_ETHERNET => null;

          when S_IP => null;

          when S_REST_IP => null;

          when S_START_PAYLOAD => null;

          when S_PAYLOAD =>
            if payload_type = "00" then
              pkt_id_counter <= pkt_rx_data_N;
            elsif payload_type = "01" then

            elsif payload_type = "10" then

            else

            end if;

          when others => null;
        end case;
      end if;
    end process;


end arch_echo_receiver_128_v2;
