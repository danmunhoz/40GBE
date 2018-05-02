library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_unsigned.all;
  use ieee.numeric_std.all;

library UNISIM;
  use UNISIM.vcomponents.all;

library UNIMACRO;
  use unimacro.Vcomponents.all;

entity data_frame_fifo is
  port (
    --INPUTS
    clk       : in std_logic;
    rst_n       : in std_logic;
    data_in   : in std_logic_vector(255 downto 0);
    eop_in    : in std_logic_vector(  5 downto 0);
    sop_in    : in std_logic;
    val_in    : in std_logic;
    ren       : in std_logic;
    wen       : in std_logic;
    --OUTPUTS
    data_out   : out std_logic_vector(255 downto 0);
    eop_out    : out std_logic_vector(  5 downto 0);
    sop_out    : out std_logic;
    val_out    : out std_logic;
    full       : out std_logic;
    empty      : out std_logic
  );
end entity;

architecture behav_data_frame_fifo of data_frame_fifo is
    signal rst            : std_logic;
    signal clk_n          : std_logic;
    signal ren_int        : std_logic;
    signal wen_int        : std_logic;

    signal l0_data_in     : std_logic_vector(63 downto 0);
    signal l1_data_in     : std_logic_vector(63 downto 0);
    signal h0_data_in     : std_logic_vector(63 downto 0);
    signal h1_data_in     : std_logic_vector(71 downto 0);

    signal l0_data_out     : std_logic_vector(63 downto 0);
    signal l1_data_out     : std_logic_vector(63 downto 0);
    signal h0_data_out     : std_logic_vector(63 downto 0);
    signal h1_data_out     : std_logic_vector(71 downto 0);

    signal l0_empty   : std_logic;
    signal l1_empty   : std_logic;
    signal h0_empty   : std_logic;
    signal h1_empty   : std_logic;

    signal l0_full   : std_logic;
    signal l1_full   : std_logic;
    signal h0_full   : std_logic;
    signal h1_full   : std_logic;

    signal l0_almost_empty  : std_logic;
    signal l1_almost_empty  : std_logic;
    signal h0_almost_empty  : std_logic;
    signal h1_almost_empty  : std_logic;

    signal l0_almost_full   : std_logic;
    signal l1_almost_full   : std_logic;
    signal h0_almost_full   : std_logic;
    signal h1_almost_full   : std_logic;

    signal l0_rdcnt : std_logic_vector(8 downto 0);
    signal l1_rdcnt : std_logic_vector(8 downto 0);
    signal h0_rdcnt : std_logic_vector(8 downto 0);
    signal h1_rdcnt : std_logic_vector(8 downto 0);

    signal l0_wrcnt : std_logic_vector(8 downto 0);
    signal l1_wrcnt : std_logic_vector(8 downto 0);
    signal h0_wrcnt : std_logic_vector(8 downto 0);
    signal h1_wrcnt : std_logic_vector(8 downto 0);

    signal rst_safe : std_logic_vector(2 downto 0);
    signal enable_fifo : std_logic;

  begin
    -- signals in
    l0_data_in  <=  data_in( 63 downto 0);
    l1_data_in  <=  data_in(127 downto 64);
    h0_data_in  <=  data_in(191 downto 128);
    h1_data_in  <=  val_in & sop_in & eop_in & data_in(255 downto 192);

    -- ren_int <= ren when enable_fifo = '1' else '0';
    ren_int <= '0', '1' after 200 ns;
    wen_int <= wen when enable_fifo = '1' else '0';

    reset_drc : process(clk, rst_n)
    begin
      if (rst_n = '0') then
        rst_safe <= (others =>'0');
        enable_fifo <= '0';
      elsif clk = '1' and clk'event then
        if (rst_safe < "101" and enable_fifo = '0') then
          rst_safe <= rst_safe + 1;
          enable_fifo <= '0';
        else
          rst_safe <= (others=>'0');
          enable_fifo <= '1';
        end if;
      end if;
    end process;


    rst <= not rst_n;
    clk_n <= not clk;

    FIFO_L0 : FIFO_SYNC_MACRO
    generic map (
      DEVICE => "7SERIES",
      ALMOST_FULL_OFFSET => X"0080",
      ALMOST_EMPTY_OFFSET => X"0080",
      DATA_WIDTH => 64,
      FIFO_SIZE => "36Kb")
    port map (
      ALMOSTEMPTY => l0_almost_empty,
      ALMOSTFULL => l0_almost_full,
      DO => l0_data_out,
      EMPTY => l0_empty,
      FULL => l0_full,
      RDCOUNT => l0_rdcnt,
      RDERR => open,
      WRCOUNT => l0_wrcnt,
      WRERR => open,
      CLK => clk_n,
      DI => l0_data_in,
      RDEN => ren_int,
      RST => rst,
      WREN => wen_int
    );

    FIFO_L1 : FIFO_SYNC_MACRO
    generic map (
      DEVICE => "7SERIES",
      ALMOST_FULL_OFFSET => X"0080",
      ALMOST_EMPTY_OFFSET => X"0080",
      DATA_WIDTH => 64,
      FIFO_SIZE => "36Kb")
    port map (
      ALMOSTEMPTY => l1_almost_empty,
      ALMOSTFULL => l1_almost_full,
      DO => l1_data_out,
      EMPTY => l1_empty,
      FULL => l1_full,
      RDCOUNT => l1_rdcnt,
      RDERR => open,
      WRCOUNT => l1_wrcnt,
      WRERR => open,
      CLK => clk_n,
      DI => l1_data_in,
      RDEN => ren_int,
      RST => rst,
      WREN => wen_int
    );

    FIFO_H0 : FIFO_SYNC_MACRO
    generic map (
      DEVICE => "7SERIES",
      ALMOST_FULL_OFFSET => X"0080",
      ALMOST_EMPTY_OFFSET => X"0080",
      DATA_WIDTH => 64,
      FIFO_SIZE => "36Kb")
    port map (
      ALMOSTEMPTY => h0_almost_empty,
      ALMOSTFULL => h0_almost_full,
      DO => h0_data_out,
      EMPTY => h0_empty,
      FULL => h0_full,
      RDCOUNT => h0_rdcnt,
      RDERR => open,
      WRCOUNT => h0_wrcnt,
      WRERR => open,
      CLK => clk_n,
      DI => h0_data_in,
      RDEN => ren_int,
      RST => rst,
      WREN => wen_int
    );

    FIFO_H1 : FIFO_SYNC_MACRO
    generic map (
      DEVICE => "7SERIES",
      ALMOST_FULL_OFFSET => X"0080",
      ALMOST_EMPTY_OFFSET => X"0080",
      DATA_WIDTH => 72,
      FIFO_SIZE => "36Kb")
    port map (
      ALMOSTEMPTY => h1_almost_empty,
      ALMOSTFULL => h1_almost_full,
      DO => h1_data_out,
      EMPTY => h1_empty,
      FULL => h1_full,
      RDCOUNT => h1_rdcnt,
      RDERR => open,
      WRCOUNT => h1_wrcnt,
      WRERR => open,
      CLK => clk_n,
      DI => h1_data_in,
      RDEN => ren_int,
      RST => rst,
      WREN => wen_int
    );

    -- signals out
    data_out  <=  h1_data_out(63 downto 0) & h0_data_out &
                  l1_data_out & l0_data_out;
    eop_out   <=  h1_data_out(69 downto 64);
    sop_out   <=  h1_data_out(70);
    val_out   <=  h1_data_out(71);

    full      <=  h1_full or h0_full or l1_full or l0_full;
    empty     <=  h1_empty or h0_empty or l1_empty or l0_empty;

end behav_data_frame_fifo;
