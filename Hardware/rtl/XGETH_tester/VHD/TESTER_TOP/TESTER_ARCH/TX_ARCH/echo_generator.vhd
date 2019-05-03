--////////////////////////////////////////////////////////////////////////
--////                                                                ////
--//// File name "echo_generator.vhd"                                 ////
--////                                                                ////
--//// This file is part of "Testset X40G" project                    ////
--////                                                                ////
--//// Author(s):                                                     ////
--//// - Matheus Lemes Ferronato                                      ////
--////                                                                ////
--////////////////////////////////////////////////////////////////////////

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
entity echo_generator is
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
    payload_type        : in std_logic_vector(1 downto 0);
    payload_cycles      : in std_logic_vector(31 downto 0);
    payload_last_size   : in std_logic_vector(7 downto 0)
  );
end echo_generator;

architecture arch_echo_generator of echo_generator is

  -------------------------------------------------------------------------------
  -- SIGNALS
  -------------------------------------------------------------------------------
  attribute mark_debug : string;

  type state_type is (S_IDLE, S_HEADER_H, S_HEADER_L, S_PAYLOAD);
  signal current_s, next_s: state_type;

  signal HEADER             : std_logic_vector(255 downto 0);
  signal PAYLOAD            : std_logic_vector(255 downto 0);
  signal PAYLOAD_PKT        : std_logic_vector(255 downto 0);
  signal PAYLOAD_LAST       : std_logic_vector(255 downto 0);
  signal RANDOM             : std_logic_vector(255 downto 0);
  signal SEED               : std_logic_vector(255 downto 0);
  signal IP                 : std_logic_vector(191 downto 0);
  signal MAC                : std_logic_vector(127 downto 0);
  signal EOH_SOF            : std_logic_vector(127 downto 0); --END OF HEADER - START OF FRAME
  signal ID_COUNTER_L       : std_logic_vector(127 downto 0);
  signal ID_COUNTER_H       : std_logic_vector(127 downto 0); -- counter for ID
  signal ALL_ONE            : std_logic_vector(127 downto 0) := (others => '1');
  signal ALL_ZERO           : std_logic_vector(127 downto 0) := (others => '0');
  signal IDLE_VALUE         : std_logic_vector(127 downto 0) := x"07070707070707070707070707070707";
  signal PKT_COUNTER        : std_logic_vector(63 downto 0);
  signal UPD_INFO           : std_logic_vector(15 downto 0) := x"0000";
  signal start_lfsr         : std_logic;
  signal preset_lfsr        : std_logic;
  signal count              :  integer range 0 to 15;

  signal pkt_tx_data_out : std_logic_vector(255 downto 0);
  signal pkt_tx_data_reg    : std_logic_vector(255 downto 0);
  signal pkt_tx_data_N      : std_logic_vector(255 downto 0);
  signal pkt_tx_data_buffer : std_logic_vector(255 downto 0);
  signal pkt_split          : std_logic_vector(255 downto 0);
  signal pkt_tx_mod_buffer  : std_logic_vector(4 downto 0);
  signal pkt_tx_mod_ctrl    : std_logic_vector(4 downto 0);
  signal pkt_tx_sop_reg     : std_logic_vector(1 downto 0);
  signal pkt_tx_sop_buffer  : std_logic_vector(1 downto 0);
  signal pkt_tx_val_buffer  : std_logic;
  signal pkt_tx_val_reg     : std_logic;
  signal pkt_tx_eop_reg     : std_logic;
  signal last_pkt_delay0    : std_logic;
  signal last_pkt_delay1    : std_logic;
  signal last_pkt           : std_logic;
  -------------------------------------------------------------------------------
  -- Traffic control
  -------------------------------------------------------------------------------
  signal time_stamp        : std_logic_vector(47 downto 0); --
  signal it_payload        : std_logic_vector(31 downto 0); -- iterator used in payload
  signal it_mod            : std_logic_vector(4 downto 0);

  -------------------------------------------------------------------------------
  -- IP
  -------------------------------------------------------------------------------
  signal ip_checksum       : std_logic_vector(15 downto 0); -- Checksum on the IP header
  signal aux_checksum      : std_logic_vector(31 downto 0); -- Auxiliar flag on the checksum calculation
  signal ip_message_length : std_logic_vector(15 downto 0); -- Frame size internal signal
  signal ifg  : std_logic := '0';

  -------------------------------------------------------------------------------
  -- UDP
  -------------------------------------------------------------------------------
  signal udp_message_length : std_logic_vector(15 downto 0);  -- UDP packet length

  function invert_bytes(bytes : std_logic_vector) return std_logic_vector is
    variable bytes_N : std_logic_vector(255 downto 0) := (others => '0');
    variable i_N : integer range 0 to 255;
    begin
      for i in 1 to 32 loop
        bytes_N(((i*8)-1) downto ((i-1)*8)) := bytes((255-(8*(i-1))) downto (255-((8*(i-1))+7)));
      end loop;
    return bytes_N;
  end function invert_bytes;

