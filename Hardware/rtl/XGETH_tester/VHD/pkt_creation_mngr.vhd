--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- GENERIC SYNC FIFO
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
library UNISIM;
  use UNISIM.vcomponents.all;
library UNIMACRO;
  use unimacro.Vcomponents.all;

entity GENERIC_SYNC_FIFO is
           generic( FIFO_N       : integer := 4;
                    TARGET_SIZE  : integer := 64;
                    CTRL_SIZE    : integer := 9;
                    CURRENT_SIZE : integer := 256);
           port (
              CLK         : IN  std_logic;
              RST         : IN  std_logic;
              DATA_IN     : IN  std_logic_vector(CURRENT_SIZE-1 downto 0);
              DATA_OUT    : OUT std_logic_vector(CURRENT_SIZE-1 downto 0);
              CTRL_IN     : IN  std_logic_vector(CTRL_SIZE-1 downto 0);
              CTRL_OUT    : OUT  std_logic_vector(CTRL_SIZE-1 downto 0);
              READ_DATA   : IN  std_logic;
              WRITE_DATA  : IN  std_logic;
              EMPTY       : OUT std_logic;
              FULL        : OUT std_logic;
              A_FULL      : OUT std_logic;
              A_EMPTY     : OUT std_logic
         );
end GENERIC_SYNC_FIFO;


architecture ARCH_GENERIC_SYNC_FIFO of GENERIC_SYNC_FIFO is
  signal ALL_ZEROS    : std_logic_vector(CURRENT_SIZE-1 downto 0);

  type   ctrl_table is array (0 to FIFO_N) of std_logic;
  signal fifo_empty   : ctrl_table;
  signal fifo_full    : ctrl_table;
  signal fifo_a_full  : ctrl_table;
  signal fifo_a_empty : ctrl_table;

  signal wire_empty : std_logic;
  signal wire_full : std_logic;
  signal wire_a_full : std_logic;
  signal wire_a_empty : std_logic;

  type   data_table is array (0 to FIFO_N-1) of std_logic_vector(TARGET_SIZE-1 downto 0);
  signal data_in_slipt    : data_table;
  signal data_out_slipt   : data_table;
  signal data_out_concat  : std_logic_vector(CURRENT_SIZE-1 downto 0);

  type   counter_table is array (0 to 1) of std_logic_vector(8 downto 0);
  signal fifo_data_counter    : counter_table;

  signal fifo_ctrl_in         : std_logic_vector(TARGET_SIZE-1 downto 0);
  signal fifo_ctrl_out        : std_logic_vector(TARGET_SIZE-1 downto 0);
  signal fifo_ctrl_counter_r  :std_logic_vector(8 downto 0);
  signal fifo_ctrl_counter_w  : std_logic_vector(8 downto 0);

