library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity arp_generator is
  port 
  (
    clock               : in  std_logic; -- Clock 156.25 MHz
    reset               : in  std_logic; -- Reset (Active High)
    
    -- Control Signals
    start               : in  std_logic; -- Enable the packet generation

    -- Settings
    mac_source          : in  std_logic_vector(47 downto 0); -- MAC source address
    ip_source           : in  std_logic_vector(31 downto 0); -- IP source address
    ip_destination      : in  std_logic_vector(31 downto 0); -- IP destination address
    
    -- TX mac interface
    pkt_tx_full         : in  std_logic;                     -- Informs if xMAC tx buffer is full
    pkt_tx_data         : out std_logic_vector(63 downto 0); -- Data bus 
    pkt_tx_val          : out std_logic;                     -- Indicates if the data is valid
    pkt_tx_sop          : out std_logic;                     -- Start of packet flag (sent along with the first frame)
    pkt_tx_eop          : out std_logic;                     -- End of packet flag (sent along with the last frame)
    pkt_tx_mod          : out std_logic_vector(2 downto 0)   -- Module (frame size, only read when eop='1')
  );
end arp_generator;

architecture arch_arp_generator of arp_generator is

  -------------------------------------------------------------------------------
  -- State
  -------------------------------------------------------------------------------
  type state_type is (S_ARP_FIRST, S_ARP, S_ARP_LAST, S_IDLE, S_ERROR);
  signal current_s, next_s: state_type;  

  signal header_0, header_1, header_2, header_3, header_4, header_5 : std_logic_vector(63 downto 0);

  -------------------------------------------------------------------------------
  -- Traffic control
  -------------------------------------------------------------------------------    
  signal it_header : std_logic_vector(2 downto 0); -- iterator used in header
  
begin

  -------------------------------------------------------------------------------
  -- HEADER
  -------------------------------------------------------------------------------
  -- Header Table
  header_0 <= x"FFFFFFFFFFFF" & mac_source(47 downto 32);
  header_1 <= mac_source(31 downto 0) & x"08060001";
  header_2 <= x"080006040001" & mac_source(47 downto 32);
  header_3 <= mac_source(31 downto 0) & ip_source;
  header_4 <= x"FFFFFFFFFFFF" & ip_destination(31 downto 16);
  header_5 <= ip_destination(15 downto 0) & x"000000000000";

  -------------------------------------------------------------------------------
  -- MAC
  -------------------------------------------------------------------------------

  -- Data to MAC
  pkt_tx_data <= header_0 when it_header = "000" else
                 header_1 when it_header = "001" else
                 header_2 when it_header = "010" else
                 header_3 when it_header = "011" else
                 header_4 when it_header = "100" else
                 header_5 when it_header = "101" else
                 (others => '1');

  -- MAC Module
  pkt_tx_mod <= "010";

  -- Start of packet
  pkt_tx_sop <= '1' when current_s = S_ARP_FIRST else
                '0';

  -- End of packet
  pkt_tx_eop <= '1' when current_s = S_ARP_LAST else
                '0';

  -- Is sending words to MAC
  pkt_tx_val <= '1' when current_s = S_ARP_FIRST or current_s = S_ARP or current_s = S_ARP_LAST else
                '0';

  -------------------------------------------------------------------------------
  -- Combinational Logic
  -------------------------------------------------------------------------------
  -- Updates the state
  process (current_s, it_header, start)
  begin
    next_s <= current_s;    

    case current_s is
        when S_IDLE =>          
            if(start = '1') then
                next_s <= S_ARP_FIRST;
            end if;
        when S_ARP_FIRST =>
            next_s <= S_ARP;
        when S_ARP =>     
            if(it_header >= 4) then
                next_s <= S_ARP_LAST;
            end if;   
        when S_ARP_LAST =>       
            next_s <= S_IDLE;
        when others =>
            next_s <= S_ERROR;       
    end case;
  end process;

  -------------------------------------------------------------------------------
  -- Sequential Logic
  -------------------------------------------------------------------------------
  -- Update the current state
  process (clock, reset)
  begin
    if (reset='0') then
      current_s <= S_IDLE;
    elsif (rising_edge(clock)) then
      current_s <= next_s;  
    end if;
  end process;

  -- Updates the header iterator
  process (reset, clock)
  begin
    if(reset = '0') then
      it_header <= (others => '0');
    elsif rising_edge(clock) then
      case current_s is
        when S_IDLE      => it_header <= (others => '0'); 
        when S_ARP_FIRST => it_header <= it_header + 1;            
        when S_ARP       => it_header <= it_header + 1;
        when others      => it_header <= it_header;                
      end case;
    end if;
  end process;

end arch_arp_generator;
