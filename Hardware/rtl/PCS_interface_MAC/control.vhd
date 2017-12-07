library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use ieee.std_logic_unsigned.all;

use work.interface_defs.all;


entity control is
  port (
    clk             : in  std_logic;
    rst_n           : in  std_logic;
    xgmii_rxc_0     : in  std_logic_vector( 7 downto 0);
    xgmii_rxd_0     : in  std_logic_vector(63 downto 0);
    xgmii_rxc_1     : in  std_logic_vector( 7 downto 0);
    xgmii_rxd_1     : in  std_logic_vector(63 downto 0);
    xgmii_rxc_2     : in  std_logic_vector( 7 downto 0);
    xgmii_rxd_2     : in  std_logic_vector(63 downto 0);
    xgmii_rxc_3     : in  std_logic_vector( 7 downto 0);
    xgmii_rxd_3     : in  std_logic_vector(63 downto 0);
    ctrl_delay      : out std_logic_vector( 1 downto 0);
    shift_out       : out std_logic_vector(2 downto 0);
    is_sop          : out std_logic;
    eop_location_out: out std_logic_vector(5 downto 0);
    wen_fifo        : out std_logic
  );
end entity;

architecture behav_control of control is
  constant NO_EOP : std_logic_vector(5 downto 0) := "100000";

  signal sop_location               : std_logic_vector(3 downto 0);
  signal sop_location_reg           : std_logic_vector(3 downto 0);
  signal eop_location               : std_logic_vector(7 downto 0);
  signal sop_by_byte                : std_logic_vector(7 downto 0);
  signal eop_location_reg           : std_logic_vector(7 downto 0);
  signal eop_location_reg_reg       : std_logic_vector(7 downto 0);
  signal shift_calc                 : std_logic_vector(2 downto 0);
  signal shift_out_int              : std_logic_vector(2 downto 0);
  signal shift_out_reg              : std_logic_vector(2 downto 0);
  signal shift_out_reg_reg          : std_logic_vector(2 downto 0);
  signal shift_eop                  : std_logic_vector(2 downto 0);
  signal shift_eop_reg              : std_logic_vector(2 downto 0);
  signal ctrl_delay_int             : std_logic_vector( 1 downto 0);
  signal ctrl_delay_reg             : std_logic_vector( 1 downto 0);
  signal ctrl_delay_reg_reg         : std_logic_vector( 1 downto 0);
  signal ctrl_delay_reg_reg_reg     : std_logic_vector( 1 downto 0);
  signal wen_fifo_reg               : std_logic;
  signal wen_fifo_reg_reg           : std_logic;
  signal missed_sop                 : std_logic;
  signal missed_sop_reg             : std_logic;
  signal sop_eop_same_cycle         : std_logic;
  signal sop7_eop_same_cycle        : std_logic;
  signal sop7_eop_same_cycle_reg    : std_logic;
  signal sop_eop_same_cycle_reg     : std_logic;
  signal sop_eop_same_cycle_reg_reg : std_logic;
  signal sop_eop_packet             : std_logic;
  signal is_sop_int                 : std_logic;
  signal is_sop_reg                 : std_logic;
  signal is_sop_reg_reg             : std_logic;
  signal eop_location_calc          : std_logic_vector(5 downto 0);
  signal eop_location_calc_reg      : std_logic_vector(5 downto 0);
  signal eop_location_calc_reg_reg  : std_logic_vector(5 downto 0);
  signal eop_location_calc_reg_reg_reg  : std_logic_vector(5 downto 0);
