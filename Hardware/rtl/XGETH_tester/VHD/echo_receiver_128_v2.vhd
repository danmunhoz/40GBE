
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
        packets_lost    : out std_logic_vector(127 downto 0);
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
        reset_test               : in std_logic;       -- activates reset test
        pkt_sequence_in          : in std_logic_vector(31 downto 0);   -- number of packets to define if recovery is completed
        pkt_sequence_error_flag  : out std_logic; -- to RFC254|
        pkt_sequence_error       : out std_logic;                -- '0' if sequence is ok, '1' if error in sequence and not recovered -- to RFC254|
        count_error               : out std_logic_vector(127 downto 0);
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
    type   lfsr_state_type is (S_IDLE, S_SETUP_PIPELINE, S_SETUP_DELAY, S_RUN);
    type   recovery_state_type is (S_WAIT_START, S_WAIT_STOP, S_RECOVERY);

    signal current_s, next_s : fsm_state_type ;
    signal lfsr_state : lfsr_state_type;
    signal recovery_state : recovery_state_type;

    signal pkt_rx_data_N : std_logic_vector(127 downto 0);
    signal pkt_rx_data_NC : std_logic_vector(127 downto 0);
    signal pkt_sequence_error_flag_aux : std_logic;


    --------------------------------------------------------------------------------
    -- MAC n IP reg
    signal reg_mac_source, reg_mac_destination : std_logic_vector(47 downto 0);
    signal reg_ip_source, reg_ip_destination   : std_logic_vector(31 downto 0);
    signal reg_ethernet_type                   : std_logic_vector(15 downto 0);
    signal reg_ip_protocol                     : std_logic_vector(7 downto 0);
    signal reg_ip_message_length               : std_logic_vector(15 downto 0);
    signal ip_low, ip_high                     : std_logic_vector(15 downto 0);
    signal ip_pkt_type                         : std_logic;
    signal udp_pkt_type                        : std_logic;
    signal received_packet_reg                 : std_logic;
    --------------------------------------------------------------------------------
    --ID TESTS

    signal id_pkt_tester : std_logic_vector(127 downto 0) := (OTHERS => '0');
    signal id_sequence_counter : std_logic_vector(31 downto 0) := (OTHERS => '0');
    signal id_checker_reg : std_logic_vector(127 downto 0) := (OTHERS => '0');

    signal lost_pkt_flag : std_logic;
    signal not_lost_pkt_test : std_logic;
    signal lost_counter : std_logic_vector(31 downto 0) := (OTHERS => '0');
    signal lost_pkt_tester : std_logic_vector(127 downto 0) := (OTHERS => '0');

    ------------------------------------------------------------------------------
    signal IDLE_count_reg : std_logic_vector(127 downto 0) := (OTHERS => '0');
    signal pkt_zeros      : std_logic_vector(127 downto 0) := (OTHERS => '0');
    signal pkt_ones       : std_logic_vector(127 downto 0) := (OTHERS => '0');


    --------------------------------------------------------------------------------
    --LFSR AND BERT SIGNALS
    signal RANDOM : std_logic_vector(127 downto 0);
    signal lfsr_bert : std_logic_vector(127 downto 0);
    signal start : std_logic;
    signal lfsr_start : std_logic;
    signal lfsr_start_delay : std_logic;
    signal lfsr_resync_ON : std_logic;
    signal lfsr_fsm_begin : std_logic;
    signal lfsr_test_begin : std_logic;
    signal delay_B0, delay_B1, delay_B2: std_logic_vector (127 downto 0);
    signal lfsr_resync_SIGNAL : std_logic_vector (127 downto 0);
    signal lfsr_resync_RANDOM : std_logic_vector (127 downto 0);
    signal lfsr_counter : integer range 0 to 15;

    signal const_test_begin : std_logic;

    signal bert_target_lfsr : std_logic_vector (127 downto 0);
    signal bert_xor : std_logic_vector (127 downto 0);
    signal bert_cycle_wrong : std_logic_vector (127 downto 0);
    signal bert_n_flipped_b : std_logic_vector (127 downto 0);
    signal bert_count_flip : std_logic_vector (127 downto 0);
    signal bert_test_begin : std_logic;

    signal ALL_ONE : std_logic_vector(127 downto 0) := (OTHERS => '1');
    signal ALL_ZERO : std_logic_vector(127 downto 0) := (OTHERS => '0');

    signal recovery_n_flipped_b : std_logic_vector(127 downto 0);
    signal recovery_cycle_wrong : std_logic_vector(127 downto 0);
    signal recovery_ON : std_logic;
    signal recovery_start_pkt : std_logic;
    signal recovery_stop_pkt : std_logic;



    function invert_bytes_127(bytes : std_logic_vector(127 DOWNTO 0)) return std_logic_vector
      is
        variable bytes_N : std_logic_vector(127 downto 0) := (others => '0');
        variable i_N : integer range 0 to 127;
        begin
          for i in 1 to 16 loop
            bytes_N(((i*8)-1) downto ((i-1)*8)) := bytes((127-(8*(i-1))) downto (127-((8*(i-1))+7)));
        end loop;
        return bytes_N;
    end function invert_bytes_127;

    function count_ones(s : std_logic_vector) return std_logic_vector is
        variable temp : std_logic_vector(127 downto 0) := (others => '0');
    begin
      for i in s'range loop
        if s(i) = '1' then temp := temp + '1';
        end if;
      end loop;
      return temp;
    end function count_ones;

