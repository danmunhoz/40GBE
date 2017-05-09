library IEEE;
use IEEE.std_logic_1164.all;
--use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity echo_generator is
  port
  (
    clock               : in  std_logic; -- Clock 156.25 MHz
    reset               : in  std_logic; -- Reset (Active High)

    -- Control Signals
    start               : in  std_logic;  -- Enable the packet generation

    --LFSR Initialization
    lfsr_seed       : in std_logic_vector(63 downto 0);
    valid_seed      : in std_logic;
    lfsr_polynomial : in std_logic_vector(1 downto 0);   

    -- Settings
    mac_source          : in  std_logic_vector(47 downto 0); -- MAC source address
    mac_destination     : in  std_logic_vector(47 downto 0); -- MAC destination address
    ip_source           : in  std_logic_vector(31 downto 0); -- IP source address
    ip_destination      : in  std_logic_vector(31 downto 0); -- IP destination address
    packet_length       : in  std_logic_vector(15 downto 0);  -- Packet size:  "000" - 64B, "001" - 128B, "010" - 256B, "011" - 512B,
                                                             --               "100" - 768B, "101" - 1024B, "110" - 1280B, "111" - 1518B
    timestamp_base      : in  std_logic_vector(47 downto 0);
    time_stamp_flag     : in  std_logic; -- If the timestamp is needed in the latency test, first bit of payload is '1'

    -- TX mac interface
    pkt_tx_full         : in  std_logic;                     -- Informs if xMAC tx buffer is full
    pkt_tx_data         : out std_logic_vector(63 downto 0); -- Data bus
    pkt_tx_val          : out std_logic;                     -- Indicates if the data is valid
    pkt_tx_sop          : out std_logic;                     -- Start of packet flag (sent along with the first frame)
    pkt_tx_eop          : out std_logic;                     -- End of packet flag (sent along with the last frame)
    pkt_tx_mod          : out std_logic_vector(2 downto 0);   -- Module (frame size, only read when eop='1')
    pkt_lost_counter    : out std_logic_vector(31 downto 0);
    payload_type        : in std_logic_vector(2 downto 0);
    payload_cycles      : in std_logic_vector(31 downto 0);
    payload_last_size   : in std_logic_vector(6 downto 0)
  );
end echo_generator;

architecture arch_echo_generator of echo_generator is

  -------------------------------------------------------------------------------
  -- Debug
  -------------------------------------------------------------------------------
  attribute mark_debug : string;

  -- State
  type state_type is (S_IDLE, S_HEADER_FIRST, S_HEADER_0, S_HEADER_1, S_HEADER_2, S_HEADER_3, S_HEADER_4 , S_HEADER_5, S_PAYLOAD_FIRST, S_PAYLOAD, S_PAYLOAD_LAST);
  signal current_s, next_s: state_type;
  --attribute mark_debug of current_s : signal is "true";

  signal header_0, header_1, header_2, header_3, header_4 : std_logic_vector(63 downto 0);

  -------------------------------------------------------------------------------
  -- Input Registers
  -------------------------------------------------------------------------------
  signal mac_source_reg       :  std_logic_vector(47 downto 0); -- MAC source address
  signal mac_destination_reg  :  std_logic_vector(47 downto 0); -- MAC destination address
  signal ip_source_reg        :  std_logic_vector(31 downto 0); -- IP source address
  signal ip_destination_reg   :  std_logic_vector(31 downto 0); -- IP destination address
  signal packet_length_reg    :  std_logic_vector(15 downto 0);  -- Packet size:  "000" - 64B, "001" - 128B, "010" - 256B, "011" - 512B,:
                                                                --               "100" - 768B, "101" - 1024B, "110" - 1280B, "111" - 1518B
  signal timestamp_base_reg   :  std_logic_vector(47 downto 0);
  signal time_stamp_flag_reg  :  std_logic;                      -- If the timestamp is needed in the latency test, first bit of payload is '1'
  signal start_reg            :  std_logic;
  -------------------------------------------------------------------------------
  -- Output Registers
  -------------------------------------------------------------------------------
  signal pkt_tx_data_reg      : std_logic_vector(63 downto 0);
  attribute mark_debug of pkt_tx_data_reg : signal is "true";
  signal pkt_tx_val_reg, pkt_tx_sop_reg, pkt_tx_eop_reg : std_logic;
  --attribute mark_debug of pkt_tx_sop_reg : signal is "true";
  --attribute mark_debug of pkt_tx_eop_reg : signal is "true";



  signal pkt_one              : std_logic_vector(63 downto 0) := (others=>'1');

  signal pkt_tx_mod_reg       : std_logic_vector(2 downto 0);
  --attribute mark_debug of pkt_tx_mod_reg : signal is "true";


  signal pkt_tx_data_wire      : std_logic_vector(63 downto 0);
  signal pkt_tx_val_wire, pkt_tx_sop_wire, pkt_tx_eop_wire : std_logic;
  signal pkt_tx_mod_wire       : std_logic_vector(2 downto 0);
  -------------------------------------------------------------------------------
  -- Traffic control
  -------------------------------------------------------------------------------
  signal time_stamp        : std_logic_vector(46 downto 0); --
  signal time_stamp_value  : std_logic_vector(63 downto 0); --
  signal it_header         : std_logic_vector(2 downto 0); -- iterator used in header
  signal it_payload        : std_logic_vector(31 downto 0); -- iterator used in payload
  signal id_counter        : std_logic_vector(63 downto 0); -- counter for ID

  -------------------------------------------------------------------------------
  -- IP
  -------------------------------------------------------------------------------
  signal ip_checksum       : std_logic_vector(15 downto 0); -- Checksum on the IP header
  signal aux_checksum      : std_logic_vector(31 downto 0); -- Auxiliar flag on the checksum calculation
  signal ip_message_length : std_logic_vector(15 downto 0); -- Frame size internal signal

  -------------------------------------------------------------------------------
  -- UDP
  -------------------------------------------------------------------------------
  signal udp_message_length : std_logic_vector(15 downto 0);  -- UDP packet length

  -------------------------------------------------------------------------------
  -- LFSR 64 bits - Signals to be used
  -------------------------------------------------------------------------------
  signal random           : std_logic_vector(63 downto 0);
  attribute mark_debug of random : signal is "true";
  signal last_random      : std_logic_vector(63 downto 0);
  signal linear_feedback  : std_logic;
  signal start_lfsr            : std_logic;
  attribute mark_debug of start_lfsr : signal is "true";
  
  signal flag_lfsr_16_rem, flag_lfsr_32_rem, flag_lfsr_48_rem, flag_lfsr_8_rem, flag_lfsr_24_rem, flag_lfsr_40_rem, flag_lfsr_56_rem : std_logic;
  signal lfsr_rem : std_logic_vector(55 downto 0) := (others=>'0');

