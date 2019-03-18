library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
use ieee.numeric_std.all;
-- MUDAR BARRAMENTO 256b
-- MUDAR CLOCK 312.5 Mhz
entity echo_receiver_128_old is
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
        RESET_done 	   	: out std_logic; -- to RFC254|
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
        payload_type             : in std_logic_vector(2 downto 0);
        verify_system_rec        : in std_logic;
        reset_test		           : in std_logic;						 -- activates reset test
        pkt_sequence_in          : in std_logic_vector(15 downto 0);   -- number of packets to define if recovery is completed
        pkt_sequence_error_flag  : out std_logic; -- to RFC254|
        pkt_sequence_error       : out std_logic;                -- '0' if sequence is ok, '1' if error in sequence and not recovered -- to RFC254|
        cont_error               : out std_logic_vector(127 downto 0);
        IDLE_count               : out std_logic_vector(127 downto 0)
    );
end echo_receiver_128_old;

architecture arch_echo_receiver_128_old of echo_receiver_128_old is
    -------------------------------------------------------------------------------
    -- Debug
    -------------------------------------------------------------------------------
    attribute mark_debug : string;

    -------------------------------------------------------------------------------
    -- State
    -------------------------------------------------------------------------------
    type   state_type is (START_PKT, ETHERNET, IP, S_TIMESTAMP,  S_PAYLOAD, S_IDLE, TYPE_0, TYPE_1, TYPE_2, TYPE_3);
    signal current_s, next_s : state_type;
    signal debug_reset : std_logic;
	  attribute mark_debug of debug_reset      : signal is "true";
    signal rx_mod : std_logic_vector(3 downto 0);
    signal rx_eop : std_logic;
    attribute mark_debug of rx_eop : signal is "true";
    signal rx_sop : std_logic;
    attribute mark_debug of rx_sop : signal is "true";
    -------------------------------------------------------------------------------
    -- Registers
    -------------------------------------------------------------------------------
    signal reg_rest_of_bits                    : std_logic_vector(87 downto 0):= (others => '0'); --sobra do frame 2 para ser usado nos types
    signal reg_mac_source, reg_mac_destination : std_logic_vector(47 downto 0);
    signal reg_ip_source, reg_ip_destination   : std_logic_vector(31 downto 0);
    signal reg_ethernet_type                   : std_logic_vector(15 downto 0);
    signal reg_ip_protocol                     : std_logic_vector(7 downto 0);
    signal reg_ip_message_length               : std_logic_vector(15 downto 0);
    signal reg_time_stamp                      : std_logic_vector(47 downto 0);
    signal last_pkt_id					           	   : std_logic_vector(63 downto 0);
    attribute mark_debug of last_pkt_id        : signal is "true";
    signal lost								                 : std_logic;
    signal reset_counter					             : std_logic_vector(31 downto 0);
    attribute mark_debug of reset_counter      : signal is "true";
    signal reg_lfsr                            : std_logic_vector(127 downto 0):= (others => '0');
	  signal count_one_lost					             : std_logic;
    signal reg_zero                            : std_logic_vector(127 downto 0) := (others => '0');
    signal reg_one                             : std_logic_vector(127 downto 0) := (others => '1');
    signal pkt_rx_data_reg                     : std_logic_vector(127 downto 0);  -- Receive data
    signal pkt_rx_data_id_count                : std_logic_vector(63 downto 0); --change bit order to sub from last id
    -------------------------------------------------------------------------------
    -- LFSR  - Signals to be used
    -------------------------------------------------------------------------------
    ---TEST SIGNAL BE DELETED
    signal data_in_lfsr                       : std_logic_vector(127 downto 0);
    signal data_bit_fixed                     : std_logic_vector(63 downto 0);
    --- END TEST SIGNAL BE DELETED

    signal random                             : std_logic_vector(127 downto 0);
    signal random_ppl                         : std_logic_vector(127 downto 0);
    signal random_reg                         : std_logic_vector(127 downto 0);
    signal start, start_reg                   : std_logic;
    -------------------------------------------------------------------------------
    -- Others
    -------------------------------------------------------------------------------
    signal flag_id_counter                    : std_logic ; --only get id the first time type_0 is executed.
    signal flag_reg_zero                      : std_logic ; --reg_zero
    signal flag_reg_one                      : std_logic ; --reg_zero
    -------------------------------------------------------------------------------
    -------------------------------------------------------------------------------
    signal is_ip_packet                       : std_logic;
    signal is_udp_packet                      : std_logic;
    signal time_stamp_recv                    : std_logic_vector(46 downto 0);
    signal my_time_stamp                      : std_logic_vector(47 downto 0);
    signal pkt_sequence_error_flag_aux        : std_logic;
    signal pkt_id_counter                     : std_logic_vector(63 downto 0);
    signal sequence_counter                   : std_logic_vector(15 downto 0);
    signal received_packet_wire               : std_logic;
    signal IDLE_count_reg                     : std_logic_vector(127 downto 0);
    signal flag_lfsr_16_rem, flag_lfsr_32_rem, flag_lfsr_48_rem, flag_lfsr_8_rem, flag_lfsr_24_rem, flag_lfsr_40_rem, flag_lfsr_56_rem : std_logic;
    signal lfsr_rem                           : std_logic_vector(55 downto 0) := (others=>'0');
    signal bits_wrong                         : std_logic_vector(127 downto 0);
    signal bits_wrong_xor                     : std_logic_vector(127 downto 0) := (others => '0');
    signal cycle_with_bits_wrong              : std_logic_vector(127 downto 0);
    signal lfsr_seed_wire, lfsr_resync_seed   : std_logic_vector(127 downto 0):= (others => '0'); -- changed due to new vector length 64b -> 128b
    signal resync_lfsr, resync2_lfsr, valid_seed_wire, resync_done: std_logic;
  	signal id_diff	                      	  : std_logic_vector(63 downto 0) := (others => '0') ;
    signal debug_id_diff                      : std_logic_vector(63 downto 0) := (others => '0');
    signal reg_id_current		                  : std_logic_vector(63 downto 0) := (others => '0');
	  signal reg_id_last		                    : std_logic_vector(63 downto 0) := (others => '0');
    signal flag                               : std_logic;

    function count_ones(s : std_logic_vector)
                     return std_logic_vector
      is
        variable temp : std_logic_vector(127 downto 0) := (others => '0');
        begin
          for i in s'range loop
            temp(i) := s(i) and '1';
            --if s(i) = '1' then temp := temp + '1';
          --end if;
        end loop;

        return temp;
    end function count_ones;

