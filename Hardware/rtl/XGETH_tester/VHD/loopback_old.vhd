library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

--This entity is responsible for invert MACs and IPs from packet header, used in loopback mode.

entity loopback_old is
  port
    (
        clock : in std_logic;             -- Clock 156.25 MHz
        reset : in std_logic;             -- Reset (Active Low)

        mac_source      : in std_logic_vector(47 downto 0);  -- MAC address of the SFP

        -- pkt_rx_avail: Should only be asserted when a packet is available in the receive FIFO.
        -- When asserted, the packet transfer will begin on next cycle. Should remain asserted until EOP.
        pkt_rx_avail    : in  std_logic;
        pkt_rx_eop      : in  std_logic;
        pkt_rx_sop      : in  std_logic;
        pkt_rx_val      : in  std_logic;
        pkt_rx_err      : in  std_logic;
        pkt_rx_data     : in  std_logic_vector(63 downto 0);
        pkt_rx_mod      : in  std_logic_vector(2 downto 0);
        mac_filter      : in  std_logic_vector(1 downto 0);
        -- 000 inverts mac source and mac target and receives just packets in broadcast or intended for its mac
        -- 001 does not invert mac source and mac target and receives just packets in broadcast or intended for its mac
        -- 010 inverts mac source and mac target and operates in promiscous mode
        -- 011 does not invert mac source and mac target and operates in promiscous mode


        lb_pkt_tx_eop   : out  std_logic;
        lb_pkt_tx_sop   : out  std_logic_vector (1 downto 0);
        lb_pkt_tx_val   : out  std_logic;
        lb_pkt_tx_data  : out  std_logic_vector(63 downto 0);
        lb_pkt_tx_mod   : out  std_logic_vector(4 downto 0);

        lb_mac_destination  : out std_logic_vector(47 downto 0);
        lb_mac_source       : out std_logic_vector(47 downto 0);
        lb_ip_destination   : out std_logic_vector(31 downto 0);
        lb_ip_source        : out std_logic_vector(31 downto 0)
    );
end loopback_old;

architecture arch_loopback_old of loopback_old is

    type   state_type is (S_IDLE, S_HEADER, S_PAYLOAD, S_PAYLOAD_LAST);
    signal current_s : state_type;
    signal lb_pkt_rx_data: std_logic_vector(63 downto 0);
    signal it_header: std_logic_vector(2 downto 0);
    signal lb_pkt_rx_mod: std_logic_vector(4 downto 0);
    signal lb_mac_source_wire: std_logic_vector(47 downto 0);
    signal lb_mac_destination_wire: std_logic_vector(47 downto 0);
    signal lb_ip_message_length: std_logic_vector(15 downto 0);
    signal lb_ip_source_wire: std_logic_vector(31 downto 0);
    signal lb_ip_destination_wire: std_logic_vector(31 downto 0);
    signal lb_ip_checksum: std_logic_vector(15 downto 0);
    signal lb_udp_message_length: std_logic_vector(15 downto 0);