begin

  -- Making things clear:
  -- LANEs from 0 to 7 are the eight bytes for each MII data interface.
  -- WORDs from 0 to 7 are the eight 32bits words for all four MIIs in use

  sop_finder: process(xgmii_rxc_0, xgmii_rxd_0, xgmii_rxc_1, xgmii_rxd_1,
                      xgmii_rxc_2, xgmii_rxd_2, xgmii_rxc_3, xgmii_rxd_3)
  begin
      missed_sop <= '0';
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
        missed_sop <= '1'; --
      elsif (xgmii_rxc_3(4) = '1' and xgmii_rxd_3(LANE4) = START) then
        -- SOP on LANE 4 of PCS 3 -> word 7
        sop_location <= "0111";
        missed_sop <= '1';

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

  ctrl_delay_int <= "01" when (sop_location = "0101" and eop_location /= "00100000") else
                    "10" when (sop_location = "0100" and eop_location /= "00100000") else
                    "00";

  mux_delay_ctrl: process(clk, rst_n)
  begin
    if rst_n = '0' then
      ctrl_delay_reg <= (others=>'0');
      ctrl_delay_reg_reg <= (others=>'0');
      ctrl_delay_reg_reg_reg <= (others=>'0');
    elsif clk'event and clk = '1' then
      ctrl_delay_reg_reg <= ctrl_delay_reg;
      ctrl_delay_reg_reg_reg <= ctrl_delay_reg_reg;
      if ctrl_delay_int /= "00" then
        -- ctrl_delay_int updated to a valid value
        ctrl_delay_reg <= ctrl_delay_int;
      elsif eop_location /= "00100000" then
        ctrl_delay_reg <= (others=>'0');
      end if;
    end if;
  end process;

  ctrl_delay <= ctrl_delay_reg_reg_reg;

  reg_shift_ctrl: process (sop_location, eop_location)
  begin
    -- SOP
    if sop_location /= "1000" and eop_location = "00100000" then
      case sop_location is
        when "0000" => shift_calc <= "010";
        when "0001" => shift_calc <= "011";
        when "0010" => shift_calc <= "100";
        when "0011" => shift_calc <= "101";
        when "0100" => shift_calc <= "110";
        when "0101" => shift_calc <= "111";
        when "0110" => shift_calc <= "000";
        when "0111" => shift_calc <= "001";
        -- For "0111" we will write 1 to shift_calc,
        -- but WEN will be low only enabling writing on next cycle
        when others => null;
      end case;
    -- SOP & EOP
    elsif sop_location /= "1000" and eop_location /= "00100000" then
      case eop_location is
        -- EOP at word 0
        when x"00" | x"01" | x"02" | x"03" => shift_calc <= (others=>'0');
        -- EOP at word 1
        when x"04" | x"05" | x"06" | x"07" => shift_calc <= (others=>'0');
        -- EOP at word 2
        when x"08" | x"09" | x"0A" | x"0B" => shift_calc <= (others=>'0');
        -- EOP at word 3
        -- when x"0C" | x"0D" | x"0E" | x"0F" => shift_calc <= "001";  -- TESTE DESLOCADOR PARA TESTE COM CYLES = 3E. KOROL
        when x"0C" | x"0D" | x"0E" | x"0F" => shift_calc <= "000";
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

  -- Process to calculate the SOP bnyte position
  sop_pos_byte: process (clk, rst_n)
  begin
    if rst_n = '0' then
      sop_by_byte <= (others=>'0');
    elsif clk'event and clk = '1' then
      if sop_location /= "1000" then
        sop_by_byte <= "00" & (sop_location + 1) & "00";
      end if;
    end if;
  end process;

  -- Inform fifo if is SOP
  is_sop_int <= '0' when sop_location = "1000" else '1';
  -- is_sop_int <= '0' when sop_location = "1000" and sop_eop_same_cycle = '0' else
  --               '1';
  -- Inform fifo where  EOP is

  -- Inform process that a SOP and EOP happened on the same cycle
  sop_eop_same_cycle <= '1' when sop_location /= "1000" and eop_location /= "00100000" else
                        '0';
  sop7_eop_same_cycle <= '1' when (sop_location /= "1000" and sop_location /= "0111") and eop_location /= "00100000" else
                        '0';

  calculate_new_eop: process(rst_n, eop_location,shift_out_reg_reg,ctrl_delay_reg_reg_reg)
begin
  if rst_n = '0' then
    eop_location_calc <= "100000";
  else
    eop_location_calc(5) <= eop_location(5);  -- atua como sinal de controle, indicando q há EOP se '0'
    if (eop_location(5) = '0') then
      case shift_out_reg_reg is
        when "000" => if ctrl_delay_reg_reg_reg = "01" then
                        eop_location_calc(4 downto 0) <= eop_location(4 downto 0) + 4;
                      elsif ctrl_delay_reg_reg_reg = "10" then
                      eop_location_calc(4 downto 0) <= eop_location(4 downto 0) + 8;
                    else eop_location_calc(4 downto 0) <= eop_location(4 downto 0);
                      end if;
        when "001" =>if (eop_location(4 downto 0) < "0100") then
                        eop_location_calc(4 downto 0) <= 32 - (4 - eop_location(4 downto 0));
                      else eop_location_calc(4 downto 0) <= eop_location(4 downto 0) - 4;
                    end if;
        when "010" =>if (eop_location(4 downto 0) < 8) then
                        eop_location_calc(4 downto 0) <= 32 - (8 - eop_location(4 downto 0));
                      else eop_location_calc(4 downto 0) <= eop_location(4 downto 0) - 8;
                    end if;
        when "011" =>if (eop_location(4 downto 0) < 12) then
                        eop_location_calc(4 downto 0) <= 32 - (12 - eop_location(4 downto 0));
                      else eop_location_calc(4 downto 0) <= eop_location(4 downto 0) - 12;
                    end if;
        when "100" =>if (eop_location(4 downto 0) < 16) then
                        eop_location_calc(4 downto 0) <= 32 - (16 - eop_location(4 downto 0));
                      else eop_location_calc(4 downto 0) <= eop_location(4 downto 0) - 16;
                    end if;
        when "101" =>if (eop_location(4 downto 0) < 20) then
                        eop_location_calc(4 downto 0) <= 32 - (20 - eop_location(4 downto 0));
                      else eop_location_calc(4 downto 0) <= eop_location(4 downto 0) - 20;
                    end if;
        when "110" =>if (eop_location(4 downto 0) < 24) then
                          eop_location_calc(4 downto 0) <= 32 - (24 - eop_location(4 downto 0));
                      else eop_location_calc(4 downto 0) <= eop_location(4 downto 0) - 24;
                    end if;
        when "111" =>if (eop_location(4 downto 0) < 28) then
                      eop_location_calc(4 downto 0) <= 32 - (28 - eop_location(4 downto 0));
                    else eop_location_calc(4 downto 0) <= eop_location(4 downto 0) - 28;
                  end if;
        when others => eop_location_calc <= "100000";
      end case;
    else eop_location_calc <= "100000";
  end if;
  end if;
