library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use ieee.std_logic_unsigned.all;
  use work.PKG_CODES.all;

entity mii_if is
  port (
    clk      : in std_logic;
    rst      : in std_logic;

    data_in  : in std_logic_vector(255 downto 0);
    eop_in   : in std_logic_vector(  5 downto 0);
    sop_in   : in std_logic_vector(  1 downto 0);
    val_in   : in std_logic;
    almost_e : in std_logic;
    almost_f : in std_logic;
    empty    : in std_logic;
    full     : in std_logic;

    ren_out    : out std_logic;
    mii_data_0 : out std_logic_vector(63 downto 0);
    mii_ctrl_0 : out std_logic_vector( 7 downto 0);
    mii_data_1 : out std_logic_vector(63 downto 0);
    mii_ctrl_1 : out std_logic_vector( 7 downto 0);
    mii_data_2 : out std_logic_vector(63 downto 0);
    mii_ctrl_2 : out std_logic_vector( 7 downto 0);
    mii_data_3 : out std_logic_vector(63 downto 0);
    mii_ctrl_3 : out std_logic_vector( 7 downto 0)
  );
end entity;


architecture behav_mii_if of mii_if is
  type mii_fsm_states is (S_IDLE, S_TX, S_IPG, S_EOP, S_SHIFTED_EOP, S_ADJUST_IPG, S_WAIT_1C, S_ERROR);
  signal ps_mii : mii_fsm_states;
  signal ns_mii : mii_fsm_states;

  signal ren_int : std_logic;
  signal shift   : std_logic_vector(1 downto 0);

  signal data_0_o : std_logic_vector(63 downto 0);
  signal data_1_o : std_logic_vector(63 downto 0);
  signal data_2_o : std_logic_vector(63 downto 0);
  signal data_3_o : std_logic_vector(63 downto 0);
  signal eop_in_o : std_logic_vector(5 downto 0);
  signal sop_in_o : std_logic_vector(1 downto 0);

  signal data_0_o_o : std_logic_vector(63 downto 0);
  signal data_1_o_o : std_logic_vector(63 downto 0);
  signal data_2_o_o : std_logic_vector(63 downto 0);
  signal data_3_o_o : std_logic_vector(63 downto 0);

  begin

