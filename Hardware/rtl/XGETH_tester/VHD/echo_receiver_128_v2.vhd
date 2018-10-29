
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
    type   fsm_state_type is (S_IDLE, S_ETHERNET,S_IP, S_REST_IP , S_PAYLOAD, S_START_PAYLOAD);
    type   lfsr_state_type is (S_IDLE, S_CONFIG, S_START);
    signal current_s, next_s : fsm_state_type ;
    signal lfsr_state : lfsr_state_type;

    signal pkt_rx_data_N : std_logic_vector(127 downto 0);
    signal pkt_rx_data_NC : std_logic_vector(127 downto 0);


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

    --------------------------------------------------------------------------------
    --LFSR AND BERT SIGNALS
    signal RANDOM : std_logic_vector(127 downto 0);
    signal pkt_rx_data_bert : std_logic_vector(127 downto 0);
    signal lfsr_start : std_logic;
    signal lfsr_fsm_begin : std_logic;
    signal lfsr_test_begin : std_logic;
    signal delay_B0, delay_B1, delay_B2, lfsr_resync : std_logic_vector (127 downto 0);
    signal lfsr_counter : integer range 0 to 15;

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

    pkt_rx_data_N <= invert_bytes_127(pkt_rx_data);
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
        end case;
      end if;
    end process;

    current_updater : process(reset, clock, pkt_rx_avail, pkt_rx_sop, pkt_rx_eop)
    begin
      if reset = '0' then
          current_s <= S_IDLE;
      elsif pkt_rx_sop = '1' and next_s /= S_IP and pkt_rx_avail = '1' then
          current_s <= S_ETHERNET;
      elsif pkt_rx_eop = '1' and pkt_rx_avail = '1' then
            current_s <= S_IDLE;
      elsif rising_edge(clock)  then
          current_s <= next_s;
      end if;
    end process;

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------


  IDLE_count <= IDLE_count_reg;

    pkt_rx_ren <= '0' when current_s = S_IDLE else '1';

    reg_mac_source <= pkt_rx_data_N (127 downto 80) when current_s = S_ETHERNET else
                      (others => '0') when current_s = S_IDLE;
    reg_mac_destination <= pkt_rx_data_N (79 downto 32) when current_s = S_ETHERNET else
                      (others => '0') when current_s = S_IDLE;
    reg_ethernet_type <= pkt_rx_data_N (31 downto 16) when current_s = S_ETHERNET else
                      (others => '0') when current_s = S_IDLE;
    reg_ip_source <= pkt_rx_data_N (47 downto 16) when current_s = S_IP else
                      (others => '0') when current_s = S_IDLE;
    reg_ip_destination <= ip_high & ip_low when current_s = S_REST_IP else
                      (others => '0') when current_s = S_IDLE;
    ip_high <= pkt_rx_data_N (15 downto 0) when current_s = S_IP else
                      (others => '0') when current_s = S_IDLE;
    ip_low <= pkt_rx_data_N (127 downto 112) when current_s = S_REST_IP else
                      (others => '0') when current_s = S_IDLE;
    reg_ip_protocol <= pkt_rx_data_N (71 downto 64) when current_s = S_IP else
                      (others => '0') when current_s = S_IDLE;
    reg_ip_message_length <= pkt_rx_data_N (127 downto 112) when current_s = S_IP else
                      (others => '0') when current_s = S_IDLE;
    lfsr_start <= '1' when current_s = S_PAYLOAD else '0' when current_s = S_IDLE;

    package_updater : process(reset, clock)
    begin
      if reset = '0' then
        IDLE_count_reg <= (others => '0');
        pkt_id_counter <= (others => '0');
        lfsr_fsm_begin <= '0';
      elsif rising_edge(clock) then
        case current_s is
          when S_IDLE =>
            if pkt_rx_avail = '1' then
              IDLE_count_reg <= IDLE_count_reg + '1';
              lfsr_fsm_begin <= '0';
            end if;
          when S_ETHERNET =>
            null;
          when S_IP =>
            null;
          when S_REST_IP =>
            null;
          when S_START_PAYLOAD =>
            lfsr_fsm_begin <= '1';
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



    -------------------------------------------------------------------------------
    -- BERT TEST LFSR
    -------------------------------------------------------------------------------

    pipelined_lfsr_inputs : process(reset, clock)
    begin
      if reset = '0' then
          Delay_B0 <= (others => '0');
          Delay_B1 <= (others => '0');
          Delay_B2 <= (others => '0');
          lfsr_resync <= (others => '0');
          lfsr_counter <= 0;
      elsif rising_edge(clock) then
        case lfsr_state is
          when S_IDLE =>
            lfsr_counter <= 0;
            Delay_B0 <= (others => '0');
            Delay_B1 <= (others => '0');
            Delay_B2 <= (others => '0');
            if lfsr_fsm_begin = '1' then
              lfsr_state <= S_CONFIG;
            end if;
          when S_CONFIG =>
            Delay_B0 <= pkt_rx_data_N;
            Delay_B1 <= Delay_B0;
            Delay_B2 <= Delay_B1;
            if lfsr_counter = 2 then
              lfsr_counter <= 0;
              lfsr_test_begin <= '1';
              lfsr_state <= S_START;
            elsif lfsr_counter = 1 then
              lfsr_resync <= pkt_rx_data_N;
              lfsr_counter <= lfsr_counter +1;
            else
              lfsr_counter <= lfsr_counter +1;
            end if;
          when S_START =>
            Delay_B0 <= pkt_rx_data_N;
            Delay_B1 <= Delay_B0;
            Delay_B2 <= Delay_B1;
            if lfsr_fsm_begin = '0' Then
              lfsr_state <= S_IDLE;
           elsif lfsr_counter = 3 then
              lfsr_counter <= 0;
            elsif lfsr_counter = 1 then
              lfsr_resync <= pkt_rx_data_N;
              lfsr_counter <= lfsr_counter +1;
            else
              lfsr_counter <= lfsr_counter +1;
            end if;
        end case;
      end if;
    end process;

    pkt_rx_data_bert <= lfsr_resync when lfsr_counter = 0 else
                        Delay_B2;

    LFSR_REC: entity work.LFSR_REC
    generic map (DATA_SIZE => 128,
                 PPL_SIZE => 4)
    port map(
      clock => clock,
      reset_N => reset,
      seed => lfsr_seed,
      polynomial => lfsr_polynomial,
      data_in => pkt_rx_data_N,
      start => lfsr_start,
      data_out => RANDOM
    );


end arch_echo_receiver_128_v2;