begin


    pkt_rx_data_N <= invert_bytes_127(pkt_rx_data);
    ip_pkt_type <= '1' when reg_ethernet_type = x"0800" else '0';

    udp_pkt_type <= '1' when reg_ip_protocol = x"11" else '0';


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

    mac_source_rx   <= reg_mac_source;
    mac_destination <= reg_mac_destination;
    ip_source       <= reg_ip_source;
    ip_destination  <= reg_ip_destination;
    --time_stamp_out  :
  --  end_latency     :
    received_packet <= received_packet_reg;
    IDLE_count <= IDLE_count_reg;
    --end_latency <= '1' when ((received_packet_wire = '1') and (ip_pkt_type = '1') and (udp_pkt_type = '1') and (reg_time_stamp(0) = '1')) else '0';

    pkt_rx_ren <= '0' when current_s = S_IDLE else '1';


    const_test_begin <= '1' when current_s = S_PAYLOAD and (payload_type = "10" or payload_type = "11") else '0';
    lfsr_start <= '1' when current_s = S_PAYLOAD and payload_type = "01"  else '0';

    package_updater : process(reset, clock)
    begin
      if reset = '0' then
        IDLE_count_reg <= (others => '0');
        id_pkt_tester <= (others => '0');
        lfsr_fsm_begin <= '0';
        received_packet_reg <= '0';
        reg_mac_source <= (others => '0');
        reg_mac_destination <=(others => '0');
        reg_ethernet_type <= (others => '0');
        reg_ip_protocol <= (others => '0');
        reg_ip_message_length <= (others => '0');
        reg_ip_source <= (others => '0');
        ip_high <= (others => '0');
        reg_ip_destination <= (others => '0');
      elsif rising_edge(clock) then
        case current_s is
          when S_IDLE =>
            if pkt_rx_avail = '1' then
              IDLE_count_reg <= IDLE_count_reg + '1';
              lfsr_fsm_begin <= '0';
            end if;
          when S_ETHERNET =>
            reg_mac_source <= pkt_rx_data_N (127 downto 80);
            reg_mac_destination <= pkt_rx_data_N (79 downto 32);
            reg_ethernet_type <= pkt_rx_data_N (31 downto 16);
          when S_IP =>
            reg_ip_protocol <= pkt_rx_data_N (71 downto 64);
            reg_ip_message_length <= pkt_rx_data_N (127 downto 112);
            reg_ip_source <= pkt_rx_data_N (47 downto 16);
            ip_high <= pkt_rx_data_N (15 downto 0);

            if mac_source = reg_mac_destination then
              received_packet_reg <= '1';
            else
              received_packet_reg <= '0';
            end if;
            null;
          when S_REST_IP =>
            reg_ip_destination <= ip_high & pkt_rx_data_N (127 downto 112);
          when S_START_PAYLOAD =>
            if payload_type = "00" then
              id_pkt_tester <= pkt_rx_data_N;
            end if;
          when S_PAYLOAD =>
            if payload_type = "00" then

            elsif payload_type = "01" then
              lfsr_fsm_begin <= '1';
            elsif payload_type = "10" then
              null;
            else
              null;
            end if;

          when others => null;
        end case;
      end if;
    end process;

    --------------------------------------------------------------------------------
    -- ID CHECKER
    --------------------------------------------------------------------------------
    pkt_sequence_error <= '1' when (id_sequence_counter < pkt_sequence_in) else '0';
    pkt_sequence_error_flag <= pkt_sequence_error_flag_aux;

    id_checker : process(reset, clock)
    begin
      if reset = '0' then
        id_sequence_counter <= (others => '0');
        pkt_sequence_error_flag_aux <= '0';
      elsif rising_edge(clock) then
        if current_s = S_START_PAYLOAD and payload_type = "00" and verify_system_rec = '1' then
           if (id_pkt_tester = (pkt_rx_data_N - '1')) then
             pkt_sequence_error_flag_aux <= '0';
             id_sequence_counter <= id_sequence_counter + '1';
           else
             pkt_sequence_error_flag_aux <= '1';
             id_sequence_counter <= (others => '0');
           end if;
        else
          pkt_sequence_error_flag_aux <= '0';
        end if;
      end if;
    end process;


    packets_lost <= lost_pkt_tester;
    RESET_done   <= '1' when lost_counter >= 1000 else '0';

    reset_id_diff_test : process(reset, clock)
    begin
      if reset = '0' then
        lost_pkt_flag <= '0';
        lost_pkt_tester <= (others => '0');
        not_lost_pkt_test <= '0';
        lost_counter <= (others => '0');
      elsif rising_edge(clock) then
        if current_s = S_START_PAYLOAD and payload_type = "00" and reset_test = '1' then
          if (id_pkt_tester = (pkt_rx_data_N - '1')) then
            if lost_pkt_flag = '1' then
              lost_counter <= lost_counter + '1';
            end if;
            not_lost_pkt_test <= '1';
          else
            lost_pkt_tester <= lost_pkt_tester + pkt_rx_data_N - id_pkt_tester - '1';
            lost_counter <= (others => '0');
            lost_pkt_flag <= '1';
            not_lost_pkt_test <= '0';
          end if;
        end if;
      end if;
    end process;

    -------------------------------------------------------------------------------
    -- BERT TEST AND LFSR
    -------------------------------------------------------------------------------

    pipelined_lfsr_inputs : process(reset, clock)
    begin
      if reset = '0' then
          lfsr_start_delay <= '0';
          lfsr_test_begin <= '0';
          Delay_B0 <= (others => '0');
          Delay_B1 <= (others => '0');
          Delay_B2 <= (others => '0');
          lfsr_resync_RANDOM <= (others => '0');
          lfsr_resync_SIGNAL <= (others => '0');
          lfsr_counter <= 0;
          lfsr_resync_ON <= '0';
      elsif rising_edge(clock) then
        case lfsr_state is
          when S_IDLE =>
            lfsr_test_begin <= '0';
            lfsr_resync_ON <= '0';
            lfsr_start_delay <= '0';
            lfsr_counter <= 0;
            Delay_B0 <= (others => '0');
            Delay_B1 <= (others => '0');
            Delay_B2 <= (others => '0');
            if lfsr_fsm_begin = '1' then
              lfsr_state <= S_SETUP_PIPELINE;
            end if;
          when S_SETUP_PIPELINE =>
            lfsr_start_delay <= '1';
            Delay_B0 <= pkt_rx_data_N;
            Delay_B1 <= Delay_B0;
            Delay_B2 <= Delay_B1;
            if lfsr_counter = 2 then
              lfsr_counter <= 0;
              lfsr_test_begin <= '1';
              lfsr_state <= S_SETUP_DELAY;
            else
              lfsr_counter <= lfsr_counter +1;
            end if;
          when S_SETUP_DELAY =>
              Delay_B0 <= pkt_rx_data_N;
              Delay_B1 <= Delay_B0;
              Delay_B2 <= Delay_B1;
              if lfsr_fsm_begin = '0' Then
                lfsr_start_delay <= '0';
                lfsr_state <= S_IDLE;
             elsif lfsr_counter = 7 then
                lfsr_test_begin <= '1';
                lfsr_state <= S_RUN;
                lfsr_counter <= 0;
              elsif lfsr_counter = 6 then
                lfsr_test_begin <= '1';
                lfsr_resync_RANDOM <= RANDOM;
                lfsr_counter <= lfsr_counter +1;
              elsif lfsr_counter = 5 then
                lfsr_test_begin <= '0';
                lfsr_counter <= lfsr_counter +1;
              else
                lfsr_counter <= lfsr_counter +1;
              end if;
          when S_RUN =>
            Delay_B0 <= pkt_rx_data_N;
            Delay_B1 <= Delay_B0;
            Delay_B2 <= Delay_B1;
            if lfsr_fsm_begin = '0' Then
              lfsr_start_delay <= '0';
              lfsr_state <= S_IDLE;
           elsif lfsr_counter = 7 then
              lfsr_counter <= 0;
            elsif lfsr_counter = 6 then
              lfsr_resync_RANDOM <= RANDOM;
              lfsr_resync_ON <= '0';
              lfsr_counter <= lfsr_counter +1;
            elsif lfsr_counter = 5 then
              lfsr_resync_ON <= '1';
              lfsr_counter <= lfsr_counter +1;
            elsif lfsr_counter = 3 then
              lfsr_counter <= lfsr_counter +1;
              lfsr_resync_SIGNAL <= Delay_B1;
            else
              lfsr_counter <= lfsr_counter +1;
            end if;
        end case;
      end if;
    end process;

    start <= lfsr_start or lfsr_start_delay;
    lfsr_bert <= lfsr_resync_SIGNAL when lfsr_resync_ON = '1' else
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
      start => start,
      data_out => RANDOM
    );

    bert_target_lfsr <= lfsr_resync_RANDOM when lfsr_resync_ON = '1' else
                   RANDOM;

    bert_xor <= pkt_rx_data_N xor ALL_ONE when payload_type = "11" else
                pkt_rx_data_N xor ALL_ZERO when payload_type = "10" else
                bert_target_lfsr xor lfsr_bert when payload_type = "01" else
                (others=>'0');

    bert_test_begin <= (lfsr_test_begin or const_test_begin);

    bert_count_flip <= count_ones(bert_xor) when bert_test_begin = '1' else (others => '0');

    count_error <= bert_n_flipped_b;


    BERT: process (clock, reset)
    begin
      if(reset = '0') then
        bert_n_flipped_b <= (others=>'0');
        bert_cycle_wrong <= (others=>'0');
      elsif rising_edge(clock) then
        if recovery_ON = '1' then
          bert_n_flipped_b <= recovery_n_flipped_b;
          bert_cycle_wrong <= recovery_cycle_wrong;
        elsif bert_test_begin = '1' then
            bert_n_flipped_b <= bert_n_flipped_b + bert_count_flip;
            if (bert_count_flip /= 0 ) then
                bert_cycle_wrong <= bert_cycle_wrong + 1;
            end if;
        end if;
      end if;
    end process;



    -------------------------------------------------------------------------------
    -- ERROR CORRECTION
    -------------------------------------------------------------------------------

    recovery_start_pkt <= pkt_rx_sop and pkt_rx_avail;
    recovery_stop_pkt <= pkt_rx_eop and pkt_rx_avail;


    ERROR_RECOVERY: process (clock, reset)
    begin
      if(reset = '0') then
        recovery_state <= S_WAIT_START;
        recovery_n_flipped_b <= (others => '0');
        recovery_cycle_wrong <= (others => '0');
      elsif rising_edge(clock) then
        case recovery_state is
          when S_WAIT_START =>
            if recovery_start_pkt = '1' then
              recovery_state <= S_WAIT_STOP;
              recovery_n_flipped_b <= bert_n_flipped_b;
              recovery_cycle_wrong <= bert_cycle_wrong;
            end if;
          when S_WAIT_STOP =>
            if recovery_stop_pkt = '1' then
              recovery_state <= S_WAIT_START;
            elsif recovery_start_pkt = '1' then
              recovery_state <= S_RECOVERY;
              recovery_ON <= '1';
            end if;
          when S_RECOVERY =>
            recovery_ON <= '0';
            recovery_state <= S_WAIT_STOP;
        end case;
      end if;
    end process;


end arch_echo_receiver_128_v2;
