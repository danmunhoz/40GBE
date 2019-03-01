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
library UNISIM;
  use UNISIM.vcomponents.all;
library UNIMACRO;
  use unimacro.Vcomponents.all;
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

    wen        : in  std_logic;
    ren        : in  std_logic;

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

    mac_filter      : in  std_logic_vector(2 downto 0);
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
 signal parity       : std_logic;
 signal data_fifo_out : std_logic_vector(127 downto 0);

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



  signal pkt_fifo_out    :   std_logic_vector(127 downto 0);
  signal teste           :   std_logic_vector(1 downto 0);

  type   state_type is (idle, writing);
  signal current_s : state_type;
  signal fifo_rst : std_logic;
  signal fifo_r_en : std_logic;
  signal fifo_w_en : std_logic;
  signal fifo_afull_l  : std_logic;
  signal fifo_full_l  : std_logic;
  signal fifo_empty_l  : std_logic;
  signal fifo_aempty_l  : std_logic;
  signal fifo_afull_h  : std_logic;
  signal fifo_full_h  : std_logic;
  signal fifo_empty_h  : std_logic;
  signal fifo_aempty_h  : std_logic;

  signal fifo_r_error_l  : std_logic;
  signal fifo_r_error_h  : std_logic;
  signal fifo_w_error_l  : std_logic;
  signal fifo_w_error_h  : std_logic;


  signal fifo_wrcount_l : std_logic_vector(8 downto 0);
  signal fifo_rdcount_l : std_logic_vector(8 downto 0);
  signal fifo_wrcount_h : std_logic_vector(8 downto 0);
  signal fifo_rdcount_h : std_logic_vector(8 downto 0);

  signal fifo_datain_l  : std_logic_vector(63 downto 0);
  signal fifo_dataout_l  : std_logic_vector(63 downto 0);
  signal fifo_datain_h  : std_logic_vector(63 downto 0);
  signal fifo_dataout_h  : std_logic_vector(63 downto 0);

  signal fifo_datain_reg : std_logic_vector(127 downto 0);
  signal data_concat_l : std_logic_vector(127 downto 0);
  signal data_concat_h : std_logic_vector(127 downto 0);

  signal rebuilding_pkt     :  std_logic_vector(255 downto 0); -- Data bus

  signal fifo_counter : integer range 0 to 6000;


  type teste_type is array (0 to 1) of std_logic_vector (127 downto 0);
  signal teste_reg : teste_type;
  signal teste_reg_out0 : std_logic_vector (255 downto 0);
  signal teste_reg_out1 : std_logic_vector (255 downto 0);
  signal teste_reg_out2 : std_logic_vector (255 downto 0);
  signal teste_reg_out3 : std_logic_vector (255 downto 0);
  signal teste_turn_156 : std_logic;
  signal teste_turn_312 : std_logic;

  type teste_fsm_type is (S_IDLE, S_REBUILD_SOP, S_REBUILD_EOP);
  signal current_s_312: teste_fsm_type;
  signal current_s_156: teste_fsm_type;

