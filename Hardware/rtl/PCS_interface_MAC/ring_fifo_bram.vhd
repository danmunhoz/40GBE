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
    data_val   : out std_logic;
    is_sop_in  : in  std_logic;
    eop_addr_in: in  std_logic_vector(5 downto 0);
    is_sop_out : out  std_logic;
    eop_addr_out: out  std_logic_vector(4 downto 0);
    wen        : in  std_logic;
		ren	       : in  std_logic;
		empty	     : out std_logic;
		full	     : out std_logic;
    almost_f   : out std_logic;
    almost_e   : out std_logic
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
  signal data_val_w : std_logic;

  signal ren_int_l : std_logic;            -- Controls the reading from low fifo
  signal ren_int_h : std_logic;           -- Controls the reading from high fifo

  signal last_w  : std_logic; -- A write happened last cycle
  signal last_r  : std_logic; -- A read happened last cycle

  signal wen_reg,wen_bram : std_logic;
  signal mem_low_in_0_reg  : std_logic_vector(63 downto 0);
  signal mem_low_in_1_reg  : std_logic_vector(71 downto 0);
  signal mem_high_in_0_reg : std_logic_vector(63 downto 0);
  signal mem_high_in_1_reg : std_logic_vector(71 downto 0);

  signal rdcount_l_0 : std_logic_vector(8 downto 0);
  signal wrcount_l_0 : std_logic_vector(8 downto 0);
  signal rdcount_h_0 : std_logic_vector(8 downto 0);
  signal wrcount_h_0 : std_logic_vector(8 downto 0);
  signal rdcount_l_1 : std_logic_vector(8 downto 0);
  signal wrcount_l_1 : std_logic_vector(8 downto 0);
  signal rdcount_h_1 : std_logic_vector(8 downto 0);
  signal wrcount_h_1 : std_logic_vector(8 downto 0);

  signal empty_l_0 : std_logic;
  signal full_l_0  : std_logic;
  signal empty_h_0 : std_logic;
  signal full_h_0  : std_logic;
  signal empty_l_1 : std_logic;
  signal full_l_1  : std_logic;
  signal empty_h_1 : std_logic;
  signal full_h_1  : std_logic;

  signal a_empty_l_0 : std_logic;
  signal a_full_l_0  : std_logic;
  signal a_empty_h_0 : std_logic;
  signal a_full_h_0  : std_logic;
  signal a_empty_l_1 : std_logic;
  signal a_full_l_1  : std_logic;
  signal a_empty_h_1 : std_logic;
  signal a_full_h_1  : std_logic;

  -- debug
  signal high_in_o    :std_logic_vector (63 downto 0);
  signal high_in_1    :std_logic_vector (63 downto 0);
  signal low_in_o     :std_logic_vector (63 downto 0);
  signal low_in_1     :std_logic_vector (63 downto 0);

  signal r_high_in_o    :std_logic_vector (63 downto 0);
  signal r_high_in_1    :std_logic_vector (63 downto 0);
  signal r_low_in_o     :std_logic_vector (63 downto 0);
  signal r_low_in_1     :std_logic_vector (63 downto 0);

  signal DO_L_1         :std_logic_vector (63 downto 0);
  signal DO_H_1         :std_logic_vector (63 downto 0);

