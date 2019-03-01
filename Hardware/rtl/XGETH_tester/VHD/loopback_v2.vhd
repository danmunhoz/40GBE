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

        mac_source      : in std_logic_vector(47 downto 0);  -- MAC address of the SFP

        -- pkt_rx_avail: Should only be asserted when a packet is available in the receive FIFO.
        -- When asserted, the packet transfer will begin on next cycle. Should remain asserted until EOP.
        pkt_rx_avail    : in  std_logic;
        pkt_rx_eop      : in  std_logic;
        pkt_rx_sop      : in  std_logic;
        pkt_rx_val      : in  std_logic;
        pkt_rx_err      : in  std_logic;
        pkt_rx_data     : in  std_logic_vector(255 downto 0);
        pkt_rx_mod      : in  std_logic_vector(3 downto 0);
        mac_filter      : in  std_logic_vector(2 downto 0); -- 000 inverts mac source and mac target and receives just packets in broadcast or intended for its mac
                                                            -- 001 does not invert mac source and mac target and receives just packets in broadcast or intended for its mac
                                                            -- 010 inverts mac source and mac target and operates in promiscous mode
                                                            -- 011 does not invert mac source and mac target and operates in promiscous mode


        lb_pkt_tx_eop   : out  std_logic;
        lb_pkt_tx_sop   : out  std_logic_vector (1 downto 0);
        lb_pkt_tx_val   : out  std_logic;
        lb_pkt_tx_data  : out  std_logic_vector(255 downto 0);
        lb_pkt_tx_mod   : out  std_logic_vector(4 downto 0);

        lb_mac_destination  : out std_logic_vector(47 downto 0);
        lb_mac_source       : out std_logic_vector(47 downto 0);
        lb_ip_destination   : out std_logic_vector(31 downto 0);
        lb_ip_source        : out std_logic_vector(31 downto 0)
    );
end loopback_v2;

