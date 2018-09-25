--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- BIP CHECKER MODULE
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_textio.all;
  use ieee.std_logic_arith.all;
  use ieee.numeric_std.all;
  use std.textio.all;

entity bip_calculator is
  port(
      clk          : in std_logic;
      rst          : in std_logic;
      data_in      : in std_logic_vector(63 downto 0);
      header_in    : in std_logic_vector( 1 downto 0);
      valid_in     : in std_logic;
      enable       : in std_logic;
      is_sync      : in std_logic;

      bip_ok       : out std_logic
      );
end entity;

architecture behav_bip_calculator of bip_calculator is
  signal first_alignment  : std_logic;
  signal first_BIP        : std_logic_vector(7 downto 0);
  signal bip_current      : std_logic_vector(7 downto 0);

  signal teste            :std_logic;
begin

  detect_alignment:process (clk, rst)
  begin
    if rst = '0' then
      first_alignment <= '0';

    elsif clk'event and clk = '1' then          -- detecta o 1º alinhamento
      if  is_sync = '1' then
        first_alignment <= '1';
      end if;

    end if;
  end process;


  take_first_BIP:process (clk, rst)
  begin
    if rst = '0' then
      first_BIP <= (others => '0');

    elsif clk'event and clk = '1' then
      if  is_sync = '1' and first_alignment = '0' then
        first_BIP <= data_in(39 downto 32);    -- captura 1º BIP para poder começar a calcular
      end if;

    end if;
  end process;



calc_bip: process (clk, rst)
begin
  if rst = '0' then
    bip_current <= (others => '0');
    teste <= '0';

  elsif clk'event and clk = '1' then
    if  enable = '1' and is_sync = '1' and valid_in = '1' then
      -- Calculo do BIP
      bip_current(7) <= ( data_in(56) xor data_in(48) xor data_in(40) xor data_in(32) xor
                          data_in(24) xor data_in(16) xor data_in( 8) xor data_in( 0));
      bip_current(6) <= ( data_in(57) xor data_in(49) xor data_in(41) xor data_in(33) xor
                          data_in(25) xor data_in(17) xor data_in( 9) xor data_in( 1));
      bip_current(5) <= ( data_in(58) xor data_in(50) xor data_in(42) xor data_in(34) xor
                          data_in(26) xor data_in(18) xor data_in(10) xor data_in( 2));
      bip_current(4) <= ( data_in(59) xor data_in(51) xor data_in(43) xor data_in(35) xor
                          data_in(27) xor data_in(19) xor data_in(11) xor data_in( 3) xor header_in(0));
      bip_current(3) <= ( data_in(60) xor data_in(52) xor data_in(44) xor data_in(36) xor
                          data_in(28) xor data_in(20) xor data_in(12) xor data_in( 4) xor header_in(1));
      bip_current(2) <= ( data_in(61) xor data_in(53) xor data_in(45) xor data_in(37) xor
                          data_in(29) xor data_in(21) xor data_in(13) xor data_in( 5));
      bip_current(1) <= ( data_in(62) xor data_in(54) xor data_in(46) xor data_in(38) xor
                          data_in(30) xor data_in(22) xor data_in(14) xor data_in( 6));
      bip_current(0) <= ( data_in(63) xor data_in(55) xor data_in(47) xor data_in(39) xor
                          data_in(31) xor data_in(23) xor data_in(15) xor data_in( 7));

    elsif enable = '1' and first_alignment = '1' and valid_in = '1' and is_sync = '0'  then
      bip_current(7) <= ( bip_current(7)  xor data_in(56) xor data_in(48) xor data_in(40) xor data_in(32)
                                          xor data_in(24) xor data_in(16) xor data_in( 8) xor data_in( 0));
      bip_current(6) <= ( bip_current(6)  xor data_in(57) xor data_in(49) xor data_in(41) xor data_in(33)
                                          xor data_in(25) xor data_in(17) xor data_in( 9) xor data_in( 1));
      bip_current(5) <= ( bip_current(5)  xor data_in(58) xor data_in(50) xor data_in(42) xor data_in(34)
                                          xor data_in(26) xor data_in(18) xor data_in(10) xor data_in( 2));
      bip_current(4) <= ( bip_current(4)  xor data_in(59) xor data_in(51) xor data_in(43) xor data_in(35)
                                          xor data_in(27) xor data_in(19) xor data_in(11) xor data_in( 3) xor header_in(0));
      bip_current(3) <= ( bip_current(3)  xor data_in(60) xor data_in(52) xor data_in(44) xor data_in(36)
                                          xor data_in(28) xor data_in(20) xor data_in(12) xor data_in( 4) xor header_in(1));
      bip_current(2) <= ( bip_current(2)  xor data_in(61) xor data_in(53) xor data_in(45) xor data_in(37)
                                          xor data_in(29) xor data_in(21) xor data_in(13) xor data_in( 5));
      bip_current(1) <= ( bip_current(1)  xor data_in(62) xor data_in(54) xor data_in(46) xor data_in(38)
                                          xor data_in(30) xor data_in(22) xor data_in(14) xor data_in( 6));
      bip_current(0) <= ( bip_current(0)  xor data_in(63) xor data_in(55) xor data_in(47) xor data_in(39)
                                          xor data_in(31) xor data_in(23) xor data_in(15) xor data_in( 7));

    end if;

  end if;
end process;


  bip_ok <= '1' when (bip_current = data_in(39 downto 32) and is_sync = '1')
            else '0';

end behav_bip_calculator;
