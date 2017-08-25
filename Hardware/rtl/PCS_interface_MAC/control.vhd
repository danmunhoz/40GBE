library ieee;
  use ieee.std_logic_1164.all;
  use IEEE.std_logic_unsigned.all;
  use IEEE.numeric_std.all;

use work.interface_defs.all;


entity control is
  port (
    clk         : in  std_logic;
    rst_n       : in  std_logic;
    xgmii_rxc_0 : in  std_logic_vector( 7 downto 0);
    xgmii_rxd_0 : in  std_logic_vector(63 downto 0);
    xgmii_rxc_1 : in  std_logic_vector( 7 downto 0);
    xgmii_rxd_1 : in  std_logic_vector(63 downto 0);
    xgmii_rxc_2 : in  std_logic_vector( 7 downto 0);
    xgmii_rxd_2 : in  std_logic_vector(63 downto 0);
    xgmii_rxc_3 : in  std_logic_vector( 7 downto 0);
    xgmii_rxd_3 : in  std_logic_vector(63 downto 0);
    ctrl_delay  : out std_logic_vector( 1 downto 0);
    shift_out   : out std_logic_vector(2 downto 0);
    wen_fifo    : out std_logic
  );
end entity;

architecture behav_control of control is
  signal sop_location      : std_logic_vector(3 downto 0);
  signal eop_location      : std_logic_vector(7 downto 0);
  signal shift_calc        : std_logic_vector(2 downto 0);
  signal shift_out_int     : std_logic_vector(2 downto 0);
  signal shift_out_reg     : std_logic_vector(2 downto 0);
  signal shift_out_reg_reg : std_logic_vector(2 downto 0);
  signal wen_fifo_reg      : std_logic;
  signal wen_fifo_reg_reg  : std_logic;

