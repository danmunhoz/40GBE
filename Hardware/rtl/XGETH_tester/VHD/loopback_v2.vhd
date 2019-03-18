--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- TOP ARCHITECTURE DEVELOPED BY MATHEUS LEMES FERRONATO AND GABRIEL SUSIN.
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
use ieee.numeric_std.all;
--This entity is responsible for invert MACs and IPs from packet header, used in loopback mode.

entity loopback_v2 is
  port
    (
        clk_156 : in std_logic;             -- Clock 156.25 MHz
        reset : in std_logic;             -- Reset (Active Low)
        parity : in std_logic;

        mac_source_in      : in std_logic_vector(47 downto 0);  -- MAC address of the SFP

        -- pkt_rx_avail: Should only be asserted when a packet is available in the receive FIFO.
        -- When asserted, the packet transfer will begin on next cycle. Should remain asserted until EOP.
        pkt_rx_avail_in    : in  std_logic;
        pkt_rx_eop_in      : in  std_logic;
        pkt_rx_sop_in      : in  std_logic;
        pkt_rx_val_in      : in  std_logic;
        pkt_rx_err_in      : in  std_logic;
        pkt_rx_data_in     : in  std_logic_vector(255 downto 0);
        pkt_rx_mod_in      : in  std_logic_vector(3 downto 0);
        mac_filter_in      : in  std_logic_vector(2 downto 0); -- 000 inverts mac source and mac target and receives just packets in broadcast or intended for its mac
                                                            -- 001 does not invert mac source and mac target and receives just packets in broadcast or intended for its mac
                                                            -- 010 inverts mac source and mac target and operates in promiscous mode
                                                            -- 011 does not invert mac source and mac target and operates in promiscous mode


        pkt_tx_eop_out   : out  std_logic;
        pkt_tx_sop_out   : out  std_logic_vector (1 downto 0);
        pkt_tx_val_out   : out  std_logic;
        pkt_tx_data_out  : out  std_logic_vector(255 downto 0);
        pkt_tx_mod_out   : out  std_logic_vector(4 downto 0);

        mac_destination_out  : out std_logic_vector(47 downto 0);
        mac_source_out       : out std_logic_vector(47 downto 0);
        ip_destination_out   : out std_logic_vector(31 downto 0);
        ip_source_out        : out std_logic_vector(31 downto 0)
    );
end loopback_v2;