begin

    is_ip_packet <= '1' when reg_ethernet_type = x"0008" else '0'; --0080 para 0008
    is_udp_packet <= '1' when reg_ip_protocol = x"11" else '0';
    pkt_sequence_error_flag <= pkt_sequence_error_flag_aux;
    received_packet <= received_packet_wire;
    IDLE_count <= IDLE_count_reg;
    rx_eop <= pkt_rx_eop;
    rx_sop <= pkt_rx_sop;
    rx_mod <= pkt_rx_mod;
  -------------------------------------------------------------------------------
  -- Combinational Logic
  -------------------------------------------------------------------------------
  -- Updates the current state
    process(current_s, pkt_rx_avail, pkt_rx_sop, pkt_rx_eop, pkt_rx_mod, flag_lfsr_48_rem, flag_lfsr_32_rem, flag_lfsr_16_rem, flag_lfsr_24_rem, flag_lfsr_8_rem, flag_lfsr_40_rem, flag_lfsr_56_rem, payload_type, pkt_rx_err, mac_source, reg_mac_destination)
    begin
        next_s <= current_s;
        pkt_rx_ren <= '0';
        received_packet_wire <= '0';
        start <= '0';
---VERIFICAR NUMERO DE ESTAGIOS PARA 128B
        case current_s is
            when START_PKT =>
                if pkt_rx_avail = '1' and pkt_rx_sop = '1'  then
                    pkt_rx_ren <= '1';
                    next_s <= ETHERNET;
                else
                    pkt_rx_ren <= '0';
                    next_s <= START_PKT;
                end if;

            when S_IDLE =>
                if pkt_rx_avail = '1' and pkt_rx_sop = '1' then
                    pkt_rx_ren <= '1';
                    next_s <= ETHERNET;
                else
                    pkt_rx_ren <= '0';
                end if;

            when ETHERNET =>
              if pkt_rx_eop = '0' and pkt_rx_avail = '1' then
                pkt_rx_ren <= '1';
                -- if is_ip_packet = '1' then
                  next_s <= IP;
                -- else
                --   next_s <= S_IDLE;
                -- end if;
              else
                next_s <= S_IDLE;
              end if;

            when IP =>
                pkt_rx_ren <= '1';
              if pkt_rx_avail = '1' and pkt_rx_sop = '0' then
                case payload_type is
                  when  "000" =>
                    next_s <= TYPE_0;
                  when  "001" =>
                    if (flag_lfsr_16_rem = '1' or flag_lfsr_24_rem = '1' or flag_lfsr_32_rem = '1' or flag_lfsr_40_rem = '1' or flag_lfsr_48_rem = '1' or flag_lfsr_56_rem = '1' ) then
                           start <= '1';
                    end if;
                     start <= '1';
                    next_s <= TYPE_1;
                  when  "010" =>
                    next_s <= TYPE_2;
                    start    <= '1';
                  when  "011" =>
                    next_s <= TYPE_3;
                    start    <= '1';
                    --temporario
                  when others =>
                    next_s <= S_IDLE;
                  end case;
              elsif pkt_rx_avail = '1' and pkt_rx_eop = '1' then
                        next_s <= S_IDLE;
              elsif pkt_rx_err = '1' and pkt_rx_avail = '1' then
                        pkt_rx_ren <= '1';
                        next_s <= ETHERNET;
              end if;

            when TYPE_0 =>
                pkt_rx_ren <= '1';
                if pkt_rx_avail = '1' and pkt_rx_eop = '1' then
                        next_s <= S_IDLE;

                elsif pkt_rx_err = '1' and pkt_rx_avail = '0' then
                        pkt_rx_ren <= '0';
                        next_s <= S_IDLE;

                elsif pkt_rx_err = '1' and pkt_rx_avail = '1' then
                        pkt_rx_ren <= '1';
                        next_s <= ETHERNET;
                else
                    next_s <= TYPE_0;
                end if;


            when TYPE_1 =>
                pkt_rx_ren <= '1';
                next_s   <= S_PAYLOAD;
                start    <= '1';
              when TYPE_2 =>
                pkt_rx_ren <= '1';
            if pkt_rx_avail = '1' and pkt_rx_eop = '1' then
                    next_s <= S_IDLE;

            elsif pkt_rx_err = '1' and pkt_rx_avail = '0' then
                    pkt_rx_ren <= '0';
                    next_s <= S_IDLE;

            elsif pkt_rx_err = '1' and pkt_rx_avail = '1' then
                    pkt_rx_ren <= '1';
                    next_s <= ETHERNET;
            else
                next_s <= TYPE_2;
            end if;

           when TYPE_3 =>
               pkt_rx_ren <= '1';
              if pkt_rx_avail = '1' and pkt_rx_eop = '1' then
                      next_s <= S_IDLE;

              elsif pkt_rx_err = '1' and pkt_rx_avail = '0' then
                      pkt_rx_ren <= '0';
                      next_s <= S_IDLE;

              elsif pkt_rx_err = '1' and pkt_rx_avail = '1' then
                      pkt_rx_ren <= '1';
                      next_s <= ETHERNET;
              else
                  next_s <= TYPE_3;
              end if;

            when  S_PAYLOAD =>
              if pkt_rx_eop = '1' then
                    --if payload_type = "001" then
                          if pkt_rx_mod = "0001" and flag_lfsr_56_rem = '1' then
                              start <= '1';
                          elsif pkt_rx_mod = "0010" and (flag_lfsr_48_rem = '1' or flag_lfsr_56_rem = '1')  then
                              start <= '1';
                          elsif pkt_rx_mod = "0011" and (flag_lfsr_40_rem = '1' or flag_lfsr_48_rem = '1' or flag_lfsr_56_rem = '1') then
                              start <= '1';
                          elsif pkt_rx_mod = "0100" and (flag_lfsr_32_rem = '1' or flag_lfsr_40_rem = '1' or flag_lfsr_48_rem = '1' or flag_lfsr_56_rem = '1')  then
                              start <= '1';
                          elsif pkt_rx_mod = "0101" and (flag_lfsr_24_rem = '1' or flag_lfsr_32_rem = '1' or flag_lfsr_40_rem = '1' or flag_lfsr_48_rem = '1' or flag_lfsr_56_rem = '1') then
                              start <= '1';
                          elsif pkt_rx_mod = "0110" and (flag_lfsr_16_rem = '1' or flag_lfsr_24_rem = '1' or flag_lfsr_32_rem = '1' or flag_lfsr_40_rem = '1' or flag_lfsr_48_rem = '1' or flag_lfsr_56_rem = '1') then
                              start <= '1';
                          elsif pkt_rx_mod = "0111" and (flag_lfsr_8_rem = '1' or flag_lfsr_16_rem = '1' or flag_lfsr_24_rem = '1' or flag_lfsr_32_rem = '1' or flag_lfsr_40_rem = '1' or flag_lfsr_48_rem = '1' or flag_lfsr_56_rem = '1') then
                              start <= '1';
                          elsif pkt_rx_mod = "0000" then
                              start <= '1';
                          -- added else... pkt_rx_mod passando de 3bits para 4 bits (variavel de teste)
                          -- devido a entrada possuir 128bits
                          else
                              start <= '1';
                          end if;
             end if;
             if pkt_rx_avail = '1' and pkt_rx_eop = '1' then
                     next_s <= S_IDLE;

             elsif pkt_rx_err = '1' and pkt_rx_avail = '0' then
                     pkt_rx_ren <= '0';
                     next_s <= S_IDLE;

             elsif pkt_rx_err = '1' and pkt_rx_avail = '1' then
                     pkt_rx_ren <= '1';
                     next_s <= ETHERNET;
             else
                 next_s <= S_PAYLOAD;
             end if;

        when others =>
                next_s <= START_PKT;

        end case;

    end process;

  -------------------------------------------------------------------------------
  -- Sequential Logic
  -------------------------------------------------------------------------------

  -- Updates the header iterator
    process(reset, clock)
    begin
        if reset = '0' then
          current_s <= START_PKT;
        elsif rising_edge(clock) then
            current_s <= next_s;
        end if;
    end process;
    -- Extracts the packet info
    process(reset, clock)
    begin
        if reset = '0' then
            -- current_s <= START_PKT;
            IDLE_count_reg        <= (others => '0');
            reg_mac_destination   <= (others => '0');
            reg_mac_source        <= (others => '0');
            reg_ethernet_type     <= (others => '0');
            reg_ip_protocol       <= (others => '0');
            reg_ip_message_length <= (others => '0');
            reg_ip_source         <= (others => '0');
            reg_ip_destination    <= (others => '0');
            reg_time_stamp        <= (others => '0');
      pkt_id_counter        <= (others => '0');
      flag_lfsr_8_rem <= '0';
            flag_lfsr_16_rem <= '0';
            flag_lfsr_24_rem <= '0';
            flag_lfsr_32_rem <= '0';
            flag_lfsr_40_rem <= '0';
            flag_lfsr_48_rem <= '0';
            flag_lfsr_56_rem <= '0';
            flag_id_counter <= '0';
            flag_reg_zero <= '0';
            flag_reg_one <= '0';
            reg_lfsr <= (others=>'0');
            pkt_rx_data_reg <= (others=>'0');
        elsif rising_edge(clock) then
            pkt_rx_data_reg       <= pkt_rx_data;
            reg_mac_destination   <= reg_mac_destination;
            reg_mac_source        <= reg_mac_source;
            reg_ethernet_type     <= reg_ethernet_type;
            reg_ip_protocol       <= reg_ip_protocol;
            reg_ip_message_length <= reg_ip_message_length;
            reg_ip_source         <= reg_ip_source;
            reg_ip_destination    <= reg_ip_destination;
            reg_time_stamp        <= reg_time_stamp;
         if resync2_lfsr = '1' or resync_lfsr = '1' then
                    flag_lfsr_8_rem <= '0';
                    flag_lfsr_16_rem <= '0';
                    flag_lfsr_24_rem <= '0';
                    flag_lfsr_32_rem <= '0';
                    flag_lfsr_40_rem <= '0';
                    flag_lfsr_48_rem <= '0';
                    flag_lfsr_56_rem <= '0';
                end if;
        case current_s is
           when S_IDLE =>
                IDLE_count_reg <= IDLE_count_reg + '1';
                flag_id_counter <= '0';
              --  flag_reg_zero <= not(flag_reg_zero);
                flag_reg_zero <= '0';
                flag_reg_one <= '0';
            when ETHERNET =>
                IDLE_count_reg <= IDLE_count_reg + '1';
                reg_mac_destination                 <= pkt_rx_data_reg(47 downto 0); --x"AA00BB11CC22"
                reg_mac_source                      <= pkt_rx_data_reg(95 downto 48); --x"00AA11BB22CC"
                reg_ethernet_type                   <= pkt_rx_data_reg(111 downto 96); --x"0080" 0045???
                if is_ip_packet = '1' then
                  reg_ip_message_length               <= pkt_rx_data(15 downto 0); --DC05 if UPD 05C8
                end if;
                reg_rest_of_bits (15 downto 0)      <= pkt_rx_data_reg (127 downto 112);
                flag_id_counter <= '0';
              --  flag_reg_zero <= not(flag_reg_zero);
                flag_reg_zero <= '0';
                flag_reg_one <= '0';
            when IP =>
                IDLE_count_reg <= IDLE_count_reg + '1';
                reg_ip_protocol                        <= pkt_rx_data_reg(63 downto 56); --x'11'
                reg_rest_of_bits (87 downto 16)        <= pkt_rx_data(127 downto 56); --88 bits -necessario para reg_time_stamp
                reg_ip_source                          <= pkt_rx_data_reg(111 downto 80); --x"0ABCDE01"
                reg_ip_destination                     <= pkt_rx_data(15 downto 0) & pkt_rx_data_reg(127 downto 112);--x"0ABCDE02"
                flag_id_counter <= '0';
              --  flag_reg_zero <= '0';
                ---             VER
                if resync2_lfsr = '1' or resync_lfsr = '1' then
                    flag_lfsr_8_rem <= '0';
                    flag_lfsr_16_rem <= '0';
                    flag_lfsr_24_rem <= '0';
                    flag_lfsr_32_rem <= '0';
                    flag_lfsr_40_rem <= '0';
                    flag_lfsr_48_rem <= '0';
                    flag_lfsr_56_rem <= '0';
                end if;
            --- payload_type = 0
            when TYPE_0 =>
            ---time stamp continua 48b
            IDLE_count_reg <= IDLE_count_reg + '1';
                reg_time_stamp <= reg_rest_of_bits(83 downto 36); --x"10000001"
                if flag_id_counter = '0' then
                   pkt_id_counter <= pkt_rx_data(7 downto 0) & pkt_rx_data(15 downto 8) & pkt_rx_data(23 downto 16)  & pkt_rx_data(31 downto 24) & pkt_rx_data(39 downto 32) & pkt_rx_data(47 downto 40) & pkt_rx_data(55 downto 48) & pkt_rx_data(63 downto 56);
                   flag_id_counter <= '1';
                   pkt_rx_data_id_count <= pkt_rx_data(7 downto 0) & pkt_rx_data(15 downto 8) & pkt_rx_data(23 downto 16)  & pkt_rx_data(31 downto 24) & pkt_rx_data(39 downto 32) & pkt_rx_data(47 downto 40) & pkt_rx_data(55 downto 48) & pkt_rx_data(63 downto 56);
                end if;
                   --count +1 +1 +1...


            --- payload_type = 1
            when TYPE_1 =>
            IDLE_count_reg <= IDLE_count_reg + '1';
            reg_lfsr <= pkt_rx_data;

            when TYPE_2 => --all 0s ---ver data 64 -> 128
            IDLE_count_reg <= IDLE_count_reg + '1';
            if flag_reg_zero = '0' then
               reg_zero(127 downto 64)  <= pkt_rx_data_reg(127 downto 64);
               reg_zero(63 downto 0) <= (others=>'0');
               flag_reg_zero <= '1';
            else
              if pkt_rx_mod = "0001" then
                  reg_zero(127 downto 120) <= pkt_rx_data_reg(127 downto 120);
                  reg_zero(119 downto 0)  <= (others=>'0');
              elsif pkt_rx_mod = "0010" then
                 reg_zero(127 downto 112) <= pkt_rx_data_reg(127 downto 112);
                 reg_zero(111 downto 0)  <= (others=>'0');
              elsif pkt_rx_mod = "0011" then
                 reg_zero(127 downto 104) <= pkt_rx_data_reg(127 downto 104);
                 reg_zero(103 downto 0)  <= (others=>'0');
              elsif pkt_rx_mod = "0100" then
                 reg_zero(127 downto 96) <= pkt_rx_data_reg(127 downto 96);
                 reg_zero(95 downto 0)  <= (others=>'0');
              elsif pkt_rx_mod = "0101" then
                 reg_zero(127 downto 88) <= pkt_rx_data_reg(127 downto 88);
                 reg_zero(87 downto 0)  <= (others=>'0');
              elsif pkt_rx_mod = "0110" then
                 reg_zero(127 downto 80) <= pkt_rx_data_reg(127 downto 80);
                 reg_zero(79 downto 0)  <= (others=>'0');
              elsif pkt_rx_mod = "0111" then
                 reg_zero(127 downto 72) <= pkt_rx_data_reg(127 downto 72);
                 reg_zero(71 downto 0)  <= (others=>'0');
              else
                 reg_zero(127 downto 0) <= pkt_rx_data_reg(127 downto 0);
              end if;
            end if;

            when TYPE_3 => --all 1s  ---ver data
            IDLE_count_reg <= IDLE_count_reg + '1';
              if flag_reg_one = '0' then
                 reg_one(127 downto 98)  <= pkt_rx_data_reg(127 downto 98);
                 reg_one(89 downto 0) <= (others=>'1');
                 flag_reg_one <= '1';
              else
                 if pkt_rx_mod = "0001" then
                     reg_one(127 downto 120) <= pkt_rx_data_reg(127 downto 120);
                     reg_one(119 downto 0)  <= (others=>'1');
                 elsif pkt_rx_mod = "0010" then
                    reg_one(127 downto 112) <= pkt_rx_data_reg(127 downto 112);
                    reg_one(111 downto 0)  <= (others=>'1');
                elsif pkt_rx_mod = "0011" then
                    reg_one(127 downto 104) <= pkt_rx_data_reg(127 downto 104);
                    reg_one(103 downto 0)  <= (others=>'1');
                elsif pkt_rx_mod = "0100" then
                    reg_one(127 downto 96) <= pkt_rx_data_reg(127 downto 96);
                    reg_one(95 downto 0)  <= (others=>'1');
                elsif pkt_rx_mod = "0101" then
                    reg_one(127 downto 88) <= pkt_rx_data_reg(127 downto 88);
                    reg_one(87 downto 0)  <= (others=>'1');
                elsif pkt_rx_mod = "0110" then
                    reg_one(127 downto 80) <= pkt_rx_data_reg(127 downto 80);
                    reg_one(79 downto 0)  <= (others=>'1');
                elsif pkt_rx_mod = "0111" then
                    reg_one(127 downto 72) <= pkt_rx_data_reg(127 downto 72);
                    reg_one(71 downto 0)  <= (others=>'1');
                else
                    reg_one(127 downto 64) <= pkt_rx_data_reg(127 downto 64);
                    reg_one(63 downto 0)  <= (others=>'1');
                end if;
            end if;


            when S_PAYLOAD =>
            IDLE_count_reg <= IDLE_count_reg + '1';
                if pkt_rx_eop = '1' then
                  reg_lfsr <= pkt_rx_data;
                else
                  reg_lfsr <= pkt_rx_data;
               end if;
            when others =>
                null;

        end case;
    end if;