begin

  ---------------------------------------------------------
  -- Test
  --------------------------------------------------------

  teste312 : process(clk_312, rst_n)
  begin
    if rst_n = '0' Then
      current_s_312 <= S_IDLE;
      teste_reg(0) <= (others => '0');
      teste_reg(1) <= (others => '0');
      teste_reg_out0 <= (others => '0');
      teste_reg_out1 <= (others => '0');
      teste_turn_312 <= '0';
    elsif (clk_312'event and clk_312 = '1') then
      if (pkt_rx_avail_in = '1') then
        case current_s_312 is
          when S_IDLE =>
            teste_turn_312 <= '0';
            if( pkt_rx_sop_in = '1') then
              current_s_312 <= S_REBUILD_SOP;
            end if;
          when S_REBUILD_EOP =>
            current_s_312 <= S_IDLE;
            if(pkt_rx_eop_in = '1') then
                current_s_312 <= S_IDLE;
            end if;
            if(teste_turn_312 = '1') Then
              teste_reg(0) <= pkt_rx_data_in;
              teste_turn_312 <= '0';
              teste_reg_out1 <= teste_reg_out0;
            else
              teste_reg(1) <= pkt_rx_data_in;
              teste_reg_out0 <= teste_reg(0) & pkt_rx_data_in ;
              teste_turn_312 <= '1';
            end if;
        end case;
      end if;
    end if;
  end process teste312;



  teste156 : process(clk_156, rst_n)
  begin
    if rst_n = '0' Then
      current_s_156 <= S_IDLE;
      teste_turn_156 <= '0';
      teste_reg_out2 <= (others => '0');
      teste_reg_out3 <= (others => '0');
    elsif (clk_156'event and clk_156 = '1') then
      if (pkt_rx_avail_in = '1') then
        case current_s_156 is
          when S_IDLE =>
            teste_turn_156 <= '0';
            if(pkt_rx_sop_in = '1') then
              current_s_156 <= S_REBUILD;
            end if;
          when S_REBUILD =>
            if(pkt_rx_eop_in = '1') then
                current_s_156 <= S_IDLE;
            end if;
            if(teste_turn_156 = '0') then
              teste_reg_out2 <= teste_reg_out1;
              teste_turn_156 <= '1';
            else
              teste_reg_out3 <= teste_reg_out1;
              teste_turn_156 <= '0';
            end if;
          end case;
        end if;
    end if;
  end process teste156;

  ---------------------------------------------------------
  -- DUAL CLOCK FIFO
  --------------------------------------------------------

      fifo_rst <= not rst_n;
      data_rebuild <= data_concat_h & data_concat_l;

      Read_from_Fifo : process (clk_156,rst_n)
      begin
        if rst_n = '0' then
          teste <= "00";
          turn <= '0';
          fifo_r_en <= '0';
          data_concat_l     <= (others=>'0');
          data_concat_h      <= (others=>'0');
        elsif (clk_156'event and clk_156 = '1') then
          if (teste = "00") Then
              fifo_r_en <= '0';
              if (fifo_full_l = '1' or fifo_full_h = '1') Then
                teste <= "01";
              end if;
          end if;
          if (teste = "01") Then
              fifo_r_en <= '1';
              if (fifo_aempty_l = '1' or fifo_aempty_h = '1') Then
                teste <= "00";
              end if;
          end if;
        end if;
      end process Read_from_Fifo;

    Write_in_Fifo : process (rst_n, clk_312)
    begin
      if (rst_n = '0') then
        fifo_w_en <= '0';
        fifo_datain_reg  <= (others=>'0');
        fifo_datain_l      <= (others=>'0');
        fifo_datain_h      <= (others=>'0');
      elsif (clk_312'event and clk_312 = '1') then
        if (pkt_rx_avail_in = '1') then
          fifo_datain_reg <= pkt_rx_data_in;
          fifo_datain_l <= fifo_datain_reg(63 downto 0);
          fifo_datain_h <= fifo_datain_reg(127 downto 64);
          fifo_w_en <= '1';
        else
          fifo_w_en <= '0';
        end if;
      end if;
    end process Write_in_Fifo;

    FIFO_high : FIFO_DUALCLOCK_MACRO
    generic map (
      DEVICE => "7SERIES",              -- Target Device: "VIRTEX5", "VIRTEX6", "7SERIES"
      ALMOST_FULL_OFFSET => X"0016",    -- Sets almost full threshold
      ALMOST_EMPTY_OFFSET => X"0016",   -- Sets the almost empty threshold
      DATA_WIDTH => 64,                 -- Valid values are 1-72 (37-72 only valid when FIFO_SIZE="36Kb")
      FIFO_SIZE => "36Kb",              -- Target BRAM, "18Kb" or "36Kb"
      FIRST_WORD_FALL_THROUGH => FALSE) -- Sets the FIFO FWFT to TRUE or FALSE
    port map (
      ALMOSTEMPTY => fifo_aempty_h,       -- 1-bit output almost empty
      ALMOSTFULL => fifo_afull_h,         -- 1-bit output almost full
      DO => fifo_dataout_h,              -- Output data, width defined by DATA_WIDTH parameter
      EMPTY => fifo_empty_h,               -- 1-bit output empty
      FULL =>  fifo_full_h,                -- 1-bit output full
      RDCOUNT => fifo_rdcount_h,           -- Output read count, width determined by FIFO depth
      RDERR => fifo_r_error_h,                    -- 1-bit output read error
      WRCOUNT => fifo_wrcount_h,           -- Output write count, width determined by FIFO depth
      WRERR => fifo_w_error_h,                    -- 1-bit output write error
      DI =>  fifo_datain_h,  -- Input data, width defined by DATA_WIDTH parameter
      RDCLK => clk_312,                   -- 1-bit input read clock
      RDEN => fifo_r_en,                -- 1-bit input read enable
      RST => fifo_rst,                       -- 1-bit input reset
      WRCLK => clk_156,                   -- 1-bit input write clock
      WREN => fifo_w_en                -- 1-bit input write enable
    );

    FIFO_low : FIFO_DUALCLOCK_MACRO
    generic map (
      DEVICE => "7SERIES",              -- Target Device: "VIRTEX5", "VIRTEX6", "7SERIES"
      ALMOST_FULL_OFFSET => X"0016",    -- Sets almost full threshold
      ALMOST_EMPTY_OFFSET => X"0016",   -- Sets the almost empty threshold
      DATA_WIDTH => 64,                 -- Valid values are 1-72 (37-72 only valid when FIFO_SIZE="36Kb")
      FIFO_SIZE => "36Kb",              -- Target BRAM, "18Kb" or "36Kb"
      FIRST_WORD_FALL_THROUGH => FALSE) -- Sets the FIFO FWFT to TRUE or FALSE
    port map (
      ALMOSTEMPTY => fifo_aempty_l,       -- 1-bit output almost empty
      ALMOSTFULL => fifo_afull_l,         -- 1-bit output almost full
      DO => fifo_dataout_l,              -- Output data, width defined by DATA_WIDTH parameter
      EMPTY => fifo_empty_l,               -- 1-bit output empty
      FULL =>  fifo_full_l,                -- 1-bit output full
      RDCOUNT => fifo_rdcount_l,           -- Output read count, width determined by FIFO depth
      RDERR => fifo_r_error_l,                    -- 1-bit output read error
      WRCOUNT => fifo_wrcount_l,           -- Output write count, width determined by FIFO depth
      WRERR => fifo_w_error_l,                    -- 1-bit output write error
      DI =>  fifo_datain_l,  -- Input data, width defined by DATA_WIDTH parameter
      RDCLK => clk_312,                   -- 1-bit input read clock
      RDEN => fifo_r_en,                -- 1-bit input read enable
      RST => fifo_rst,                       -- 1-bit input reset
      WRCLK => clk_156,                   -- 1-bit input write clock
      WREN => fifo_w_en                -- 1-bit input write enable
    );

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

  loopback_inst : entity work.loopback_v2 port map (
      -- STANDARD INPUTS
      clk_156             => clk_156,
      reset               => rst_n,
      parity              => parity,
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