architecture arch_loopback_v2 of loopback_v2 is

    type   state_type is (S_IDLE, S_CRACK, S_REMOUNT, S_HEADER_H, S_HEADER_L, S_PAYLOAD);
    signal current_s, next_s : state_type;

    --------------------------------------------------------------------------------
    -- MAC n IP reg
    signal mac_source_reg, mac_destination_reg : std_logic_vector(47 downto 0);
    signal ip_source_reg                       : std_logic_vector(31 downto 0);
    signal ip_destination_reg                  : std_logic_vector(31 downto 0);
    signal ip_protocol_reg                     : std_logic_vector(7 downto 0);
    signal ip_message_length_reg               : std_logic_vector(15 downto 0);
    signal ip_checksum_reg                     : std_logic_vector(15 downto 0);
    signal ip_pkt_type                         : std_logic;
    signal ip_low, ip_high                     : std_logic_vector(15 downto 0);

    signal ethernet_type_reg                   : std_logic_vector(15 downto 0);
    signal udp_pkt_type                        : std_logic;
    signal time_stamp_generator                : std_logic_vector(47 downto 0);
    signal ip_destination_wire                 : std_logic_vector(31 downto 0);
    signal udp_message_length_reg : std_logic_vector(15 downto 0);

    --------------------------------------------------------------------------------
    signal pkt_rx_data_N                 : std_logic_vector(255 downto 0);
    signal pkt_rx_data_buffer : std_logic_vector(255 downto 0);

    -- loopback
    --------------------------------------------------------------------------------

    signal pkt_ctrl_delay : std_logic_vector (7 downto 0);
    signal pkt_rebuilt    : std_logic_vector(255 downto 0);
    signal mod_rebuilt    : std_logic_vector(4 downto 0);
    signal MAC            : std_logic_vector(127 downto 0);
    signal IP             : std_logic_vector(191 downto 0);
    signal EOH_SOF        : std_logic_vector(127 downto 0) := x"00000000000000000000000000000000";--END OF HEADER - START OF FRAME
    signal HEADER_H       : std_logic_vector(255 downto 0);
    signal HEADER_L       : std_logic_vector(255 downto 0) := (others => '0');
    signal PAYLOAD        : std_logic_vector(255 downto 0);
    signal IDLE_VALUE     : std_logic_vector(127 downto 0) := x"07070707070707070707070707070707";
    signal ALL_ZERO       : std_logic_vector(63 downto 0):= x"0000000000000000";


    function invert_bytes_255(bytes : std_logic_vector(255 DOWNTO 0)) return std_logic_vector
      is
        variable bytes_N : std_logic_vector(255 downto 0) := (others => '0');
        variable i_N : integer range 0 to 255;
        begin
          for i in 1 to 32 loop
            bytes_N(((i*8)-1) downto ((i-1)*8)) := bytes((255-(8*(i-1))) downto (255-((8*(i-1))+7)));
        end loop;
        return bytes_N;
    end function invert_bytes_255;

    BEGIN

    --------------------------------------------------------------------------------
    --MUX - CONCAT DATA OUT TO BUS
    --------------------------------------------------------------------------------

    pkt_rx_data_N       <= invert_bytes_255(pkt_rx_data_in);

    pkt_tx_val_out      <=  pkt_ctrl_delay(7);
    pkt_tx_sop_out      <=  pkt_ctrl_delay(6) & '0';
    pkt_tx_mod_out      <=  pkt_ctrl_delay(5 downto 1);
    pkt_tx_eop_out      <=  pkt_ctrl_delay(0);
    pkt_tx_data_out     <=  invert_bytes_255(pkt_rebuilt);

    mac_destination_out <=  mac_destination_reg;
    mac_source_out      <=  mac_source_reg;
    ip_destination_out  <=  ip_destination_reg;
    ip_source_out       <=  ip_source_reg;

    pkt_rebuilt         <= PAYLOAD when current_s = S_PAYLOAD else
                           HEADER_H when current_s = S_HEADER_H else
                           HEADER_L when current_s = S_HEADER_L else
                           IDLE_VALUE & IDLE_VALUE;

    PAYLOAD             <= pkt_rx_data_buffer;

    HEADER_H            <= MAC & IP(191 downto 64) when current_s = S_HEADER_H else
                           EOH_SOF & IDLE_VALUE;

    HEADER_L            <= IP(63 downto 0) & ALL_ZERO &  EOH_SOF when current_s = S_HEADER_L else EOH_SOF & IDLE_VALUE;

    MAC                 <=  mac_destination_reg & mac_source_reg & ethernet_type_reg & x"4500";

    IP                  <= ip_message_length_reg & x"000000000A11" & ip_checksum_reg &
                           ip_source_reg & ip_destination_reg & x"C020C021" & udp_message_length_reg;



    --------------------------------------------------------------------------------
    --NEXT LOGIC
    --------------------------------------------------------------------------------

    NEXT_UPDATER : process(current_s, pkt_rx_avail_in, pkt_rx_sop_in, pkt_rx_eop_in)
    begin
    next_s <= S_IDLE;
      case current_s is
        when S_IDLE =>
          if pkt_rx_avail_in = '1' and pkt_rx_sop_in = '1' then
            next_s <= S_CRACK;
          end if;
        when S_CRACK => next_s <= S_REMOUNT;
        when S_REMOUNT => next_s <= S_HEADER_H;
        when S_HEADER_H => next_s <= S_HEADER_L;
        when S_HEADER_L => next_s <= S_PAYLOAD;
        when S_PAYLOAD =>
          if pkt_rx_eop_in = '1' then
            next_s <= S_IDLE;
          else
            next_s <= S_PAYLOAD;
          end if;
      end case;
    end process;

    --------------------------------------------------------------------------------
    --FSM
    --------------------------------------------------------------------------------

    ip_destination_wire <= ip_high & pkt_rx_data_buffer (255 downto 240);

    CRAKC: process(reset, clk_156)
    begin
      if reset = '0' then
        udp_message_length_reg <= (others => '0');
        mac_source_reg         <= (others => '0');
        mac_destination_reg    <= (others => '0');
        ethernet_type_reg      <= (others => '0');
        ip_message_length_reg  <= (others => '0');
        ip_protocol_reg        <= (others => '0');
        ip_checksum_reg        <= (others => '0');
        ip_source_reg          <= (others => '0');
        ip_high                <= (others => '0');
        ip_destination_reg     <= (others => '0');
        pkt_rx_data_buffer     <= (others => '0');

      elsif rising_edge(clk_156) then
        pkt_ctrl_delay <= pkt_rx_val_in & pkt_rx_sop_in & parity & pkt_rx_mod_in & pkt_rx_eop_in;

        current_s <= next_s;
        pkt_rx_data_buffer <= pkt_rx_data_N;
        case current_s is
          when S_IDLE =>
          udp_message_length_reg <= (others => '0');
          ip_destination_reg    <= (others => '0');
          mac_source_reg        <= (others => '0');
          mac_destination_reg   <= (others => '0');
          ethernet_type_reg     <= (others => '0');
          ip_message_length_reg <= (others => '0');
          ip_protocol_reg       <= (others => '0');
          ip_checksum_reg       <= (others => '0');
          ip_source_reg         <= (others => '0');
          ip_high               <= (others => '0');
          when S_CRACK =>
            mac_source_reg        <= pkt_rx_data_buffer (255 downto 208);
            mac_destination_reg   <= pkt_rx_data_buffer (207 downto 160);
            ethernet_type_reg     <= pkt_rx_data_buffer (159 downto 144);
            ip_message_length_reg <= pkt_rx_data_buffer (127 downto 112);
            ip_protocol_reg       <= pkt_rx_data_buffer (71 downto 64);
            ip_checksum_reg       <= pkt_rx_data_buffer (63 downto 48);
            ip_source_reg         <= pkt_rx_data_buffer (47 downto 16);
            ip_high               <= pkt_rx_data_buffer (15 downto 0);
          when S_REMOUNT =>
            if (mac_filter_in = "000") then -- MAC ASSIGNMENT
              mac_source_reg      <= mac_destination_reg;
              mac_destination_reg <= mac_source_in;
            elsif (mac_filter_in = "001") then-- does not inverts
              mac_source_reg      <= mac_source_in;
              mac_destination_reg <= mac_destination_reg;
            elsif (mac_filter_in = "010") then --inverts
              mac_source_reg      <= mac_destination_reg;
              mac_destination_reg <= mac_source_reg;
            else -- does not inverts
              mac_source_reg      <= mac_source_reg;
              mac_destination_reg <= mac_destination_reg;
            end if;
            if (mac_filter_in(0) = '0') Then -- IP ASSIGNMENT
              ip_source_reg       <= ip_destination_wire;
              ip_destination_reg  <= ip_source_reg;
            else
              ip_source_reg       <= ip_source_reg;
              ip_destination_reg  <= ip_destination_wire;
            end if;
          when S_PAYLOAD =>
              udp_message_length_reg <= ip_message_length_reg - 20;
          when others => null;
        end case;
      end if;
    end process;




end arch_loopback_v2;