BEGIN

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- BREAK DATA
-- split bus data in to chunks of Target size
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  break : for i in 0 to  FIFO_N-1 generate
    data_in_slipt(i) <= DATA_IN( ((TARGET_SIZE)*(i+1))-1 downto (TARGET_SIZE)*(i));
  end generate break;

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- GENERATE DATA FIFOS
-- generates N-1 fifos
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  generate_fifos : for i in 0 to  FIFO_N-1 generate
    FIFO_SYNC_MACRO_inst : FIFO_SYNC_MACRO
    generic map (
      DEVICE => "7SERIES", -- Target Device: "VIRTEX5, "VIRTEX6", "7SERIES"
      ALMOST_FULL_OFFSET => X"0080", -- Sets almost full threshold
      ALMOST_EMPTY_OFFSET => X"0080", -- Sets the almost empty threshold
      DATA_WIDTH => TARGET_SIZE, -- Valid values are 1-72 (37-72 only valid when FIFO_SIZE="36Kb")
      FIFO_SIZE => "36Kb") -- Target BRAM, "18Kb" or "36Kb"
    port map (
      ALMOSTEMPTY => fifo_a_empty(i), -- 1-bit output almost empty
      ALMOSTFULL => fifo_a_full(i), -- 1-bit output almost full
      DO => data_out_slipt(i), -- Output data, width defined by DATA_WIDTH parameter
      EMPTY => fifo_empty(i), -- 1-bit output empty
      FULL => fifo_full(i), -- 1-bit output full
      RDCOUNT => fifo_data_counter(0), -- Output read count, width determined by FIFO depth
      RDERR => open, -- 1-bit output read error
      WRCOUNT => fifo_data_counter(1), -- Output write count, width determined by FIFO depth
      WRERR => open, -- 1-bit output write error
      CLK => CLK, -- 1-bit input clock
      DI => data_in_slipt(i), -- Input data, width defined by DATA_WIDTH parameter
      RDEN => READ_DATA, -- 1-bit input read enable
      RST => RST,-- 1-bit input reset
      WREN => WRITE_DATA -- 1-bit input write enable
      );
    end generate generate_fifos;

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- GENERATE CTRL FIFOS
-- generates 1 ctrl fifos
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    fifo_ctrl_in <= ALL_ZEROS( (TARGET_SIZE - CTRL_SIZE)-1 downto 0) & CTRL_IN;
    CTRL_OUT     <= fifo_ctrl_out(CTRL_SIZE-1 downto 0);

    FIFO_SYNC_MACRO_CTRL : FIFO_SYNC_MACRO
    generic map (
      DEVICE => "7SERIES", -- Target Device: "VIRTEX5, "VIRTEX6", "7SERIES"
      ALMOST_FULL_OFFSET => X"0080", -- Sets almost full threshold
      ALMOST_EMPTY_OFFSET => X"0080", -- Sets the almost empty threshold
      DATA_WIDTH => TARGET_SIZE, -- Valid values are 1-72 (37-72 only valid when FIFO_SIZE="36Kb")
      FIFO_SIZE => "36Kb") -- Target BRAM, "18Kb" or "36Kb"
    port map (
      ALMOSTEMPTY => fifo_a_empty(FIFO_N), -- 1-bit output almost empty
      ALMOSTFULL => fifo_a_full(FIFO_N), -- 1-bit output almost full
      DO => fifo_ctrl_out, -- Output data, width defined by DATA_WIDTH parameter
      EMPTY => fifo_empty(FIFO_N), -- 1-bit output empty
      FULL => fifo_full(FIFO_N), -- 1-bit output full
      RDCOUNT => fifo_ctrl_counter_r , -- Output read count, width determined by FIFO depth
      RDERR => open, -- 1-bit output read error
      WRCOUNT => fifo_ctrl_counter_w, -- Output write count, width determined by FIFO depth
      WRERR => open, -- 1-bit output write error
      CLK => CLK, -- 1-bit input clock
      DI => fifo_ctrl_in, -- Input data, width defined by DATA_WIDTH parameter
      RDEN => READ_DATA, -- 1-bit input read enable
      RST => RST,-- 1-bit input reset
      WREN => WRITE_DATA -- 1-bit input write enable
      );

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- DATA OUT REBUILD
-- concatenate data from fifo
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    DATA_OUT <= data_out_concat;

    concat : for i in 0 to  FIFO_N-1 generate
      data_out_concat( ((TARGET_SIZE)*(i+1))-1 downto (TARGET_SIZE)*(i)) <=  data_out_slipt(i);
    end generate concat;

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- FIFO CTRL SIGNALS
-- execute bitwise or of the 4 fifos ctrl output signals
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    EMPTY   <= wire_empty;
    FULL    <= wire_full;
    A_EMPTY <= wire_a_full;
    A_FULL  <= wire_a_empty;

    opertation_or : for i in 0 to  FIFO_N-1 generate
      wire_empty   <= wire_empty or fifo_empty(i);
      wire_full    <= wire_full or fifo_full(i);
      wire_a_full <= wire_a_full or fifo_a_empty(i);
      wire_a_empty  <= wire_a_empty or fifo_a_full(i);
    end generate;

end ARCH_GENERIC_SYNC_FIFO;

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- TOP
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
library UNISIM;
  use UNISIM.vcomponents.all;
