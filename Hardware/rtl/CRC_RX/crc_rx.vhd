library ieee;
  use ieee.std_logic_1164.all;

package lane_defs is
  subtype LANE0 is natural range 7 downto 0;
  subtype LANE1 is natural range 15 downto 8;
  subtype LANE2 is natural range 23 downto 16;
  subtype LANE3 is natural range 31 downto 24;
  subtype LANE4 is natural range 39 downto 32;
  subtype LANE5 is natural range 47 downto 40;
  subtype LANE6 is natural range 55 downto 48;
  subtype LANE7 is natural range 63 downto 56;
end lane_defs;

library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_unsigned.all;
  use ieee.numeric_std.all;
library UNISIM;
  use UNISIM.vcomponents.all;
library UNIMACRO;
  use unimacro.Vcomponents.all;
use work.PCK_CRC32_D8.all;
use work.PCK_CRC32_D64.all;
use work.PCK_CRC32_D128.all;
use work.lane_defs.all;

entity crc_rx is
  port(
  -- INPUTS
  clk_312         : in std_logic;
  rst_n           : in std_logic;
  mac_data        : in std_logic_vector(127 downto 0);
  mac_sop         : in std_logic;
  mac_eop         : in std_logic_vector(4 downto 0);

  --OUTPUTS
  app_data        : out std_logic_vector(127 downto 0);
  app_sop         : out std_logic;
  app_eop         : out std_logic_vector(4 downto 0);
  crc_ok          : out std_logic
  );
end entity;