end process;

    mac_source_rx <= reg_mac_source;
    mac_destination <= reg_mac_destination;
    ip_source <= reg_ip_source;
    ip_destination <= reg_ip_destination;

--SYSTEM RECOVERY TEST
    process(reset, clock)
    begin
        if reset = '0' then
            pkt_sequence_error_flag_aux <= '0';
            sequence_counter <= (others => '0');
        elsif rising_edge(clock) then
          if flag_id_counter = '0'then
            if current_s = TYPE_0 and verify_system_rec = '1'  then
                if (pkt_id_counter = (pkt_rx_data_id_count - '1')) then
                    pkt_sequence_error_flag_aux <= '0';
                    sequence_counter <= sequence_counter + '1';
                else
                    pkt_sequence_error_flag_aux <= '1';
                    sequence_counter <= (others => '0');
                end if;
            else
                pkt_sequence_error_flag_aux <= '0';
            end if;
        end if;
      end if;
    end process;

	--RESET TEST
    process(reset, clock)
    begin
        if reset = '0' then
			        id_diff  <= (others => '0');
			        lost <= '0';
			        reset_counter <= (others => '0');
			        last_pkt_id <= (others => '0');
			        count_one_lost <= '0';
        elsif rising_edge(clock) then
          if flag_id_counter = '0'then
            if current_s = TYPE_0 and reset_test = '1' then
                if (pkt_id_counter = (pkt_rx_data_id_count - '1')) then
					             if lost = '1' then
						                   reset_counter <= reset_counter + '1';
					             end if;
                    count_one_lost <= '1';
               else
					--report "Salvando ID perdido!";
					       last_pkt_id <= pkt_rx_data_id_count;
                 lost <= '1';
                 id_diff <= id_diff + (pkt_rx_data(7 downto 0) & pkt_rx_data(15 downto 8) & pkt_rx_data(23 downto 16)  & pkt_rx_data(31 downto 24) & pkt_rx_data(39 downto 32) & pkt_rx_data(47 downto 40) & pkt_rx_data(55 downto 48) & pkt_rx_data(63 downto 56)) - pkt_id_counter - '1';
                 reg_id_current	<= (pkt_rx_data(7 downto 0) & pkt_rx_data(15 downto 8) & pkt_rx_data(23 downto 16)  & pkt_rx_data(31 downto 24) & pkt_rx_data(39 downto 32) & pkt_rx_data(47 downto 40) & pkt_rx_data(55 downto 48) & pkt_rx_data(63 downto 56));
                 reg_id_last		<= pkt_id_counter;
					       reset_counter <= (others => '0');
              end if;
            end if;
        end if;
      end if;
    end process;


    -- the system has recovered from the reset
	packets_lost <= id_diff;
	RESET_done   <= '1' when reset_counter >= 1000 else '0'; -- rever mod 1111
	debug_reset  <= '1' when reset_counter >= 1000 else '0';

