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

  -- component generic_fifo is
  --
  --   generic(
  --     DWIDTH                : integer := 66;
  --     AWIDTH                : integer := 6;
  --     -- RAM_DEPTH          : integer := 20;
  --     REGISTER_READ         : integer := 1;
  --     EARLY_READ            : integer := 1;
  --     CLOCK_CROSSING        : integer := 0;
  --     ALMOST_EMPTY_THRESH   : integer := 1;
  --     ALMOST_FULL_THRESH    : integer := 7;
  --     MEM_TYPE              : integer := 1
  --   );
  --
  --   port(
  --     --  RW FIFO
  --     wclk            : in std_logic;
  --     wrst_n          : in std_logic;
  --     wen             : in std_logic;
  --     wdata           : in std_logic_vector(65 downto 0);
  --
  --     wfull           : out std_logic;
  --     walmost_full    : out std_logic;
  --
  --     --  RD FIFO
  --     rclk            : in std_logic;
  --     rrst_n          : in std_logic;
  --     ren             : in std_logic;
  --
  --     rdata           : out std_logic_vector (65 downto 0);
  --     rempty          : out std_logic;
  --     ralmost_empty   : out std_logic
  --   );
  --
  -- end component;
  signal w_ptr     : std_logic_vector(8 downto 0);
  signal r_ptr     : std_logic_vector(8 downto 0);
  signal read_err  : std_logic;
  signal write_err : std_logic;
  signal rr        : std_logic;                   -- Round Robbin between fifos when reading

  -- signal last_op : std_logic; -- 1 - last operation = write / 0 - last operation = read
  signal last_w  : std_logic; -- A write happened last cycle
  signal last_r  : std_logic; -- A read happened last cycle

begin

  -- reorder_generic_fifo: generic_fifo port map(
  --                                         wclk          =>  clk,
  --                                         wrst_n        =>  rst_n,
  --                                         wen           =>  wen,
  --                                         wdata         =>  data_in,
  --
  --                                         wfull         =>  full,
  --                                         walmost_full  =>  almost_f,
  --
  --                                         rclk          =>  clk,
  --                                         rrst_n        =>  rst_n,
  --                                         ren           =>  ren,
  --
  --                                         rdata         =>  data_out,
  --                                         rempty        =>  empty,
  --                                         ralmost_empty =>  almost_e
  --                                         );

  -- BRAM_inst : BRAM_SDP_MACRO
  --   generic map (
  --     BRAM_SIZE => "36Kb",            -- Target BRAM, "18Kb" or "36Kb"
  --     DEVICE => "7SERIES",            -- Target device: "VIRTEX5", "VIRTEX6", "7SERIES", "SPARTAN6"
  --     WRITE_WIDTH => 66,              -- Valid values are 1-72 (37-72 only valid when BRAM_SIZE="36Kb")
  --     READ_WIDTH => 66,               -- Valid values are 1-72 (37-72 only valid when BRAM_SIZE="36Kb")
  --     DO_REG => 0,                    -- Optional output register (0 or 1)
  --     INIT_FILE => "NONE",
  --     SIM_COLLISION_CHECK => "ALL",   -- Collision check enable "ALL", "WARNING_ONLY",
  --     SRVAL => X"000000000000000000", -- Set/Reset value for port output
  --     WRITE_MODE => "READ_FIRST")    -- Specify "WRITE_FIRST for asynchrononous clocks on ports
  --   port map(
  --     DO => data_out,            -- Output read data port, width defined by READ_WIDTH parameter
  --     DI => data_in,             -- Input write data port, width defined by WRITE_WIDTH parameter
  --     RDADDR => r_ptr,                -- Input read address, width defined by read port depth
  --     RDCLK => clk,                   -- 1-bit input read clock
  --     RDEN => ren,                    -- 1-bit input read port enable
  --     REGCE => '0',                   -- 1-bit input read output register enable
  --     RST => rst_n,                     -- 1-bit input reset
  --     WE => ARRAY_8_ONES,             -- Input write enable, width defined by write port depth
  --     WRADDR => w_ptr,                -- Input write address, width defined by write port depth
  --     WRCLK => clk,                   -- 1-bit input write clock
  --     WREN => wen                     -- 1-bit input write port enable
  --     );

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
      CLK => clk,               -- 1-bit input clock
      DI => data_in,            -- Input data, width defined by DATA_WIDTH parameter
      RDEN => ren,              -- 1-bit input read enable
      RST => rst_n,             -- 1-bit input reset
      WREN => wen               -- 1-bit input write enable
    );

      -- sync_w: process(clk, rst_n)
      -- begin
      --   if rst_n = '0' then
      --     w_ptr <= (others=>'0');
      --   elsif clk'event and clk = '1' then
      --       if wen = '1' then              -- Does not check if full, will overwrite
      --         w_ptr <= w_ptr + 1;
      --         last_w <= '1';
      --       else
      --         last_w <= '0';
      --       end if;
      --   end if;
      -- end process;
      --
      -- sync_r: process(clk, rst_n)
      -- begin
      --   if rst_n = '0' then
      --     r_ptr  <= (others=>'0');
      --   elsif clk'event and clk = '1' then
      --     if ren = '1' then              -- Does not check if empty, will underwrite
      --         r_ptr <= r_ptr + 1;
      --     end if;
      --   end if;
      -- end process;
      --
      -- comb: process(w_ptr, r_ptr, last_w)
      -- begin
      --   if w_ptr = r_ptr then -- For at least one cycle they will be equal
      --     if last_w = '1' then
      --       full <= '1';
      --       empty <= '0';
      --     else
      --       full <= '0';
      --       empty <= '1';
      --     end if;
      --   else
      --     full <= '0';
      --     empty <= '0';
      --   end if;
      -- end process;

end behav_fifo_reorder;