end process;

propagate_eop_location_calc: process(rst_n,clk)
begin
  if rst_n = '0' then
    eop_location_calc_reg <= "100000";
    eop_location_calc_reg_reg <= "100000";
    eop_location_calc_reg_reg_reg <= "100000";
  elsif clk'event and clk='1' then
      eop_location_calc_reg <= eop_location_calc;
      eop_location_calc_reg_reg <= eop_location_calc_reg;
      -- teste para ajustar eop
      if ctrl_delay_reg_reg_reg /= "00" then
        eop_location_calc_reg_reg_reg <= eop_location_calc_reg_reg;
      else
        eop_location_calc_reg_reg_reg <= eop_location_calc_reg;
    end if;
  end if;
end process;

-- Some cases eop needs to be outputed one cycle ahead
-- Ending with shift of 100/110 and next shift is different
eop_location_out <= eop_location_calc_reg when (shift_eop = "100" or shift_eop_reg = "100") and shift_out_reg /= "100" else
                    eop_location_calc_reg when (shift_eop = "110" or shift_eop_reg = "110") and shift_out_reg /= "110" else
                    eop_location_calc_reg_reg;
-- eop_location_out <= eop_location_calc_reg_reg;

  -- Process to control fifo write enable
  wen_fifo_proc: process (clk, rst_n)
  begin
    if rst_n = '0' then
      wen_fifo_reg <= '0';
      wen_fifo_reg_reg <= '0';
      eop_location_reg <= (others=>'0');
      eop_location_reg_reg <= (others=>'0');
      sop_eop_same_cycle_reg <= '0';
      sop_eop_same_cycle_reg_reg <= '0';
      sop7_eop_same_cycle_reg <= '0';
      sop_eop_packet <= '0';

    elsif clk'event and clk = '1' then
      wen_fifo_reg_reg <= wen_fifo_reg;
      eop_location_reg <= eop_location;
      eop_location_reg_reg <= eop_location_reg;
      sop_eop_same_cycle_reg <= sop_eop_same_cycle;
      sop_eop_same_cycle_reg_reg <= sop_eop_same_cycle_reg;
      sop7_eop_same_cycle_reg <= sop7_eop_same_cycle;

      if eop_location /= "00100000" then
        sop_eop_packet <= sop7_eop_same_cycle;
      end if;

      -- SOP: start writing
      if (sop_location /= "1000" and sop_location /= "0111" and sop_location /= "0110"
          and wen_fifo_reg = '0') or missed_sop_reg = '1' or sop_eop_same_cycle_reg_reg = '1' then
        wen_fifo_reg <= '1';

      elsif sop_eop_same_cycle_reg = '1' and sop7_eop_same_cycle_reg = '1' then
        wen_fifo_reg <= '1';

      -- EOP: stop writing
    elsif eop_location_reg_reg /= "00100000" and sop_location = "1000" and sop_location_reg = "1000" then
          wen_fifo_reg <= '0';
      end if;

    end if;
  end process;

  -- Process to keep shift value between SOPs
  shift_out_latch: process (clk, rst_n, sop_location, shift_calc, shift_out_int)
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
      shift_eop_reg <= (others=>'0');
      is_sop_reg <= '0';
      is_sop_reg_reg <= '0';
      sop_location_reg <= (others=>'0');
    elsif clk'event and clk = '1' then
      shift_out_reg <= shift_out_int;
      sop_location_reg <= sop_location;
      missed_sop_reg <= missed_sop;
      shift_eop_reg <= shift_eop;

      if (sop_location(2 downto 0) >= "100" and eop_location /= "00100000") or sop_location = "0110" or sop_location = "0111" then
        is_sop_reg <= '0';
      else
        is_sop_reg <= is_sop_int;
        if (sop_location_reg(2 downto 0) >= "100" and eop_location_reg /= "00100000") or sop_location_reg = "0110" or sop_location_reg = "0111" then
          is_sop_reg <= '1';
        end if;
      end if;

      if sop_eop_same_cycle_reg = '1' then
        is_sop_reg_reg <= is_sop_reg_reg;
      else
        is_sop_reg_reg <= is_sop_reg;
      end if;

      if sop_eop_same_cycle_reg = '1' and sop7_eop_same_cycle_reg = '0' then
        shift_out_reg_reg <= shift_out_reg_reg;
        is_sop_reg_reg <= is_sop_reg_reg;
      else
        shift_out_reg_reg <= shift_out_reg;
        is_sop_reg_reg <= is_sop_reg;
      end if;

    end if;
  end process;


  wen_fifo <= wen_fifo_reg_reg;
  shift_eop <= shift_out_reg_reg;
  shift_out <= shift_eop;
  is_sop <= is_sop_reg_reg;

end architecture;