begin
  process (clock, reset)
  begin
    if reset = '0' then
        mac_source_reg         <= (others=>'0');
        mac_destination_reg    <= (others=>'0');
        ip_source_reg          <= (others=>'0');
        ip_destination_reg     <= (others=>'0');
        packet_length_reg      <= (others=>'0');
        timestamp_base_reg     <= (others=>'0');
        time_stamp_flag_reg    <= '0';   
        pkt_tx_val_reg         <= '0'; 
    elsif rising_edge(clock) then         
         mac_source_reg         <= mac_source;
         mac_destination_reg    <= mac_destination;
         ip_source_reg          <= ip_source;
         ip_destination_reg     <= ip_destination;
         packet_length_reg      <= packet_length;
         timestamp_base_reg     <= timestamp_base;
         time_stamp_flag_reg    <= time_stamp_flag;
         pkt_tx_val_reg         <= pkt_tx_val_wire;  
         pkt_tx_sop_reg         <= pkt_tx_sop_wire;  
         pkt_tx_eop_reg         <= pkt_tx_eop_wire;  
         pkt_tx_mod_reg         <= pkt_tx_mod_wire; 
         pkt_tx_data_reg        <= pkt_tx_data_wire;
         start_reg              <= start;
    end if;
  end process;


  --pkt_tx_mod <= pkt_tx_mod_reg;
  --pkt_tx_val <= pkt_tx_val_reg; 
  --pkt_tx_sop <= pkt_tx_sop_reg; 
  --pkt_tx_eop <= pkt_tx_eop_reg; 
  pkt_tx_data <= pkt_tx_data_wire;

  header_0 <= mac_destination_reg & mac_source_reg(47 downto 32);
  header_1 <= mac_source_reg(31 downto 0) & x"08004500";
  header_2 <= ip_message_length & x"000000000A11";
  header_3 <= ip_checksum & ip_source_reg & ip_destination_reg(31 downto 16);
  header_4 <= ip_destination_reg(15 downto 0) & x"C020C021" & udp_message_length;

  -- Timestamp value to be sent in the packet payload
  time_stamp_value <= x"0000" & timestamp_base_reg(46 downto 0) & time_stamp_flag_reg;
               
  ip_message_length <= packet_length_reg - 18;

  udp_message_length <= ip_message_length - 20;     -- Packet length minus 20 bytes of header (MACs and type)

      --Checksum calculation
  aux_checksum <= x"0000_4F11" +  --4F11 -> sum of all constants
                  ip_message_length(15 downto 0) +
                  ip_source_reg(31 downto 16) +
                  ip_source_reg(15 downto 0) +
                  ip_destination_reg(31 downto 16) +
                  ip_destination_reg(15 downto 0);

  ip_checksum <= not(aux_checksum(31 downto 16) + aux_checksum(15 downto 0));

  -------------------------------------------------------------------------------
  -- Sequential Logic
  -------------------------------------------------------------------------------
  -- Update the current state
  process (clock, reset)
  begin
    if reset='0' then
      current_s <= S_IDLE;
    elsif rising_edge(clock) then
      current_s <= next_s;  
    end if;
  end process;

  -------------------------------------------------------------------------------
  -- Combinational Logic
  -------------------------------------------------------------------------------
  -- Updates the state
  process (current_s, it_payload, start, payload_cycles, flag_lfsr_48_rem, flag_lfsr_32_rem, flag_lfsr_16_rem, flag_lfsr_24_rem, flag_lfsr_8_rem, flag_lfsr_40_rem, flag_lfsr_56_rem, payload_type, payload_last_size)
  begin   
        next_s <= current_s;
        start_lfsr <= '0';
        case current_s is
          when S_IDLE =>      
            if(start = '1') then
              next_s <= S_HEADER_0;
            end if;

          when S_HEADER_0 =>
            next_s <= S_HEADER_1;

          when S_HEADER_1 =>
            next_s <= S_HEADER_2;

          when S_HEADER_2 =>
            next_s <= S_HEADER_3;

          when S_HEADER_3 =>
            next_s <= S_HEADER_4;

          when S_HEADER_4 =>
            next_s <= S_HEADER_5;

          when S_HEADER_5 =>
            if(payload_type = 1 and flag_lfsr_48_rem = '0' and flag_lfsr_56_rem = '0') then
              start_lfsr <= '1';
            end if;
            next_s <= S_PAYLOAD_FIRST;

          when S_PAYLOAD_FIRST =>
            start_lfsr <='1';           
            if(it_payload >= payload_cycles) then  
              next_s <= S_PAYLOAD_LAST;
            else            
              next_s <= S_PAYLOAD;
            end if;

          when S_PAYLOAD =>
            start_lfsr <='1';          
            if(it_payload >= payload_cycles) then
              next_s <= S_PAYLOAD_LAST;
            end if;

          when S_PAYLOAD_LAST =>
            next_s <= S_IDLE;

            if payload_type = 0 then --PACKET ID
              start_lfsr <='1';         
            elsif payload_type = 1 then -- BERT
              if payload_last_size = 8 and flag_lfsr_8_rem = '0' and flag_lfsr_16_rem = '0' and flag_lfsr_24_rem = '0' and flag_lfsr_32_rem = '0' and flag_lfsr_40_rem = '0' and flag_lfsr_48_rem = '0' and flag_lfsr_56_rem = '0' then
                start_lfsr <= '1';
              elsif payload_last_size = 16 and flag_lfsr_16_rem = '0' and flag_lfsr_24_rem = '0' and flag_lfsr_32_rem = '0' and flag_lfsr_40_rem = '0' and flag_lfsr_48_rem = '0' and flag_lfsr_56_rem = '0'  then 
                  start_lfsr <='1';
              elsif payload_last_size = 24 and flag_lfsr_24_rem = '0' and flag_lfsr_32_rem = '0' and flag_lfsr_40_rem = '0' and flag_lfsr_48_rem = '0' and flag_lfsr_56_rem = '0'  then 
                  start_lfsr <='1';
              elsif payload_last_size = 32 and flag_lfsr_32_rem = '0' and flag_lfsr_40_rem = '0' and flag_lfsr_48_rem = '0' and flag_lfsr_56_rem = '0'  then 
                  start_lfsr <='1';
              elsif payload_last_size = 40 and flag_lfsr_40_rem = '0' and flag_lfsr_48_rem = '0' and flag_lfsr_56_rem = '0'  then 
                  start_lfsr <='1';
              elsif payload_last_size = 48 and flag_lfsr_48_rem = '0' and flag_lfsr_56_rem = '0'  then 
                  start_lfsr <='1';
              elsif payload_last_size = 56 and flag_lfsr_56_rem = '0'  then 
                  start_lfsr <='1';
              elsif payload_last_size = 0 then                
                  start_lfsr <='1';    
              end if;
            end if;
          when others =>
            next_s <= S_IDLE;
        end case;
  end process;

  process (reset, clock)
  begin
    if(reset = '0') then
      flag_lfsr_8_rem <= '0';
      flag_lfsr_16_rem <= '0';
      flag_lfsr_24_rem <= '0';
      flag_lfsr_32_rem <= '0';
      flag_lfsr_40_rem <= '0';
      flag_lfsr_48_rem <= '0';
      flag_lfsr_56_rem <= '0';
      pkt_tx_sop <= '0';
      pkt_tx_eop <= '0';
      pkt_tx_val <= '0';
      pkt_tx_mod <= "000";  
      pkt_tx_data_wire <= (others=>'0');  

    elsif rising_edge(clock) then
      case current_s is
        when S_IDLE =>
          pkt_tx_val <= '0';   
          pkt_tx_eop <= '0';
          pkt_tx_mod <= "000"; 

        when S_HEADER_0 =>
          pkt_tx_val <= '1';  
          pkt_tx_sop <= '1';
          pkt_tx_mod <= "000";  
          pkt_tx_data_wire <= header_0;

        when S_HEADER_1 =>
          pkt_tx_val <= '1';  
          pkt_tx_sop <= '0';
          pkt_tx_data_wire <= header_1;

        when S_HEADER_2 =>
          pkt_tx_val <= '1'; 
          pkt_tx_data_wire <= header_2;

        when S_HEADER_3 =>        
          pkt_tx_val <= '1'; 
          pkt_tx_data_wire <= header_3;

        when S_HEADER_4 =>
          pkt_tx_val <= '1'; 
          pkt_tx_data_wire <= header_4;
        
        when S_HEADER_5 => -- send 16 bits of UDP Checksum (all zeros) + 48 bits of payload
          pkt_tx_val <= '1';          
          if payload_type = 0 then 
            pkt_tx_data_wire <= time_stamp_value;

          elsif payload_type = 1 then -- BERT
            if flag_lfsr_8_rem = '1' then
              pkt_tx_data_wire(63 downto 0) <= x"0000" & lfsr_rem(7 downto 0) & random(63 downto 24);
              lfsr_rem(23 downto 0) <= random(23 downto 0);
              flag_lfsr_8_rem <= '0';
              flag_lfsr_24_rem <= '1';

            elsif(flag_lfsr_16_rem = '1') then 
              pkt_tx_data_wire(63 downto 0) <= x"0000" & lfsr_rem(15 downto 0) & random(63 downto 32);
              lfsr_rem(31 downto 0) <= random(31 downto 0);
              flag_lfsr_16_rem <= '0';
              flag_lfsr_32_rem <= '1'; 

            elsif(flag_lfsr_24_rem = '1') then 
              pkt_tx_data_wire(63 downto 0) <= x"0000" & lfsr_rem(23 downto 0) & random(63 downto 40);
              lfsr_rem(39 downto 0) <= random(39 downto 0);
              flag_lfsr_24_rem <= '0';
              flag_lfsr_40_rem <= '1'; 

            elsif(flag_lfsr_32_rem = '1') then 
              pkt_tx_data_wire(63 downto 0) <= x"0000" & lfsr_rem(31 downto 0) & random (63 downto 48);
              lfsr_rem(47 downto 0) <= random(47 downto 0);
              flag_lfsr_32_rem <= '0';
              flag_lfsr_48_rem <= '1';    
              
            elsif(flag_lfsr_40_rem = '1') then 
              pkt_tx_data_wire(63 downto 0) <= x"0000" & lfsr_rem(39 downto 0) & random(63 downto 56);
              lfsr_rem(55 downto 0) <= random(55 downto 0);
              flag_lfsr_40_rem <= '0';
              flag_lfsr_56_rem <= '1';  

            elsif(flag_lfsr_48_rem = '1') then
              pkt_tx_data_wire(63 downto 0) <= x"0000" & lfsr_rem(47 downto 0);
              flag_lfsr_48_rem <= '0';  
              
            elsif(flag_lfsr_56_rem = '1') then 
              pkt_tx_data_wire(63 downto 0) <= x"0000" & lfsr_rem(55 downto 8);
              flag_lfsr_8_rem <= '1';
              flag_lfsr_56_rem <= '0';    

            else
              pkt_tx_data_wire(63 downto 0) <= x"0000" & random(63 downto 16);
              lfsr_rem(15 downto 0) <= random(15 downto 0);
              flag_lfsr_16_rem <= '1';   
            end if;

          elsif payload_type = 2 then -- all 0s
            pkt_tx_data_wire <= (others=>'0');

          elsif payload_type = 3 then -- all 1s
            pkt_tx_data_wire <= x"0000" & x"FFFFFFFFFFFF";
          end if;

        when S_PAYLOAD_FIRST =>
          pkt_tx_val <= '1';
          if payload_type = 0 then --PACKET ID
            pkt_tx_data_wire(63 downto 0) <= id_counter;
          elsif payload_type = 1 then -- BERT
            if(flag_lfsr_8_rem = '1') then 
              pkt_tx_data_wire(63 downto 0) <= lfsr_rem(7 downto 0) & random (63 downto 8);
              lfsr_rem(7 downto 0) <= random(7 downto 0);

            elsif(flag_lfsr_16_rem = '1') then 
              pkt_tx_data_wire(63 downto 0) <= lfsr_rem(15 downto 0) & random (63 downto 16);
              lfsr_rem(15 downto 0) <= random(15 downto 0);

            elsif(flag_lfsr_24_rem = '1') then 
              pkt_tx_data_wire(63 downto 0) <= lfsr_rem(23 downto 0) & random (63 downto 24);
              lfsr_rem(23 downto 0) <= random(23 downto 0);

            elsif(flag_lfsr_32_rem = '1') then 
              pkt_tx_data_wire(63 downto 0) <= lfsr_rem(31 downto 0) & random (63 downto 32);
              lfsr_rem(31 downto 0) <= random(31 downto 0);

            elsif(flag_lfsr_40_rem = '1') then 
              pkt_tx_data_wire(63 downto 0) <= lfsr_rem(39 downto 0) & random (63 downto 40);
              lfsr_rem(39 downto 0) <= random(39 downto 0);

            elsif(flag_lfsr_48_rem = '1') then 
              pkt_tx_data_wire(63 downto 0) <= lfsr_rem(47 downto 0) & random (63 downto 48);
              lfsr_rem(47 downto 0) <= random(47 downto 0);

            elsif(flag_lfsr_56_rem = '1') then
              pkt_tx_data_wire(63 downto 0) <= lfsr_rem(55 downto 0) & random (63 downto 56);
              lfsr_rem(55 downto 0) <= random(55 downto 0);

            else
              pkt_tx_data_wire(63 downto 0) <= random(63 downto 0);
            end if;

          elsif payload_type = 2 then -- all 0s
            pkt_tx_data_wire(63 downto 0) <= (others=>'0');
          elsif payload_type = 3 then -- all 1s
            pkt_tx_data_wire(63 downto 0) <= (others=>'1');
          end if;

        when S_PAYLOAD =>         
          pkt_tx_val <= '1'; 
          if payload_type = 0 then --PACKET ID
            pkt_tx_data_wire(63 downto 0) <= random(63 downto 0);
          elsif payload_type = 1 then -- BERT
            if(flag_lfsr_8_rem = '1') then 
              pkt_tx_data_wire(63 downto 0) <= lfsr_rem(7 downto 0) & random (63 downto 8);
              lfsr_rem(7 downto 0) <= random(7 downto 0);

            elsif(flag_lfsr_16_rem = '1') then 
              pkt_tx_data_wire(63 downto 0) <= lfsr_rem(15 downto 0) & random (63 downto 16);
              lfsr_rem(15 downto 0) <= random(15 downto 0);

            elsif(flag_lfsr_24_rem = '1') then 
              pkt_tx_data_wire(63 downto 0) <= lfsr_rem(23 downto 0) & random (63 downto 24);
              lfsr_rem(23 downto 0) <= random(23 downto 0);

            elsif(flag_lfsr_32_rem = '1') then 
              pkt_tx_data_wire(63 downto 0) <= lfsr_rem(31 downto 0) & random (63 downto 32);
              lfsr_rem(31 downto 0) <= random(31 downto 0);

            elsif(flag_lfsr_40_rem = '1') then 
              pkt_tx_data_wire(63 downto 0) <= lfsr_rem(39 downto 0) & random (63 downto 40);
              lfsr_rem(39 downto 0) <= random(39 downto 0);

            elsif(flag_lfsr_48_rem = '1') then 
              pkt_tx_data_wire(63 downto 0) <= lfsr_rem(47 downto 0) & random (63 downto 48);
              lfsr_rem(47 downto 0) <= random(47 downto 0);

            elsif(flag_lfsr_56_rem = '1') then
              pkt_tx_data_wire(63 downto 0) <= lfsr_rem(55 downto 0) & random (63 downto 56);
              lfsr_rem(55 downto 0) <= random(55 downto 0);

            else
              pkt_tx_data_wire(63 downto 0) <= random(63 downto 0);
            end if;

          elsif payload_type = "010" then -- all 0s
            pkt_tx_data_wire(63 downto 0) <= (others=>'0');

          elsif payload_type = "011" then -- all 1s
            pkt_tx_data_wire(63 downto 0) <= (others=>'1');
          end if;

        when S_PAYLOAD_LAST => 
          pkt_tx_val <= '1'; 
          pkt_tx_eop <= '1';

          if payload_last_size = 8 then
            pkt_tx_mod <= "001"; -- 8 bits (63 downto 56)
          elsif payload_last_size = 16 then
            pkt_tx_mod <= "010"; -- 16 bits (63 downto 48)
          elsif payload_last_size = 24 then
            pkt_tx_mod <= "011"; -- 24 bits (63 downto 40)
          elsif payload_last_size = 32 then
            pkt_tx_mod <= "100"; -- 32 bits (63 downto 32)
          elsif payload_last_size = 40 then
            pkt_tx_mod <= "101"; -- 40 bits (63 downto 24)
          elsif payload_last_size = 48 then
            pkt_tx_mod <= "110"; -- 48 bits (63 downto 16)
          elsif payload_last_size = 56 then
            pkt_tx_mod <= "111"; -- 56 bits (63 downto 8)
          else
            pkt_tx_mod <= "000"; -- 64 bits (63 downto 0)
          end if;

          if payload_type = 0 then --PACKET ID
            if payload_last_size = 8 then
              pkt_tx_data_wire(63 downto 56) <= random(63 downto 56);
            elsif payload_last_size = 16 then
              pkt_tx_data_wire(63 downto 48) <= random(63 downto 48); 
            elsif payload_last_size = 24 then
              pkt_tx_data_wire(63 downto 40) <= random(63 downto 40); 
            elsif payload_last_size = 32 then
              pkt_tx_data_wire(63 downto 32) <= random(63 downto 32); 
            elsif payload_last_size = 40 then
              pkt_tx_data_wire(63 downto 24) <= random(63 downto 24); 
            elsif payload_last_size = 48 then
              pkt_tx_data_wire(63 downto 16) <= random(63 downto 16); 
            elsif payload_last_size = 56 then
              pkt_tx_data_wire(63 downto 8) <= random(63 downto 8); 
            else
              pkt_tx_data_wire(63 downto 0) <= random(63 downto 0);  
            end if;

          elsif payload_type = 1 then -- BERT
            if payload_last_size = 8 then
                if flag_lfsr_8_rem = '1' then
                  pkt_tx_data_wire(63 downto 56) <= lfsr_rem(7 downto 0);
                  pkt_tx_data_wire(55 downto 0) <= (others=>'0');
                  flag_lfsr_8_rem <= '0';

                elsif(flag_lfsr_16_rem = '1') then 
                  pkt_tx_data_wire(63 downto 56) <= lfsr_rem(15 downto 8);
                  pkt_tx_data_wire(47 downto 0) <= (others=>'0');
                  flag_lfsr_8_rem <= '1';
                  flag_lfsr_16_rem <= '0';

                elsif flag_lfsr_24_rem = '1' then
                  pkt_tx_data_wire(63 downto 56) <= lfsr_rem(23 downto 16);
                  pkt_tx_data_wire(55 downto 0) <= (others=>'0');
                  flag_lfsr_16_rem <= '1';
                  flag_lfsr_24_rem <= '0';

                elsif(flag_lfsr_32_rem = '1') then 
                  pkt_tx_data_wire(63 downto 56) <= lfsr_rem(31 downto 24);
                  pkt_tx_data_wire(55 downto 0) <= (others=>'0');
                  flag_lfsr_24_rem <= '1';
                  flag_lfsr_32_rem <= '0';

                elsif flag_lfsr_40_rem = '1' then
                  pkt_tx_data_wire(63 downto 56) <= lfsr_rem(39 downto 32);
                  pkt_tx_data_wire(55 downto 0) <= (others=>'0');
                  flag_lfsr_32_rem <= '1';
                  flag_lfsr_40_rem <= '0';

                elsif(flag_lfsr_48_rem = '1') then
                  pkt_tx_data_wire(63 downto 56) <= lfsr_rem(47 downto 40);
                  pkt_tx_data_wire(55 downto 0) <= (others=>'0');
                  flag_lfsr_40_rem <= '1';
                  flag_lfsr_48_rem <= '0';

                elsif flag_lfsr_56_rem = '1' then
                  pkt_tx_data_wire(63 downto 56) <= lfsr_rem(55 downto 48);
                  pkt_tx_data_wire(55 downto 0) <= (others=>'0');
                  flag_lfsr_48_rem <= '1';
                  flag_lfsr_56_rem <= '0'; 

                else                  
                  pkt_tx_data_wire(63 downto 56) <= random(63 downto 56);
                  pkt_tx_data_wire(55 downto 0) <= (others=>'0');
                  lfsr_rem(55 downto 0) <= random(55 downto 0);
                  flag_lfsr_56_rem <= '1'; 
                end if;  

            elsif payload_last_size = 16 then
                if flag_lfsr_8_rem = '1' then
                  pkt_tx_data_wire(63 downto 48) <= lfsr_rem(7 downto 0) & random(63 downto 56);
                  pkt_tx_data_wire(47 downto 0) <= (others=>'0');                  
                  lfsr_rem(55 downto 0) <= random(55 downto 0);
                  flag_lfsr_8_rem <= '0';
                  flag_lfsr_56_rem <= '1';  

                elsif(flag_lfsr_16_rem = '1') then 
                  pkt_tx_data_wire(63 downto 48) <= lfsr_rem(15 downto 0);
                  pkt_tx_data_wire(47 downto 0) <= (others=>'0');
                  flag_lfsr_16_rem <= '0';

                elsif flag_lfsr_24_rem = '1' then
                  pkt_tx_data_wire(63 downto 48) <= lfsr_rem(23 downto 8);
                  pkt_tx_data_wire(47 downto 0) <= (others=>'0');
                  flag_lfsr_8_rem <= '1';
                  flag_lfsr_24_rem <= '0';

                elsif(flag_lfsr_32_rem = '1') then 
                  pkt_tx_data_wire(63 downto 48) <= lfsr_rem(31 downto 16);
                  pkt_tx_data_wire(47 downto 0) <= (others=>'0');
                  flag_lfsr_16_rem <= '1';
                  flag_lfsr_32_rem <= '0';

                elsif flag_lfsr_40_rem = '1' then
                  pkt_tx_data_wire(63 downto 48) <= lfsr_rem(39 downto 24);
                  pkt_tx_data_wire(47 downto 0) <= (others=>'0');
                  flag_lfsr_24_rem <= '1';
                  flag_lfsr_40_rem <= '0';

                elsif(flag_lfsr_48_rem = '1') then
                  pkt_tx_data_wire(63 downto 48) <= lfsr_rem(47 downto 32);
                  pkt_tx_data_wire(47 downto 0) <= (others=>'0');
                  flag_lfsr_32_rem <= '1';
                  flag_lfsr_48_rem <= '0';

                elsif flag_lfsr_56_rem = '1' then
                  pkt_tx_data_wire(63 downto 48) <= lfsr_rem(55 downto 40);
                  pkt_tx_data_wire(47 downto 0) <= (others=>'0');
                  flag_lfsr_40_rem <= '1';
                  flag_lfsr_56_rem <= '0';

                else                  
                  pkt_tx_data_wire(63 downto 48) <= random(63 downto 48);
                  pkt_tx_data_wire(47 downto 0) <= (others=>'0');
                  lfsr_rem(47 downto 0) <= random(47 downto 0);
                  flag_lfsr_48_rem <= '1';
                end if;  

            elsif payload_last_size = 24 then
                if flag_lfsr_8_rem = '1' then
                  pkt_tx_data_wire(63 downto 40) <= lfsr_rem(7 downto 0) & random(63 downto 48);
                  pkt_tx_data_wire(39 downto 0) <= (others=>'0');                  
                  lfsr_rem(47 downto 0) <= random(47 downto 0);
                  flag_lfsr_8_rem <= '0';
                  flag_lfsr_48_rem <= '1';  

                elsif(flag_lfsr_16_rem = '1') then 
                  pkt_tx_data_wire(63 downto 40) <= lfsr_rem(15 downto 0) & random(63 downto 56);
                  pkt_tx_data_wire(39 downto 0) <= (others=>'0');                  
                  lfsr_rem(55 downto 0) <= random(55 downto 0);
                  flag_lfsr_16_rem <= '0';
                  flag_lfsr_56_rem <= '1';  

                elsif flag_lfsr_24_rem = '1' then
                  pkt_tx_data_wire(63 downto 40) <= lfsr_rem(23 downto 0);
                  pkt_tx_data_wire(39 downto 0) <= (others=>'0');
                  flag_lfsr_24_rem <= '0';

                elsif(flag_lfsr_32_rem = '1') then 
                  pkt_tx_data_wire(63 downto 40) <= lfsr_rem(31 downto 8);
                  pkt_tx_data_wire(39 downto 0) <= (others=>'0');
                  flag_lfsr_8_rem <= '1';
                  flag_lfsr_32_rem <= '0';

                elsif flag_lfsr_40_rem = '1' then
                  pkt_tx_data_wire(63 downto 40) <= lfsr_rem(39 downto 16);
                  pkt_tx_data_wire(39 downto 0) <= (others=>'0');
                  flag_lfsr_16_rem <= '1';
                  flag_lfsr_40_rem <= '0';

                elsif(flag_lfsr_48_rem = '1') then
                  pkt_tx_data_wire(63 downto 40) <= lfsr_rem(47 downto 24);
                  pkt_tx_data_wire(39 downto 0) <= (others=>'0');
                  flag_lfsr_24_rem <= '1';
                  flag_lfsr_48_rem <= '0';

                elsif flag_lfsr_56_rem = '1' then
                  pkt_tx_data_wire(63 downto 40) <= lfsr_rem(55 downto 32);
                  pkt_tx_data_wire(39 downto 0) <= (others=>'0');
                  flag_lfsr_32_rem <= '1';
                  flag_lfsr_56_rem <= '0';

                else                  
                  pkt_tx_data_wire(63 downto 40) <= random(63 downto 40);
                  pkt_tx_data_wire(39 downto 0) <= (others=>'0');
                  lfsr_rem(39 downto 0) <= random(39 downto 0);
                  flag_lfsr_40_rem <= '1';
                end if;  

            elsif payload_last_size = 32 then                
                if flag_lfsr_8_rem = '1' then
                  pkt_tx_data_wire(63 downto 32) <= lfsr_rem(7 downto 0) & random(63 downto 40);
                  pkt_tx_data_wire(31 downto 0) <= (others=>'0');                  
                  lfsr_rem(39 downto 0) <= random(39 downto 0);
                  flag_lfsr_8_rem <= '0';
                  flag_lfsr_40_rem <= '1';  

                elsif(flag_lfsr_16_rem = '1') then 
                  pkt_tx_data_wire(63 downto 32) <= lfsr_rem(15 downto 0) & random(63 downto 48);
                  pkt_tx_data_wire(31 downto 0) <= (others=>'0');                  
                  lfsr_rem(47 downto 0) <= random(47 downto 0);
                  flag_lfsr_16_rem <= '0';
                  flag_lfsr_48_rem <= '1';  

                elsif flag_lfsr_24_rem = '1' then
                  pkt_tx_data_wire(63 downto 32) <= lfsr_rem(23 downto 0) & random(63 downto 56);
                  pkt_tx_data_wire(31 downto 0) <= (others=>'0');                          
                  lfsr_rem(55 downto 0) <= random(55 downto 0);
                  flag_lfsr_24_rem <= '0';
                  flag_lfsr_56_rem <= '1';

                elsif(flag_lfsr_32_rem = '1') then 
                  pkt_tx_data_wire(63 downto 32) <= lfsr_rem(31 downto 0);
                  pkt_tx_data_wire(31 downto 0) <= (others=>'0');
                  flag_lfsr_32_rem <= '0';

                elsif flag_lfsr_40_rem = '1' then
                  pkt_tx_data_wire(63 downto 32) <= lfsr_rem(39 downto 8);
                  pkt_tx_data_wire(31 downto 0) <= (others=>'0');
                  flag_lfsr_8_rem <= '1';
                  flag_lfsr_40_rem <= '0';

                elsif(flag_lfsr_48_rem = '1') then
                  pkt_tx_data_wire(63 downto 32) <= lfsr_rem(47 downto 16);
                  pkt_tx_data_wire(31 downto 0) <= (others=>'0');
                  flag_lfsr_16_rem <= '1';
                  flag_lfsr_48_rem <= '0';

                elsif flag_lfsr_56_rem = '1' then
                  pkt_tx_data_wire(63 downto 32) <= lfsr_rem(55 downto 24);
                  pkt_tx_data_wire(31 downto 0) <= (others=>'0');
                  flag_lfsr_24_rem <= '1';
                  flag_lfsr_56_rem <= '0';

                else                  
                  pkt_tx_data_wire(63 downto 32) <= random(63 downto 32);
                  pkt_tx_data_wire(31 downto 0) <= (others=>'0');
                  lfsr_rem(31 downto 0) <= random(31 downto 0);
                  flag_lfsr_32_rem <= '1';
                end if;    

            elsif payload_last_size = 40 then                
                if flag_lfsr_8_rem = '1' then
                  pkt_tx_data_wire(63 downto 24) <= lfsr_rem(7 downto 0) & random(63 downto 32);
                  pkt_tx_data_wire(23 downto 0) <= (others=>'0');                  
                  lfsr_rem(31 downto 0) <= random(31 downto 0);
                  flag_lfsr_8_rem <= '0';
                  flag_lfsr_32_rem <= '1';  

                elsif(flag_lfsr_16_rem = '1') then 
                  pkt_tx_data_wire(63 downto 24) <= lfsr_rem(15 downto 0) & random(63 downto 40);
                  pkt_tx_data_wire(23 downto 0) <= (others=>'0');                  
                  lfsr_rem(39 downto 0) <= random(39 downto 0);
                  flag_lfsr_16_rem <= '0';
                  flag_lfsr_40_rem <= '1';  

                elsif flag_lfsr_24_rem = '1' then
                  pkt_tx_data_wire(63 downto 24) <= lfsr_rem(23 downto 0) & random(63 downto 48);
                  pkt_tx_data_wire(23 downto 0) <= (others=>'0');                          
                  lfsr_rem(47 downto 0) <= random(47 downto 0);
                  flag_lfsr_24_rem <= '0';
                  flag_lfsr_48_rem <= '1';

                elsif(flag_lfsr_32_rem = '1') then 
                  pkt_tx_data_wire(63 downto 24) <= lfsr_rem(31 downto 0) & random(63 downto 56);
                  pkt_tx_data_wire(23 downto 0) <= (others=>'0');                        
                  lfsr_rem(55 downto 0) <= random(55 downto 0);
                  flag_lfsr_32_rem <= '0';
                  flag_lfsr_56_rem <= '1';

                elsif flag_lfsr_40_rem = '1' then
                  pkt_tx_data_wire(63 downto 24) <= lfsr_rem(39 downto 0);
                  pkt_tx_data_wire(23 downto 0) <= (others=>'0');
                  flag_lfsr_40_rem <= '0';

                elsif(flag_lfsr_48_rem = '1') then
                  pkt_tx_data_wire(63 downto 24) <= lfsr_rem(47 downto 8);
                  pkt_tx_data_wire(23 downto 0) <= (others=>'0');
                  flag_lfsr_8_rem <= '1';
                  flag_lfsr_48_rem <= '0';

                elsif flag_lfsr_56_rem = '1' then
                  pkt_tx_data_wire(63 downto 24) <= lfsr_rem(55 downto 16);
                  pkt_tx_data_wire(23 downto 0) <= (others=>'0');
                  flag_lfsr_16_rem <= '1';
                  flag_lfsr_56_rem <= '0';

                else                  
                  pkt_tx_data_wire(63 downto 24) <= random(63 downto 24);
                  pkt_tx_data_wire(23 downto 0) <= (others=>'0');
                  lfsr_rem(23 downto 0) <= random(23 downto 0);
                  flag_lfsr_24_rem <= '1';
                end if;    

            elsif payload_last_size = 48 then                
                if flag_lfsr_8_rem = '1' then
                  pkt_tx_data_wire(63 downto 16) <= lfsr_rem(7 downto 0) & random(63 downto 24);
                  pkt_tx_data_wire(15 downto 0) <= (others=>'0');                  
                  lfsr_rem(23 downto 0) <= random(23 downto 0);
                  flag_lfsr_8_rem <= '0';
                  flag_lfsr_24_rem <= '1';  

                elsif(flag_lfsr_16_rem = '1') then 
                  pkt_tx_data_wire(63 downto 16) <= lfsr_rem(15 downto 0) & random(63 downto 32);
                  pkt_tx_data_wire(15 downto 0) <= (others=>'0');                  
                  lfsr_rem(31 downto 0) <= random(31 downto 0);
                  flag_lfsr_16_rem <= '0';
                  flag_lfsr_32_rem <= '1';  

                elsif flag_lfsr_24_rem = '1' then
                  pkt_tx_data_wire(63 downto 16) <= lfsr_rem(23 downto 0) & random(63 downto 40);
                  pkt_tx_data_wire(15 downto 0) <= (others=>'0');                          
                  lfsr_rem(39 downto 0) <= random(39 downto 0);
                  flag_lfsr_24_rem <= '0';
                  flag_lfsr_40_rem <= '1';

                elsif(flag_lfsr_32_rem = '1') then 
                  pkt_tx_data_wire(63 downto 16) <= lfsr_rem(31 downto 0) & random(63 downto 48);
                  pkt_tx_data_wire(15 downto 0) <= (others=>'0');                        
                  lfsr_rem(47 downto 0) <= random(47 downto 0);
                  flag_lfsr_32_rem <= '0';
                  flag_lfsr_48_rem <= '1';

                elsif flag_lfsr_40_rem = '1' then
                  pkt_tx_data_wire(63 downto 16) <= lfsr_rem(39 downto 0) & random(63 downto 56);
                  pkt_tx_data_wire(15 downto 0) <= (others=>'0');                    
                  lfsr_rem(55 downto 0) <= random(55 downto 0);
                  flag_lfsr_40_rem <= '0';
                  flag_lfsr_56_rem <= '1';

                elsif(flag_lfsr_48_rem = '1') then
                  pkt_tx_data_wire(63 downto 16) <= lfsr_rem(47 downto 0);
                  pkt_tx_data_wire(15 downto 0) <= (others=>'0');
                  flag_lfsr_48_rem <= '0';

                elsif flag_lfsr_56_rem = '1' then
                  pkt_tx_data_wire(63 downto 16) <= lfsr_rem(55 downto 8);
                  pkt_tx_data_wire(15 downto 0) <= (others=>'0');
                  flag_lfsr_8_rem <= '1';
                  flag_lfsr_56_rem <= '0';

                else                  
                  pkt_tx_data_wire(63 downto 16) <= random(63 downto 16);
                  pkt_tx_data_wire(15 downto 0) <= (others=>'0');
                  lfsr_rem(15 downto 0) <= random(15 downto 0);
                  flag_lfsr_16_rem <= '1';
                end if;    

            elsif payload_last_size = 56 then                
                if flag_lfsr_8_rem = '1' then
                  pkt_tx_data_wire(63 downto 8) <= lfsr_rem(7 downto 0) & random(63 downto 16);
                  pkt_tx_data_wire(7 downto 0) <= (others=>'0');                  
                  lfsr_rem(15 downto 0) <= random(15 downto 0);
                  flag_lfsr_8_rem <= '0';
                  flag_lfsr_16_rem <= '1';  

                elsif(flag_lfsr_16_rem = '1') then 
                  pkt_tx_data_wire(63 downto 8) <= lfsr_rem(15 downto 0) & random(63 downto 24);
                  pkt_tx_data_wire(7 downto 0) <= (others=>'0');                  
                  lfsr_rem(23 downto 0) <= random(23 downto 0);
                  flag_lfsr_16_rem <= '0';
                  flag_lfsr_24_rem <= '1';  

                elsif flag_lfsr_24_rem = '1' then
                  pkt_tx_data_wire(63 downto 8) <= lfsr_rem(23 downto 0) & random(63 downto 32);
                  pkt_tx_data_wire(7 downto 0) <= (others=>'0');                          
                  lfsr_rem(31 downto 0) <= random(31 downto 0);
                  flag_lfsr_24_rem <= '0';
                  flag_lfsr_32_rem <= '1';

                elsif(flag_lfsr_32_rem = '1') then 
                  pkt_tx_data_wire(63 downto 8) <= lfsr_rem(31 downto 0) & random(63 downto 40);
                  pkt_tx_data_wire(7 downto 0) <= (others=>'0');                        
                  lfsr_rem(39 downto 0) <= random(39 downto 0);
                  flag_lfsr_32_rem <= '0';
                  flag_lfsr_40_rem <= '1';

                elsif flag_lfsr_40_rem = '1' then
                  pkt_tx_data_wire(63 downto 8) <= lfsr_rem(39 downto 0) & random(63 downto 48);
                  pkt_tx_data_wire(7 downto 0) <= (others=>'0');                    
                  lfsr_rem(47 downto 0) <= random(47 downto 0);
                  flag_lfsr_40_rem <= '0';
                  flag_lfsr_48_rem <= '1';

                elsif(flag_lfsr_48_rem = '1') then
                  pkt_tx_data_wire(63 downto 8) <= lfsr_rem(47 downto 0) & random(63 downto 56);
                  pkt_tx_data_wire(7 downto 0) <= (others=>'0');                 
                  lfsr_rem(55 downto 0) <= random(55 downto 0);
                  flag_lfsr_48_rem <= '0';
                  flag_lfsr_56_rem <= '1';

                elsif flag_lfsr_56_rem = '1' then
                  pkt_tx_data_wire(63 downto 8) <= lfsr_rem(55 downto 0);
                  pkt_tx_data_wire(7 downto 0) <= (others=>'0');
                  flag_lfsr_56_rem <= '0';

                else                  
                  pkt_tx_data_wire(63 downto 8) <= random(63 downto 8);
                  pkt_tx_data_wire(7 downto 0) <= (others=>'0');
                  lfsr_rem(7 downto 0) <= random(7 downto 0);
                  flag_lfsr_8_rem <= '1';
                end if;   

            else --payload size = 64                
                if flag_lfsr_8_rem = '1' then
                  pkt_tx_data_wire(63 downto 0) <= lfsr_rem(7 downto 0) & random(63 downto 8);
                  lfsr_rem(7 downto 0) <= random(7 downto 0);

                elsif(flag_lfsr_16_rem = '1') then 
                  pkt_tx_data_wire(63 downto 0) <= lfsr_rem(15 downto 0) & random(63 downto 16);
                  lfsr_rem(15 downto 0) <= random(15 downto 0);

                elsif flag_lfsr_24_rem = '1' then
                  pkt_tx_data_wire(63 downto 0) <= lfsr_rem(23 downto 0) & random(63 downto 24);
                  lfsr_rem(23 downto 0) <= random(23 downto 0);

                elsif(flag_lfsr_32_rem = '1') then 
                  pkt_tx_data_wire(63 downto 0) <= lfsr_rem(31 downto 0) & random(63 downto 32);
                  lfsr_rem(31 downto 0) <= random(31 downto 0);

                elsif flag_lfsr_40_rem = '1' then
                  pkt_tx_data_wire(63 downto 0) <= lfsr_rem(39 downto 0) & random(63 downto 40);
                  lfsr_rem(39 downto 0) <= random(39 downto 0);

                elsif(flag_lfsr_48_rem = '1') then
                  pkt_tx_data_wire(63 downto 0) <= lfsr_rem(47 downto 0) & random(63 downto 48);
                  lfsr_rem(47 downto 0) <= random(47 downto 0);

                elsif flag_lfsr_56_rem = '1' then
                  pkt_tx_data_wire(63 downto 0) <= lfsr_rem(55 downto 0) & random(63 downto 56);
                  lfsr_rem(55 downto 0) <= random(55 downto 0);

                else                  
                  pkt_tx_data_wire(63 downto 0) <= random(63 downto 0);
                end if;   

            end if;    

          elsif payload_type = "010" then -- all 0s
            pkt_tx_data_wire(63 downto 0) <= (others=>'0');
          elsif payload_type = "011" then -- all 1s
            pkt_tx_data_wire(63 downto 0) <= (others=>'1');
          end if;

        when others =>
          pkt_tx_val <= '0';
          pkt_tx_data_wire(63 downto 0) <= (others=>'0');

      end case;
    end if;
  end process;

  -- Updates the payload iterator
  process (reset, clock)
  begin
    if(reset = '0') then
      it_payload <= (others => '0');
    elsif rising_edge(clock) then
      case current_s is
        when S_PAYLOAD_FIRST => it_payload <= it_payload + 1;
        when S_PAYLOAD => it_payload <= it_payload + 1;
        when S_PAYLOAD_LAST => it_payload <= (others => '0');
        when others => it_payload <= it_payload;
      end case;
    end if;
  end process;

  --"000" - 64B, "001" - 128B, "010" - 256B, "011" - 512B,:
  --"100" - 768B, "101" - 1024B, "110" - 1280B, "111" - 1518B

lfsr_i: entity work.lfsr 
    port map(   
      clock => clock,
      reset => reset,
      seed => lfsr_seed,
      valid_seed => valid_seed,
      polynomial => lfsr_polynomial,
      data_in => random,
      start => start_lfsr,
      data_out => random
    ); 

-- id counter
  process (clock, reset)
  begin
    if (reset = '0') then
      id_counter <= (others => '0');
     -- pkt_lost_counter_reg <= (others => '0');
    elsif rising_edge(clock) then
      if current_s = S_HEADER_5 then
        id_counter <= id_counter + '1';        
      end if;
    end if;
  end process;

--pkt_lost_counter <= pkt_lost_counter_reg;

end arch_echo_generator;
