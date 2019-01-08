library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

--This entity is responsible for invert MACs and IPs from packet header, used in loopback mode.

entity loopback is
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
        pkt_rx_data     : in  std_logic_vector(127 downto 0);
        pkt_rx_mod      : in  std_logic_vector(2 downto 0);
        mac_filter      : in  std_logic_vector(2 downto 0); -- 000 inverts mac source and mac target and receives just packets in broadcast or intended for its mac
                                                            -- 001 does not invert mac source and mac target and receives just packets in broadcast or intended for its mac
                                                            -- 010 inverts mac source and mac target and operates in promiscous mode
                                                            -- 011 does not invert mac source and mac target and operates in promiscous mode


        pkt_loopback_ren: out  std_logic;
        lb_pkt_tx_eop   : out  std_logic;
        lb_pkt_tx_sop   : out  std_logic;
        lb_pkt_tx_val   : out  std_logic;
        lb_pkt_tx_data  : out  std_logic_vector(255 downto 0);
        lb_pkt_tx_mod   : out  std_logic_vector(2 downto 0);

        lb_mac_destination  : out std_logic_vector(47 downto 0);
        lb_mac_source       : out std_logic_vector(47 downto 0);
        lb_ip_destination   : out std_logic_vector(31 downto 0);
        lb_ip_source        : out std_logic_vector(31 downto 0)
    );
end loopback;

architecture arch_loopback of loopback is

    type   state_type is (S_IDLE, S_HEADER, S_PAYLOAD, S_PAYLOAD_LAST);
    signal current_s : state_type;

end arch_loopback;
