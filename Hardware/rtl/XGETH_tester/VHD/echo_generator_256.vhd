--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- ECHO GENERATOR ARCHITECTURE DEVELOPED BY MATHEUS LEMES FERRONATO
-- AND GABRIEL SUSIN. BASED UPON OLD ARCHITECTURE FROM 10GB PROJECT
-- NEW ARCHITECTURE CREATED TO ADDRESS 128 BITS DATA
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
library IEEE;
use IEEE.std_logic_1164.all;
--use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;


-- TODO
-- MOD 5 bits indica termino do pacote em determinada posicao.
-- EOP 6 bits MOD dentro do EOP nos ultimos 5 bits, EOP atual sera o 6 bit(mais significativo).
-- SOP 2 bits, avisar se pacote comeca no meio ou no inicio.
-- ENCODINGS
--  SOP:
--    00 - Invalid value
--    01 - Invalid value
--    10 - Packet starting at byte 0
--    11 - Packet starting at byte 16
--
--  EOP:
--    100000 - No eop at this cycle
--    0xxxxx - Packet ending at byte xxxxx
--

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
entity echo_generator_256 is
  port
  (
    clock               : in  std_logic; -- Clock 156.25 MHz
    reset               : in  std_logic; -- Reset (Active High)

    -- Control Signals
    start               : in  std_logic;  -- Enable the packet generation

    --LFSR Initialization
    lfsr_seed       : in std_logic_vector(255 downto 0);
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
    pkt_tx_data         : out std_logic_vector(255 downto 0); -- Data bus
    pkt_tx_val          : out std_logic;                     -- Indicates if the data is valid
    pkt_tx_sop          : out std_logic_vector(1 downto 0);                     -- Start of packet flag (sent along with the first frame)
    pkt_tx_eop          : out std_logic;                     -- End of packet flag (sent along with the last frame)
    pkt_tx_mod          : out std_logic_vector(4 downto 0);   -- Module (frame size, only read when eop='1')
    pkt_lost_counter    : out std_logic_vector(31 downto 0);
    payload_type        : in std_logic_vector(1 downto 0);
    payload_cycles      : in std_logic_vector(31 downto 0);
    payload_last_size   : in std_logic_vector(2 downto 0)
  );
end echo_generator_256;

architecture arch_echo_generator of echo_generator_256 is

  -------------------------------------------------------------------------------
  -- SIGNALS
  -------------------------------------------------------------------------------
  attribute mark_debug : string;

  type state_type is (S_IDLE, S_HEADER_H, S_HEADER_L, S_PAYLOAD);
  signal current_s, next_s: state_type;

  signal MAC        : std_logic_vector(127 downto 0);
  signal IP         : std_logic_vector(191 downto 0);
  signal EOH_SOF    : std_logic_vector(127 downto 0); --END OF HEADER - START OF FRAME
  signal HEADER     : std_logic_vector(255 downto 0);
  signal PAYLOAD    : std_logic_vector(255 downto 0);
  signal IDLE_VALUE       : std_logic_vector(255 downto 0) := x"0707070707070707070707070707070707070707070707070707070707070707";

  signal UPD_INFO   : std_logic_vector(15 downto 0) := x"0000";
  signal ALL_ONE    : std_logic_vector(127 downto 0) := (others => '1');
  signal ALL_ZERO   : std_logic_vector(127 downto 0) := (others => '0');
  signal THROUGHPUT   : std_logic_vector(255 downto 0) := (others => '0');
  signal PKT_COUNTER : std_logic_vector(127 downto 0);
  signal ID_COUNTER_H : std_logic_vector(127 downto 0); -- counter for ID
  signal ID_COUNTER_L : std_logic_vector(127 downto 0);

  signal SEED        : std_logic_vector(255 downto 0);
  signal RANDOM : std_logic_vector(255 downto 0);
  signal start_lfsr  : std_logic;
  signal preset_lfsr : std_logic;
  signal count :  integer range 0 to 15;


  signal pkt_tx_data_N_H  : std_logic_vector(127 downto 0);
  signal pkt_tx_data_N_L  : std_logic_vector(127 downto 0);
  signal pkt_tx_data_N  : std_logic_vector(255 downto 0);
  signal pkt_tx_data_buffer : std_logic_vector(255 downto 0);
  signal pkt_tx_mod_reg : std_logic_vector(4 downto 0);
  signal pkt_tx_eop_reg : std_logic;
  signal last_pkt : std_logic;



  -------------------------------------------------------------------------------
  -- Traffic control
  -------------------------------------------------------------------------------
  signal time_stamp        : std_logic_vector(47 downto 0); --
  signal it_header         : std_logic_vector(2 downto 0); -- iterator used in header
  signal it_payload        : std_logic_vector(31 downto 0); -- iterator used in payload

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



  function invert_bytes(bytes : std_logic_vector)
                   return std_logic_vector
    is
      variable bytes_N : std_logic_vector(255 downto 0) := (others => '0');
      variable i_N : integer range 0 to 255;
      begin
        for i in 1 to 32 loop
          bytes_N(((i*8)-1) downto ((i-1)*8)) := bytes((255-(8*(i-1))) downto (255-((8*(i-1))+7)));
      end loop;
      return bytes_N;
  end function invert_bytes;
BEGIN