library UNIMACRO;
  use unimacro.Vcomponents.all;
--This entity is responsible for invert MACs and IPs from packet header, used in loopback mode.

entity pkt_creation_mngr is
  port
  (

  --STANDART PORTS
    clk_156                : in  std_logic; -- Clock 156.25 MHz
    clk_312                : in  std_logic; -- Clock 312 MHz
    rst_n                  : in  std_logic; -- Reset (Active High);

    --FROM INTERFACE
    loop_select            : in std_logic;
    mac_source             : in  std_logic_vector(47 downto 0); -- MAC source address

    --TO MAC
    pkt_tx_data            : out std_logic_vector(255 downto 0); -- Data bus
    pkt_tx_val             : out std_logic;                     -- Indicates if the data is valid
    pkt_tx_sop             : out std_logic_vector(1 downto 0);                     -- Start of packet flag (sent along with the first frame)
    pkt_tx_eop             : out std_logic;                     -- End of packet flag (sent along with the last frame)
    pkt_tx_mod             : out std_logic_vector(4 downto 0);   -- Module (frame size, only read when eop='1')

    --FROM REC
    rec_mac_source_rx      : in  std_logic_vector(47 downto 0);
    rec_mac_destination_rx : in  std_logic_vector(47 downto 0);
    rec_ip_source_rx       : in  std_logic_vector(31 downto 0);
    rec_ip_destination_rx  : in  std_logic_vector(31 downto 0);


  --GEN PORTS
    -- Control Signals
    start                  : in  std_logic;  -- Enable the packet generation

    --LFSR Initialization
    lfsr_seed              : in std_logic_vector(255 downto 0);
    valid_seed             : in std_logic;
    lfsr_polynomial        : in std_logic_vector(1 downto 0);

    -- Settings

    mac_destination        : in  std_logic_vector(47 downto 0); -- MAC destination address
    ip_source              : in  std_logic_vector(31 downto 0); -- IP source address
    ip_destination         : in  std_logic_vector(31 downto 0); -- IP destination address
    packet_length          : in  std_logic_vector(15 downto 0); -- Packet size:  "000" - 64B, "001" - 128B, "010" - 256B, "011" - 512B,
                                                             --               "100" - 768B, "101" - 1024B, "110" - 1280B, "111" - 1518B
    timestamp_base         : in  std_logic_vector(47 downto 0);
    time_stamp_flag        : in  std_logic; -- If the timestamp is needed in the latency test, first bit of payload is '1'

    -- TX mac interface
    pkt_tx_full            : in  std_logic;                     -- Informs if xMAC tx buffer is full

    wen                    : in  std_logic;
    ren                    : in  std_logic;

    payload_type           : in std_logic_vector(1 downto 0);
    payload_cycles         : in std_logic_vector(31 downto 0);

    --LOOPBACK PORTS

    -- When asserted, the packet transfer will begin on next cycle. Should remain asserted until EOP.
    pkt_rx_avail_in       : in  std_logic;
    pkt_rx_eop_in         : in  std_logic;
    pkt_rx_sop_in         : in  std_logic;
    pkt_rx_val_in         : in  std_logic;
    pkt_rx_err_in         : in  std_logic;
    pkt_rx_data_in        : in  std_logic_vector(127 downto 0);
    pkt_rx_mod_in         : in  std_logic_vector(3 downto 0);

    mac_filter            : in  std_logic_vector(2 downto 0);
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

 --LOOPBACK SIGNALS

 signal lb_pkt_tx_eop         :   std_logic;
 signal lb_pkt_tx_sop         :   std_logic_vector (1 downto 0);
 signal lb_pkt_tx_val         :   std_logic;
 signal lb_pkt_tx_data        :   std_logic_vector(255 downto 0);
 signal lb_pkt_tx_mod         :   std_logic_vector(4 downto 0);

 signal lb_mac_destination    :  std_logic_vector(47 downto 0);
 signal lb_mac_source         :  std_logic_vector(47 downto 0);
 signal lb_ip_destination     :  std_logic_vector(31 downto 0);
 signal lb_ip_source          :  std_logic_vector(31 downto 0);

--GEN SIGNALS

  signal gen_pkt_tx_data      :  std_logic_vector(255 downto 0); -- Data bus
  signal gen_pkt_tx_val       :  std_logic;                     -- Indicates if the data is valid
  signal gen_pkt_tx_sop       :  std_logic_vector(1 downto 0);                     -- Start of packet flag (sent along with the first frame)
  signal gen_pkt_tx_eop       :  std_logic;                     -- End of packet flag (sent along with the last frame)
  signal gen_pkt_tx_mod       :  std_logic_vector(4 downto 0);   -- Module (frame size, only read when eop='1')

--CONTROL SIGNALS
  signal clk_312_n            : std_logic;
  signal parity               : std_logic;
  signal data_ctrl_in         : std_logic_vector(7 downto 0);
  signal data_ctrl_out        : std_logic_vector(7 downto 0);
  signal data_concat          : std_logic_vector(135 downto 0);
  signal data_rebuild         : std_logic_vector (255 downto 0);

--FIFO Signals

  type   read_type is (S_IDLE, S_READ);
  type   write_type is (S_IDLE, S_WRITE);
  signal read_s           : read_type;
  signal write_s          : write_type;

  signal fifo_pkt_tx_data     : std_logic_vector (255 downto 0);
  signal fifo_ctrl_in         : std_logic_vector (8 downto 0);
  signal fifo_ctrl_out        : std_logic_vector (8 downto 0);
  signal fifo_reset           : std_logic;
  signal fifo_read_en         : std_logic;
  signal fifo_write_en        : std_logic;
  signal fifo_a_empty         : std_logic;
  signal fifo_a_full          : std_logic;
  signal fifo_empty           : std_logic;
  signal fifo_full            : std_logic;

  signal fifo_eop_out         : std_logic;
  signal fifo_sop_out         : std_logic_vector (1 downto 0);
  signal fifo_mod_out         : std_logic_vector (4 downto 0);
  signal fifo_val_out         : std_logic;




begin

---------------------------------------------------------
-- SHIFTED CLOCK DATA REBUILD
--------------------------------------------------------

  clk_312_n <= not clk_312;
  data_ctrl_in <= pkt_rx_avail_in & pkt_rx_val_in & pkt_rx_sop_in &
                  pkt_rx_mod_in   & pkt_rx_eop_in;


  data_concatenation : process (clk_312_n, clk_156, rst_n)
  begin
    if (rst_n = '0') then
      data_rebuild <= (others => '0');
      data_concat <= (others => '0');
      data_ctrl_out  <= (others => '0');
      parity <= '0';
    else
      if (clk_312_n'event and clk_312_n = '1') then
        if(parity = '0') then
          if (pkt_rx_sop_in = '1') then
            data_concat <= pkt_rx_data_in & data_ctrl_in;
            parity <= '0';
          else
            parity <= '1';
          end if;
        else
          data_concat <= pkt_rx_data_in & data_ctrl_in;
          parity <= '0';
        end if;
      end if;
      if (clk_156'event and clk_156 = '1') then
        data_rebuild <=  pkt_rx_data_in & data_concat(135 downto 8);
        data_ctrl_out <= data_concat(7 downto 0) or data_ctrl_in;
      end if;
    end if;
  end process;

---------------------------------------------------------
-- FIFO LOOPBACK IN
--------------------------------------------------------

    fifo_reset <= not(rst_n);
    fifo_ctrl_in <= lb_pkt_tx_val & lb_pkt_tx_sop & lb_pkt_tx_mod & lb_pkt_tx_eop;
    fifo_val_out <= fifo_ctrl_out(8);
    fifo_sop_out <= fifo_ctrl_out(7 downto 6);
    fifo_mod_out <= fifo_ctrl_out(5 downto 1);
    fifo_eop_out <= fifo_ctrl_out(0);

    read_from_fifo : process(clk_156, rst_n)
    begin
      if rst_n = '0' then

      elsif clk_156'event and clk_156 = '1' then
        case read_s is
          when S_IDLE =>
            if start= '1' and pkt_rx_avail_in = '1' then
              fifo_read_en <= '1';
              read_s <= S_READ;
            end if;
          when S_READ =>
            if fifo_eop_out= '1' then
              fifo_read_en <= '0';
              read_s <= S_IDLE;
            end if;
        end case;
      end if;
    end process read_from_fifo;

    write_in_fifo : process(clk_156, rst_n)
    begin
      if rst_n = '0' then

      elsif clk_156'event and clk_156 = '1' then

      end if;
    end process write_in_fifo ;


    SYNC_FIFO : entity work.GENERIC_SYNC_FIFO
    generic map (
      FIFO_N       => 4,
      TARGET_SIZE  =>  64,
      CTRL_SIZE    => 9,
      CURRENT_SIZE => 256)
    port map(
      CLK          => clk_156,
      RST          => fifo_reset,
      DATA_IN      => lb_pkt_tx_data,
      DATA_OUT     => fifo_pkt_tx_data,
      CTRL_IN      => fifo_ctrl_in,
      CTRL_OUT     => fifo_ctrl_out,
      READ_DATA    => fifo_read_en,
      WRITE_DATA   => fifo_write_en,
      A_EMPTY      => fifo_a_empty,
      A_FULL       => fifo_a_full,
      EMPTY        => fifo_empty,
      FULL         => fifo_full
    );

---------------------------------------------------------
-- MUX to select ECHO GEN or LOOPBACK  -> MAC bus
---------------------------------------------------------

  mac_source_out       <= lb_mac_source when loop_select = '1' else rec_mac_source_rx;
  mac_destination_out  <= lb_mac_destination when loop_select = '1' else rec_mac_destination_rx;
  ip_source_out        <= lb_ip_source when loop_select = '1' else rec_ip_source_rx;
  ip_destination_out   <= lb_ip_destination when loop_select = '1' else rec_ip_destination_rx;


  pkt_tx_data <= fifo_pkt_tx_data when loop_select = '1' else
              gen_pkt_tx_data;

  pkt_tx_val  <= fifo_val_out when loop_select = '1' else
              gen_pkt_tx_val;

  pkt_tx_sop  <= fifo_sop_out when loop_select = '1' else
              gen_pkt_tx_sop;

  pkt_tx_eop  <= fifo_eop_out when loop_select = '1' else
              gen_pkt_tx_eop;

  pkt_tx_mod  <= fifo_mod_out when loop_select = '1' else
              gen_pkt_tx_mod;

  ---------------------------------------------------------
  -- MUX to select ECHO GEN or LOOPBACK  -> MAC bus
  ---------------------------------------------------------

  loopback_inst : entity work.loopback_v2 port map (
      -- STANDARD INPUTS
      clk_156             => clk_156,
      reset               => rst_n,
      parity              => parity,
      mac_source_in          => mac_source,

      pkt_rx_avail_in        => data_ctrl_out(7),--FROM INTERFACE
      pkt_rx_eop_in          => data_ctrl_out(0),
      pkt_rx_sop_in          => data_ctrl_out(5),
      pkt_rx_val_in          => data_ctrl_out(6),
      pkt_rx_err_in          => pkt_rx_err_in,
      pkt_rx_data_in         => data_rebuild,
      pkt_rx_mod_in          => data_ctrl_out(4 downto 1),
      mac_filter_in          => mac_filter,

      pkt_tx_eop_out       => lb_pkt_tx_eop,
      pkt_tx_sop_out       => lb_pkt_tx_sop,
      pkt_tx_val_out       => lb_pkt_tx_val,
      pkt_tx_data_out      => lb_pkt_tx_data,
      pkt_tx_mod_out       => lb_pkt_tx_mod,

      mac_destination_out  => lb_mac_destination,
      mac_source_out       => lb_mac_source,
      ip_destination_out   => lb_ip_destination,
      ip_source_out        => lb_ip_source

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
