--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- BIP CHECKER MODULE
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
library ieee;
use ieee.std_logic_1164.all;
entity bip_calculator is
  port(
      clk          : in std_logic;
      rst          : in std_logic;
      data_in      : in std_logic_vector(63 downto 0);
      header_in    : in std_logic_vector(1 downto 0);

      enable       : in std_logic;
      is_sync      : in std_logic;
      bip_ok       : out std_logic
      );
end entity;
architecture behav_bip_calculator of bip_calculator is
  signal  bip           :std_logic_vector(7 downto 0);
  signal  bip_old       :std_logic_vector(7 downto 0):= (others=>'0');
begin

  --  Registrador para o sinal bip_old
  reg_bip_old:  entity work.regnbit generic map (size=>8) port map (ck=>clk, rst=>rst, ce=>'1', D=>bip, Q=>bip_old);

  --  Calcula o BIP quando is_sync=0
  bip(0) <= (bip_old(0) xor data_in(0) xor data_in(8)  xor data_in(16) xor data_in(24)
                        xor data_in(32) xor data_in(40) xor data_in(48) xor data_in(56))
             when (is_sync = '0')
             else bip(0);

  bip(1) <= (bip_old(1) xor data_in(1) xor data_in(9)  xor data_in(17) xor data_in(25)
                        xor data_in(33) xor data_in(41) xor data_in(49) xor data_in(57))
            when is_sync = '0'
            else bip(1);

  bip(2) <= (bip_old(2) xor data_in(2) xor data_in(10) xor data_in(18) xor data_in(26)
                        xor data_in(34) xor data_in(42) xor data_in(50) xor data_in(58))
            when is_sync = '0'
            else bip(2);

  bip(3) <= (bip_old(3) xor data_in(3) xor data_in(11) xor data_in(19) xor data_in(27)
                        xor data_in(35) xor data_in(43) xor data_in(51) xor data_in(59) xor header_in(0))
            when is_sync = '0'
            else bip(3);

  bip(4) <= (bip_old(4) xor data_in(4) xor data_in(12) xor data_in(20) xor data_in(28)
                        xor data_in(36) xor data_in(44) xor data_in(52) xor data_in(60) xor header_in(1))
            when is_sync = '0'
            else bip(4);

  bip(5) <= (bip_old(5) xor data_in(5) xor data_in(13) xor data_in(21) xor data_in(29)
                        xor data_in(37) xor data_in(45) xor data_in(53) xor data_in(61))
            when is_sync = '0'
            else bip(5);

  bip(6) <= (bip_old(6) xor data_in(6) xor data_in(14) xor data_in(22) xor data_in(30)
                        xor data_in(38) xor data_in(46) xor data_in(54) xor data_in(62))
            when is_sync = '0'
            else bip(6);

  bip(7) <= (bip_old(7) xor data_in(7) xor data_in(15) xor data_in(23) xor data_in(31)
                        xor data_in(39) xor data_in(47) xor data_in(55) xor data_in(63))
            when is_sync = '0'
            else bip(7);

  bip_ok <= '1' when (bip = data_in(39 downto 32) and (not bip) = data_in(7 downto 0))
            else '0';

end behav_bip_calculator;
