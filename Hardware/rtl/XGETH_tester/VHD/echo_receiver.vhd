library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
use ieee.numeric_std.all;

entity echo_receiver is
  port
    (
        clock : in std_logic;             -- Clock 156.25 MHz
        reset : in std_logic;             -- Reset (Active High)

        --LFSR Initialization
        lfsr_seed       : in std_logic_vector(63 downto 0);
        lfsr_polynomial : in std_logic_vector(1 downto 0);
        valid_seed      : in std_logic;
        -------------------------------------------------------------------------------
        -- Packet Info
        -------------------------------------------------------------------------------

        mac_source      : in std_logic_vector(47 downto 0);  -- MAC source address
        mac_source_rx   : out std_logic_vector(47 downto 0);  -- MAC source address
        mac_destination : out std_logic_vector(47 downto 0);  -- MAC destination address
        ip_source       : out std_logic_vector(31 downto 0);  -- IP source address
        ip_destination  : out std_logic_vector(31 downto 0);  -- IP destination address
        time_stamp_out  : out std_logic_vector(47 downto 0);  -- Packet timestamp
        received_packet : out std_logic;  -- Asserted when a valid UDP packet is received
        end_latency     : out std_logic;
        packets_lost    : out std_logic_vector(63 downto 0);
        RESET_done 		: out std_logic; 

        timestamp_base  : in std_logic_vector(47 downto 0);
        -------------------------------------------------------------------------------
        -- RX mac interface
        -------------------------------------------------------------------------------
        -- Should only be asserted when a packet is available in the receive FIFO.
        -- When asserted, the packet transfer will begin on next cycle. Should remain asserted until EOP.
        pkt_rx_ren      : out std_logic;
        pkt_rx_avail    : in  std_logic;  -- Asserted when a packet is available in for reading in receive FIFO
        pkt_rx_eop      : in  std_logic;  -- Receive data is the first word of the packet 
        pkt_rx_sop      : in  std_logic;  -- Receive data is the last word of the packet 
        pkt_rx_val      : in  std_logic;  -- Indicates that valid data is present on the bus
        pkt_rx_err      : in  std_logic;  -- Current packet is bad and should be discarded
        pkt_rx_data     : in  std_logic_vector(63 downto 0);  -- Receive data
        pkt_rx_mod      : in  std_logic_vector(2 downto 0);  -- Indicates valid bytes during last word

        IDLE_count      : out std_logic_vector(63 downto 0);
        verify_system_rec  : in std_logic;  
        reset_test		   : in std_logic;						 -- activates reset test
        pkt_sequence_in    : in std_logic_vector(15 downto 0);   -- number of packets to define if recovery is completed 
        pkt_sequence_error_flag: out std_logic;
        pkt_sequence_error : out std_logic;                -- '0' if sequence is ok, '1' if error in sequence and not recovered
        cont_error         : out std_logic_vector(63 downto 0);
        --last_id			   : out std_logic_vector(63 downto 0);
        --current_id		   : out std_logic_vector(63 downto 0);
        payload_type       : in std_logic_vector(2 downto 0)
    );
end echo_receiver;

architecture arch_echo_receiver of echo_receiver is
    -------------------------------------------------------------------------------
    -- Debug
    -------------------------------------------------------------------------------
    attribute mark_debug : string;

    -------------------------------------------------------------------------------
    -- State
    -------------------------------------------------------------------------------
    type   state_type is (S_FIRST_PKT, S_HEADER_FIRST, S_HEADER, S_TIMESTAMP, S_PAYLOAD_FIRST, S_PAYLOAD, S_IDLE);
    signal current_s, next_s : state_type;
    --attribute mark_debug of current_s : signal is "true";

	signal debug_reset : std_logic;
	attribute mark_debug of debug_reset      : signal is "true";

    signal rx_mod : std_logic_vector(2 downto 0);
    --attribute mark_debug of rx_mod : signal is "true";

    signal rx_eop : std_logic;  
    attribute mark_debug of rx_eop : signal is "true";

    signal rx_sop : std_logic;  
    attribute mark_debug of rx_sop : signal is "true";

    -------------------------------------------------------------------------------
    -- Registers
    ------------------------------------------------------------------------------- 
    signal reg_mac_source, reg_mac_destination : std_logic_vector(47 downto 0);
    signal reg_ip_source, reg_ip_destination   : std_logic_vector(31 downto 0);
    signal reg_ethernet_type                   : std_logic_vector(15 downto 0);
    signal reg_ip_protocol                     : std_logic_vector(7 downto 0);
    signal reg_ip_message_length               : std_logic_vector(15 downto 0);
    signal reg_time_stamp                      : std_logic_vector(47 downto 0);
    signal reg_pkt_id                          : std_logic_vector(63 downto 0);
    signal last_pkt_id						   : std_logic_vector(63 downto 0);
    attribute mark_debug of last_pkt_id : signal is "true";
    signal lost								   : std_logic;
    signal reset_counter					   : std_logic_vector(31 downto 0);
    attribute mark_debug of reset_counter : signal is "true";
    signal reg_lfsr                            : std_logic_vector(63 downto 0);
	signal count_one_lost					   : std_logic;

    signal reg_zero                            : std_logic_vector(63 downto 0) := (others => '0');
    signal reg_one                             : std_logic_vector(63 downto 0) := (others => '1');
    
   -- attribute mark_debug of reg_lfsr      : signal is "true";

    signal turn                                : std_logic := '0';

    -------------------------------------------------------------------------------
    -- LFSR  - Signals to be used
    -------------------------------------------------------------------------------
    signal random           : std_logic_vector(63 downto 0);
    signal random_reg           : std_logic_vector(63 downto 0);
  --  attribute mark_debug of random : signal is "true";
    signal last_random      : std_logic_vector(63 downto 0);
    signal linear_feedback  : std_logic;
    signal start, start_reg            : std_logic;
  --  attribute mark_debug of start : signal is "true";


    signal reg_rx           : std_logic_vector(63 downto 0);
  --  attribute mark_debug of reg_rx : signal is "true";

    -------------------------------------------------------------------------------
    -- Iterator
    ------------------------------------------------------------------------------- 
    signal it_header : std_logic_vector(2 downto 0);

    -------------------------------------------------------------------------------
    -- Others
    ------------------------------------------------------------------------------- 
   -- signal internal_packet_length  : std_logic_vector(2 downto 0);
    signal is_ip_packet            : std_logic;
    signal is_udp_packet           : std_logic;
    signal time_stamp_recv         : std_logic_vector(46 downto 0);
    signal my_time_stamp           : std_logic_vector(47 downto 0);
    signal pkt_sequence_error_flag_aux : std_logic;
    signal pkt_id_counter          : std_logic_vector(63 downto 0);

    signal sequence_counter          : std_logic_vector(15 downto 0);
    signal received_packet_wire: std_logic;
    
    signal IDLE_count_reg             : std_logic_vector(63 downto 0);
    
    signal flag_lfsr_16_rem, flag_lfsr_32_rem, flag_lfsr_48_rem, flag_lfsr_8_rem, flag_lfsr_24_rem, flag_lfsr_40_rem, flag_lfsr_56_rem : std_logic;
    signal lfsr_rem : std_logic_vector(55 downto 0) := (others=>'0');

  --  attribute mark_debug of lfsr_rem : signal is "true";

    signal bits_wrong     : std_logic_vector(63 downto 0);
    signal bits_wrong_xor : std_logic_vector(63 downto 0);

    signal lfsr_seed_wire, cycle_with_bits_wrong, lfsr_resync_seed : std_logic_vector(63 downto 0);
    signal resync_lfsr, resync2_lfsr, valid_seed_wire, resync_done: std_logic;

	signal id_diff		: std_logic_vector(63 downto 0);
	--attribute mark_debug of id_diff      : signal is "true";
	signal debug_id_diff : std_logic_vector(63 downto 0);
	attribute mark_debug of debug_id_diff      : signal is "true";
	
	signal reg_id_current		: std_logic_vector(63 downto 0);
	signal reg_id_last		: std_logic_vector(63 downto 0);
	
    function count_ones(s : std_logic_vector) return std_logic_vector is
        variable temp : std_logic_vector(63 downto 0) := (others => '0');
    begin
      for i in s'range loop
        if s(i) = '1' then temp := temp + '1'; 
        end if;
      end loop;
      
      return temp;
    end function count_ones;