architecture arch_loopback_v2 of loopback_v2 is

    type   state_type is (S_IDLE, S_HEADER_H, S_HEADER_L, S_PAYLOAD);
    signal current_s, next_s : state_type;

    --------------------------------------------------------------------------------
    -- MAC n IP reg
    signal wire_mac_source, wire_mac_destination : std_logic_vector(47 downto 0);
    signal wire_ip_source                       : std_logic_vector(31 downto 0);
    signal wire_ethernet_type                   : std_logic_vector(15 downto 0);
    signal wire_ip_protocol                     : std_logic_vector(7 downto 0);
    signal wire_ip_message_length               : std_logic_vector(15 downto 0);
    signal ip_destination_reg   : std_logic_vector(31 downto 0);
    signal ip_low, ip_high                     : std_logic_vector(15 downto 0);
    signal ip_pkt_type                         : std_logic;
    signal udp_pkt_type                        : std_logic;
    signal time_stamp_generator                : std_logic_vector(47 downto 0);
    --signal time_stamp_receiver                 : std_logic_vector(46 downto 0);
    --signal time_stamp_ready                    : std_logic;
    --signal received_packet_wire                : std_logic;
    signal wire_ip_checksum                   :std_logic_vector(15 downto 0);
    --------------------------------------------------------------------------------

    signal pkt_rx_data_buffer            : std_logic_vector(255 downto 0);
    signal pkt_rx_data_nbits     : std_logic_vector(255 downto 0);
    signal pkt_rx_data_N                 : std_logic_vector(255 downto 0);


    -- loopback
    --------------------------------------------------------------------------------
    --signal lb_pkt_rx_data: std_logic_vector(255 downto 0);
    --signal lb_pkt_rx_mod: std_logic_vector(2 downto 0);
    signal lb_mac_source_reg: std_logic_vector(47 downto 0);
    signal lb_mac_destination_reg: std_logic_vector(47 downto 0);
    signal lb_ip_message_length: std_logic_vector(15 downto 0);
    signal lb_ip_source_reg: std_logic_vector(31 downto 0);
    signal lb_ip_destination_reg: std_logic_vector(31 downto 0);
    signal lb_ip_checksum: std_logic_vector(15 downto 0);
    signal lb_udp_message_length: std_logic_vector(15 downto 0);


    signal pkt_rebuilt : std_logic_vector(255 downto 0);
    signal mod_rebuilt : std_logic_vector(4 downto 0);
    signal MAC          : std_logic_vector(127 downto 0);
    signal IP           : std_logic_vector(191 downto 0);
    signal EOH_SOF      : std_logic_vector(127 downto 0) := x"00000000000000000000000000000000";--END OF HEADER - START OF FRAME
    signal HEADER       : std_logic_vector(255 downto 0);
    signal HEADER2       : std_logic_vector(255 downto 0) := (others => '0');
    signal PAYLOAD      : std_logic_vector(255 downto 0);
    signal IDLE_VALUE   : std_logic_vector(127 downto 0) := x"07070707070707070707070707070707";
    signal TESTE          : std_logic_vector(63 downto 0):= x"0000000000000000";


    function invert_bytes_127(bytes : std_logic_vector(255 DOWNTO 0)) return std_logic_vector
      is
        variable bytes_N : std_logic_vector(255 downto 0) := (others => '0');
        variable i_N : integer range 0 to 255;
        begin
          for i in 1 to 32 loop
            bytes_N(((i*8)-1) downto ((i-1)*8)) := bytes((255-(8*(i-1))) downto (255-((8*(i-1))+7)));
        end loop;
        return bytes_N;
    end function invert_bytes_127;

    BEGIN

    --------------------------------------------------------------------------------
    --MUX - CONCAT DATA OUT TO BUS
    --------------------------------------------------------------------------------


    pkt_rx_data_N <= invert_bytes_127(pkt_rx_data_buffer);

    lb_pkt_tx_eop      <=  pkt_rx_eop;
    lb_pkt_tx_sop      <=  pkt_rx_sop & '0';
    lb_pkt_tx_data     <=  pkt_rebuilt;
    lb_pkt_tx_mod      <=  mod_rebuilt;

    mod_rebuilt <= parity & pkt_rx_mod;

    pkt_rebuilt <= PAYLOAD when current_s = S_PAYLOAD else
                   IDLE_VALUE & IDLE_VALUE when current_s = S_IDLE else
                   HEADER when current_s = S_HEADER_H else HEADER2 when current_s = S_HEADER_L;

     PAYLOAD <= pkt_rx_data_N;

     HEADER <= MAC & IP(191 downto 64) when current_s = S_HEADER_H else
               EOH_SOF & IDLE_VALUE;

     HEADER2 <= IP(63 downto 0) & TESTE &  EOH_SOF when current_s = S_HEADER_L else EOH_SOF & IDLE_VALUE;

    MAC     <=  lb_mac_destination_reg & lb_mac_source_reg & x"08004500";

    IP       <= lb_ip_message_length & x"000000000A11" & lb_ip_checksum &
                lb_ip_source_reg & lb_ip_destination_reg & x"C020C021" & lb_udp_message_length;


    lb_mac_destination <=  lb_mac_destination_reg;
    lb_mac_source      <=  lb_mac_source_reg;
    lb_ip_destination  <=  lb_ip_destination_reg;
    lb_ip_source       <=  lb_ip_source_reg;

    --------------------------------------------------------------------------------
    --NEXT LOGIC
    --------------------------------------------------------------------------------


    NEXT_UPDATER : process(current_s, pkt_rx_avail, pkt_rx_sop, pkt_rx_eop)
    begin
    next_s <= S_IDLE;
      case current_s is
        when S_IDLE =>
          if pkt_rx_avail = '1' and pkt_rx_sop = '1' then
            next_s <= S_HEADER_H;
          end if;
        when S_HEADER_H => next_s <= S_HEADER_L;
        when S_HEADER_L => next_s <= S_PAYLOAD;
        when S_PAYLOAD =>
          if pkt_rx_eop = '1' then
            next_s <= S_IDLE;
          else
            next_s <= S_PAYLOAD;
          end if;
      end case;
    end process;


  --------------------------------------------------------------------------------
  --COMBINATIONAL LOGIC - SPLIT DATA IN FROM BUS
  --------------------------------------------------------------------------------

  wire_mac_source <= pkt_rx_data_N (255 downto 208);
  wire_mac_destination <= pkt_rx_data_N (207 downto 160);
  wire_ethernet_type <= pkt_rx_data_N (159 downto 144);
  wire_ip_message_length <= pkt_rx_data_N (127 downto 112);
  wire_ip_protocol <= pkt_rx_data_N (71 downto 64);
  wire_ip_source <= pkt_rx_data_N (47 downto 16);
  time_stamp_generator <= pkt_rx_data_N(175 downto 128);
  wire_ip_checksum <= pkt_rx_data_N (63 downto 48);

    pkt_rx_data_nbits <= pkt_rx_data;

    -- pkt_rx_data_nbits <= pkt_rx_data_buffer(119 downto 0) & pkt_rx_data(7 downto 0)      when pkt_rx_mod  = "0000" else
    --                      pkt_rx_data_buffer(111 downto 0) & pkt_rx_data(15 downto 0)     when pkt_rx_mod  = "0001" else
    --                      pkt_rx_data_buffer(103 downto 0) & pkt_rx_data(23 downto 0)     when pkt_rx_mod  = "0010" else
    --                      pkt_rx_data_buffer(95 downto 0) & pkt_rx_data(31 downto 0)      when pkt_rx_mod  = "0011" else
    --                      pkt_rx_data_buffer(87 downto 0) & pkt_rx_data(39 downto 0)      when pkt_rx_mod  = "0100" else
    --                      pkt_rx_data_buffer(79 downto 0) & pkt_rx_data(47 downto 0)      when pkt_rx_mod  = "0101" else
    --                      pkt_rx_data_buffer(71 downto 0) & pkt_rx_data(55 downto 0)      when pkt_rx_mod  = "0110" else
    --                      pkt_rx_data_buffer(63 downto 0) & pkt_rx_data(63 downto 0)      when pkt_rx_mod  = "0111" else
    --                      pkt_rx_data_buffer(55 downto 0) & pkt_rx_data(71 downto 0)      when pkt_rx_mod  = "1000" else
    --                      pkt_rx_data_buffer(47 downto 0) & pkt_rx_data(79 downto 0)      when pkt_rx_mod  = "1001" else
    --                      pkt_rx_data_buffer(39 downto 0) & pkt_rx_data(87 downto 0)      when pkt_rx_mod  = "1010" else
    --                      pkt_rx_data_buffer(31 downto 0) & pkt_rx_data(95 downto 0)      when pkt_rx_mod  = "1011" else
    --                      pkt_rx_data_buffer(23 downto 0) & pkt_rx_data(103 downto 0)     when pkt_rx_mod  = "1100" else
    --                      pkt_rx_data_buffer(15 downto 0) & pkt_rx_data(111 downto 0)     when pkt_rx_mod  = "1101" else
    --                      pkt_rx_data_buffer(7 downto 0) & pkt_rx_data(119 downto 0)      when pkt_rx_mod  = "1110" else
    --                      pkt_rx_data;


    --------------------------------------------------------------------------------
    --- SEQUENTIAL LOGIC
    --------------------------------------------------------------------------------

      pkt_rx_data_buffer <= pkt_rx_data_nbits when pkt_rx_eop = '1' else
                            pkt_rx_data;


    FLIP_STATE : process(reset, clk_156)
    begin
      if reset = '0' Then
        current_s <= S_IDLE;
        lb_mac_source_reg <= (others => '0');
        lb_mac_destination_reg <= (others => '0');
        lb_ip_message_length <= (others => '0');
        lb_ip_source_reg <= (others => '0');
        lb_ip_destination_reg <= (others => '0');
        lb_ip_checksum <= (others => '0');
        lb_udp_message_length <= (others => '0');
        wire_ip_checksum    <= (others => '0');
        ip_destination_reg <= (others => '0');
          lb_pkt_tx_val <= '0';
      elsif rising_edge(clk_156)then
        current_s <= next_s;
        case current_s is
          when S_IDLE =>
            ip_high <= (others => '0');
            lb_mac_source_reg <= (others => '0');
            lb_mac_destination_reg <= (others => '0');
            lb_ip_message_length <= (others => '0');
            lb_ip_source_reg <= (others => '0');
            lb_ip_destination_reg <= (others => '0');
            lb_ip_checksum <= (others => '0');
            lb_udp_message_length <= (others => '0');
              wire_ip_checksum    <= (others => '0');
              ip_destination_reg <= (others => '0');
                lb_pkt_tx_val <= '0';
          when S_HEADER_H =>
          ip_destination_reg <= ip_high & pkt_rx_data_N (255 downto 240);
          lb_ip_message_length <= wire_ip_message_length;
          lb_ip_checksum <= wire_ip_checksum;

          when S_HEADER_L =>

            ip_high <= pkt_rx_data_N (15 downto 0);
            -- if ( (wire_mac_source /= mac_source) and (lb_mac_source_reg /= x"FFFFFFFFFFFFFFFFFFFFFFFF") and (not(mac_filter(1)) = '1') ) then -- Only send back packets that were sent to broadcast or for this SFP.
            --     current_s <= S_IDLE;
            --     lb_pkt_tx_val <= '0';
            -- else
              lb_pkt_tx_val <= '1';
              if (mac_filter = "000") then -- MAC ASSIGNMENT
                lb_mac_source_reg      <= wire_mac_destination;
                lb_mac_destination_reg <= mac_source;
              elsif (mac_filter = "001") then-- does not inverts
                lb_mac_source_reg      <= mac_source;
                lb_mac_destination_reg <= wire_mac_destination;
              elsif (mac_filter = "010") then --inverts
                lb_mac_source_reg      <= wire_mac_destination;
                lb_mac_destination_reg <= wire_mac_source;
              else -- does not inverts
                lb_mac_source_reg      <= wire_mac_source;
                lb_mac_destination_reg <= wire_mac_destination;
              end if;
              if (mac_filter(0) = '0') Then -- IP ASSIGNMENT
                lb_ip_source_reg       <= ip_destination_reg;
                lb_ip_destination_reg  <= wire_ip_source;
              else
                lb_ip_source_reg       <= wire_ip_source;
                lb_ip_destination_reg  <= ip_destination_reg;
              end if;
        --    end if;
          when S_PAYLOAD =>
            lb_udp_message_length <= lb_ip_message_length - 20;
        end case;
      end if;
    end process;

end arch_loopback_v2;
