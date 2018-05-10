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
  signal mii_ctrl_s0  : std_logic_vector(7 downto 0):= CODE_ERROR;
  signal mii_ctrl_s1  : std_logic_vector(7 downto 0):= CODE_ERROR;
  signal mii_ctrl_s2  : std_logic_vector(7 downto 0):= CODE_ERROR;
  signal mii_ctrl_s3  : std_logic_vector(7 downto 0):= CODE_ERROR;
  signal mii_data_s0  : std_logic_vector(63 downto 0):=LANE_ERROR;
  signal mii_data_s1  : std_logic_vector(63 downto 0):=LANE_ERROR;
  signal mii_data_s2  : std_logic_vector(63 downto 0):=LANE_ERROR;
  signal mii_data_s3  : std_logic_vector(63 downto 0):=LANE_ERROR;
  signal ren_int      : std_logic;

  begin

    ren_out <= '0' when almost_e = '1' and eop_in(5) = '0' else '1';

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


    set_ctrl_mii: process (clk,rst)
    begin
      if rst = '0' then
        mii_ctrl_s0 <= CODE_ERROR;
        mii_ctrl_s1 <= CODE_ERROR;
        mii_ctrl_s2 <= CODE_ERROR;
        mii_ctrl_s3 <= CODE_ERROR;

      elsif clk 'event and clk = '1' then
        if ren_int = '1' and val_in = '1' and sop_in = "10" and eop_in = "100000" then
          mii_ctrl_s0 <= x"01";
          mii_ctrl_s1 <= x"00";
          mii_ctrl_s2 <= x"00";
          mii_ctrl_s3 <= x"00";
          mii_data_s0 <= data_in(63 downto 0);
          mii_data_s1 <= data_in(127 downto 64);
          mii_data_s2 <= data_in(191 downto 128);
          mii_data_s3 <= data_in(255 downto 192);

        elsif ren_int = '1' and val_in = '1' and sop_in = "11" and eop_in = "100000" then
          mii_ctrl_s0 <= CODE_CTRL_IDLE;
          mii_ctrl_s1 <= CODE_CTRL_IDLE;
          mii_ctrl_s2 <= x"01";
          mii_ctrl_s3 <= x"00";
          mii_data_s0 <= LANE_IDLE;
          mii_data_s1 <= LANE_IDLE;
          mii_data_s2 <= data_in(191 downto 128);
          mii_data_s3 <= data_in(255 downto 192);

        elsif ren_int = '1' and val_in = '1' and (sop_in /= "10" and sop_in /= "11") and eop_in = "100000" then
          mii_ctrl_s0 <= x"00";
          mii_ctrl_s1 <= x"00";
          mii_ctrl_s2 <= x"00";
          mii_ctrl_s3 <= x"00";
          mii_data_s0 <= data_in(63 downto 0);
          mii_data_s1 <= data_in(127 downto 64);
          mii_data_s2 <= data_in(191 downto 128);
          mii_data_s3 <= data_in(255 downto 192);

        elsif ren_int = '1' and val_in = '1' and (sop_in /= "10" and sop_in /= "11") and eop_in /= "100000" then

          case eop_in is

            when "000000" =>  mii_ctrl_s0 <= "11111110"; mii_ctrl_s1 <= x"ff"; mii_ctrl_s2 <= x"ff"; mii_ctrl_s3 <= x"ff";
                              mii_data_s0 <= x"07070707070707" & data_in(7 downto 0);
                              mii_data_s1 <= LANE_IDLE; mii_data_s2 <= LANE_IDLE; mii_ctrl_s3 <= LANE_IDLE;
            when "000001" =>  mii_ctrl_s0 <= "11111100"; mii_ctrl_s1 <= x"ff"; mii_ctrl_s2 <= x"ff"; mii_ctrl_s3 <= x"ff";
                              mii_data_s0 <= x"070707070707" & data_in(15 downto 0);
                              mii_data_s1 <= LANE_IDLE; mii_data_s2 <= LANE_IDLE; mii_data_s3 <= LANE_IDLE;
            when "000010" =>  mii_ctrl_s0 <= "11111000"; mii_ctrl_s1 <= x"ff"; mii_ctrl_s2 <= x"ff"; mii_ctrl_s3 <= x"ff";
                              mii_data_s0 <= x"0707070707" & data_in(23 downto 0);
                              mii_data_s1 <= LANE_IDLE; mii_data_s2 <= LANE_IDLE; mii_data_s3 <= LANE_IDLE;
            when "000011" =>  mii_ctrl_s0 <= "11110000"; mii_ctrl_s1 <= x"ff"; mii_ctrl_s2 <= x"ff"; mii_ctrl_s3 <= x"ff";
                              mii_data_s0 <= x"07070707" & data_in(31 downto 0);
                              mii_data_s1 <= LANE_IDLE; mii_data_s2 <= LANE_IDLE; mii_data_s3 <= LANE_IDLE;
            when "000100" =>  mii_ctrl_s0 <= "11100000"; mii_ctrl_s1 <= x"ff"; mii_ctrl_s2 <= x"ff"; mii_ctrl_s3 <= x"ff";
                              mii_data_s0 <= x"070707" & data_in(39 downto 0);
                              mii_data_s1 <= LANE_IDLE; mii_data_s2 <= LANE_IDLE; mii_data_s3 <= LANE_IDLE;
            when "000101" =>  mii_ctrl_s0 <= "11000000"; mii_ctrl_s1 <= x"ff"; mii_ctrl_s2 <= x"ff"; mii_ctrl_s3 <= x"ff";
                              mii_data_s0 <= x"0707" & data_in(47 downto 0);
                              mii_data_s1 <= LANE_IDLE; mii_data_s2 <= LANE_IDLE; mii_data_s3 <= LANE_IDLE;
            when "000110" =>  mii_ctrl_s0 <= "10000000"; mii_ctrl_s1 <= x"ff"; mii_ctrl_s2 <= x"ff"; mii_ctrl_s3 <= x"ff";
                              mii_data_s0 <= x"07" & data_in(55 downto 0);
                              mii_data_s1 <= LANE_IDLE; mii_data_s2 <= LANE_IDLE; mii_data_s3 <= LANE_IDLE;
            when "000111" =>  mii_ctrl_s0 <= "00000000"; mii_ctrl_s1 <= x"ff"; mii_ctrl_s2 <= x"ff"; mii_ctrl_s3 <= x"ff";
                              mii_data_s0 <= data_in(63 downto 0);
                              mii_data_s1 <= LANE_IDLE; mii_data_s2 <= LANE_IDLE; mii_data_s3 <= LANE_IDLE;

            when "001000" =>  mii_ctrl_s1 <= "11111110"; mii_ctrl_s0 <= x"00"; mii_ctrl_s2 <= x"ff"; mii_ctrl_s3 <= x"ff";
                              mii_data_s0 <= data_in(63 downto 0); mii_data_s1 <= x"07070707070707" & data_in(71 downto 64);
                              mii_data_s2 <= LANE_IDLE; mii_data_s3 <= LANE_IDLE;
            when "001001" =>  mii_ctrl_s1 <= "11111100"; mii_ctrl_s0 <= x"00"; mii_ctrl_s2 <= x"ff"; mii_ctrl_s3 <= x"ff";
                              mii_data_s0 <= data_in(63 downto 0); mii_data_s1 <= x"070707070707" & data_in(79 downto 64);
                              mii_data_s2 <= LANE_IDLE; mii_data_s3 <= LANE_IDLE;
            when "001010" =>  mii_ctrl_s1 <= "11111000"; mii_ctrl_s0 <= x"00"; mii_ctrl_s2 <= x"ff"; mii_ctrl_s3 <= x"ff";
                              mii_data_s0 <= data_in(63 downto 0); mii_data_s1 <= x"0707070707" & data_in(87 downto 64);
                              mii_data_s2 <= LANE_IDLE; mii_data_s3 <= LANE_IDLE;
            when "001011" =>  mii_ctrl_s1 <= "11110000"; mii_ctrl_s0 <= x"00"; mii_ctrl_s2 <= x"ff"; mii_ctrl_s3 <= x"ff";
                              mii_data_s0 <= data_in(63 downto 0); mii_data_s1 <= x"07070707" & data_in(95 downto 64);
                              mii_data_s2 <= LANE_IDLE; mii_data_s3 <= LANE_IDLE;
            when "001100" =>  mii_ctrl_s1 <= "11100000"; mii_ctrl_s0 <= x"00"; mii_ctrl_s2 <= x"ff"; mii_ctrl_s3 <= x"ff";
                              mii_data_s0 <= data_in(63 downto 0); mii_data_s1 <= x"070707" & data_in(103 downto 64);
                              mii_data_s2 <= LANE_IDLE; mii_data_s3 <= LANE_IDLE;
            when "001101" =>  mii_ctrl_s1 <= "11000000"; mii_ctrl_s0 <= x"00"; mii_ctrl_s2 <= x"ff"; mii_ctrl_s3 <= x"ff";
                              mii_data_s0 <= data_in(63 downto 0); mii_data_s1 <= x"0707" & data_in(111 downto 64);
                              mii_data_s2 <= LANE_IDLE; mii_data_s3 <= LANE_IDLE;
            when "001110" =>  mii_ctrl_s1 <= "10000000"; mii_ctrl_s0 <= x"00"; mii_ctrl_s2 <= x"ff"; mii_ctrl_s3 <= x"ff";
                              mii_data_s0 <= data_in(63 downto 0); mii_data_s1 <= x"07" & data_in(119 downto 64);
                              mii_data_s2 <= LANE_IDLE; mii_data_s3 <= LANE_IDLE;
            when "001111" =>  mii_ctrl_s1 <= "00000000"; mii_ctrl_s0 <= x"00"; mii_ctrl_s2 <= x"ff"; mii_ctrl_s3 <= x"ff";
                              mii_data_s0 <= data_in(63 downto 0); mii_data_s1 <= data_in(127 downto 64);
                              mii_data_s2 <= LANE_IDLE; mii_data_s3 <= LANE_IDLE;

            when "010000" =>  mii_ctrl_s2 <= "11111110"; mii_ctrl_s0 <= x"00"; mii_ctrl_s1 <= x"00"; mii_ctrl_s3 <= x"ff";
                              mii_data_s0 <= data_in(63 downto 0); mii_data_s1 <= data_in(127 downto 64);
                              mii_data_s2 <= x"07070707070707" & data_in(135 downto 128); mii_data_s3 <= LANE_IDLE;
            when "010001" =>  mii_ctrl_s2 <= "11111100"; mii_ctrl_s0 <= x"00"; mii_ctrl_s1 <= x"00"; mii_ctrl_s3 <= x"ff";
                              mii_data_s0 <= data_in(63 downto 0); mii_data_s1 <= data_in(127 downto 64);
                              mii_data_s2 <= x"070707070707" & data_in(143 downto 128); mii_data_s3 <= LANE_IDLE;
            when "010010" =>  mii_ctrl_s2 <= "11111000"; mii_ctrl_s0 <= x"00"; mii_ctrl_s1 <= x"00"; mii_ctrl_s3 <= x"ff";
                              mii_data_s0 <= data_in(63 downto 0); mii_data_s1 <= data_in(127 downto 64);
                              mii_data_s2 <= x"0707070707" & data_in(151 downto 128); mii_data_s3 <= LANE_IDLE;
            when "010011" =>  mii_ctrl_s2 <= "11110000"; mii_ctrl_s0 <= x"00"; mii_ctrl_s1 <= x"00"; mii_ctrl_s3 <= x"ff";
                              mii_data_s0 <= data_in(63 downto 0); mii_data_s1 <= data_in(127 downto 64);
                              mii_data_s2 <= x"07070707" & data_in(159 downto 128); mii_data_s3 <= LANE_IDLE;
            when "010100" =>  mii_ctrl_s2 <= "11100000"; mii_ctrl_s0 <= x"00"; mii_ctrl_s1 <= x"00"; mii_ctrl_s3 <= x"ff";
                              mii_data_s0 <= data_in(63 downto 0); mii_data_s1 <= data_in(127 downto 64);
                              mii_data_s2 <= x"070707" & data_in(167 downto 128); mii_data_s3 <= LANE_IDLE;
            when "010101" =>  mii_ctrl_s2 <= "11000000"; mii_ctrl_s0 <= x"00"; mii_ctrl_s1 <= x"00"; mii_ctrl_s3 <= x"ff";
                              mii_data_s0 <= data_in(63 downto 0); mii_data_s1 <= data_in(127 downto 64);
                              mii_data_s2 <= x"0707" & data_in(175 downto 128); mii_data_s3 <= LANE_IDLE;
            when "010110" =>  mii_ctrl_s2 <= "10000000"; mii_ctrl_s0 <= x"00"; mii_ctrl_s1 <= x"00"; mii_ctrl_s3 <= x"ff";
                              mii_data_s0 <= data_in(63 downto 0); mii_data_s1 <= data_in(127 downto 64);
                              mii_data_s2 <= x"07" & data_in(183 downto 128); mii_data_s3 <= LANE_IDLE;
            when "010111" =>  mii_ctrl_s2 <= "00000000"; mii_ctrl_s0 <= x"00"; mii_ctrl_s1 <= x"00"; mii_ctrl_s3 <= x"ff";
                              mii_data_s0 <= data_in(63 downto 0);    mii_data_s1 <= data_in(127 downto 64);
                              mii_data_s2 <= data_in(191 downto 128); mii_data_s3 <= LANE_IDLE;

            when "011000" =>  mii_ctrl_s3 <= "11111110"; mii_ctrl_s0 <= x"00"; mii_ctrl_s1 <= x"00"; mii_ctrl_s2 <= x"00";
                              mii_data_s0 <= data_in(63 downto 0);    mii_data_s1 <= data_in(127 downto 64);
                              mii_data_s2 <= data_in(191 downto 128); mii_data_s3 <= x"07070707070707" & data_in(199 downto 192);
            when "011001" =>  mii_ctrl_s3 <= "11111100"; mii_ctrl_s0 <= x"00"; mii_ctrl_s1 <= x"00"; mii_ctrl_s2 <= x"00";
                              mii_data_s0 <= data_in(63 downto 0);    mii_data_s1 <= data_in(127 downto 64);
                              mii_data_s2 <= data_in(191 downto 128); mii_data_s3 <= x"070707070707" & data_in(207 downto 192);
            when "011010" =>  mii_ctrl_s3 <= "11111000"; mii_ctrl_s0 <= x"00"; mii_ctrl_s1 <= x"00"; mii_ctrl_s2 <= x"00";
                              mii_data_s0 <= data_in(63 downto 0);    mii_data_s1 <= data_in(127 downto 64);
                              mii_data_s2 <= data_in(191 downto 128); mii_data_s3 <= x"0707070707" & data_in(215 downto 192);
            when "011011" =>  mii_ctrl_s3 <= "11110000"; mii_ctrl_s0 <= x"00"; mii_ctrl_s1 <= x"00"; mii_ctrl_s2 <= x"00";
                              mii_data_s0 <= data_in(63 downto 0);    mii_data_s1 <= data_in(127 downto 64);
                              mii_data_s2 <= data_in(191 downto 128); mii_data_s3 <= x"07070707" & data_in(223 downto 192);
            when "011100" =>  mii_ctrl_s3 <= "11100000"; mii_ctrl_s0 <= x"00"; mii_ctrl_s1 <= x"00"; mii_ctrl_s2 <= x"00";
                              mii_data_s0 <= data_in(63 downto 0);    mii_data_s1 <= data_in(127 downto 64);
                              mii_data_s2 <= data_in(191 downto 128); mii_data_s3 <= x"070707" & data_in(231 downto 192);
            when "011101" =>  mii_ctrl_s3 <= "11000000"; mii_ctrl_s0 <= x"00"; mii_ctrl_s1 <= x"00"; mii_ctrl_s2 <= x"00";
                              mii_data_s0 <= data_in(63 downto 0);    mii_data_s1 <= data_in(127 downto 64);
                              mii_data_s2 <= data_in(191 downto 128); mii_data_s3 <= x"0707" & data_in(239 downto 192);
            when "011110" =>  mii_ctrl_s3 <= "10000000"; mii_ctrl_s0 <= x"00"; mii_ctrl_s1 <= x"00"; mii_ctrl_s2 <= x"00";
                              mii_data_s0 <= data_in(63 downto 0);    mii_data_s1 <= data_in(127 downto 64);
                              mii_data_s2 <= data_in(191 downto 128); mii_data_s3 <= x"07" & data_in(247 downto 192);
            when "011111" =>  mii_ctrl_s3 <= "00000000"; mii_ctrl_s0 <= x"00"; mii_ctrl_s1 <= x"00"; mii_ctrl_s2 <= x"00";
                              mii_data_s0 <= data_in(63 downto 0);    mii_data_s1 <= data_in(127 downto 64);
                              mii_data_s2 <= data_in(191 downto 128); mii_data_s3 <= data_in(247 downto 192);

            when others   =>  mii_ctrl_s0 <= CODE_ERROR;
                              mii_ctrl_s1 <= CODE_ERROR;
                              mii_ctrl_s2 <= CODE_ERROR;
                              mii_ctrl_s3 <= CODE_ERROR;
                              mii_data_s0 <= LANE_ERROR;
                              mii_data_s1 <= LANE_ERROR;
                              mii_data_s2 <= LANE_ERROR;
                              mii_data_s3 <= LANE_ERROR;
          end case;

      elsif ren_int = '1' and val_in = '1' and (sop_in = "11" or sop_in = "10") and eop_in /= "100000" then -- ERROR
          mii_ctrl_s0 <= CODE_ERROR;
          mii_ctrl_s1 <= CODE_ERROR;
          mii_ctrl_s2 <= CODE_ERROR;
          mii_ctrl_s3 <= CODE_ERROR;
          mii_data_s0 <= LANE_ERROR;
          mii_data_s1 <= LANE_ERROR;
          mii_data_s2 <= LANE_ERROR;
          mii_data_s3 <= LANE_ERROR;

        else
          mii_ctrl_s0 <= CODE_CTRL_IDLE;
          mii_ctrl_s1 <= CODE_CTRL_IDLE;
          mii_ctrl_s2 <= CODE_CTRL_IDLE;
          mii_ctrl_s3 <= CODE_CTRL_IDLE;
          mii_data_s0 <= LANE_IDLE;
          mii_data_s1 <= LANE_IDLE;
          mii_data_s2 <= LANE_IDLE;
          mii_data_s3 <= LANE_IDLE;
        end if; -- atribuições do controle no mii

      end if;   -- rst, clk
    end process;

    -- connecting the internals signal with the OUTPUTS
    mii_ctrl_0 <= mii_ctrl_s0;
    mii_ctrl_1 <= mii_ctrl_s1;
    mii_ctrl_2 <= mii_ctrl_s2;
    mii_ctrl_3 <= mii_ctrl_s3;
    mii_data_0 <= mii_data_s0;
    mii_data_1 <= mii_data_s1;
    mii_data_2 <= mii_data_s2;
    mii_data_3 <= mii_data_s3;

end architecture;
