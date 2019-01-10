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


        pkt_loopback_ren: out  std_logic;
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

    type   state_type is (S_IDLE, S_HEADER_ETH_IP, S_REST_IP, S_PAYLOAD, S_PAYLOAD_LAST);
    signal current_s, next_s : state_type;

    type   flip_type is (S_IDLE, S_FLIP_ETH_IP , S_REST_IP, S_UDP_UPDATER);
    signal flip_s: flip_type;

    type   create_type is (S_IDLE); -- VER
    signal create_s: flip_type;

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
    signal time_stamp_generator                : std_logic_vector(47 downto 0);
    signal time_stamp_receiver                 : std_logic_vector(46 downto 0);
    signal time_stamp_ready                    : std_logic;
    signal received_packet_wire                : std_logic;
    --------------------------------------------------------------------------------

    signal pkt_rx_data_buffer            : std_logic_vector(255 downto 0);
    signal pkt_rx_data_nbits     : std_logic_vector(255 downto 0);
    signal pkt_rx_data_N                 : std_logic_vector(255 downto 0);


    -- loopback
    --------------------------------------------------------------------------------
    signal lb_pkt_rx_data: std_logic_vector(255 downto 0);
    signal lb_pkt_rx_mod: std_logic_vector(2 downto 0);
    signal lb_mac_source_wire: std_logic_vector(47 downto 0);
    signal lb_mac_destination_wire: std_logic_vector(47 downto 0);
    signal lb_ip_message_length: std_logic_vector(15 downto 0);
    signal lb_ip_source_wire: std_logic_vector(31 downto 0);
    signal lb_ip_destination_wire: std_logic_vector(31 downto 0);
    signal lb_ip_checksum: std_logic_vector(15 downto 0);
    signal lb_udp_message_length: std_logic_vector(15 downto 0);

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

    pkt_rx_data_N <= invert_bytes_127(pkt_rx_data_buffer);

    NEXT_UPDATER : process(current_s, pkt_rx_avail, pkt_rx_sop, pkt_rx_eop)
    begin
    next_s <= S_IDLE;
      case current_s is
        when S_IDLE =>
          if pkt_rx_avail = '1' and pkt_rx_sop = '1' then
            next_s <= S_HEADER_ETH_IP;
          end if;
        when S_HEADER_ETH_IP => next_s <= S_REST_IP;
        when S_REST_IP => next_s <= S_PAYLOAD;
        when S_PAYLOAD =>
          if pkt_rx_eop = '1' then
            next_s <= S_PAYLOAD_LAST;
          else
            next_s <= S_PAYLOAD;
          end if;
        when S_PAYLOAD_LAST => next_s <= S_IDLE;
      end case;
    end process;

      current_updater : process(reset, clk_156)
      begin
        if reset = '0' then
            current_s <= S_IDLE;
        elsif rising_edge(clk_156)  then
          if pkt_rx_eop = '1' then
            pkt_rx_data_buffer <= pkt_rx_data_nbits;
          else
            pkt_rx_data_buffer <= pkt_rx_data;
          end if;
          current_s <= next_s;
        end if;
      end process;

  --------------------------------------------------------------------------------
  --------------------------------------------------------------------------------



      package_updater : process(reset, clk_156)
      begin
        if reset = '0' then
          reg_mac_source <= (others => '0');
          reg_mac_destination <=(others => '0');
          reg_ethernet_type <= (others => '0');
          reg_ip_protocol <= (others => '0');
          reg_ip_message_length <= (others => '0');
          reg_ip_source <= (others => '0');
          ip_high <= (others => '0');
          reg_ip_destination <= (others => '0');
        elsif rising_edge(clk_156) then
          case current_s is
            when S_IDLE =>
              reg_mac_source <= (others => '0');
              reg_mac_destination <=(others => '0');
              reg_ethernet_type <= (others => '0');
              reg_ip_protocol <= (others => '0');
              reg_ip_message_length <= (others => '0');
              reg_ip_source <= (others => '0');
              ip_high <= (others => '0');
              reg_ip_destination <= (others => '0');
            when S_HEADER_ETH_IP =>
              reg_mac_source <= pkt_rx_data_N (255 downto 208);
              reg_mac_destination <= pkt_rx_data_N (207 downto 160);
              reg_ethernet_type <= pkt_rx_data_N (159 downto 144);
              reg_ip_message_length <= pkt_rx_data_N (127 downto 112);
              reg_ip_protocol <= pkt_rx_data_N (71 downto 64);
              reg_ip_source <= pkt_rx_data_N (47 downto 16);
              ip_high <= pkt_rx_data_N (15 downto 0);
            when S_REST_IP =>
              time_stamp_generator <= pkt_rx_data_N(175 downto 128);
              reg_ip_destination <= ip_high & pkt_rx_data_N (255 downto 240);
            when S_PAYLOAD =>
            null;
            when S_PAYLOAD_LAST =>
            null;
          end case;
        end if;

    end process;

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
    --- FLIP MAC and IP
    --------------------------------------------------------------------------------


    FLIP_STATE : process(reset, clk_156)
    begin
      if reset = '0' Then
        lb_mac_source_wire <= (others => '0');
        lb_mac_destination_wire <= (others => '0');
        lb_ip_message_length <= (others => '0');
        lb_ip_source_wire <= (others => '0');
        lb_ip_destination_wire <= (others => '0');
        lb_ip_checksum <= (others => '0');
        lb_udp_message_length <= (others => '0');
      elsif rising_edge(clk_156)then
        case flip_s is
          when S_IDLE =>
          when S_FLIP_ETH_IP =>
          if (mac_filter = "00" or mac_filter = "01") then
            if ((reg_mac_source /= mac_source) and (lb_mac_source_wire /= x"FFFFFFFFFFFFFFFFFFFFFFFF")) then -- Only send back packets that were sent to broadcast or for this SFP.
                flip_s <= S_IDLE;
                lb_pkt_tx_val <= '0';
            else
              lb_pkt_tx_val <= '1';
              lb_pkt_tx_sop <= "10";
              if (mac_filter = "00") then --inverts
                lb_mac_source_wire      <= reg_mac_destination;
                lb_mac_destination_wire <= mac_source;
                lb_ip_source_wire       <= reg_ip_destination;
                lb_ip_destination_wire  <= reg_ip_source;
              else -- does not inverts
                lb_mac_source_wire      <= mac_source;
                lb_mac_destination_wire <= reg_mac_destination;
                lb_ip_source_wire       <= reg_ip_source;
                lb_ip_destination_wire  <= reg_ip_destination;
              end if;
            end if;
          elsif (mac_filter = "10" or mac_filter = "11") then
            lb_pkt_tx_sop <= "10";
            lb_pkt_tx_val <= '1';
            if (mac_filter = "10") then --inverts
              lb_mac_source_wire      <= reg_mac_destination;
              lb_mac_destination_wire <= reg_mac_source;
              lb_ip_source_wire       <= reg_ip_destination;
              lb_ip_destination_wire  <= reg_ip_source;
            else -- does not inverts
              lb_mac_source_wire      <= reg_mac_source;
              lb_mac_destination_wire <= reg_mac_destination;
              lb_ip_source_wire       <= reg_ip_source;
              lb_ip_destination_wire  <= reg_ip_destination;
            end if;
          end if;
          when S_REST_IP =>
            lb_ip_message_length <= reg_ip_message_length;
            lb_ip_checksum <= (others => '1');
          when S_UDP_UPDATER =>
            lb_udp_message_length <= lb_ip_message_length - 20;

        end case;
      end if;
    end process;


    CREATE_PKT_STATE : process(reset, clk_156)
    begin
      if reset = '0' Then
        lb_pkt_tx_mod <= '0' & pkt_rx_mod;
        lb_pkt_rx_data <= pkt_rx_data;
      elsif rising_edge(clk_156)then
        case create_s is
          when S_IDLE => null;
          when others => null;


        end case;
      end if;
    end process;

end arch_loopback_v2;