begin

  -- Making things clear:
  -- LANEs from 0 to 7 are the eight bytes for each MII data interface.
  -- WORDs from 0 to 7 are the eight 32bits words for all four MIIs in use


  sop_finder: process(xgmii_rxc_0, xgmii_rxd_0, xgmii_rxc_1, xgmii_rxd_1,
                      xgmii_rxc_2, xgmii_rxd_2, xgmii_rxc_3, xgmii_rxd_3)
  begin
      -- MII from PCS 0
      if (xgmii_rxc_0(0) = '1' and xgmii_rxd_0(LANE0) = START) then
        -- SOP on LANE 0 of PCS 0 -> word 0
        sop_location <= "0000";
      elsif (xgmii_rxc_0(4) = '1' and xgmii_rxd_0(LANE4) = START) then
        -- SOP on LANE 4 of PCS 0 -> word 1
        sop_location <= "0001";

      -- MII from PCS 1
      elsif (xgmii_rxc_1(0) = '1' and xgmii_rxd_1(LANE0) = START) then
        -- SOP on LANE 0 of PCS 1 -> word 2
        sop_location <= "0010";
      elsif (xgmii_rxc_1(4) = '1' and xgmii_rxd_1(LANE4) = START) then
        -- SOP on LANE 4 of PCS 1 -> word 3
        sop_location <= "0011";

      -- MII from PCS 2
      elsif (xgmii_rxc_2(0) = '1' and xgmii_rxd_2(LANE0) = START) then
        -- SOP on LANE 0 of PCS 2 -> word 4
        sop_location <= "0100";
      elsif (xgmii_rxc_2(4) = '1' and xgmii_rxd_2(LANE4) = START) then
        -- SOP on LANE 4 of PCS 2 -> word 5
        sop_location <= "0101";

      -- MII from PCS 3
      elsif (xgmii_rxc_3(0) = '1' and xgmii_rxd_3(LANE0) = START) then
        -- SOP on LANE 0 of PCS 3 -> word 6
        sop_location <= "0110";
      elsif (xgmii_rxc_3(4) = '1' and xgmii_rxd_3(LANE4) = START) then
        -- SOP on LANE 4 of PCS 3 -> word 7
        sop_location <= "0111";

      else
        -- No SOP this time...
        sop_location <= "1000";
      end if;
  end process;

  -- TERMINATE can appear in any byte of any MII
  eop_finder: process(xgmii_rxc_0, xgmii_rxd_0, xgmii_rxc_1, xgmii_rxd_1,
                      xgmii_rxc_2, xgmii_rxd_2, xgmii_rxc_3, xgmii_rxd_3)
  begin
      if (xgmii_rxc_0(0) = '1' and xgmii_rxd_0(LANE0) = TERMINATE) then
        eop_location <= x"00";
      elsif (xgmii_rxc_0(1) = '1' and xgmii_rxd_0(LANE1) = TERMINATE) then
        eop_location <= x"01";
      elsif (xgmii_rxc_0(2) = '1' and xgmii_rxd_0(LANE2) = TERMINATE) then
        eop_location <= x"02";
      elsif (xgmii_rxc_0(3) = '1' and xgmii_rxd_0(LANE3) = TERMINATE) then
        eop_location <= x"03";
      elsif (xgmii_rxc_0(4) = '1' and xgmii_rxd_0(LANE4) = TERMINATE) then
        eop_location <= x"04";
      elsif (xgmii_rxc_0(5) = '1' and xgmii_rxd_0(LANE5) = TERMINATE) then
        eop_location <= x"05";
      elsif (xgmii_rxc_0(6) = '1' and xgmii_rxd_0(LANE6) = TERMINATE) then
        eop_location <= x"06";
      elsif (xgmii_rxc_0(7) = '1' and xgmii_rxd_0(LANE7) = TERMINATE) then
        eop_location <= x"07";

      -- MII from PCS 1
      elsif (xgmii_rxc_1(0) = '1' and xgmii_rxd_1(LANE0) = TERMINATE) then
        eop_location <= x"08";
      elsif (xgmii_rxc_1(1) = '1' and xgmii_rxd_1(LANE1) = TERMINATE) then
        eop_location <= x"09";
      elsif (xgmii_rxc_1(2) = '1' and xgmii_rxd_1(LANE2) = TERMINATE) then
        eop_location <= x"0A";
      elsif (xgmii_rxc_1(3) = '1' and xgmii_rxd_1(LANE3) = TERMINATE) then
        eop_location <= x"0B";
      elsif (xgmii_rxc_1(4) = '1' and xgmii_rxd_1(LANE4) = TERMINATE) then
        eop_location <= x"0C";
      elsif (xgmii_rxc_1(5) = '1' and xgmii_rxd_1(LANE5) = TERMINATE) then
        eop_location <= x"0D";
      elsif (xgmii_rxc_1(6) = '1' and xgmii_rxd_1(LANE6) = TERMINATE) then
        eop_location <= x"0E";
      elsif (xgmii_rxc_1(7) = '1' and xgmii_rxd_1(LANE7) = TERMINATE) then
        eop_location <= x"0F";

      -- MII from PCS 2
      elsif (xgmii_rxc_2(0) = '1' and xgmii_rxd_2(LANE0) = TERMINATE) then
        eop_location <= x"10";
      elsif (xgmii_rxc_2(1) = '1' and xgmii_rxd_2(LANE1) = TERMINATE) then
        eop_location <= x"11";
      elsif (xgmii_rxc_2(2) = '1' and xgmii_rxd_2(LANE2) = TERMINATE) then
        eop_location <= x"12";
      elsif (xgmii_rxc_2(3) = '1' and xgmii_rxd_2(LANE3) = TERMINATE) then
        eop_location <= x"13";
      elsif (xgmii_rxc_2(4) = '1' and xgmii_rxd_2(LANE4) = TERMINATE) then
        eop_location <= x"14";
      elsif (xgmii_rxc_2(5) = '1' and xgmii_rxd_2(LANE5) = TERMINATE) then
        eop_location <= x"15";
      elsif (xgmii_rxc_2(6) = '1' and xgmii_rxd_2(LANE6) = TERMINATE) then
        eop_location <= x"16";
      elsif (xgmii_rxc_2(7) = '1' and xgmii_rxd_2(LANE7) = TERMINATE) then
        eop_location <= x"17";

      -- MII from PCS 3
      elsif (xgmii_rxc_3(0) = '1' and xgmii_rxd_3(LANE0) = TERMINATE) then
        eop_location <= x"18";
      elsif (xgmii_rxc_3(1) = '1' and xgmii_rxd_3(LANE1) = TERMINATE) then
        eop_location <= x"19";
      elsif (xgmii_rxc_3(2) = '1' and xgmii_rxd_3(LANE2) = TERMINATE) then
        eop_location <= x"1A";
      elsif (xgmii_rxc_3(3) = '1' and xgmii_rxd_3(LANE3) = TERMINATE) then
        eop_location <= x"1B";
      elsif (xgmii_rxc_3(4) = '1' and xgmii_rxd_3(LANE4) = TERMINATE) then
        eop_location <= x"1C";
      elsif (xgmii_rxc_3(5) = '1' and xgmii_rxd_3(LANE5) = TERMINATE) then
        eop_location <= x"1D";
      elsif (xgmii_rxc_3(6) = '1' and xgmii_rxd_3(LANE6) = TERMINATE) then
        eop_location <= x"1E";
      elsif (xgmii_rxc_3(7) = '1' and xgmii_rxd_3(LANE7) = TERMINATE) then
        eop_location <= x"1F";

      else
        -- No EOP this time...
        eop_location <= "00100000";
      end if;
  end process;

  -- When there is SOP/EOP on the last lane, tell shift_reg to use delay_reg
  -- 00 : Words 6 and 7 bypass delay
  -- 01 : Word 6 delayed and word 7 bypassed
  -- 10 : Words 6 and 7 delayed
  -- 11 : Never happens

  ctrl_delay_mux: ctrl_delay <= "01" when sop_location = "0111" or (eop_location >= x"18" and eop_location <= x"1F") else
                                "10" when sop_location = "0110" or (eop_location >= x"18" and eop_location <= x"1F") else -- Verificar eop
                                "00";

  reg_shift_ctrl: process (sop_location, eop_location)
  begin
    -- SOP
    if sop_location /= "1000" and eop_location = "00100000" then
      case sop_location is
        when "0000" => shift_calc <= "001";
        when "0001" => shift_calc <= "010";
        when "0010" => shift_calc <= "011";
        when "0011" => shift_calc <= "100";
        when "0100" => shift_calc <= "101";
        when "0101" => shift_calc <= "110";
        when "0110" => shift_calc <= "111";
        when "0111" => shift_calc <= "000";
        when others => null;
      end case;
    -- SOP & EOP
    elsif sop_location /= "1000" and eop_location /= "00100000" then
      case eop_location is
        -- EOP at word 0
        when x"00" | x"01" | x"02" | x"03" => shift_calc <= sop_location(2 downto 0) + 1;
        -- EOP at word 1
        when x"04" | x"05" | x"06" | x"07" => shift_calc <= sop_location(2 downto 0);
        -- EOP at word 2
        when x"08" | x"09" | x"0A" | x"0B" => shift_calc <= (sop_location(2 downto 0) + 1) - 2;
        -- EOP at word 3
        when x"0C" | x"0D" | x"0E" | x"0F" => shift_calc <= (sop_location(2 downto 0) + 1) - 3;
        -- EOP at word 4
        when x"10" | x"11" | x"12" | x"13" => shift_calc <= (sop_location(2 downto 0) + 1) - 4;
        -- EOP at word 5
        when x"14" | x"15" | x"16" | x"17" => shift_calc <= (sop_location(2 downto 0) + 1) - 5;
        -- EOP at word 6
        when x"18" | x"19" | x"1A" | x"1B" => shift_calc <= (sop_location(2 downto 0) + 1) - 6;
        -- EOP at word 7
        when x"1C" | x"1D" | x"1E" | x"1F" => shift_calc <= (sop_location(2 downto 0) + 1) - 7;
        when others => null;
      end case;
      -- default
    else
      shift_calc <= (others=>'0');
    end if;

  end process;

  -- Process to control fifo write enable
  wen_fifo_proc: process (clk, rst_n)
  begin
    if (rst_n = '0') then
      wen_fifo_reg <= '0';
    elsif clk'event and clk = '1' then
      -- SOP: start writing
      if sop_location /= "1000" and wen_fifo_reg = '0' then
        wen_fifo_reg <= '1';
      -- EOP: stop writing
      elsif eop_location /= "00100000" and wen_fifo_reg = '1' then
        wen_fifo_reg <= '0';

      end if;
    end if;

  end process;

  -- Process to keep shift value between SOPs
  shift_out_latch: process (clk, rst_n, sop_location, shift_calc)
  begin
    if (rst_n = '0') then
      shift_out_int <= (others=>'0');
    elsif clk='1' then
      if sop_location /= "1000" then
        shift_out_int <= shift_calc;
      else
        shift_out_int <= shift_out_int;
      end if;
    else
        shift_out_int <= shift_out_int;
    end if;
  end process;

  -- Process to sync output with the shifter module
  shift_out_sync: process (clk, rst_n)
  begin
    if (rst_n = '0') then
      shift_out_reg <= (others=>'0');
      shift_out_reg_reg <= (others=>'0');
    elsif clk'event and clk = '1' then
      shift_out_reg <= shift_out_int;
      shift_out_reg_reg <= shift_out_reg;
      wen_fifo_reg_reg <= wen_fifo_reg;
    end if;
  end process;

  wen_fifo <= wen_fifo_reg_reg;
  shift_out <= shift_out_reg_reg;

end architecture;