-- Controla a Leitura da FIFO que alimenta o módulo
  ctrl_fifo1: process(clk,rst)
  begin
    if rst = '0' then
      ren_int <= '0';

    elsif clk'event and clk = '1' then
      if almost_e = '0' then
        ren_int <= '1';
      else
        if eop_in(5) = '0' then
          ren_int <= '0';
        end if;
      end if;
    end if;
  end process;
  ren_out <= '0' when almost_e = '1' and eop_in(5) = '0' else '1';


  RST_SM: process (clk, rst)
  begin
    if rst = '0' then
      ps_mii <= S_ERROR;
      shift <= "00";
    elsif clk 'event and clk = '1' then
      ps_mii <= ns_mii;
    end if;
  end process;


  SM_MII: process (ps_mii, ren_int, val_in, sop_in, eop_in)
  begin
    case ps_mii is

      when S_IDLE =>
        if ren_int = '1' and val_in = '0' then
          ns_mii <= S_IDLE;
        elsif ren_int = '1' and val_in = '1' and sop_in(1) = '1' then
          ns_mii <= S_TX;
        else
          --ns_mii <= S_ERROR;
        end if;

      when S_TX =>
        if ren_int = '1' and val_in = '1' and sop_in(1) = '0' and
           eop_in = "100000" then
          ns_mii <= S_TX;
        elsif ren_int = '1' and val_in = '1' and eop_in /= "100000" then
          ns_mii <= S_EOP;
        else
          --ns_mii <= S_ERROR;
        end if;

      when S_EOP =>
        -- if ren_int = '1' and val_in = '1' and sop_in(1) = '0' and eop_in < "010100" then -- Garante IPG sem SOP
        if sop_in(1) = '0' and eop_in < "010100" then -- Garante IPG sem SOP
          ns_mii <= S_IDLE;
        elsif ren_int = '1' and val_in = '1' and sop_in = "11" and eop_in < "000100" then -- Garante IPG com SOP
          ns_mii <= S_IDLE;
        -- elsif ren_int = '1' and val_in = '1' and sop_in(1) = '0' and eop_in > "010011" then -- EOP > 19ºbyte
        elsif sop_in(1) = '0' and eop_in > "010011" then -- EOP > 19ºbyte
          ns_mii <= S_IPG;
        elsif ren_int = '1' and val_in = '1' and sop_in(1) = '0' and eop_in > "001111" and shift = "01" then -- EOP shiftado acima do 15° byte
          ns_mii <= S_SHIFTED_EOP;
        elsif ren_int = '1' and val_in = '1' and sop_in = "11" and eop_in >= "000100" and shift = "00" then -- Ajusta IPG
          ns_mii <= S_ADJUST_IPG;
        elsif ren_int = '1' and val_in = '1' and sop_in = "11" and eop_in >= "000100" and shift = "01" then -- Pausa 1C e reoderna transmição
          -- baixa REN da FIFO de entrada
          ns_mii <= S_WAIT_1C;
        else
          --ns_mii <= S_ERROR;
        end if;

      when S_ERROR =>
        ns_mii <= S_IDLE;

      -- when S_SHIFTED_EOP =>
        -- if ren_int = '1' and val_in = '1' and sop_in(1) = '0'

      when S_IPG =>
        if sop_in_o(1) = '0' then
          ns_mii <= S_IDLE;
        else
          ns_mii <= S_TX;
        end if;

      when S_ADJUST_IPG =>
        -- shift <= '1';
        ns_mii <= S_TX;

      when S_WAIT_1C =>
        -- shift <= '0';
        ns_mii <= S_TX;

      when others =>

    end case;
  end process;


  OUTPUTS_MII: process (ps_mii, ren_int, val_in, sop_in, eop_in, clk)
  begin
    if clk'event and clk = '1' then

    mii_data_0 <= LANE_IDLE;
    mii_data_1 <= LANE_IDLE;
    mii_data_2 <= LANE_IDLE;
    mii_data_3 <= LANE_IDLE;
    mii_ctrl_0 <= x"ff";
    mii_ctrl_1 <= x"ff";
    mii_ctrl_2 <= x"ff";
    mii_ctrl_3 <= x"ff";

    case ps_mii is

      when S_IDLE =>

      when S_TX =>
        case shift is
          when "00" =>
            -- mii_ctrl_0 <= x"00";
            -- mii_ctrl_1 <= x"00";
            -- mii_ctrl_2 <= x"00";
            -- mii_ctrl_3 <= x"00";
            -- mii_data_0 <= data_0_o;
            -- mii_data_1 <= data_1_o;
            -- mii_data_2 <= data_2_o;
            -- mii_data_3 <= data_3_o;

            if sop_in_o = "10" then
              mii_ctrl_0 <= x"01";
              mii_ctrl_1 <= x"00";
              mii_ctrl_2 <= x"00";
              mii_ctrl_3 <= x"00";
              mii_data_0 <= data_0_o;
              mii_data_1 <= data_1_o;
              mii_data_2 <= data_2_o;
              mii_data_3 <= data_3_o;

            elsif sop_in_o = "11" then
              mii_ctrl_0 <= x"ff";
              mii_ctrl_1 <= x"ff";
              mii_ctrl_2 <= x"01";
              mii_ctrl_3 <= x"00";
              mii_data_0 <= LANE_IDLE;
              mii_data_1 <= LANE_IDLE;
              mii_data_2 <= data_2_o;
              mii_data_3 <= data_3_o;

            else
              mii_ctrl_0 <= x"00";
              mii_ctrl_1 <= x"00";
              mii_ctrl_2 <= x"00";
              mii_ctrl_3 <= x"00";
              mii_data_0 <= data_0_o;
              mii_data_1 <= data_1_o;
              mii_data_2 <= data_2_o;
              mii_data_3 <= data_3_o;
            end if;

          when "01" =>
            mii_data_0 <= data_0_o_o;
            mii_data_1 <= data_1_o_o;
            mii_data_2 <= data_2_o;
            mii_data_3 <= data_3_o;
            mii_ctrl_0 <= x"00";
            mii_ctrl_1 <= x"00";
            mii_ctrl_3 <= x"00";
            if sop_in_o = "10" then
              mii_ctrl_2 <= x"01";
            else
              mii_ctrl_2 <= x"00";
            end if;

          when "11" =>
            mii_data_0 <= data_0_o_o;
            mii_data_1 <= data_1_o_o;
            mii_data_2 <= data_2_o_o;
            mii_data_3 <= data_3_o_o;
            mii_ctrl_1 <= x"00";
            mii_ctrl_2 <= x"00";
            mii_ctrl_3 <= x"00";
            if sop_in_o = "10" then
              mii_ctrl_0 <= x"01";
            else
              mii_ctrl_0 <= x"00";
            end if;

          when others =>
        end case;

      when S_EOP =>
        case eop_in_o is
          when "000000" =>  if shift = "00" then
                              mii_ctrl_0 <= "11111110"; mii_ctrl_1 <= x"ff"; mii_ctrl_2 <= x"ff"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= x"07070707070707" & data_0_o(7 downto 0);
                              mii_data_1 <= LANE_IDLE; mii_data_2 <= LANE_IDLE; mii_data_3 <= LANE_IDLE;
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= "11111110"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= x"07070707070707" & data_0_o(7 downto 0); mii_data_3 <= LANE_IDLE;
                            end if;
          when "000001" =>  if shift = "00" then
                              mii_ctrl_0 <= "11111100"; mii_ctrl_1 <= x"ff"; mii_ctrl_2 <= x"ff"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= x"070707070707" & data_0_o(15 downto 0);
                              mii_data_1 <= LANE_IDLE; mii_data_2 <= LANE_IDLE; mii_data_3 <= LANE_IDLE;
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= "11111100"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= x"070707070707" & data_0_o(15 downto 0); mii_data_3 <= LANE_IDLE;
                            end if;
          when "000010" =>  if shift = "00" then
                              mii_ctrl_0 <= "11111000"; mii_ctrl_1 <= x"ff"; mii_ctrl_2 <= x"ff"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= x"0707070707" & data_0_o(23 downto 0);
                              mii_data_1 <= LANE_IDLE; mii_data_2 <= LANE_IDLE; mii_data_3 <= LANE_IDLE;
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= "11111000"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= x"0707070707" & data_0_o(23 downto 0); mii_data_3 <= LANE_IDLE;
                            end if;
          when "000011" =>  if shift = "00" then
                              mii_ctrl_0 <= "11110000"; mii_ctrl_1 <= x"ff"; mii_ctrl_2 <= x"ff"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= x"07070707" & data_0_o(31 downto 0);
                              mii_data_1 <= LANE_IDLE; mii_data_2 <= LANE_IDLE; mii_data_3 <= LANE_IDLE;
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= "11110000"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= x"07070707" & data_0_o(31 downto 0); mii_data_3 <= LANE_IDLE;
                            end if;
          when "000100" =>  if shift = "00" then
                              mii_ctrl_0 <= "11100000"; mii_ctrl_1 <= x"ff"; mii_ctrl_2 <= x"ff"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= x"070707" & data_0_o(39 downto 0);
                              mii_data_1 <= LANE_IDLE; mii_data_2 <= LANE_IDLE; mii_data_3 <= LANE_IDLE;
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= "11100000"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= x"070707" & data_0_o(39 downto 0); mii_data_3 <= LANE_IDLE;
                            end if;
          when "000101" =>  if shift = "00" then
                              mii_ctrl_0 <= "11000000"; mii_ctrl_1 <= x"ff"; mii_ctrl_2 <= x"ff"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= x"0707" & data_0_o(47 downto 0);
                              mii_data_1 <= LANE_IDLE; mii_data_2 <= LANE_IDLE; mii_data_3 <= LANE_IDLE;
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= "11000000"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= x"0707" & data_0_o(47 downto 0); mii_data_3 <= LANE_IDLE;
                            end if;
          when "000110" =>  if shift = "00" then
                              mii_ctrl_0 <= "10000000"; mii_ctrl_1 <= x"ff"; mii_ctrl_2 <= x"ff"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= x"07" & data_0_o(55 downto 0);
                              mii_data_1 <= LANE_IDLE; mii_data_2 <= LANE_IDLE; mii_data_3 <= LANE_IDLE;
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= "10000000"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= x"07" & data_0_o(55 downto 0); mii_data_3 <= LANE_IDLE;
                            end if;
          when "000111" =>  if shift = "00" then
                              mii_ctrl_0 <= "00000000"; mii_ctrl_1 <= x"ff"; mii_ctrl_2 <= x"ff"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= data_0_o(63 downto 0);
                              mii_data_1 <= LANE_IDLE; mii_data_2 <= LANE_IDLE; mii_data_3 <= LANE_IDLE;
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= "00000000"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= data_0_o(63 downto 0); mii_data_3 <= LANE_IDLE;
                            end if;
          ---------------------------------------------------------------------------------------------------------------
          when "001000" =>  if shift = "00" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= "11111110"; mii_ctrl_2 <= x"ff"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= data_0_o(63 downto 0); mii_data_1 <= x"07070707070707" & data_1_o(7 downto 0);
                              mii_data_2 <= LANE_IDLE; mii_data_3 <= LANE_IDLE;
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= "11111110";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= data_0_o; mii_data_3 <= x"07070707070707" & data_1_o(7 downto 0);
                            end if;
          when "001001" =>  if shift = "00" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= "11111100"; mii_ctrl_2 <= x"ff"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= data_0_o(63 downto 0); mii_data_1 <= x"070707070707" & data_1_o(15 downto 0);
                              mii_data_2 <= LANE_IDLE; mii_data_3 <= LANE_IDLE;
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= "11111100";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= data_0_o; mii_data_3 <= x"070707070707" & data_1_o(15 downto 0);
                            end if;
          when "001010" =>  if shift = "00" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= "11111000"; mii_ctrl_2 <= x"ff"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= data_0_o(63 downto 0); mii_data_1 <= x"0707070707" & data_1_o(23 downto 0);
                              mii_data_2 <= LANE_IDLE; mii_data_3 <= LANE_IDLE;
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= "11111000";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= data_0_o; mii_data_3 <= x"0707070707" & data_1_o(23 downto 0);
                            end if;
          when "001011" =>  if shift = "00" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= "11110000"; mii_ctrl_2 <= x"ff"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= data_0_o(63 downto 0); mii_data_1 <= x"07070707" & data_1_o(31 downto 0);
                              mii_data_2 <= LANE_IDLE; mii_data_3 <= LANE_IDLE;
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= "11110000";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= data_0_o; mii_data_3 <= x"07070707" & data_1_o(31 downto 0);
                            end if;
          when "001100" =>  if shift = "00" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= "11100000"; mii_ctrl_2 <= x"ff"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= data_0_o(63 downto 0); mii_data_1 <= x"070707" & data_1_o(39 downto 0);
                              mii_data_2 <= LANE_IDLE; mii_data_3 <= LANE_IDLE;
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= "11100000";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= data_0_o; mii_data_3 <= x"070707" & data_1_o(39 downto 0);
                            end if;
          when "001101" =>  if shift = "00" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= "11000000"; mii_ctrl_2 <= x"ff"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= data_0_o(63 downto 0); mii_data_1 <= x"0707" & data_1_o(47 downto 0);
                              mii_data_2 <= LANE_IDLE; mii_data_3 <= LANE_IDLE;
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= "11000000";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= data_0_o; mii_data_3 <= x"0707" & data_1_o(47 downto 0);
                            end if;
          when "001110" =>  if shift = "00" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= "10000000"; mii_ctrl_2 <= x"ff"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= data_0_o(63 downto 0); mii_data_1 <= x"07" & data_1_o(55 downto 0);
                              mii_data_2 <= LANE_IDLE; mii_data_3 <= LANE_IDLE;
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= "10000000";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= data_0_o; mii_data_3 <= x"07" & data_1_o(55 downto 0);
                            end if;
          when "001111" =>  if shift = "00" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= "00000000"; mii_ctrl_2 <= x"ff"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= data_0_o(63 downto 0); mii_data_1 <= data_1_o(63 downto 0);
                              mii_data_2 <= LANE_IDLE; mii_data_3 <= LANE_IDLE;
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= "00000000";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= data_0_o; mii_data_3 <= data_1_o(63 downto 0);
                            end if;
          ---------------------------------------------------------------------------------------------------------------
          when "010000" =>  if shift = "00" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= "11111110"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= data_0_o(63 downto 0); mii_data_1 <= data_1_o(63 downto 0);
                              mii_data_2 <= x"07070707070707" & data_2_o(7 downto 0); mii_data_3 <= LANE_IDLE;
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= x"00";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= data_0_o; mii_data_3 <= data_1_o;
                            end if;
          when "010001" =>  if shift = "00" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= "11111100"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= data_0_o(63 downto 0); mii_data_1 <= data_1_o(63 downto 0);
                              mii_data_2 <= x"070707070707" & data_2_o(15 downto 0); mii_data_3 <= LANE_IDLE;
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= x"00";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= data_0_o; mii_data_3 <= data_1_o;
                            end if;
          when "010010" =>  if shift = "00" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= "11111000"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= data_0_o(63 downto 0); mii_data_1 <= data_1_o(63 downto 0);
                              mii_data_2 <= x"0707070707" & data_2_o(23 downto 0); mii_data_3 <= LANE_IDLE;
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= x"00";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= data_0_o; mii_data_3 <= data_1_o;
                            end if;
          when "010011" =>  if shift = "00" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= "11110000"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= data_0_o(63 downto 0); mii_data_1 <= data_1_o(63 downto 0);
                              mii_data_2 <= x"07070707" & data_2_o(31 downto 0); mii_data_3 <= LANE_IDLE;
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= x"00";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= data_0_o; mii_data_3 <= data_1_o;
                            end if;
          when "010100" =>  if shift = "00" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= "11100000"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= data_0_o(63 downto 0); mii_data_1 <= data_1_o(63 downto 0);
                              mii_data_2 <= x"070707" & data_2_o(39 downto 0); mii_data_3 <= LANE_IDLE;
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= x"00";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= data_0_o; mii_data_3 <= data_1_o;
                            end if;
          when "010101" =>  if shift = "00" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= "11000000"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= data_0_o(63 downto 0); mii_data_1 <= data_1_o(63 downto 0);
                              mii_data_2 <= x"0707" & data_2_o(47 downto 0); mii_data_3 <= LANE_IDLE;
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= x"00";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= data_0_o; mii_data_3 <= data_1_o;
                            end if;
          when "010110" =>  if shift = "00" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= "10000000"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= data_0_o(63 downto 0); mii_data_1 <= data_1_o(63 downto 0);
                              mii_data_2 <= x"07" & data_2_o(55 downto 0); mii_data_3 <= LANE_IDLE;
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= x"00";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= data_0_o; mii_data_3 <= data_1_o;
                            end if;
          when "010111" =>  if shift = "00" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= "00000000"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= data_0_o(63 downto 0); mii_data_1 <= data_1_o(63 downto 0);
                              mii_data_2 <= data_2_o(63 downto 0); mii_data_3 <= LANE_IDLE;
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= x"00";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= data_0_o; mii_data_3 <= data_1_o;
                            end if;
          ---------------------------------------------------------------------------------------------------------------
          when "011000" =>  if shift = "00" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= "11111110";
                              mii_data_0 <= data_0_o(63 downto 0); mii_data_1 <= data_1_o(63 downto 0);
                              mii_data_2 <= data_2_o(63 downto 0); mii_data_3 <= x"07070707070707" & data_3_o(7 downto 0);
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= x"00";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= data_0_o; mii_data_3 <= data_1_o;
                            end if;
          when "011001" =>  if shift = "00" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= "11111100";
                              mii_data_0 <= data_0_o(63 downto 0); mii_data_1 <= data_1_o(63 downto 0);
                              mii_data_2 <= data_2_o(63 downto 0); mii_data_3 <= x"070707070707" & data_3_o(15 downto 0);
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= x"00";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= data_0_o; mii_data_3 <= data_1_o;
                            end if;
          when "011010" =>  if shift = "00" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= "11111000";
                              mii_data_0 <= data_0_o(63 downto 0); mii_data_1 <= data_1_o(63 downto 0);
                              mii_data_2 <= data_2_o(63 downto 0); mii_data_3 <= x"0707070707" & data_3_o(23 downto 0);
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= x"00";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= data_0_o; mii_data_3 <= data_1_o;
                            end if;
          when "011011" =>  if shift = "00" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= "11110000";
                              mii_data_0 <= data_0_o(63 downto 0); mii_data_1 <= data_1_o(63 downto 0);
                              mii_data_2 <= data_2_o(63 downto 0); mii_data_3 <= x"07070707" & data_3_o(31 downto 0);
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= x"00";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= data_0_o; mii_data_3 <= data_1_o;
                            end if;
          when "011100" =>  if shift = "00" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= "11100000";
                              mii_data_0 <= data_0_o(63 downto 0); mii_data_1 <= data_1_o(63 downto 0);
                              mii_data_2 <= data_2_o(63 downto 0); mii_data_3 <= x"070707" & data_3_o(39 downto 0);
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= x"00";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= data_0_o; mii_data_3 <= data_1_o;
                            end if;
          when "011101" =>  if shift = "00" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= "11000000";
                              mii_data_0 <= data_0_o(63 downto 0); mii_data_1 <= data_1_o(63 downto 0);
                              mii_data_2 <= data_2_o(63 downto 0); mii_data_3 <= x"0707" & data_3_o(47 downto 0);
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= x"00";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= data_0_o; mii_data_3 <= data_1_o;
                            end if;
          when "011110" =>  if shift = "00" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= "10000000";
                              mii_data_0 <= data_0_o(63 downto 0); mii_data_1 <= data_1_o(63 downto 0);
                              mii_data_2 <= data_2_o(63 downto 0); mii_data_3 <= x"07" & data_3_o(55 downto 0);
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= x"00";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= data_0_o; mii_data_3 <= data_1_o;
                            end if;
          when "011111" =>  if shift = "00" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= "00000000";
                              mii_data_0 <= data_0_o(63 downto 0); mii_data_1 <= data_1_o(63 downto 0);
                              mii_data_2 <= data_2_o(63 downto 0); mii_data_3 <= data_3_o(63 downto 0);
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= x"00";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= data_0_o; mii_data_3 <= data_1_o;
                            end if;

          when others =>
        end case;

      when S_ERROR =>
        mii_data_0 <= LANE_ERROR;
        mii_data_1 <= LANE_ERROR;
        mii_data_2 <= LANE_ERROR;
        mii_data_3 <= LANE_ERROR;
        mii_ctrl_0 <= x"fe";
        mii_ctrl_1 <= x"fe";
        mii_ctrl_2 <= x"fe";
        mii_ctrl_3 <= x"fe";

      --when S_SHIFTED_EOP =>

      when S_IPG =>
        if sop_in_o(1) = '0' then
          mii_data_0 <= LANE_IDLE;
          mii_data_1 <= LANE_IDLE;
          mii_data_2 <= LANE_IDLE;
          mii_data_3 <= LANE_IDLE;
          mii_ctrl_0 <= x"ff";
          mii_ctrl_1 <= x"ff";
          mii_ctrl_2 <= x"ff";
          mii_ctrl_3 <= x"ff";

        elsif sop_in_o = "10" then
          mii_data_0 <= LANE_IDLE;
          mii_data_1 <= LANE_IDLE;
          mii_data_2 <= data_0_o;
          mii_data_3 <= data_1_o;
          mii_ctrl_0 <= x"ff";
          mii_ctrl_1 <= x"ff";
          mii_ctrl_2 <= x"01";
          mii_ctrl_3 <= x"00";
          -- shift <= "01";

        elsif sop_in_o = "11" then
          mii_data_0 <= LANE_IDLE;
          mii_data_1 <= LANE_IDLE;
          mii_data_2 <= data_2_o;
          mii_data_3 <= data_3_o;
          mii_ctrl_0 <= x"ff";
          mii_ctrl_1 <= x"ff";
          mii_ctrl_2 <= x"01";
          mii_ctrl_3 <= x"00";

        end if;


      --when S_ADJUST_IPG =>

      --when S_WAIT_1C =>

      when others =>

    end case;
    end if;
  end process;

  REG_LANES: process (clk, rst)
  begin
    if rst = '0' then
      data_0_o <= (others =>'0');
      data_1_o <= (others =>'0');
      data_2_o <= (others =>'0');
      data_3_o <= (others =>'0');
      data_0_o_o <= (others =>'0');
      data_1_o_o <= (others =>'0');
      data_2_o_o <= (others =>'0');
      data_3_o_o <= (others =>'0');

    elsif clk'event and clk = '1' then
      data_0_o <= data_in(63 downto 0);
      data_1_o <= data_in(127 downto 64);
      data_2_o <= data_in(191 downto 128);
      data_3_o <= data_in(255 downto 192);
      eop_in_o  <= eop_in;
      sop_in_o  <= sop_in;

      data_0_o_o <= data_0_o;
      data_1_o_o <= data_1_o;
      data_2_o_o <= data_2_o;
      data_3_o_o <= data_3_o;
    else
    end if;
  end process;

end architecture;
