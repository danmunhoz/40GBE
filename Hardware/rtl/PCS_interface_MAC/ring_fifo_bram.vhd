library UNISIM;
  use UNISIM.vcomponents.all;

library UNIMACRO;
  use unimacro.Vcomponents.all;

library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_unsigned.all;
  use ieee.numeric_std.all;

entity ring_fifo_bram is
	generic (
		WIDTH    : integer := 256; -- 256 (Data)
    N        : integer := 9;
    DEPTH    : integer := 32 -- where DEPTH = 2^N
	);
	port (
		clk_w      : in  std_logic;
    clk_r      : in  std_logic;
		rst_n	     : in  std_logic;
    data_in	   : in  std_logic_vector (WIDTH-1 downto 0);
    data_out   : out std_logic_vector (WIDTH/2-1 downto 0);
    is_sop_in  : in  std_logic;
    eop_addr_in: in  std_logic_vector(5 downto 0);
    is_sop_out : out  std_logic;
    eop_addr_out: out  std_logic_vector(4 downto 0);
    wen        : in  std_logic;
		ren	       : in  std_logic;
		empty	     : out std_logic;
		full	     : out std_logic
	);
end ring_fifo_bram;

--------------------------------------------------------------------
-- SOP and EOP flags:
-- SOP: 1 - sop present / 0 - not present
-- EOP: BV & ADDRESS
--  -> BV = 1 - eop present / 0 - not present
--  -> ADDRESS = eop address from byte 0 to 31 (256-bit data bus)
--------------------------------------------------------------------
-- 1 (SOP present) + 6 (Points to the EOP) - Separeted from data bus for now..

architecture behav of ring_fifo_bram is
  constant ARRAY_8_ONES : std_logic_vector(7 downto 0) := (others => '1');

  signal rst : std_logic;

  signal mem_low_in_0 : std_logic_vector(63 downto 0);
  signal mem_low_in_1 : std_logic_vector(71 downto 0);

  signal mem_low_out_0 : std_logic_vector(63 downto 0);
  signal mem_low_out_1 : std_logic_vector(71 downto 0);

  signal mem_high_in_0 : std_logic_vector(63 downto 0);
  signal mem_high_in_1 : std_logic_vector(71 downto 0);

  signal mem_high_out_0 : std_logic_vector(63 downto 0);
  signal mem_high_out_1 : std_logic_vector(71 downto 0);

  signal w_ptr   : std_logic_vector(N-1 downto 0);
  signal r_ptr_l : std_logic_vector(N-1 downto 0);
  signal r_ptr_h : std_logic_vector(N-1 downto 0);
  signal rr      : std_logic;         -- Round Robbin between fifos when reading

  signal ren_int_l : std_logic;            -- Controls the reading from low fifo
  signal ren_int_h : std_logic;           -- Controls the reading from high fifo

  -- signal last_op : std_logic; -- 1 - last operation = write / 0 - last operation = read
  signal last_w  : std_logic; -- A write happened last cycle
  signal last_r  : std_logic; -- A read happened last cycle

  signal wen_reg,wen_bram : std_logic;
  signal mem_low_in_0_reg  : std_logic_vector(63 downto 0);
  signal mem_low_in_1_reg  : std_logic_vector(71 downto 0);
  signal mem_high_in_0_reg : std_logic_vector(63 downto 0);
  signal mem_high_in_1_reg : std_logic_vector(71 downto 0);

  attribute dont_touch : string;
  attribute dont_touch of BRAM_inst_l_0,BRAM_inst_l_1,BRAM_inst_h_0,BRAM_inst_h_1,regs : label is "true";
