--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- TOP ARCHITECTURE DEVELOPED BY MATHEUS LEMES FERRONATO.
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- CrossClock
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity CrossClock is
           generic( FF_NUMBER : integer := 2;
                    DATA_SIZE : integer := 64);
           port (
              rst_n   : in std_logic;
              clk_A   : in std_logic;
              clk_B   : in std_logic;
              dataIN  : in std_logic_vector (DATA_SIZE-1 downto 0);
              dataOUT : out std_logic_vector (DATA_SIZE-1 downto 0)
         );
end CrossClock;


architecture arch_CrossClock of CrossClock is
  type ff_array is array (0 to FF_NUMBER-1) of std_logic_vector (FF_NUMBER-1 downto 0);
  signal flipflop : ff_array;

  signal data : std_logic_vector(DATA_SIZE-1 downto 0);

begin

dataOUT <= flipflop(FF_NUMBER-1);

crossFlipFlops : process(clk_A,clk_B, rst_n)
  begin
    if(rst_n = '0') Then
      for i in 0 to FF_NUMBER-1 loop
        flipflop(i) <= (others=> '0');
      end loop;
    else
      if(clk_A'event and clk_A = '1') Then
        flipflop(0) <= dataIN;
      end if;
      if(clk_B'event and clk_B = '1') Then
        for i in 1 to FF_NUMBER-1 loop
          flipflop(i) <= flipflop(i-1);
        end loop;
      end if;
    end if;
end process crossFlipFlops;


end arch_CrossClock;

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- TOP
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

--This entity is responsible for invert MACs and IPs from packet header, used in loopback mode.

entity pkt_creation_mngr is
  port
  (

  --STANDART PORTS
    clk_156             : in  std_logic; -- Clock 156.25 MHz
    clk_312             : in  std_logic; -- Clock 312 MHz
    rst_n               : in  std_logic; -- Reset (Active High);

    --FROM INTERFACE
    loop_select         : in std_logic;
    mac_source          : in  std_logic_vector(47 downto 0); -- MAC source address

    --TO MAC
    pkt_tx_data         : out std_logic_vector(255 downto 0); -- Data bus
    pkt_tx_val          : out std_logic;                     -- Indicates if the data is valid
    pkt_tx_sop          : out std_logic_vector(1 downto 0);                     -- Start of packet flag (sent along with the first frame)
    pkt_tx_eop          : out std_logic;                     -- End of packet flag (sent along with the last frame)
    pkt_tx_mod          : out std_logic_vector(4 downto 0);   -- Module (frame size, only read when eop='1')

    --FROM REC
    rec_mac_source_rx  : in  std_logic_vector(47 downto 0);
    rec_mac_destination_rx : in  std_logic_vector(47 downto 0);
    rec_ip_source_rx : in  std_logic_vector(31 downto 0);
    rec_ip_destination_rx : in  std_logic_vector(31 downto 0);


  --GEN PORTS
    -- Control Signals
    start               : in  std_logic;  -- Enable the packet generation

    --LFSR Initialization
    lfsr_seed       : in std_logic_vector(255 downto 0);
    valid_seed      : in std_logic;
    lfsr_polynomial : in std_logic_vector(1 downto 0);

    -- Settings

    mac_destination     : in  std_logic_vector(47 downto 0); -- MAC destination address
    ip_source           : in  std_logic_vector(31 downto 0); -- IP source address
    ip_destination      : in  std_logic_vector(31 downto 0); -- IP destination address
    packet_length       : in  std_logic_vector(15 downto 0); -- Packet size:  "000" - 64B, "001" - 128B, "010" - 256B, "011" - 512B,
                                                             --               "100" - 768B, "101" - 1024B, "110" - 1280B, "111" - 1518B
    timestamp_base      : in  std_logic_vector(47 downto 0);
    time_stamp_flag     : in  std_logic; -- If the timestamp is needed in the latency test, first bit of payload is '1'

    -- TX mac interface
    pkt_tx_full         : in  std_logic;                     -- Informs if xMAC tx buffer is full

    payload_type        : in std_logic_vector(1 downto 0);
    payload_cycles      : in std_logic_vector(31 downto 0);

    --LOOPBACK PORTS

    -- When asserted, the packet transfer will begin on next cycle. Should remain asserted until EOP.
    pkt_rx_avail_in    : in  std_logic;
    pkt_rx_eop_in      : in  std_logic;
    pkt_rx_sop_in      : in  std_logic;
    pkt_rx_val_in      : in  std_logic;
    pkt_rx_err_in      : in  std_logic;
    pkt_rx_data_in     : in  std_logic_vector(127 downto 0);
    pkt_rx_mod_in      : in  std_logic_vector(3 downto 0);

    mac_filter      : in  std_logic_vector(1 downto 0);
    -- 000 inverts mac source and mac target and receives just packets in broadcast or intended for its mac
    -- 001 does not invert mac source and mac target and receives just packets in broadcast or intended for its mac
    -- 010 inverts mac source and mac target and operates in promiscous mode
    -- 011 does not invert mac source and mac target and operates in promiscous mode

    --OUTPUT TO INTERFACE

    mac_source_out          : out  std_logic_vector(47 downto 0); -- MAC destination address
    mac_destination_out     : out  std_logic_vector(47 downto 0); -- MAC destination address
    ip_source_out           : out  std_logic_vector(31 downto 0); -- IP source address
    ip_destination_out      : out  std_logic_vector(31 downto 0) -- IP destination address

  );
end pkt_creation_mngr;

architecture arch_pkt_creation_mngr of pkt_creation_mngr is

 signal data_rebuild : std_logic_vector (255 downto 0);
 signal turn         : std_logic;

 --LOOPBACK SIGNALS


 signal lb_pkt_tx_eop     :   std_logic;
 signal lb_pkt_tx_sop     :   std_logic_vector (1 downto 0);
 signal lb_pkt_tx_val     :   std_logic;
 signal lb_pkt_tx_data    :   std_logic_vector(255 downto 0);
 signal lb_pkt_tx_mod     :   std_logic_vector(4 downto 0);

 signal lb_mac_destination  :  std_logic_vector(47 downto 0);
 signal lb_mac_source       :  std_logic_vector(47 downto 0);
 signal lb_ip_destination   :  std_logic_vector(31 downto 0);
 signal lb_ip_source        :  std_logic_vector(31 downto 0);

--GEN SIGNALS
  signal gen_pkt_tx_data      :  std_logic_vector(255 downto 0); -- Data bus
  signal gen_pkt_tx_val       :  std_logic;                     -- Indicates if the data is valid
  signal gen_pkt_tx_sop       :  std_logic_vector(1 downto 0);                     -- Start of packet flag (sent along with the first frame)
  signal gen_pkt_tx_eop       :  std_logic;                     -- End of packet flag (sent along with the last frame)
  signal gen_pkt_tx_mod       :  std_logic_vector(4 downto 0);   -- Module (frame size, only read when eop='1')

begin


---------------------------------------------------------
-- DATA REBUILD
---------------------------------------------------------

  packet_rebuild: process(rst_n, clk_312)
  BEGIN
    if (rst_n = '0') Then
      turn <= '0';
      data_rebuild <= (others =>'0');
    elsif (clk_312'event and clk_312 = '1') then
      if (turn = '0') then
        data_rebuild(255 downto 128) <= pkt_rx_data_in;
      else
        data_rebuild(127 downto 0) <= pkt_rx_data_in;
      end if;
    end if;
  end process packet_rebuild;

  ---------------------------------------------------------
  -- MUX to select ECHO GEN or LOOPBACK  -> MAC bus
  ---------------------------------------------------------

  mac_source_out       <= lb_mac_source when loop_select = '1' else rec_mac_source_rx;
  mac_destination_out  <= lb_mac_destination when loop_select = '1' else rec_mac_destination_rx;
  ip_source_out        <= lb_ip_source when loop_select = '1' else rec_ip_source_rx;
  ip_destination_out   <= lb_ip_destination when loop_select = '1' else rec_ip_destination_rx;


  pkt_tx_data <= lb_pkt_tx_data when loop_select = '1' else
              gen_pkt_tx_data;

  pkt_tx_val  <= lb_pkt_tx_val when loop_select = '1' else
              gen_pkt_tx_val;

  pkt_tx_sop  <= lb_pkt_tx_sop when loop_select = '1' else
              gen_pkt_tx_sop;

  pkt_tx_eop  <= lb_pkt_tx_eop when loop_select = '1' else
              gen_pkt_tx_eop;

  pkt_tx_mod  <= lb_pkt_tx_mod when loop_select = '1' else
              gen_pkt_tx_mod;

  ---------------------------------------------------------
  -- MUX to select ECHO GEN or LOOPBACK  -> MAC bus
  ---------------------------------------------------------

  loopback_inst : entity work.loopback port map (
      -- STANDARD INPUTS
      clock               => clk_156,
      reset               => rst_n,
      mac_source          => mac_source,

      pkt_rx_avail        => pkt_rx_avail_in,--FROM INTERFACE
      pkt_rx_eop          => pkt_rx_eop_in,
      pkt_rx_sop          => pkt_rx_sop_in,
      pkt_rx_val          => pkt_rx_val_in,
      pkt_rx_err          => pkt_rx_err_in,
      pkt_rx_data         => data_rebuild,
      pkt_rx_mod          => pkt_rx_mod_in,

      lb_pkt_tx_eop       => lb_pkt_tx_eop,
      lb_pkt_tx_sop       => lb_pkt_tx_sop,
      lb_pkt_tx_val       => lb_pkt_tx_val,
      lb_pkt_tx_data      => lb_pkt_tx_data,
      lb_pkt_tx_mod       => lb_pkt_tx_mod,

      lb_mac_destination  => lb_mac_destination,
      lb_mac_source       => lb_mac_source,
      lb_ip_destination   => lb_ip_destination,
      lb_ip_source        => lb_ip_source,

      mac_filter          => mac_filter
  );

  echo_gen_inst : entity work.echo_generator_256 port map (
      clock         => clk_156,
      reset         => rst_n,

      -- Control Signals
      start               => start,
      time_stamp_flag     => time_stamp_flag,
      --LFSR settings
      lfsr_seed           => lfsr_seed,
      lfsr_polynomial     => lfsr_polynomial,--FROM INTERFACE
      valid_seed          => valid_seed,

      -- Settings: in  std_logic_vector(31 downto 0);
      mac_source          => mac_source,
      mac_destination     => mac_destination,
      ip_source           => ip_source,
      ip_destination      => ip_destination,
      packet_length       => packet_length,
      timestamp_base      => timestamp_base,

      -- TX mac interface
      pkt_tx_full         => pkt_tx_full,
      pkt_tx_data         => gen_pkt_tx_data,
      pkt_tx_val          => gen_pkt_tx_val,
      pkt_tx_sop          => gen_pkt_tx_sop,
      pkt_tx_eop          => gen_pkt_tx_eop,
      pkt_tx_mod          => gen_pkt_tx_mod,
      payload_type        => payload_type,
      payload_cycles      => payload_cycles
  );



end arch_pkt_creation_mngr;