--LFSR CIRCUIT INSTANTIATION AND AUX SIGNAL

    data_bit_fixed <= pkt_rx_data(71 downto 64) & pkt_rx_data(79 downto 72) & pkt_rx_data(87 downto 80)  & pkt_rx_data(95 downto 88) &
                     pkt_rx_data(103 downto 96) & pkt_rx_data(111 downto 104) & pkt_rx_data(119 downto 112) &
                     pkt_rx_data(127 downto 120);


    data_in_lfsr <= x"0000000000000000" &  data_bit_fixed when current_s = IP
                    else random;


        LFSR_RECEIVER: entity work.LFSR_REC
        generic map (DATA_SIZE => 128,
                     PPL_SIZE => 4)
        port map(
          clock => clock,
          reset_N => reset,
          seed => lfsr_seed_wire,
          polynomial => lfsr_polynomial,
          data_in => pkt_rx_data,
          start => start,
          data_out => random_ppl
        );

--PAYLOAD VERIFICATION FOR BERT TEST

    -- CHECKS DATA IN XOR CONST WHEN TYPE  1 || 2 OR CHECKS DATA IN XOR LFSR
    bits_wrong_xor <= reg_zero xor x"00000000000000000000000000000000" when payload_type = "010" and current_s = TYPE_2 else
                      reg_one  xor x"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF" when payload_type = "011" and current_s = TYPE_3 else
                      random_reg xor reg_lfsr when payload_type = "001" and (current_s = TYPE_1 or current_s = S_PAYLOAD) and start_reg = '1' else
                      (others=>'0');

    -- PROCESS THAT RUNS BERT TEST
    -- COUNTS BITS FLIPPED IN PAYLOAD
    process (clock, reset)
    begin
      if(reset = '0') then
        bits_wrong <= (others=>'0');
        cycle_with_bits_wrong <= (others=>'0');
        random_reg <= random;
        start_reg <= start;
       -- resync_lfsr <= '0';
        resync_done <= '0';
      elsif rising_edge(clock) then
        random_reg <=    random(7 downto 0) & random(15 downto 8)  & random(23 downto 16) &
                         random(31 downto 24) & random(39 downto 32) & random(47 downto 40) &
                         random(55 downto 48) & random(63 downto 56) & random(71 downto 64) &
                         random(79 downto 72) & random(87 downto 80)  & random(95 downto 88) &
                         random(103 downto 96) & random(111 downto 104) & random(119 downto 112) &
                         random(127 downto 120);
        start_reg <= start;
        if (payload_type = "001" and current_s = S_PAYLOAD) or (payload_type = "010" or payload_type = "011") then
            bits_wrong <= bits_wrong + count_ones(bits_wrong_xor);
            if (count_ones(bits_wrong_xor) /= 0 and (current_s = TYPE_1 or current_s = TYPE_2 or current_s = TYPE_3 or current_s = S_PAYLOAD)) then
                cycle_with_bits_wrong <= cycle_with_bits_wrong + 1;
            end if;

        end if;
        if resync_lfsr = '1' then
            cycle_with_bits_wrong <= (others=>'0');
            resync_done <= '1';
        elsif resync2_lfsr = '1' then
            cycle_with_bits_wrong <= (others=>'0');
            resync_done <= '0';
        end if;

      end if;
    end process;

    resync_lfsr <= '1' when resync_done = '0' and cycle_with_bits_wrong >= 2 and pkt_rx_sop = '1' else '0';
    resync2_lfsr <= '1' when resync_done = '1' and cycle_with_bits_wrong >= 1 and pkt_rx_sop = '1' else '0';

    lfsr_seed_wire <=  lfsr_seed when valid_seed = '1' else
            lfsr_resync_seed;

    valid_seed_wire <= resync_lfsr or resync2_lfsr or valid_seed;

    pkt_sequence_error <= '1' when (sequence_counter < pkt_sequence_in) else '0';

-- Timestamp value to be compared with the timestamp from packet
    time_stamp_recv <= timestamp_base (46 downto 0);

    time_stamp_out <= ('0' & (time_stamp_recv(46 downto 0) - reg_time_stamp(47 downto 1))) when (received_packet_wire = '1') and (is_ip_packet = '1') and (is_udp_packet = '1') and (reg_time_stamp(0) = '1')
                  else (others=>'0');

    end_latency <= '1' when ((received_packet_wire = '1') and (is_ip_packet = '1') and (is_udp_packet = '1') and (reg_time_stamp(0) = '1')) else '0';

    cont_error <= bits_wrong;

end arch_echo_receiver_128_old;