begin
  rst <= not rst_n;

  regs : process (clk_w,rst_n)
  begin
    if rst_n = '0' then
      wen_reg <= '0';
      mem_low_in_0_reg      <= (others=>'0');
      mem_low_in_1_reg      <= (others=>'0');
      mem_high_in_0_reg     <= (others=>'0');
      mem_high_in_1_reg     <= (others=>'0');
    elsif clk_w'event and clk_w = '1' then
      wen_reg <= wen;
      mem_low_in_0_reg      <= mem_low_in_0;
      mem_high_in_0_reg     <= mem_high_in_0;
      mem_low_in_1_reg      <= mem_low_in_1;
      mem_high_in_1_reg     <= mem_high_in_1;
    end if;
  end process;

  wen_bram <= wen or wen_reg;

  -- Keeping EOP/SOP stuff with the *_1 BRAMs
  -- bram <= data_in & EOP_FLAG & EOP_ADDR & SOP_FLAG
  -- There will be no packet starting at the lower half... So there is no need
  -- to SOP flag there.

  mem_low_in_0 <= data_in(63 downto 0);

  --              Valid low EOP
  mem_low_in_1 <= "000" & data_in(127 downto 64) & '1' & eop_addr_in(3 downto 0) when eop_addr_in(5 downto 4) = "00" else
  --              No EOP
                  "000" & data_in(127 downto 64) & "00000";

  mem_high_in_0 <= data_in(191 downto 128);

  --               Valid high EOP and SOP/no SOP
  mem_high_in_1 <= "00" & data_in(255 downto 192) & '1' & eop_addr_in(3 downto 0) & is_sop_in when eop_addr_in(5 downto 4) = "01" else
  --               Valid high EOP and no SOP/no SOP
                   "00" & data_in(255 downto 192) & "00000" & is_sop_in;


  -- eop_addr_out <= mem_low_out_1(4 downto 0) when rr = '0' else
  --                 mem_high_out_1(5 downto 1);

  -- is_sop_out <= mem_high_out_1(0) when rr = '0' else '0';

  BRAM_inst_l_0 : BRAM_SDP_MACRO
    generic map (
      BRAM_SIZE => "36Kb",            -- Target BRAM, "18Kb" or "36Kb"
      DEVICE => "7SERIES",            -- Target device: "VIRTEX5", "VIRTEX6", "7SERIES", "SPARTAN6"
      WRITE_WIDTH => 64,              -- Valid values are 1-72 (37-72 only valid when BRAM_SIZE="36Kb")
      READ_WIDTH => 64,               -- Valid values are 1-72 (37-72 only valid when BRAM_SIZE="36Kb")
      DO_REG => 0,                    -- Optional output register (0 or 1)
      INIT_FILE => "NONE",
      SIM_COLLISION_CHECK => "ALL",   -- Collision check enable "ALL", "WARNING_ONLY",
      SRVAL => X"000000000000000000", -- Set/Reset value for port output
      WRITE_MODE => "WRITE_FIRST")    -- Specify "WRITE_FIRST for asynchrononous clocks on ports
    port map(
      DO => mem_low_out_0,            -- Output read data port, width defined by READ_WIDTH parameter
      DI => mem_low_in_0_reg,         -- Input write data port, width defined by WRITE_WIDTH parameter
      RDADDR => r_ptr_l,              -- Input read address, width defined by read port depth
      RDCLK => clk_r,                 -- 1-bit input read clock
      RDEN => ren_int_l,              -- 1-bit input read port enable
      REGCE => '0',                   -- 1-bit input read output register enable
      RST => rst,                     -- 1-bit input reset
      WE => ARRAY_8_ONES,             -- Input write enable, width defined by write port depth
      WRADDR => w_ptr,                -- Input write address, width defined by write port depth
      WRCLK => clk_w,                 -- 1-bit input write clock
      WREN => wen_bram                     -- 1-bit input write port enable
      );

  BRAM_inst_l_1 : BRAM_SDP_MACRO
    generic map (
      BRAM_SIZE => "36Kb",
      DEVICE => "7SERIES",
      WRITE_WIDTH => 72,                -- 64 (data) + 5 (eop location) + 1(sop)
      READ_WIDTH => 72,
      DO_REG => 0,
      INIT_FILE => "NONE",
      SIM_COLLISION_CHECK => "ALL",
      SRVAL => X"000000000000000000",
      WRITE_MODE => "WRITE_FIRST")
    port map(
      DO => mem_low_out_1,
      DI => mem_low_in_1_reg,
      RDADDR => r_ptr_l,
      RDCLK => clk_r,
      RDEN => ren_int_l,
      REGCE => '0',
      RST => rst,
      WE => ARRAY_8_ONES,
      WRADDR => w_ptr,
      WRCLK => clk_w,
      WREN => wen_bram
    );

  BRAM_inst_h_0 : BRAM_SDP_MACRO
    generic map (
      BRAM_SIZE => "36Kb",
      DEVICE => "7SERIES",
      WRITE_WIDTH => 64,
      READ_WIDTH => 64,
      DO_REG => 0,
      INIT_FILE => "NONE",
      SIM_COLLISION_CHECK => "ALL",
      SRVAL => X"000000000000000000",
      WRITE_MODE => "WRITE_FIRST")
    port map(
      DO => mem_high_out_0,
      DI => mem_high_in_0_reg,
      RDADDR => r_ptr_h,
      RDCLK => clk_r,
      RDEN => ren_int_h,
      REGCE => '0',
      RST => rst,
      WE => ARRAY_8_ONES,
      WRADDR => w_ptr,
      WRCLK => clk_w,
      WREN => wen_bram
    );

  BRAM_inst_h_1 : BRAM_SDP_MACRO
    generic map (
      BRAM_SIZE => "36Kb",
      DEVICE => "7SERIES",
      WRITE_WIDTH => 72,
      READ_WIDTH => 72,
      DO_REG => 0,
      INIT_FILE => "NONE",
      SIM_COLLISION_CHECK => "ALL",
      SRVAL => X"000000000000000000",
      WRITE_MODE => "WRITE_FIRST")
    port map(
      DO => mem_high_out_1,
      DI => mem_high_in_1_reg,
      RDADDR => r_ptr_h,
      RDCLK => clk_r,
      RDEN => ren_int_h,
      REGCE => '0',
      RST => rst,
      WE => ARRAY_8_ONES,
      WRADDR => w_ptr,
      WRCLK => clk_w,
      WREN => wen_bram
    );



  sync_w: process(clk_w, rst_n)
  begin
    if rst_n = '0' then
      w_ptr <= (others=>'0');
    elsif clk_w'event and clk_w = '1' then
        if wen = '1' then              -- Does not check if full, will overwrite
          w_ptr <= w_ptr + 1;
          last_w <= '1';
        else
          last_w <= '0';
        end if;
    end if;
  end process;

  sync_r: process(clk_r, rst_n)
  begin
    if rst_n = '0' then
      ren_int_l <= '0';
      ren_int_h <= '0';
      r_ptr_l  <= (others=>'0');
      r_ptr_h  <= (others=>'0');
      rr <= '0';
    elsif clk_r'event and clk_r = '1' then
      if ren = '1' then              -- Does not check if empty, will underwrite
        if rr = '0' then
          r_ptr_l <= r_ptr_l + 1;
          ren_int_l <= '1';
          ren_int_h <= '0';
          data_out <= mem_low_out_1(68 downto 5) & mem_low_out_0;
          eop_addr_out <= mem_low_out_1(4 downto 0);
          is_sop_out <= '0';
        else
          r_ptr_h <= r_ptr_h + 1;
          ren_int_h <= '1';
          ren_int_l <= '0';
          data_out <= mem_high_out_1(69 downto 6) & mem_high_out_0;
          eop_addr_out <= mem_high_out_1(5 downto 1);
          is_sop_out <= mem_high_out_1(0);
        end if;
        rr <= not rr;
      end if;
    end if;
  end process;

end behav;