begin
  rst <= not rst_n;

  almost_e <= '1' when a_empty_h_0 = '1' or a_empty_h_1 = '1' else '0';

  almost_f <= '1' when a_full_h_0 = '1' or a_full_l_0 = '1' or
                       a_full_l_1 = '1' or a_full_h_1 = '1' else '0';

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
  data_val <= data_val_w;

  empty <= empty_l_0 or empty_h_0 or empty_l_1 or empty_h_1;
  full <= full_h_1 or full_l_1 or full_h_0 or full_l_0;


  -- Keeping EOP/SOP stuff with the *_1 BRAMs
  -- bram <= data_in & EOP_FLAG & EOP_ADDR & SOP_FLAG
  -- There will be no packet starting at the lower half... So there is no need
  -- to SOP flag there.

  mem_low_in_0 <= data_in(63 downto 0);

  --              Valid low EOP
  mem_low_in_1 <= "00" & data_in(127 downto 64) & '1' & eop_addr_in(3 downto 0) & is_sop_in when eop_addr_in(5 downto 4) = "00" else
  --              No EOP
                  -- "000" & data_in(127 downto 64) & "00000";
                  "00" & data_in(127 downto 64) & "00000" & is_sop_in;

  mem_high_in_0 <= data_in(191 downto 128);

  --               Valid high EOP and SOP/no SOP
  mem_high_in_1 <= "00" & data_in(255 downto 192) & '1' & eop_addr_in(3 downto 0) & '0' when eop_addr_in(5 downto 4) = "01" else
  --               Valid high EOP and no SOP/no SOP
                   "00" & data_in(255 downto 192) & "000000";

  high_in_o  <=  mem_high_in_0;
  high_in_1  <=  mem_high_in_1(69 downto 6);
  low_in_o   <=  mem_low_in_0;
  low_in_1   <=  mem_low_in_1(69 downto 6);

  r_high_in_o <=  mem_high_in_0_reg;
  r_high_in_1 <=  mem_high_in_1_reg(69 downto 6);
  r_low_in_o  <=  mem_low_in_0_reg;
  r_low_in_1  <=  mem_low_in_1_reg(69 downto 6);

  DO_L_1 <=   mem_low_out_1(69 downto 6);
  DO_H_1 <=   mem_high_out_1(69 downto 6);

  FIFO_inst_l_0 : FIFO_DUALCLOCK_MACRO
    generic map (
      DEVICE => "7SERIES",              -- Target Device: "VIRTEX5", "VIRTEX6", "7SERIES"
      ALMOST_FULL_OFFSET => X"0064",    -- Sets almost full threshold
      ALMOST_EMPTY_OFFSET => X"0064",   -- Sets the almost empty threshold
      DATA_WIDTH => 64,                 -- Valid values are 1-72 (37-72 only valid when FIFO_SIZE="36Kb")
      FIFO_SIZE => "36Kb",              -- Target BRAM, "18Kb" or "36Kb"
      FIRST_WORD_FALL_THROUGH => FALSE) -- Sets the FIFO FWFT to TRUE or FALSE
    port map (
      ALMOSTEMPTY => a_empty_l_0,       -- 1-bit output almost empty
      ALMOSTFULL => a_full_l_0,         -- 1-bit output almost full
      DO => mem_low_out_0,              -- Output data, width defined by DATA_WIDTH parameter
      EMPTY => empty_l_0,               -- 1-bit output empty
      FULL =>  full_l_0,                -- 1-bit output full
      RDCOUNT => rdcount_l_0,           -- Output read count, width determined by FIFO depth
      RDERR => open,                    -- 1-bit output read error
      WRCOUNT => wrcount_l_0,           -- Output write count, width determined by FIFO depth
      WRERR => open,                    -- 1-bit output write error
      DI => mem_low_in_0_reg,           -- Input data, width defined by DATA_WIDTH parameter
      RDCLK => clk_r,                   -- 1-bit input read clock
      RDEN => ren_int_l,                -- 1-bit input read enable
      RST => rst,                       -- 1-bit input reset
      WRCLK => clk_w,                   -- 1-bit input write clock
      WREN => wen_bram                  -- 1-bit input write enable
    );

    FIFO_inst_l_1 : FIFO_DUALCLOCK_MACRO
      generic map (
        DEVICE => "7SERIES",
        ALMOST_FULL_OFFSET => X"0064",
        ALMOST_EMPTY_OFFSET => X"0064",
        DATA_WIDTH => 72,
        FIFO_SIZE => "36Kb",
        FIRST_WORD_FALL_THROUGH => FALSE)
      port map (
        ALMOSTEMPTY => a_empty_l_1,
        ALMOSTFULL => a_full_l_1,
        DO => mem_low_out_1,
        EMPTY => empty_l_1,
        FULL =>  full_l_1,
        RDCOUNT => rdcount_l_1,
        RDERR => open,
        WRCOUNT => wrcount_l_1,
        WRERR => open,
        DI => mem_low_in_1_reg,
        RDCLK => clk_r,
        RDEN => ren_int_l,
        RST => rst,
        WRCLK => clk_w,
        WREN => wen_bram
      );

    FIFO_inst_h_0 : FIFO_DUALCLOCK_MACRO
      generic map (
        DEVICE => "7SERIES",
        ALMOST_FULL_OFFSET => X"0064",
        ALMOST_EMPTY_OFFSET => X"0064",
        DATA_WIDTH => 64,
        FIFO_SIZE => "36Kb",
        FIRST_WORD_FALL_THROUGH => FALSE)
      port map (
        ALMOSTEMPTY => a_empty_h_0,
        ALMOSTFULL => a_full_h_0,
        DO => mem_high_out_0,
        EMPTY => empty_h_0,
        FULL =>  full_h_0,
        RDCOUNT => rdcount_h_0,
        RDERR => open,
        WRCOUNT => wrcount_h_0,
        WRERR => open,
        DI => mem_high_in_0_reg,
        RDCLK => clk_r,
        RDEN => ren_int_h,
        RST => rst,
        WRCLK => clk_w,
        WREN => wen_bram
      );


    FIFO_inst_h_1 : FIFO_DUALCLOCK_MACRO
      generic map (
        DEVICE => "7SERIES",
        ALMOST_FULL_OFFSET => X"0064",
        ALMOST_EMPTY_OFFSET => X"0064",
        DATA_WIDTH => 72,
        FIFO_SIZE => "36Kb",
        FIRST_WORD_FALL_THROUGH => FALSE)
      port map (
        ALMOSTEMPTY => a_empty_h_1,
        ALMOSTFULL => a_full_h_1,
        DO => mem_high_out_1,
        EMPTY => empty_h_1,
        FULL =>  full_h_1,
        RDCOUNT => rdcount_h_1,
        RDERR => open,
        WRCOUNT => wrcount_h_1,
        WRERR => open,
        DI => mem_high_in_1_reg,
        RDCLK => clk_r,
        RDEN => ren_int_h,
        RST => rst,
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
      data_val_w <= '0';
    elsif clk_r'event and clk_r = '1' then
      if ren = '1' then              -- Does not check if empty, will underwrite
        data_val_w <= '1';
        if rr = '0' then
          r_ptr_l <= r_ptr_l + 1;
          ren_int_l <= '0';
          ren_int_h <= '1';
          data_out <= mem_low_out_1(69 downto 6) & mem_low_out_0;
          eop_addr_out <= mem_low_out_1(5 downto 1);
          is_sop_out <= mem_low_out_1(0);
        else
          r_ptr_h <= r_ptr_h + 1;
          ren_int_h <= '0';
          ren_int_l <= '1';
          data_out <= mem_high_out_1(69 downto 6) & mem_high_out_0;
          eop_addr_out <= mem_high_out_1(5 downto 1);
          is_sop_out <= '0';
        end if;
        rr <= not rr;
      else
        data_val_w <= '0';
        ren_int_l <= '0';
        ren_int_h <= '0';
      end if;

    end if;
  end process;

end behav;