begin
    lb_ip_destination <= lb_ip_destination_wire;
    lb_ip_source <= lb_ip_source_wire;
    lb_mac_source <= lb_mac_source_wire;
    lb_mac_destination <= lb_mac_destination_wire;

    process(reset, clock)
    begin
        if reset = '0' then
            it_header <= (others=>'0');
        elsif rising_edge(clock) then
            lb_pkt_tx_sop <= "00";
            lb_pkt_tx_eop <= '0';
            lb_pkt_tx_mod <= pkt_rx_mod;
            lb_pkt_tx_val <= '0';
            lb_pkt_rx_data <= pkt_rx_data;

            case current_s is
                when S_IDLE =>
                    if (pkt_rx_sop = '1') then
                        current_s <= S_HEADER;
                        lb_mac_source_wire <= pkt_rx_data(63 downto 16);
                        lb_mac_destination_wire(47 downto 32) <=  pkt_rx_data(15 downto 0);
                    end if;
                    it_header <= (others => '0');

                when S_HEADER =>
                    it_header <= it_header + 1;
                    if (it_header = 0) then
                        if(mac_filter = "00" or mac_filter = "01") then
                            if ((lb_mac_source_wire /= mac_source) and (lb_mac_source_wire /= x"FFFFFFFFFFFF")) then -- Only send back packets that were sent to broadcast or for this SFP.
                                current_s <= S_IDLE;
                                lb_pkt_tx_val <= '0';
                            else
                                lb_mac_destination_wire(31 downto 0) <= pkt_rx_data(63 downto 32);
                                lb_pkt_tx_sop <= "10";
                                if (mac_filter = "000") then --inverts
                                    lb_pkt_tx_data <= lb_mac_destination_wire(47 downto 32) & pkt_rx_data(63 downto 32) & mac_source(47 downto 32);
                                else -- does not inverts
                                    lb_pkt_tx_data <= mac_source(47 downto 0) & lb_mac_destination_wire(47 downto 32);
                                end if;
                                lb_pkt_tx_val <= '1';
                            end if;
                        elsif(mac_filter = "10" or mac_filter = "11") then
                                lb_mac_destination_wire(31 downto 0) <= pkt_rx_data(63 downto 32);
                                lb_pkt_tx_sop <= "10";
                                if (mac_filter = "10") then --inverts
                                    lb_pkt_tx_data <= lb_mac_destination_wire(47 downto 32) & pkt_rx_data(63 downto 32) & lb_mac_source_wire(47 downto 32);
                                else -- does not inverts
                                    lb_pkt_tx_data <= lb_mac_source_wire(47 downto 0) & lb_mac_destination_wire(47 downto 32);
                                end if;
                                lb_pkt_tx_val <= '1';
                        end if;
                    elsif (it_header = 1) then
                        lb_ip_message_length <= pkt_rx_data(63 downto 48);
                        lb_pkt_tx_val <= '1';
                        if (mac_filter = "00") then --inverts
                            lb_pkt_tx_data <= mac_source(31 downto 0) & x"08004500";
                        elsif  mac_filter = "10" then
                            lb_pkt_tx_data <= lb_mac_source_wire(31 downto 0) & x"08004500";
                        else -- does not inverts
                            lb_pkt_tx_data <= lb_mac_destination_wire(31 downto 0) & x"08004500";
                        end if;
                    elsif (it_header = 2) then
                        lb_ip_checksum <= pkt_rx_data(63 downto 48);
                        lb_ip_source_wire <= pkt_rx_data(47 downto 16);
                        lb_ip_destination_wire(31 downto 16) <= pkt_rx_data(15 downto 0);
                        lb_pkt_tx_val <= '1';
                        lb_pkt_tx_data <= lb_ip_message_length & x"000000000A11";
                    elsif (it_header = 3) then
                        lb_ip_destination(15 downto 0) <= pkt_rx_data(63 downto 48);
                        lb_udp_message_length <= lb_ip_message_length - 20;
                        lb_pkt_tx_val <= '1';
                        lb_ip_destination_wire(15 downto 0) <= pkt_rx_data(63 downto 48);
                        if (mac_filter = "10" or mac_filter = "00") then --inverts
                            lb_pkt_tx_data <= lb_ip_checksum & lb_ip_destination_wire(31 downto 16) & pkt_rx_data(63 downto 48) & lb_ip_source_wire(31 downto 16);
                        else -- does not invert
                            lb_pkt_tx_data <= lb_ip_checksum & lb_ip_source_wire(31 downto 0) & lb_ip_destination_wire(31 downto 16);
                        end if;
                    elsif (it_header = 4) then
                        lb_pkt_tx_val <= '1';
                        if (mac_filter = "10" or mac_filter = "00") then --inverts
                            lb_pkt_tx_data <= lb_ip_source_wire(15 downto 0) & x"C020C021" & lb_udp_message_length;
                        else -- does not invert
                            lb_pkt_tx_data <= lb_ip_destination_wire(15 downto 0) & x"C020C021" & lb_udp_message_length;
                        end if;
                        current_s <= S_PAYLOAD;
                    end if;

                when S_PAYLOAD =>
                    if (pkt_rx_eop = '1') then
                        current_s <= S_PAYLOAD_LAST;
                    end if;
                    lb_pkt_tx_val <= '1';
                    lb_pkt_tx_data <= lb_pkt_rx_data;
                    lb_pkt_rx_mod <= pkt_rx_mod;

                when S_PAYLOAD_LAST =>
                    lb_pkt_tx_val <= '1';
                    lb_pkt_tx_eop <= '1';
                    lb_pkt_tx_data <= lb_pkt_rx_data;
                    lb_pkt_tx_mod <= lb_pkt_rx_mod;
                    current_s <= S_IDLE;

                when others =>
                    current_s <= S_IDLE;
            end case;
        end if;
    end process;
end arch_loopback_old;