pkt_tx_data <= pkt_tx_data_N;
pkt_tx_data_N <= invert_bytes(pkt_tx_data_buffer);
pkt_tx_data_buffer <= PAYLOAD when current_s = S_PAYLOAD else
                      IDLE_VALUE when current_s = S_IDLE else
                      HEADER;

HEADER <=   MAC & IP(191 downto 64) when current_s = S_HEADER_H else
            EOH_SOF & PKT_COUNTER;
PAYLOAD <=  ID_COUNTER_L & ID_COUNTER_H when payload_type = "00" else
            SEED when payload_type = "01" else
            ALL_ZERO & ALL_ZERO when payload_type = "10" else
            ALL_ONE & ALL_ONE  when payload_type = "11";

MAC      <= mac_destination & mac_source & x"08004500";
IP       <= ip_message_length & x"000000000A11" & ip_checksum &
            ip_source & ip_destination & x"C020C021" & udp_message_length;
EOH_SOF  <= IP(63 downto 0) & UPD_INFO & time_stamp;


pkt_tx_val <= '0' when current_s = S_IDLE
              else '1';

last_pkt <= '1' when it_payload = payload_cycles else '0';
pkt_tx_eop_reg <= '0' when last_pkt = '1' else '1';
pkt_tx_mod <= pkt_tx_mod_reg when pkt_tx_eop_reg = '0' else (others=>'0');
pkt_tx_eop <= pkt_tx_eop_reg;
-------------------------------------------------------------------------------
-- RFC2544 FEEDBACK
-------------------------------------------------------------------------------

-- Timestamp value to be sent in the packet payload
  time_stamp <= timestamp_base(46 downto 0) & time_stamp_flag;
  ip_message_length <= packet_length - 18;
  udp_message_length <= ip_message_length - 20;     -- Packet length minus 20 bytes of header (MACs and type)
      --Checksum calculation
  aux_checksum <= x"0000_4F11" +  --4F11 -> sum of all constants
                  ip_message_length(15 downto 0) +
                  ip_source(31 downto 16) +
                  ip_source(15 downto 0) +
                  ip_destination(31 downto 16) +
                  ip_destination(15 downto 0);

  ip_checksum <= not(aux_checksum(31 downto 16) + aux_checksum(15 downto 0));

  -------------------------------------------------------------------------------
  -- FSM NEXT_STATE CONTROL
  -------------------------------------------------------------------------------

  NEXT_CTRL : process (current_s, reset, clock)
  begin
    if reset='0' then
      next_s <= S_IDLE;
    else
      case current_s is
        when S_IDLE => if (start = '1') then next_s <= S_HEADER_H; end if;
        when S_HEADER_H => next_s <= S_HEADER_L;
        when S_HEADER_L => next_s <= S_PAYLOAD;
        when S_PAYLOAD =>
          if(it_payload >= payload_cycles) then
            next_s <= S_IDLE;
          end if;
        end case;
    end if;
  end process;


  -------------------------------------------------------------------------------
  -- FSM CURRENT_STATE SIGNALS CONTROL
  -------------------------------------------------------------------------------



    STATE_CTRL : process (reset, clock)
    begin
      if(reset = '0') then
        current_s <= S_IDLE;
        pkt_tx_sop <= "00";
        ID_COUNTER_L <= (OTHERS => '0');
        ID_COUNTER_H <= ALL_ZERO(126 downto 0) & '1';
        it_payload <= (OTHERS => '0');
        start_lfsr <= '0';
        pkt_tx_mod_reg <= "00000";
        PKT_COUNTER <= (OTHERS => '0');
      elsif (clock'event and clock = '1') then
        current_s <= next_s;
        case current_s is
          when S_IDLE =>
            if (next_s = S_HEADER_H) then pkt_tx_sop <= "10"; end if;
            it_payload <= (OTHERS => '0');
          when S_HEADER_H =>
            pkt_tx_sop <= "00";
            if (payload_type = "01") then
              start_lfsr <= '1';
            end if;
          when S_HEADER_L =>
            SEED <=  RANDOM;

          when S_PAYLOAD =>
            start_lfsr <= '1';
            SEED <=  RANDOM;
            ID_COUNTER_L <= ID_COUNTER_L + 2;
            ID_COUNTER_H <= ID_COUNTER_H + 2;
            it_payload <= it_payload + 2;
            if(it_payload = 0) Then
              PKT_COUNTER <= PKT_COUNTER + 1;
            elsif(it_payload >= payload_cycles-1) then
              start_lfsr <= '0';
              pkt_tx_mod_reg <= "11111";
              pkt_tx_sop <= "00";
            end if;
        end case;
      end if;
    end process;

    -------------------------------------------------------------------------------
    -- LFSR
    -------------------------------------------------------------------------------

    PRESET_LFSR_CTRL : process (clock, reset)
    begin
      if reset = '0' then
         preset_lfsr <= '0';
       else
         if rising_edge(clock) then
            if(count = 13) then
              preset_lfsr <= '0';
            else
              count <= count + 1;
              preset_lfsr <= '1';
            end if;
          end if;
        end if;
     end process;


    LFSR_GEN: entity work.LFSR_GEN
    generic map (DATA_SIZE => 256,
                 PPL_SIZE => 4)
    port map(
      clock => clock,
      reset_N => reset,
      seed => lfsr_seed,
      polynomial => lfsr_polynomial,
      data_in => RANDOM,
      start => start_lfsr,
      preset => preset_lfsr,
      data_out => RANDOM
    );



end arch_echo_generator;