BEGIN

   pkt_tx_data        <= pkt_tx_data_N when ifg = '0' else                                   --DATAOUT SOP10
                         pkt_split(127 downto 0) & pkt_tx_data_out(255 downto 128);          --DATAOUT SOP11
   pkt_tx_data_N      <= invert_bytes(pkt_tx_data_buffer);                                   --INVERT DATA
   pkt_tx_data_buffer <= PAYLOAD when current_s = S_PAYLOAD else                             --SEND PAYLOAD
                         IDLE_VALUE & IDLE_VALUE when current_s = S_IDLE else                --SEND IDLE
                         HEADER;                                                             --SEND HEADER

   pkt_tx_val        <= pkt_tx_val_buffer when ifg = '0' else                                --USES SOP10 VAL
                        pkt_tx_val_reg or last_pkt_delay1;                                   --USES SOP11 VAL, WHICH HAS ON EXTRA FRAME
   pkt_tx_eop        <= '0' when (last_pkt = '1' and ifg = '0') else                         --USES SOP10 EOP, CHECKING IF LAST PAYLOAD WAS SENT
                        '0' when (last_pkt_delay1 = '1' and ifg = '1') else                  --USES SOP11 EOP, WHICH DELAYS 2 EXTRA CLK CYCLES
                        '1';                                                                 --NORMAL EOP
   pkt_tx_sop        <= pkt_tx_sop_buffer when ifg = '0' else                                --SOP10 FROM FSM
                        pkt_tx_sop_reg(1) & ('1' and pkt_tx_sop_reg(1));                     --SOP11 MIX OF SOP10 AND '1' AT LSB
   pkt_tx_mod        <= pkt_tx_mod_ctrl when (last_pkt = '1' and ifg = '0') else             --USES SOP10 MOD, FROM INPUT PIN
                        pkt_tx_mod_ctrl - 15 when (last_pkt_delay1 = '1' and ifg = '1') else --USES SOP11 MOD, INPUT PIN MINUS SHIFT IN TIME DELAY
                        "00000";                                                             --NORMAL MOD
  pkt_tx_val_buffer  <= '0' when current_s = S_IDLE else                                     --SOP10 VAL, ZERO WHEN IDLE
                        '1';                                                                 --SOP10 VAL, ONE WHEN RUNNING

  HEADER             <= MAC & IP(191 downto 64) when current_s = S_HEADER_H else             --HEADER IS MADE FROM MAC AND PART OF IP WHEN STATE IS HEADER_H
                        EOH_SOF & ALL_ZERO(63 downto 0) & PKT_COUNTER;                       --HEADER IS MADE OF REST OF IP, UDP INFO AND TIME STAMP, PLUS PKT ID WHEN HEADER_L
  PAYLOAD            <= PAYLOAD_LAST when last_pkt = '1' else                                --PAYLOAD RECEIVES LAST PAYLOAD AT THE LAST CYCLE
                        PAYLOAD_PKT;                                                         --PAYLOAD RECEIVES NORMAL PAYLOAD EVERY CYCLE
  PAYLOAD_PKT        <= ID_COUNTER_L & ID_COUNTER_H when payload_type = "00" else            --PAYLOAD_PKT RECEIVES 2 128b FRAME COUNTER EACH CYCLE WHEN TYPE 0
                        SEED when payload_type = "01" else                                   --PAYLOAD_PKT RECEIVES LFSR SEED EACH CYCLE WHEN TYPE 1
                        ALL_ZERO & ALL_ZERO when payload_type = "10" else                    --PAYLOAD_PKT RECEIVES ALL ZEROS EACH CYCLE WHEN TYPE 2
                        ALL_ONE & ALL_ONE   when payload_type = "11";                        --PAYLOAD_PKT RECEIVES ALL ONES EACH CYCLE WHEN TYPE 3
  MAC                <= mac_destination & mac_source & x"08004500";                          --MAC IS MADE FROM MAC DEST AND MAC SOURCE INPUT PINS, AND CONST VALUE
  IP                 <= ip_message_length & x"000000000A11" & ip_checksum &                  --IP IS MADE FROM LENGHT CHECKSUM SOURCE DEST AND CONST VALUE
                        ip_source & ip_destination & x"C020C021" & udp_message_length;
  EOH_SOF            <= IP(63 downto 0) & UPD_INFO & time_stamp;                             --END OF HEADER START OF FRAME CONSTAINS REST OF IP, UDP INFO AND TIMESTAMP

  last_pkt           <= '0' when current_s = S_IDLE else                                     --LAST PKT HIGH WHEN FSM IS IN LAST PAYLOAD GENERATION CYCLE
                        '1' when it_payload = payload_cycles else
                        '0';