architecture behav_crc_rx of crc_rx is

  TYPE states_d8 is (init, calc);
  signal s_d8      : states_d8;

  signal use_d128  : std_logic;
  signal use_d64   : std_logic;
  signal use_d8    : std_logic;

  signal crc_reg   : std_logic_vector(31 downto 0);
  signal d64_reg   : std_logic_vector(63 downto 0);  -- store higher 64 bits, so crc d8
                                                     -- has time to perform calculations
  signal valid_frame : std_logic;           -- 1 from SOP to EOP. Enables crc processes
  signal byte_cnt  : std_logic_vector(2 downto 0);

  signal crc_final  : std_logic_vector(31 downto 0);
  signal d8_done   : std_logic;

  signal input_reg : std_logic_vector(127 downto 0);
  signal eop_reg   : std_logic_vector(4 downto 0);
  signal sop_reg   : std_logic;
  signal input_reg_reg : std_logic_vector(127 downto 0);
  signal eop_reg_reg   : std_logic_vector(4 downto 0);

  signal fifo_data_out  : std_logic_vector(127 downto 0);
  signal fifo_eop_out   : std_logic_vector(4 downto 0);
  signal fifo_sop_out   : std_logic;

  signal do_l : std_logic_vector(63 downto 0);
  signal do_h : std_logic_vector(69 downto 0);
  signal di_h : std_logic_vector(69 downto 0);
  signal almost_empty_l : std_logic;
  signal almost_empty_h : std_logic;
  signal almost_full_l  : std_logic;
  signal almost_full_h  : std_logic;
  signal full_l : std_logic;
  signal full_h : std_logic;
  signal empty_l : std_logic;
  signal empty_h : std_logic;
  signal ren : std_logic;
  signal wen : std_logic;
  signal rdcnt_l : std_logic_vector(8 downto 0);
  signal rdcnt_h : std_logic_vector(8 downto 0);
  signal wrcnt_l : std_logic_vector(8 downto 0);
  signal wrcnt_h : std_logic_vector(8 downto 0);
  signal rst : std_logic;
  signal fifo_delay : std_logic_vector(2 downto 0);


  begin
    rst <= not rst_n;

    fifo_data_out <= do_h(69 downto 6) & do_l;
    fifo_eop_out <= do_h(5 downto 1);
    fifo_sop_out <= do_h(0);
    di_h <= mac_data(127 downto 64) & mac_eop & mac_sop;

    -- Hold fifo. Needed to wait for at most 8 cycles
    FIFO_hold_l : FIFO_SYNC_MACRO
    generic map (
      DEVICE => "7SERIES",
      ALMOST_FULL_OFFSET => X"0080", -- Sets almost full threshold
      ALMOST_EMPTY_OFFSET => X"0080", -- Sets the almost empty threshold
      DATA_WIDTH => 64,
      FIFO_SIZE => "36Kb")
    port map (
      ALMOSTEMPTY => almost_empty_l,
      ALMOSTFULL => almost_full_l,
      DO => do_l,
      EMPTY => empty_l,
      FULL => full_l,
      RDCOUNT => rdcnt_l,
      RDERR => open,
      WRCOUNT => wrcnt_l,
      WRERR => open,
      CLK => clk_312,
      DI => mac_data(63 downto 0),
      RDEN => ren,
      RST => rst,
      WREN => wen
    );
    FIFO_hold_h : FIFO_SYNC_MACRO
    generic map (
      DEVICE => "7SERIES",
      ALMOST_FULL_OFFSET => X"0080", -- Sets almost full threshold
      ALMOST_EMPTY_OFFSET => X"0080", -- Sets the almost empty threshold
      DATA_WIDTH => 70,
      FIFO_SIZE => "36Kb")
    port map (
      ALMOSTEMPTY => almost_empty_h,
      ALMOSTFULL => almost_full_h,
      DO => do_h,
      EMPTY => empty_h,
      FULL => full_h,
      RDCOUNT => rdcnt_h,
      RDERR => open,
      WRCOUNT => wrcnt_h,
      WRERR => open,
      CLK => clk_312,
      DI => di_h,
      RDEN => ren,
      RST => rst,
      WREN => wen
    );

    -- input regs process
    data_regs: process(clk_312,rst_n)
    begin
      if rst_n = '0' then
        input_reg <= (others=>'0');
        input_reg_reg <= (others=>'0');
        eop_reg <= (others=>'0');
        eop_reg_reg <= (others=>'0');
        sop_reg <= '0';
      elsif clk_312'event and clk_312 = '1' then
        input_reg <= fifo_data_out;
        eop_reg <= fifo_eop_out;
        eop_reg_reg <= eop_reg;
        sop_reg <= fifo_sop_out;
        input_reg_reg <= input_reg;
      end if;
    end process;

    -- process to control crc modules and fifos
    control: process(input_reg, input_reg_reg, eop_reg, eop_reg_reg, sop_reg)
    begin
      if sop_reg = '1' then -- Frame starting now
        valid_frame <= '1';
      end if;

      if eop_reg(4) = '1' and valid_frame = '1' then -- End of a frame
        valid_frame <= '0';
        use_d128 <= '0';
        -- Now, find out where it is
        case eop_reg(3 downto 0) is
          -- CRC between 2 words
          when x"0" | x"1" | x"2" | x"3" =>
          -- All CRC value inside the lower half part
          when x"4" | x"5" | x"6" | x"7" =>
            use_d128 <= '0';
            use_d64 <= '0';
            use_d8 <= '1';
          -- CRC between lower and half part
          when x"8" | x"9" | x"A" | x"B" =>
            use_d128 <= '0';
            use_d64 <= '0';
            use_d8 <= '1';
          -- All CRC in the higher half
          when x"C" | x"D" | x"E" | x"F" =>
            use_d128 <= '0';
            use_d64 <= '1';
            use_d8 <= '1';
          when others => null;
        end case;
      elsif valid_frame = '1' then
        use_d128 <= '1';
        use_d64  <= '0';
        use_d8   <= '0';
      else
        use_d128 <= '0';
        use_d64  <= '0';
        use_d8   <= '0';
      end if;
    end process;

    -- process to run crc calculations
    calc_proc: process(clk_312, rst_n, sop_reg)
    begin
      if rst_n = '0' then
        crc_reg <= (others=>'0');
        d64_reg <= (others=>'0');
        fifo_delay <= (others=>'0');
        wen <= '0';
        ren <= '0';

      elsif clk_312'event and clk_312 = '1' then
        if fifo_delay < "101" or sop_reg = '1' then
          fifo_delay <= fifo_delay + 1;
          crc_reg <= (others=>'0');
          d64_reg <= (others=>'0');
        else
          wen <= '1';
          if use_d128 = '1' then      -- free to use all input
            crc_reg <= nextCRC32_D128(input_reg, crc_reg);
            ren <= '1';
          elsif use_d64 = '1' and use_d8 = '1' and d8_done = '0' then
            -- use only lower half of the input
            crc_reg <= nextCRC32_D64(input_reg(63 downto 0), crc_reg);
            -- use 8-bit data function for the rest of data
            d64_reg <= input_reg(127 downto 64);
            -- Stop reading from fifo until crc d8 is done
            ren <= '0';
          elsif use_d8 = '1' and d8_done = '0' then
            ren <= '0';
          else
            ren <= '1';
          end if;
        end if;
      end if;
    end process;

    -- process to perform crc byte by byte using nextCRC32_D8
    -- It will use crc_reg, so input fifo must be not enabled
    calc_d8: process(clk_312, rst_n)
    begin
      if rst_n = '0' then
        s_d8 <= init;

      elsif clk_312'event and clk_312 = '1' then
            case s_d8 is
              when init =>
                byte_cnt <= (others=>'0');
                crc_final <= (others=>'0');
                d8_done  <= '0';
                if use_d8 = '1' then
                  s_d8 <= calc;
                end if;
              when calc =>
                if byte_cnt < (eop_reg(3 downto 0) - 4) then -- CRC value is not used in the crc calculation
                  case byte_cnt is
                    when "000" => crc_final <= nextCRC32_D8(d64_reg(LANE0), crc_reg);
                    when "001" => crc_final <= nextCRC32_D8(d64_reg(LANE1), crc_final);
                    when "010" => crc_final <= nextCRC32_D8(d64_reg(LANE2), crc_final);
                    when "011" => crc_final <= nextCRC32_D8(d64_reg(LANE3), crc_final);
                    when "100" => crc_final <= nextCRC32_D8(d64_reg(LANE4), crc_final);
                    when "101" => crc_final <= nextCRC32_D8(d64_reg(LANE5), crc_final);
                    when "110" => crc_final <= nextCRC32_D8(d64_reg(LANE6), crc_final);
                    when "111" => crc_final <= nextCRC32_D8(d64_reg(LANE7), crc_final);
                    when others => null;
                  end case;
                  byte_cnt <= byte_cnt + 1;
                else
                  s_d8 <= init;
                end if;
              when others => null;
          end case;
      end if;
    end process;
end behav_crc_rx;