begin

    is_ip_packet <= '1' when reg_ethernet_type = x"0800" else '0';

    is_udp_packet <= '1' when reg_ip_protocol = x"11" else '0';

    pkt_sequence_error_flag <= pkt_sequence_error_flag_aux;
    received_packet <= received_packet_wire;
    IDLE_count <= IDLE_count_reg;
    reg_rx     <= pkt_rx_data;
    rx_eop <= pkt_rx_eop;
    rx_sop <= pkt_rx_sop;
    rx_mod <= pkt_rx_mod;
  -------------------------------------------------------------------------------
  -- Combinational Logic
  -------------------------------------------------------------------------------
  -- Updates the current state
    process(current_s, pkt_rx_avail, pkt_rx_sop, pkt_rx_eop, it_header, pkt_rx_mod, flag_lfsr_48_rem, flag_lfsr_32_rem, flag_lfsr_16_rem, flag_lfsr_24_rem, flag_lfsr_8_rem, flag_lfsr_40_rem, flag_lfsr_56_rem, payload_type, pkt_rx_err, mac_source, reg_mac_destination)
    begin
        next_s <= current_s;
        pkt_rx_ren <= '0';
        received_packet_wire <= '0';
        start <= '0';

        case current_s is
            when S_FIRST_PKT =>
                if pkt_rx_avail = '1' then                    
                    pkt_rx_ren <= '1';
                    next_s <= S_HEADER_FIRST;
                else                    
                    pkt_rx_ren <= '0';
                end if;
            when S_IDLE =>
                if pkt_rx_avail = '1' then                    
                    pkt_rx_ren <= '1';
                    next_s <= S_HEADER_FIRST;
                else                    
                    pkt_rx_ren <= '0';
                end if;

            when S_HEADER_FIRST =>
                pkt_rx_ren <= '1';
                if pkt_rx_sop = '1' then
                   -- my_time_stamp <= '0' & time_stamp_recv;
                    next_s <= S_HEADER;
                end if;

            when S_HEADER =>
                pkt_rx_ren <= '1';
                if it_header >= 4  then
                    if (flag_lfsr_16_rem = '1' or flag_lfsr_24_rem = '1' or flag_lfsr_32_rem = '1' or flag_lfsr_40_rem = '1' or flag_lfsr_48_rem = '1' or flag_lfsr_56_rem = '1') then
                        start <= '1';
                    end if;
                    next_s <= S_PAYLOAD_FIRST;                
                end if;

            when S_PAYLOAD_FIRST =>                
                pkt_rx_ren <= '1';
                next_s   <= S_PAYLOAD;  
                start    <= '1'; 

            when S_PAYLOAD =>
              if pkt_rx_eop = '1' then
                    if payload_type = "001" then
                        if pkt_rx_mod = "001" and flag_lfsr_56_rem = '1' then
                            start <= '1';
                        elsif pkt_rx_mod = "010" and (flag_lfsr_48_rem = '1' or flag_lfsr_56_rem = '1')  then 
                            start <= '1';
                        elsif pkt_rx_mod = "011" and (flag_lfsr_40_rem = '1' or flag_lfsr_48_rem = '1' or flag_lfsr_56_rem = '1') then 
                            start <= '1';
                        elsif pkt_rx_mod = "100" and (flag_lfsr_32_rem = '1' or flag_lfsr_40_rem = '1' or flag_lfsr_48_rem = '1' or flag_lfsr_56_rem = '1')  then 
                            start <= '1';
                        elsif pkt_rx_mod = "101" and (flag_lfsr_24_rem = '1' or flag_lfsr_32_rem = '1' or flag_lfsr_40_rem = '1' or flag_lfsr_48_rem = '1' or flag_lfsr_56_rem = '1') then 
                            start <= '1';
                        elsif pkt_rx_mod = "110" and (flag_lfsr_16_rem = '1' or flag_lfsr_24_rem = '1' or flag_lfsr_32_rem = '1' or flag_lfsr_40_rem = '1' or flag_lfsr_48_rem = '1' or flag_lfsr_56_rem = '1') then 
                            start <= '1';
                        elsif pkt_rx_mod = "111" and (flag_lfsr_8_rem = '1' or flag_lfsr_16_rem = '1' or flag_lfsr_24_rem = '1' or flag_lfsr_32_rem = '1' or flag_lfsr_40_rem = '1' or flag_lfsr_48_rem = '1' or flag_lfsr_56_rem = '1') then 
                            start <= '1';
                        elsif pkt_rx_mod = "000" then 
                            start <= '1';
                        end if;
                    end if;

                    if pkt_rx_err = '1' and pkt_rx_avail = '0' then                    
                        pkt_rx_ren <= '0';
                        next_s <= S_IDLE;
                    elsif pkt_rx_err = '1' and pkt_rx_avail = '1' then                    
                        pkt_rx_ren <= '1';
                        next_s <= S_HEADER_FIRST;
                    elsif pkt_rx_avail = '0' then
                        pkt_rx_ren <= '0';
                        if mac_source = reg_mac_destination then
                            received_packet_wire <= '1';
                        end if;
                        next_s <= S_IDLE;
                    else 
                        pkt_rx_ren <= '1';
                        if mac_source = reg_mac_destination then
                            received_packet_wire <= '1';
                        end if;
                        next_s <= S_HEADER_FIRST;
                    end if;
              else             
                start <= '1';   
                pkt_rx_ren <= '1';
              end if;
            when others =>
                next_s <= S_FIRST_PKT;

        end case;
    end process;

  -------------------------------------------------------------------------------
  -- Sequential Logic
  -------------------------------------------------------------------------------

  -- Updates the header iterator
    process(reset, clock)
    begin
        if reset = '0' then
            current_s <= S_FIRST_PKT;
        elsif rising_edge(clock) then
            current_s <= next_s;
        end if;
    end process;

  -- Updates the header iterator
    process(reset, clock)
    begin
        if reset = '0' then
            it_header <= (others => '0');
        elsif rising_edge(clock) then
            case current_s is
                when S_HEADER_FIRST => it_header <= (others => '0');
                when S_HEADER       => it_header <= it_header + 1;
                when others         => it_header <= it_header;
            end case;
        end if;
    end process;

    -- Extracts the packet info
    process(reset, clock)
    begin
        if reset = '0' then
            IDLE_count_reg        <= (others => '0');
            reg_mac_destination   <= (others => '0');
            reg_mac_source        <= (others => '0');
            reg_ethernet_type     <= (others => '0');
            reg_ip_protocol       <= (others => '0');
            reg_ip_message_length <= (others => '0');
            reg_ip_source         <= (others => '0');
            reg_ip_destination    <= (others => '0');
            reg_time_stamp        <= (others => '0');
            reg_pkt_id            <= (others => '0');
            pkt_id_counter        <= (others => '0');
            --start <= '0';
            flag_lfsr_8_rem <= '0';
            flag_lfsr_16_rem <= '0';
            flag_lfsr_24_rem <= '0';
            flag_lfsr_32_rem <= '0';
            flag_lfsr_40_rem <= '0';
            flag_lfsr_48_rem <= '0';
            flag_lfsr_56_rem <= '0';
            reg_lfsr <= (others=>'0');
        elsif rising_edge(clock) then
            --reg_pkt_rx            <= pkt_rx_data;
            reg_mac_destination   <= reg_mac_destination;
            reg_mac_source        <= reg_mac_source;
            reg_ethernet_type     <= reg_ethernet_type;
            reg_ip_protocol       <= reg_ip_protocol;
            reg_ip_message_length <= reg_ip_message_length;
            reg_ip_source         <= reg_ip_source;
            reg_ip_destination    <= reg_ip_destination;
            reg_time_stamp        <= reg_time_stamp;
            reg_pkt_id            <= reg_pkt_id;
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

            when S_HEADER_FIRST =>
                IDLE_count_reg <= IDLE_count_reg + '1';
                reg_mac_destination          <= pkt_rx_data(63 downto 16);
                reg_mac_source(47 downto 32) <= pkt_rx_data(15 downto 0);

            when S_HEADER =>
                IDLE_count_reg <= IDLE_count_reg + '1';
                case it_header is
                    when "000" =>
                        reg_mac_source(31 downto 0)      <= pkt_rx_data(63 downto 32);
                        reg_ethernet_type                <= pkt_rx_data(31 downto 16);

                    when "001" =>
                        reg_ip_message_length            <= pkt_rx_data(63 downto 48);
                        reg_ip_protocol                  <= pkt_rx_data(7 downto 0);

                    when "010" =>
                        reg_ip_source                    <= pkt_rx_data(47 downto 16);
                        reg_ip_destination(31 downto 16) <= pkt_rx_data(15 downto 0);

                    when "011" =>
                        reg_ip_destination(15 downto 0) <= pkt_rx_data(63 downto 48);

                    when "100" =>                          
                        if resync2_lfsr = '1' or resync_lfsr = '1' then
                            flag_lfsr_8_rem <= '0';
                            flag_lfsr_16_rem <= '0';
                            flag_lfsr_24_rem <= '0';
                            flag_lfsr_32_rem <= '0';
                            flag_lfsr_40_rem <= '0';
                            flag_lfsr_48_rem <= '0'; 
                            flag_lfsr_56_rem <= '0'; 
                        end if;
                        if payload_type = 0 then
                            reg_time_stamp <= pkt_rx_data(47 downto 0);   
                            pkt_id_counter <= reg_pkt_id;    
                        elsif payload_type = 1 then -- BERT
                            if flag_lfsr_8_rem = '1' then
                              lfsr_rem(55 downto 48) <= lfsr_rem(7 downto 0);
                              lfsr_rem(47 downto 0)  <= pkt_rx_data(47 downto 0);
                              flag_lfsr_8_rem <= '0'; 
                              flag_lfsr_56_rem <= '1'; 

                            elsif(flag_lfsr_16_rem = '1') then 
                              reg_lfsr(63 downto 0) <= lfsr_rem(15 downto 0) & pkt_rx_data(47 downto 0);
                              flag_lfsr_16_rem <= '0';

                            elsif(flag_lfsr_24_rem = '1') then 
                              reg_lfsr(63 downto 0) <= lfsr_rem(23 downto 0) & pkt_rx_data(47 downto 8);
                              lfsr_rem(7 downto 0) <= pkt_rx_data(7 downto 0);
                              flag_lfsr_8_rem <= '1';
                              flag_lfsr_24_rem <= '0';

                            elsif(flag_lfsr_32_rem = '1') then 
                              reg_lfsr(63 downto 0) <= lfsr_rem(31 downto 0) & pkt_rx_data(47 downto 16);
                              lfsr_rem(15 downto 0) <= pkt_rx_data(15 downto 0);
                              flag_lfsr_16_rem <= '1';
                              flag_lfsr_32_rem <= '0';

                            elsif(flag_lfsr_40_rem = '1') then
                              reg_lfsr(63 downto 0) <= lfsr_rem(39 downto 0) & pkt_rx_data(47 downto 24);
                              lfsr_rem(23 downto 0) <= pkt_rx_data(23 downto 0);
                              flag_lfsr_24_rem <= '1';
                              flag_lfsr_40_rem <= '0'; 

                            elsif(flag_lfsr_48_rem = '1') then
                              reg_lfsr(63 downto 0) <= lfsr_rem(47 downto 0) & pkt_rx_data(47 downto 32);
                              lfsr_rem(31 downto 0) <= pkt_rx_data(31 downto 0);
                              flag_lfsr_32_rem <= '1';
                              flag_lfsr_48_rem <= '0'; 

                            elsif(flag_lfsr_56_rem = '1') then
                              reg_lfsr(63 downto 0) <= lfsr_rem(55 downto 0) & pkt_rx_data(47 downto 40);
                              lfsr_rem(39 downto 0) <= pkt_rx_data(39 downto 0);
                              flag_lfsr_40_rem <= '1';
                              flag_lfsr_56_rem <= '0'; 

                            else
                              lfsr_rem(47 downto 0) <= pkt_rx_data(47 downto 0);
                              flag_lfsr_48_rem <= '1'; 
                            end if;

                        elsif payload_type = 2 then --all 0s 
                            reg_zero(47 downto 0)  <= pkt_rx_data(47 downto 0);
                            reg_zero(63 downto 48) <= (others=>'0');
                        elsif payload_type = 3 then --all 1s
                            reg_one(47 downto 0)  <= pkt_rx_data(47 downto 0);
                            reg_one(63 downto 48) <= (others=>'1');
                        end if;

                    when others =>
                        null;
                end case;

            when S_PAYLOAD_FIRST =>
                IDLE_count_reg <= IDLE_count_reg + '1';
                if resync2_lfsr = '1' or resync_lfsr = '1' then
                    flag_lfsr_8_rem <= '0';
                    flag_lfsr_16_rem <= '0';
                    flag_lfsr_24_rem <= '0';
                    flag_lfsr_32_rem <= '0';
                    flag_lfsr_40_rem <= '0';
                    flag_lfsr_48_rem <= '0'; 
                    flag_lfsr_56_rem <= '0'; 
                end if;
                if payload_type = 0 then
                    reg_pkt_id <= pkt_rx_data(63 downto 0);
                elsif payload_type = 1 then -- BERT
                    lfsr_resync_seed(63 downto 0) <= pkt_rx_data(63 downto 0);


                    if(flag_lfsr_8_rem = '1') then 
                      reg_lfsr(63 downto 0) <= lfsr_rem(7 downto 0) & pkt_rx_data(63 downto 8);
                      lfsr_rem(7 downto 0) <= pkt_rx_data(7 downto 0);

                    elsif(flag_lfsr_16_rem = '1') then 
                      reg_lfsr(63 downto 0) <= lfsr_rem(15 downto 0) & pkt_rx_data(63 downto 16);
                      lfsr_rem(15 downto 0) <= pkt_rx_data(15 downto 0);

                    elsif(flag_lfsr_24_rem = '1') then 
                      reg_lfsr(63 downto 0) <= lfsr_rem(23 downto 0) & pkt_rx_data(63 downto 24);
                      lfsr_rem(23 downto 0) <= pkt_rx_data(23 downto 0);

                    elsif(flag_lfsr_32_rem = '1') then 
                      reg_lfsr(63 downto 0) <= lfsr_rem(31 downto 0) & pkt_rx_data(63 downto 32);
                      lfsr_rem(31 downto 0) <= pkt_rx_data(31 downto 0);

                    elsif(flag_lfsr_40_rem = '1') then
                      reg_lfsr(63 downto 0) <= lfsr_rem(39 downto 0) & pkt_rx_data(63 downto 40);
                      lfsr_rem(39 downto 0) <= pkt_rx_data(39 downto 0);

                    elsif(flag_lfsr_48_rem = '1') then
                      reg_lfsr(63 downto 0) <= lfsr_rem(47 downto 0) & pkt_rx_data(63 downto 48);
                      lfsr_rem(47 downto 0) <= pkt_rx_data(47 downto 0);

                    elsif(flag_lfsr_56_rem = '1') then
                      reg_lfsr(63 downto 0) <= lfsr_rem(55 downto 0) & pkt_rx_data(63 downto 56);
                      lfsr_rem(55 downto 0) <= pkt_rx_data(55 downto 0);

                    else
                      reg_lfsr(63 downto 0) <= pkt_rx_data (63 downto 0);
                    end if;

                elsif payload_type = "010" then --all 0s or all 1s
                    reg_zero(63 downto 0)  <= pkt_rx_data(63 downto 0);
                elsif payload_type = "011" then
                    reg_one(63 downto 0)  <= pkt_rx_data(63 downto 0);
                end if;
                
            when S_PAYLOAD =>
                IDLE_count_reg <= IDLE_count_reg + '1';                
                if resync2_lfsr = '1' or resync_lfsr = '1' then
                    flag_lfsr_8_rem <= '0';
                    flag_lfsr_16_rem <= '0';
                    flag_lfsr_24_rem <= '0';
                    flag_lfsr_32_rem <= '0';
                    flag_lfsr_40_rem <= '0';
                    flag_lfsr_48_rem <= '0'; 
                    flag_lfsr_56_rem <= '0'; 
                end if;
                if pkt_rx_eop = '1' then
                    if payload_type = 1 then -- BERT
                        if pkt_rx_mod = "001" then 
                            --seed for resync lfsr
                            lfsr_resync_seed(63 downto 8) <= lfsr_resync_seed(55 downto 0);
                            lfsr_resync_seed(7 downto 0) <= pkt_rx_data(63 downto 56);

                            if(flag_lfsr_8_rem = '1') then 
                              lfsr_rem(15 downto 8) <= lfsr_rem(7 downto 0);
                              lfsr_rem(7 downto 0)  <= pkt_rx_data(63 downto 56);
                              flag_lfsr_8_rem <= '0';
                              flag_lfsr_16_rem <= '1';

                            elsif(flag_lfsr_16_rem = '1') then 
                              lfsr_rem(23 downto 8) <= lfsr_rem(15 downto 0);
                              lfsr_rem(7 downto 0)  <= pkt_rx_data(63 downto 56);
                              flag_lfsr_16_rem <= '0';
                              flag_lfsr_24_rem <= '1';

                            elsif(flag_lfsr_24_rem = '1') then 
                              lfsr_rem(31 downto 8) <= lfsr_rem(23 downto 0);
                              lfsr_rem(7 downto 0)  <= pkt_rx_data(63 downto 56);
                              flag_lfsr_24_rem <= '0';
                              flag_lfsr_32_rem <= '1';  

                            elsif(flag_lfsr_32_rem = '1') then 
                              lfsr_rem(39 downto 8) <= lfsr_rem(31 downto 0);
                              lfsr_rem(7 downto 0)  <= pkt_rx_data(63 downto 56);
                              flag_lfsr_32_rem <= '0';
                              flag_lfsr_40_rem <= '1';  

                            elsif(flag_lfsr_40_rem = '1') then 
                              lfsr_rem(47 downto 8) <= lfsr_rem(39 downto 0);
                              lfsr_rem(7 downto 0)  <= pkt_rx_data(63 downto 56);
                              flag_lfsr_40_rem <= '0';
                              flag_lfsr_48_rem <= '1'; 

                            elsif(flag_lfsr_48_rem = '1') then
                              lfsr_rem(55 downto 8) <= lfsr_rem(47 downto 0);
                              lfsr_rem(7 downto 0)  <= pkt_rx_data(63 downto 56);
                              flag_lfsr_48_rem <= '0';
                              flag_lfsr_56_rem <= '1';

                            elsif(flag_lfsr_56_rem = '1') then 
                              reg_lfsr(63 downto 0) <= lfsr_rem(55 downto 0) & pkt_rx_data(63 downto 56);
                              flag_lfsr_56_rem <= '0';  
                                                
                            else
                              lfsr_rem(7 downto 0)  <= pkt_rx_data(63 downto 56);
                              flag_lfsr_8_rem <= '1';
                            end if;  

                        elsif pkt_rx_mod = "010" then 
                            --seed for resync lfsr
                            lfsr_resync_seed(63 downto 16) <= lfsr_resync_seed(47 downto 0);
                            lfsr_resync_seed(15 downto 0) <= pkt_rx_data(63 downto 48);

                            if(flag_lfsr_8_rem = '1') then 
                              lfsr_rem(23 downto 16) <= lfsr_rem(7 downto 0);
                              lfsr_rem(15 downto 0)  <= pkt_rx_data(63 downto 48);
                              flag_lfsr_8_rem <= '0';
                              flag_lfsr_24_rem <= '1';

                            elsif(flag_lfsr_16_rem = '1') then 
                              lfsr_rem(31 downto 16) <= lfsr_rem(15 downto 0);
                              lfsr_rem(15 downto 0)  <= pkt_rx_data(63 downto 48);
                              flag_lfsr_16_rem <= '0';
                              flag_lfsr_32_rem <= '1';

                            elsif(flag_lfsr_24_rem = '1') then 
                              lfsr_rem(39 downto 16) <= lfsr_rem(23 downto 0);
                              lfsr_rem(15 downto 0) <= pkt_rx_data(63 downto 48);
                              flag_lfsr_24_rem <= '0';
                              flag_lfsr_40_rem <= '1';  

                            elsif(flag_lfsr_32_rem = '1') then 
                              lfsr_rem(47 downto 16) <= lfsr_rem(31 downto 0);
                              lfsr_rem(15 downto 0) <= pkt_rx_data(63 downto 48);
                              flag_lfsr_32_rem <= '0';
                              flag_lfsr_48_rem <= '1';  

                            elsif(flag_lfsr_40_rem = '1') then 
                              lfsr_rem(55 downto 16) <= lfsr_rem(39 downto 0);
                              lfsr_rem(15 downto 0) <= pkt_rx_data(63 downto 48);
                              flag_lfsr_40_rem <= '0';
                              flag_lfsr_56_rem <= '1'; 

                            elsif(flag_lfsr_48_rem = '1') then
                              reg_lfsr(63 downto 0) <= lfsr_rem(47 downto 0) & pkt_rx_data(63 downto 48);
                              flag_lfsr_48_rem <= '0';

                            elsif(flag_lfsr_56_rem = '1') then 
                              reg_lfsr(63 downto 0) <= lfsr_rem(55 downto 0) & pkt_rx_data(63 downto 56);
                              lfsr_rem(7 downto 0) <= pkt_rx_data(55 downto 48);
                              flag_lfsr_8_rem <= '1';
                              flag_lfsr_56_rem <= '0';  

                            else
                              lfsr_rem(15 downto 0) <= pkt_rx_data(63 downto 48);
                              flag_lfsr_16_rem <= '1';
                            end if;  

                        elsif pkt_rx_mod = "011" then 
                            --seed for resync lfsr
                            lfsr_resync_seed(63 downto 24) <= lfsr_resync_seed(39 downto 0);
                            lfsr_resync_seed(23 downto 0) <= pkt_rx_data(63 downto 40);

                            if(flag_lfsr_8_rem = '1') then 
                              lfsr_rem(31 downto 24) <= lfsr_rem(7 downto 0);
                              lfsr_rem(23 downto 0)  <= pkt_rx_data(63 downto 40);
                              flag_lfsr_8_rem <= '0';
                              flag_lfsr_32_rem <= '1';

                            elsif(flag_lfsr_16_rem = '1') then 
                              lfsr_rem(39 downto 24) <= lfsr_rem(15 downto 0);
                              lfsr_rem(23 downto 0)  <= pkt_rx_data(63 downto 40);
                              flag_lfsr_16_rem <= '0';
                              flag_lfsr_40_rem <= '1';

                            elsif(flag_lfsr_24_rem = '1') then 
                              lfsr_rem(47 downto 24) <= lfsr_rem(23 downto 0);
                              lfsr_rem(23 downto 0) <= pkt_rx_data(63 downto 40);
                              flag_lfsr_24_rem <= '0';
                              flag_lfsr_48_rem <= '1';  

                            elsif(flag_lfsr_32_rem = '1') then 
                              lfsr_rem(55 downto 24) <= lfsr_rem(31 downto 0);
                              lfsr_rem(23 downto 0) <= pkt_rx_data(63 downto 40);
                              flag_lfsr_32_rem <= '0';
                              flag_lfsr_56_rem <= '1';  

                            elsif(flag_lfsr_40_rem = '1') then 
                              reg_lfsr(63 downto 0) <= lfsr_rem(39 downto 0) & pkt_rx_data(63 downto 40);
                              flag_lfsr_40_rem <= '0';

                            elsif(flag_lfsr_48_rem = '1') then
                              reg_lfsr(63 downto 0) <= lfsr_rem(47 downto 0) & pkt_rx_data(63 downto 48);
                              lfsr_rem(7 downto 0) <= pkt_rx_data(47 downto 40);
                              flag_lfsr_8_rem <= '1';
                              flag_lfsr_48_rem <= '0';

                            elsif(flag_lfsr_56_rem = '1') then 
                              reg_lfsr(63 downto 0) <= lfsr_rem(55 downto 0) & pkt_rx_data(63 downto 56);
                              lfsr_rem(15 downto 0) <= pkt_rx_data(55 downto 40);
                              flag_lfsr_16_rem <= '1';
                              flag_lfsr_56_rem <= '0';  

                            else
                              lfsr_rem(23 downto 0) <= pkt_rx_data(63 downto 40);
                              flag_lfsr_24_rem <= '1';
                            end if;  

                        elsif pkt_rx_mod = "100" then 
                            --seed for resync lfsr
                            lfsr_resync_seed(63 downto 32) <= lfsr_resync_seed(31 downto 0);
                            lfsr_resync_seed(31 downto 0) <= pkt_rx_data(63 downto 32);

                            if(flag_lfsr_8_rem = '1') then 
                              lfsr_rem(39 downto 32) <= lfsr_rem(7 downto 0);
                              lfsr_rem(31 downto 0)  <= pkt_rx_data(63 downto 32);
                              flag_lfsr_8_rem <= '0';
                              flag_lfsr_40_rem <= '1';

                            elsif(flag_lfsr_16_rem = '1') then 
                              lfsr_rem(47 downto 32) <= lfsr_rem(15 downto 0);
                              lfsr_rem(31 downto 0)  <= pkt_rx_data(63 downto 32);
                              flag_lfsr_16_rem <= '0';
                              flag_lfsr_48_rem <= '1';

                            elsif(flag_lfsr_24_rem = '1') then 
                              lfsr_rem(55 downto 32) <= lfsr_rem(23 downto 0);
                              lfsr_rem(31 downto 0) <= pkt_rx_data(63 downto 32);
                              flag_lfsr_24_rem <= '0';
                              flag_lfsr_56_rem <= '1';  

                            elsif(flag_lfsr_32_rem = '1') then 
                              reg_lfsr(63 downto 0) <= lfsr_rem(31 downto 0) & pkt_rx_data(63 downto 32);
                              flag_lfsr_32_rem <= '0';

                            elsif(flag_lfsr_40_rem = '1') then 
                              reg_lfsr(63 downto 0) <= lfsr_rem(39 downto 0) & pkt_rx_data(63 downto 40);
                              lfsr_rem(7 downto 0) <= pkt_rx_data(39 downto 32);
                              flag_lfsr_8_rem <= '1';
                              flag_lfsr_40_rem <= '0';

                            elsif(flag_lfsr_48_rem = '1') then
                              reg_lfsr(63 downto 0) <= lfsr_rem(47 downto 0) & pkt_rx_data(63 downto 48);
                              lfsr_rem(15 downto 0) <= pkt_rx_data(47 downto 32);
                              flag_lfsr_16_rem <= '1';
                              flag_lfsr_48_rem <= '0';

                            elsif(flag_lfsr_56_rem = '1') then 
                              reg_lfsr(63 downto 0) <= lfsr_rem(55 downto 0) & pkt_rx_data(63 downto 56);
                              lfsr_rem(23 downto 0) <= pkt_rx_data(55 downto 32);
                              flag_lfsr_24_rem <= '1';
                              flag_lfsr_56_rem <= '0';  

                            else
                              lfsr_rem(31 downto 0) <= pkt_rx_data(63 downto 32);
                              flag_lfsr_32_rem <= '1';
                            end if;  

                        elsif pkt_rx_mod = "101" then 
                            --seed for resync lfsr
                            lfsr_resync_seed(63 downto 40) <= lfsr_resync_seed(23 downto 0);
                            lfsr_resync_seed(39 downto 0) <= pkt_rx_data(63 downto 24);

                            if(flag_lfsr_8_rem = '1') then 
                              lfsr_rem(47 downto 40) <= lfsr_rem(7 downto 0);
                              lfsr_rem(39 downto 0)  <= pkt_rx_data(63 downto 24);
                              flag_lfsr_8_rem <= '0';
                              flag_lfsr_48_rem <= '1';

                            elsif(flag_lfsr_16_rem = '1') then 
                              lfsr_rem(55 downto 40) <= lfsr_rem(15 downto 0);
                              lfsr_rem(39 downto 0)  <= pkt_rx_data(63 downto 24);
                              flag_lfsr_16_rem <= '0';
                              flag_lfsr_56_rem <= '1';

                            elsif(flag_lfsr_24_rem = '1') then 
                              reg_lfsr(63 downto 0) <= lfsr_rem(23 downto 0) & pkt_rx_data(63 downto 24);
                              flag_lfsr_24_rem <= '0';

                            elsif(flag_lfsr_32_rem = '1') then 
                              reg_lfsr(63 downto 0) <= lfsr_rem(31 downto 0) & pkt_rx_data(63 downto 32);
                              lfsr_rem(7 downto 0) <= pkt_rx_data(31 downto 24);
                              flag_lfsr_8_rem <= '1';
                              flag_lfsr_32_rem <= '0';

                            elsif(flag_lfsr_40_rem = '1') then 
                              reg_lfsr(63 downto 0) <= lfsr_rem(39 downto 0) & pkt_rx_data(63 downto 40);
                              lfsr_rem(15 downto 0) <= pkt_rx_data(39 downto 24);
                              flag_lfsr_16_rem <= '1';
                              flag_lfsr_40_rem <= '0';

                            elsif(flag_lfsr_48_rem = '1') then
                              reg_lfsr(63 downto 0) <= lfsr_rem(47 downto 0) & pkt_rx_data(63 downto 48);
                              lfsr_rem(23 downto 0) <= pkt_rx_data(47 downto 24);
                              flag_lfsr_24_rem <= '1';
                              flag_lfsr_48_rem <= '0';

                            elsif(flag_lfsr_56_rem = '1') then
                              reg_lfsr(63 downto 0) <= lfsr_rem(55 downto 0) & pkt_rx_data(63 downto 56);
                              lfsr_rem(31 downto 0) <= pkt_rx_data(55 downto 24);
                              flag_lfsr_32_rem <= '1';
                              flag_lfsr_56_rem <= '0';  

                            else
                              lfsr_rem(39 downto 0) <= pkt_rx_data(63 downto 24);
                              flag_lfsr_40_rem <= '1';
                            end if;  

                        elsif pkt_rx_mod = "110" then 
                            --seed for resync lfsr
                            lfsr_resync_seed(63 downto 48) <= lfsr_resync_seed(15 downto 0);
                            lfsr_resync_seed(47 downto 0) <= pkt_rx_data(63 downto 16);

                            if(flag_lfsr_8_rem = '1') then 
                              lfsr_rem(55 downto 48) <= lfsr_rem(7 downto 0);
                              lfsr_rem(47 downto 0)  <= pkt_rx_data(63 downto 16);
                              flag_lfsr_8_rem <= '0';
                              flag_lfsr_56_rem <= '1';

                            elsif(flag_lfsr_16_rem = '1') then 
                              reg_lfsr(63 downto 0) <= lfsr_rem(15 downto 0) & pkt_rx_data(63 downto 16);
                              flag_lfsr_16_rem <= '0';

                            elsif(flag_lfsr_24_rem = '1') then 
                              reg_lfsr(63 downto 0) <= lfsr_rem(23 downto 0) & pkt_rx_data(63 downto 24);
                              lfsr_rem(7 downto 0) <= pkt_rx_data(23 downto 16);
                              flag_lfsr_8_rem <= '1';
                              flag_lfsr_24_rem <= '0';

                            elsif(flag_lfsr_32_rem = '1') then 
                              reg_lfsr(63 downto 0) <= lfsr_rem(31 downto 0) & pkt_rx_data(63 downto 32);
                              lfsr_rem(15 downto 0) <= pkt_rx_data(31 downto 16);
                              flag_lfsr_16_rem <= '1';
                              flag_lfsr_32_rem <= '0';

                            elsif(flag_lfsr_40_rem = '1') then 
                              reg_lfsr(63 downto 0) <= lfsr_rem(39 downto 0) & pkt_rx_data(63 downto 40);
                              lfsr_rem(23 downto 0) <= pkt_rx_data(39 downto 16);
                              flag_lfsr_24_rem <= '1';
                              flag_lfsr_40_rem <= '0';

                            elsif(flag_lfsr_48_rem = '1') then
                              reg_lfsr(63 downto 0) <= lfsr_rem(47 downto 0) & pkt_rx_data(63 downto 48);
                              lfsr_rem(31 downto 0) <= pkt_rx_data(47 downto 16);
                              flag_lfsr_32_rem <= '1';
                              flag_lfsr_48_rem <= '0';

                            elsif(flag_lfsr_56_rem = '1') then
                              reg_lfsr(63 downto 0) <= lfsr_rem(55 downto 0) & pkt_rx_data(63 downto 56);
                              lfsr_rem(39 downto 0) <= pkt_rx_data(55 downto 16);
                              flag_lfsr_40_rem <= '1';
                              flag_lfsr_56_rem <= '0';  

                            else
                              lfsr_rem(47 downto 0) <= pkt_rx_data(63 downto 16);
                              flag_lfsr_48_rem <= '1';
                            end if;  

                        elsif pkt_rx_mod = "111" then 
                            --seed for resync lfsr
                            lfsr_resync_seed(63 downto 56) <= lfsr_resync_seed(7 downto 0);
                            lfsr_resync_seed(55 downto 0) <= pkt_rx_data(63 downto 8);

                            if(flag_lfsr_8_rem = '1') then 
                              reg_lfsr(63 downto 0) <= lfsr_rem(7 downto 0) & pkt_rx_data(63 downto 8);
                              flag_lfsr_8_rem <= '0';

                            elsif(flag_lfsr_16_rem = '1') then 
                              reg_lfsr(63 downto 0) <= lfsr_rem(15 downto 0) & pkt_rx_data(63 downto 16);
                              lfsr_rem(7 downto 0) <= pkt_rx_data(15 downto 8);
                              flag_lfsr_16_rem <= '0';
                              flag_lfsr_8_rem <= '1';

                            elsif(flag_lfsr_24_rem = '1') then 
                              reg_lfsr(63 downto 0) <= lfsr_rem(23 downto 0) & pkt_rx_data(63 downto 24);
                              lfsr_rem(15 downto 0) <= pkt_rx_data(23 downto 8);
                              flag_lfsr_16_rem <= '1';
                              flag_lfsr_24_rem <= '0';

                            elsif(flag_lfsr_32_rem = '1') then 
                              reg_lfsr(63 downto 0) <= lfsr_rem(31 downto 0) & pkt_rx_data(63 downto 32);
                              lfsr_rem(23 downto 0) <= pkt_rx_data(31 downto 8);
                              flag_lfsr_24_rem <= '1';
                              flag_lfsr_32_rem <= '0';

                            elsif(flag_lfsr_40_rem = '1') then 
                              reg_lfsr(63 downto 0) <= lfsr_rem(39 downto 0) & pkt_rx_data(63 downto 40);
                              lfsr_rem(31 downto 0) <= pkt_rx_data(39 downto 8);
                              flag_lfsr_32_rem <= '1';
                              flag_lfsr_40_rem <= '0';

                            elsif(flag_lfsr_48_rem = '1') then
                              reg_lfsr(63 downto 0) <= lfsr_rem(47 downto 0) & pkt_rx_data(63 downto 48);
                              lfsr_rem(39 downto 0) <= pkt_rx_data(47 downto 8);
                              flag_lfsr_40_rem <= '1';
                              flag_lfsr_48_rem <= '0';

                            elsif(flag_lfsr_56_rem = '1') then
                              reg_lfsr(63 downto 0) <= lfsr_rem(55 downto 0) & pkt_rx_data(63 downto 56);
                              lfsr_rem(47 downto 0) <= pkt_rx_data(55 downto 8);
                              flag_lfsr_48_rem <= '1';
                              flag_lfsr_56_rem <= '0';  

                            else
                              lfsr_rem(55 downto 0) <= pkt_rx_data(63 downto 8);
                              flag_lfsr_56_rem <= '1';
                            end if; 

                        else 
                            --seed for resync lfsr
                            lfsr_resync_seed(63 downto 0) <= pkt_rx_data(63 downto 0);

                            if(flag_lfsr_8_rem = '1') then 
                              reg_lfsr(63 downto 0) <= lfsr_rem(7 downto 0) & pkt_rx_data(63 downto 8);
                              lfsr_rem(7 downto 0) <= pkt_rx_data(7 downto 0);

                            elsif(flag_lfsr_16_rem = '1') then 
                              reg_lfsr(63 downto 0) <= lfsr_rem(15 downto 0) & pkt_rx_data(63 downto 16);
                              lfsr_rem(15 downto 0) <= pkt_rx_data(15 downto 0);

                            elsif(flag_lfsr_24_rem = '1') then 
                              reg_lfsr(63 downto 0) <= lfsr_rem(23 downto 0) & pkt_rx_data(63 downto 24);
                              lfsr_rem(23 downto 0) <= pkt_rx_data(23 downto 0);

                            elsif(flag_lfsr_32_rem = '1') then 
                              reg_lfsr(63 downto 0) <= lfsr_rem(31 downto 0) & pkt_rx_data(63 downto 32);
                              lfsr_rem(31 downto 0) <= pkt_rx_data(31 downto 0);

                            elsif(flag_lfsr_40_rem = '1') then 
                              reg_lfsr(63 downto 0) <= lfsr_rem(39 downto 0) & pkt_rx_data(63 downto 40);
                              lfsr_rem(39 downto 0) <= pkt_rx_data(39 downto 0);

                            elsif(flag_lfsr_48_rem = '1') then
                              reg_lfsr(63 downto 0) <= lfsr_rem(47 downto 0) & pkt_rx_data(63 downto 48);
                              lfsr_rem(47 downto 0) <= pkt_rx_data(47 downto 0);

                            elsif(flag_lfsr_56_rem = '1') then
                              reg_lfsr(63 downto 0) <= lfsr_rem(55 downto 0) & pkt_rx_data(63 downto 56);
                              lfsr_rem(55 downto 0) <= pkt_rx_data(55 downto 0);

                            else
                              reg_lfsr(63 downto 0) <= pkt_rx_data(63 downto 0);
                            end if; 
                        end if;            

                    elsif payload_type = 2  then --all 0s
                        if pkt_rx_mod = "001" then 
                            reg_zero(63 downto 56) <= pkt_rx_data(63 downto 56);
                            reg_zero(55 downto 0)  <= (others=>'0');
                        elsif pkt_rx_mod = "010" then 
                            reg_zero(63 downto 48) <= pkt_rx_data(63 downto 48);
                            reg_zero(47 downto 0)  <= (others=>'0');
                        elsif pkt_rx_mod = "011" then 
                            reg_zero(63 downto 40) <= pkt_rx_data(63 downto 40);
                            reg_zero(39 downto 0)  <= (others=>'0');
                        elsif pkt_rx_mod = "100" then 
                            reg_zero(63 downto 32) <= pkt_rx_data(63 downto 32);
                            reg_zero(31 downto 0)  <= (others=>'0');
                        elsif pkt_rx_mod = "101" then 
                            reg_zero(63 downto 24) <= pkt_rx_data(63 downto 24);
                            reg_zero(23 downto 0)  <= (others=>'0');
                        elsif pkt_rx_mod = "110" then 
                            reg_zero(63 downto 16) <= pkt_rx_data(63 downto 16);
                            reg_zero(15 downto 0)  <= (others=>'0');
                        elsif pkt_rx_mod = "111" then 
                            reg_zero(63 downto 8) <= pkt_rx_data(63 downto 8);
                            reg_zero(7 downto 0)  <= (others=>'0');
                        else
                            reg_zero(63 downto 0) <= pkt_rx_data(63 downto 0);
                        end if;
                    elsif payload_type = 3  then --all 1s
                        if pkt_rx_mod = "001" then 
                            reg_one(63 downto 56) <= pkt_rx_data(63 downto 56);
                            reg_one(55 downto 0)  <= (others=>'1');
                        elsif pkt_rx_mod = "010" then 
                            reg_one(63 downto 48) <= pkt_rx_data(63 downto 48);
                            reg_one(47 downto 0)  <= (others=>'1');
                        elsif pkt_rx_mod = "011" then 
                            reg_one(63 downto 40) <= pkt_rx_data(63 downto 40);
                            reg_one(39 downto 0)  <= (others=>'1');
                        elsif pkt_rx_mod = "100" then 
                            reg_one(63 downto 32) <= pkt_rx_data(63 downto 32);
                            reg_one(31 downto 0)  <= (others=>'1');
                        elsif pkt_rx_mod = "101" then 
                            reg_one(63 downto 24) <= pkt_rx_data(63 downto 24);
                            reg_one(23 downto 0)  <= (others=>'1');
                        elsif pkt_rx_mod = "110" then 
                            reg_one(63 downto 16) <= pkt_rx_data(63 downto 16);
                            reg_one(15 downto 0)  <= (others=>'1');
                        elsif pkt_rx_mod = "111" then 
                            reg_one(63 downto 8) <= pkt_rx_data(63 downto 8);
                            reg_one(7 downto 0)  <= (others=>'1');
                        else
                            reg_one(63 downto 0) <= pkt_rx_data(63 downto 0);
                        end if;
                    end if;

                else
                    if payload_type = 1 then -- BERT
                        lfsr_resync_seed <= pkt_rx_data;
                        if(flag_lfsr_8_rem = '1') then 
                          reg_lfsr(63 downto 0) <= lfsr_rem(7 downto 0) & pkt_rx_data(63 downto 8);
                          lfsr_rem(7 downto 0) <= pkt_rx_data(7 downto 0);

                        elsif(flag_lfsr_16_rem = '1') then 
                          reg_lfsr(63 downto 0) <= lfsr_rem(15 downto 0) & pkt_rx_data(63 downto 16);
                          lfsr_rem(15 downto 0) <= pkt_rx_data(15 downto 0);

                        elsif(flag_lfsr_24_rem = '1') then 
                          reg_lfsr(63 downto 0) <= lfsr_rem(23 downto 0) & pkt_rx_data(63 downto 24);
                          lfsr_rem(23 downto 0) <= pkt_rx_data(23 downto 0);

                        elsif(flag_lfsr_32_rem = '1') then 
                          reg_lfsr(63 downto 0) <= lfsr_rem(31 downto 0) & pkt_rx_data(63 downto 32);
                          lfsr_rem(31 downto 0) <= pkt_rx_data(31 downto 0);

                        elsif(flag_lfsr_40_rem = '1') then
                          reg_lfsr(63 downto 0) <= lfsr_rem(39 downto 0) & pkt_rx_data(63 downto 40);
                          lfsr_rem(39 downto 0) <= pkt_rx_data(39 downto 0);

                        elsif(flag_lfsr_48_rem = '1') then
                          reg_lfsr(63 downto 0) <= lfsr_rem(47 downto 0) & pkt_rx_data(63 downto 48);
                          lfsr_rem(47 downto 0) <= pkt_rx_data(47 downto 0);

                        elsif(flag_lfsr_56_rem = '1') then
                          reg_lfsr(63 downto 0) <= lfsr_rem(55 downto 0) & pkt_rx_data(63 downto 56);
                          lfsr_rem(55 downto 0) <= pkt_rx_data(55 downto 0);

                        else
                          reg_lfsr(63 downto 0) <= pkt_rx_data (63 downto 0);
                        end if;
                    elsif payload_type = 2 or payload_type = 3 then --all 0s or all 1s
                        reg_lfsr(63 downto 0)  <= pkt_rx_data(63 downto 0);
                    end if;
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
            if current_s = S_PAYLOAD_FIRST and verify_system_rec = '1'  then
                if (pkt_id_counter = (pkt_rx_data(63 downto 0) - '1')) then 
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
            if current_s = S_PAYLOAD_FIRST and reset_test = '1'  then
                if (pkt_id_counter = (pkt_rx_data(63 downto 0) - '1')) then 
					if lost = '1' then
						reset_counter <= reset_counter + '1';
					end if;
                    count_one_lost <= '1';
                else					
					--report "Salvando ID perdido!";
					last_pkt_id <= pkt_rx_data(63 downto 0);
                    lost <= '1';
                    id_diff <= id_diff + pkt_rx_data(63 downto 0) - pkt_id_counter - '1';
                    debug_id_diff <= id_diff + pkt_rx_data(63 downto 0) - pkt_id_counter - '1';
                    reg_id_current	<= pkt_rx_data(63 downto 0);
                    reg_id_last		<= pkt_id_counter;
					reset_counter <= (others => '0');
                end if;
            end if;
            
        end if;
    end process;
      
    
    -- the system has recovered from the reset
	packets_lost <= id_diff; 
	--last_id		 <= reg_id_current;
	--current_id   <= reg_id_last;
	RESET_done   <= '1' when reset_counter >= 1000 else '0'; 
	debug_reset  <= '1' when reset_counter >= 1000 else '0';

    lfsr_i: entity work.lfsr 
    port map(   
      clock => clock,
      reset => reset,
      seed => lfsr_seed_wire,      
      valid_seed => valid_seed_wire,
      polynomial => lfsr_polynomial,
      data_in => random,
      start => start,
      data_out => random
    ); 
    
    --Verify payload
    bits_wrong_xor <= reg_zero(63 downto 0) xor x"0000000000000000" when payload_type = "010" and (current_s = S_PAYLOAD_FIRST or current_s = S_PAYLOAD or (current_s = S_HEADER and it_header = 4)) else
                      reg_one(63 downto 0)  xor x"FFFFFFFFFFFFFFFF" when payload_type = "011" and (current_s = S_PAYLOAD_FIRST or current_s = S_PAYLOAD or (current_s = S_HEADER and it_header = 4)) else
                      random_reg(63 downto 0) xor (reg_lfsr(63 downto 0)) when payload_type = "001" and start_reg = '1' else 
                      (others=>'0');

    -- Process for BERT test.
    -- Count bits wrong in payload
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
        random_reg <= random;
        start_reg <= start;
        if (payload_type = "001" and start_reg = '1') or (payload_type = "010" or payload_type = "011") then
            bits_wrong <= bits_wrong + count_ones(bits_wrong_xor);
            if (count_ones(bits_wrong_xor) /= 0 and (current_s = S_PAYLOAD or current_s = S_PAYLOAD_FIRST or (current_s = S_HEADER and it_header = 4))) then
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

end arch_echo_receiver;