-------------------------------------------------------------------------------
-- Enables middle of bus sop
-------------------------------------------------------------------------------

  data_out_ctrl: process(reset, clock)
  begin
    if reset = '0' then
      pkt_tx_data_out <= (others => '0');
      pkt_split       <= (others => '0');
      pkt_tx_sop_reg  <= (others => '0');
      pkt_tx_val_reg  <= '0';
      last_pkt_delay0 <= '0';
      last_pkt_delay1 <= '0';
    elsif (clock'event and clock = '1')then
      last_pkt_delay0 <= last_pkt;
      last_pkt_delay1 <= last_pkt_delay0;
      pkt_tx_data_out <= pkt_tx_data_N;
      pkt_split       <= pkt_tx_data_out;
      pkt_tx_val_reg  <= pkt_tx_val_buffer;
      pkt_tx_sop_reg  <= pkt_tx_sop_buffer;
    end if;
  end process;

-------------------------------------------------------------------------------
-- IP header calculation
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
    pkt_tx_mod_ctrl <= payload_last_size(7 downto 3) - 1;


    STATE_CTRL : process (reset, clock)
    begin
      if(reset = '0') then
        ID_COUNTER_H      <= ALL_ZERO(126 downto 0) & '1';
        ID_COUNTER_L      <= (OTHERS => '0');
        it_payload        <= (OTHERS => '0');
        PKT_COUNTER       <= (OTHERS => '0');
        SEED              <= (OTHERS => '0');
        current_s         <= S_IDLE;
        it_mod            <= "11111";
        pkt_tx_sop_buffer <= "00";
        start_lfsr        <= '0';
      elsif (clock'event and clock = '1') then
        current_s <= next_s;
        case current_s is
          when S_IDLE =>
            if (next_s = S_HEADER_H) then pkt_tx_sop_buffer <= "10"; end if;
            it_payload <= (OTHERS => '0');
          when S_HEADER_H =>
            pkt_tx_sop_buffer <= "00";
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
            it_payload <= it_payload + 1;
            if(it_payload = 0) Then
              PKT_COUNTER <= PKT_COUNTER + 1;
            elsif(it_payload >= payload_cycles-1) then
              start_lfsr <= '0';
            end if;
        end case;
      end if;
    end process;

    -------------------------------------------------------------------------------
    -- PAYLOAD LAST CYCLE CONTROL
    -------------------------------------------------------------------------------

    last_pld_ctrl : process(pkt_tx_mod_ctrl)
    begin
      PAYLOAD_LAST <= (others => '0');
      for i in 0 to 31 loop
        if pkt_tx_mod_ctrl = i then
          if i < 15 then
            PAYLOAD_LAST <= PAYLOAD_PKT((8*(i+1))-1 downto 0) & IDLE_VALUE((8*(15-i))-1 downto 0) & IDLE_VALUE;
          elsif i = 15 then
            PAYLOAD_LAST <= PAYLOAD_PKT(127 downto 0) & IDLE_VALUE;
          elsif i < 31 then
            PAYLOAD_LAST <= PAYLOAD_PKT((8*(i+1))-1 downto 0) & IDLE_VALUE((8*(31-i))-1 downto 0);
          elsif i = 31 then
            PAYLOAD_LAST <= PAYLOAD_PKT;
          end if;
        end if;
      end loop;
    end process;

    ----------------------------------------------------------
    -- LFSR
    ----------------------------------------------------------

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
