library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_unsigned.all;
  use ieee.numeric_std.all;

library UNISIM;
  use UNISIM.vcomponents.all;
library UNIMACRO;
  use unimacro.Vcomponents.all;

entity reorder_fifo is
  port(
  -- INPUTS
      clk                   : in std_logic;
      rst_n                 : in std_logic;
      ren                   : in std_logic;
      wen                   : in std_logic;
      data_in               : in std_logic_vector(65 downto 0);

  -- OUTPUTS
      almost_f              : out std_logic;
      full                  : out std_logic;
      almost_e              : out std_logic;
      empty                 : out std_logic;
      data_out              : out std_logic_vector(65 downto 0)
      );
end entity;

architecture behav_fifo_reorder of reorder_fifo is
  constant ARRAY_8_ONES : std_logic_vector(7 downto 0) := (others => '1');

  signal w_ptr     : std_logic_vector(8 downto 0);
  signal r_ptr     : std_logic_vector(8 downto 0);
  signal read_err  : std_logic;
  signal write_err : std_logic;
  signal rr        : std_logic;                   -- Round Robbin between fifos when reading

  -- signal last_op : std_logic; -- 1 - last operation = write / 0 - last operation = read
  signal last_w  : std_logic; -- A write happened last cycle
  signal last_r  : std_logic; -- A read happened last cycle

  signal clk_n : std_logic; -- solves the fifo output delay problem...

begin

  clk_n <= not clk;

  FIFO_SYNC_MACRO_inst : FIFO_SYNC_MACRO
    generic map (
      DEVICE => "7SERIES",            -- Target Device: "VIRTEX5, "VIRTEX6", "7SERIES"
      ALMOST_FULL_OFFSET => X"0080",  -- Sets almost full threshold
      ALMOST_EMPTY_OFFSET => X"0080", -- Sets the almost empty threshold
      DATA_WIDTH => 66,               -- Valid values are 1-72 (37-72 only valid when FIFO_SIZE="36Kb")
      FIFO_SIZE => "36Kb")            -- Target BRAM, "18Kb" or "36Kb"
    port map (
      ALMOSTEMPTY => almost_e,  -- 1-bit output almost empty
      ALMOSTFULL => almost_f,   -- 1-bit output almost full
      DO => data_out,           -- Output data, width defined by DATA_WIDTH parameter
      EMPTY => empty,           -- 1-bit output empty
      FULL => full,             -- 1-bit output full
      RDCOUNT => r_ptr,         -- Output read count, width determined by FIFO depth
      RDERR => read_err,        -- 1-bit output read error
      WRCOUNT => w_ptr,         -- Output write count, width determined by FIFO depth
      WRERR => write_err,       -- 1-bit output write error
      CLK => clk_n,             -- 1-bit input clock
      DI => data_in,            -- Input data, width defined by DATA_WIDTH parameter
      RDEN => ren,              -- 1-bit input read enable
      RST => rst_n,             -- 1-bit input reset
      WREN => wen               -- 1-bit input write enable
    );

end behav_fifo_reorder;
