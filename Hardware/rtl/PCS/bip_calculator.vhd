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
      data_in      : in std_logic_vector(0 to 63);
      header_in    : in std_logic_vector(0 to 1);

      enable       : in std_logic;
      is_sync      : in std_logic;
      bip_ok       : out std_logic
      );
end entity;

architecture behav_bip_calculator of bip_calculator is
  signal bip_out         :std_logic_vector(7 downto 0):= (others=>'0');
  signal bip_out_old     :std_logic_vector(7 downto 0):= (others=>'0');

  signal sync_block_old     :std_logic_vector(0 to 63):= (others=>'0');
  signal sync_block_old_old :std_logic_vector(0 to 63):= (others=>'0');
  signal sync_hdr_old       :std_logic_vector(0 to 1):= (others=>'0');
  signal sync_hdr_old_old   :std_logic_vector(0 to 1):= (others=>'0');

  signal last_bip        :std_logic_vector(7 downto 0):= (others=>'0');

  signal reg_calc_en      :std_logic;
  signal bip_calc_mux     :std_logic_vector(7 downto 0);

begin

  --  Registrador para o sinal bip_out_old
  reg_bip_calc_old:   entity work.regnbit generic map (size=>8) port map (ck=>clk, rst=>rst, ce=>'1', D=>bip_calc_mux, Q=>bip_out_old);

  bip_calc_mux <= bip_out when is_sync = '0' else (others=>'0');

  --  Registrador para o sinal sync_block_old
  reg_bip3_old:       entity work.regnbit generic map (size=>64) port map (ck=>is_sync, rst=>rst, ce=>'1', D=>data_in, Q=>sync_block_old);
  --  Registrador para o sinal sync_block_old_old
  reg_bip3_old_old:   entity work.regnbit generic map (size=>64) port map (ck=>is_sync, rst=>rst, ce=>'1', D=>sync_block_old, Q=>sync_block_old_old);

  --  Registrador para o sinal sync_block_old
  reg_bip3_hdr_old:       entity work.regnbit generic map (size=>2) port map (ck=>is_sync, rst=>rst, ce=>'1', D=>header_in, Q=>sync_hdr_old);
  --  Registrador para o sinal sync_block_old_old
  reg_bip3_hdr_old_old:   entity work.regnbit generic map (size=>2) port map (ck=>is_sync, rst=>rst, ce=>'1', D=>sync_hdr_old, Q=>sync_hdr_old_old);

  --  Calcula o BIP quando is_sync=0
  bip_out(0) <= ( bip_out_old(7)  xor data_in(0)  xor data_in(8)  xor data_in(16) xor data_in(24)
                                    xor data_in(32) xor data_in(40) xor data_in(48) xor data_in(56));

  bip_out(1) <= ( bip_out_old(6)  xor data_in(1)  xor data_in(9)  xor data_in(17) xor data_in(25)
                                    xor data_in(33) xor data_in(41) xor data_in(49) xor data_in(57));

  bip_out(2) <= ( bip_out_old(5)  xor data_in(2)  xor data_in(10) xor data_in(18) xor data_in(26)
                                    xor data_in(34) xor data_in(42) xor data_in(50) xor data_in(58));

  bip_out(3) <= ( bip_out_old(4)  xor data_in(3)   xor data_in(11) xor data_in(19) xor data_in(27)
                                    xor data_in(35)  xor data_in(43) xor data_in(51) xor data_in(59) xor header_in(1));

  bip_out(4) <= ( bip_out_old(3)  xor data_in(4)   xor data_in(12) xor data_in(20) xor data_in(28)
                                    xor data_in(36)  xor data_in(44) xor data_in(52) xor data_in(60) xor header_in(0));

  bip_out(5) <= ( bip_out_old(2)  xor data_in(5)   xor data_in(13) xor data_in(21) xor data_in(29)
                                    xor data_in(37)  xor data_in(45) xor data_in(53) xor data_in(61));

  bip_out(6) <= ( bip_out_old(1)  xor data_in(6)   xor data_in(14) xor data_in(22) xor data_in(30)
                                    xor data_in(38)  xor data_in(46) xor data_in(54) xor data_in(62));

  bip_out(7) <= ( bip_out_old(0)  xor data_in(7)   xor data_in(15) xor data_in(23) xor data_in(31)
                                    xor data_in(39)  xor data_in(47) xor data_in(55) xor data_in(63));


  last_bip(7) <= ( bip_out_old(7)  xor sync_block_old_old(0)  xor sync_block_old_old(8)  xor sync_block_old_old(16) xor sync_block_old_old(24)
                                    xor sync_block_old_old(32) xor sync_block_old_old(40) xor sync_block_old_old(48) xor sync_block_old_old(56));

  last_bip(6) <= ( bip_out_old(6)  xor sync_block_old_old(1)  xor sync_block_old_old(9)  xor sync_block_old_old(17) xor sync_block_old_old(25)
                                    xor sync_block_old_old(33) xor sync_block_old_old(41) xor sync_block_old_old(49) xor sync_block_old_old(57));

  last_bip(5) <= ( bip_out_old(5)  xor sync_block_old_old(2)  xor sync_block_old_old(10) xor sync_block_old_old(18) xor sync_block_old_old(26)
                                    xor sync_block_old_old(34) xor sync_block_old_old(42) xor sync_block_old_old(50) xor sync_block_old_old(58));

  last_bip(4) <= ( bip_out_old(4)  xor sync_block_old_old(3)   xor sync_block_old_old(11) xor sync_block_old_old(19) xor sync_block_old_old(27)
                                    xor sync_block_old_old(35)  xor sync_block_old_old(43) xor sync_block_old_old(51) xor sync_block_old_old(59) xor sync_hdr_old_old(0));

  last_bip(3) <= ( bip_out_old(3)  xor sync_block_old_old(4)   xor sync_block_old_old(12) xor sync_block_old_old(20) xor sync_block_old_old(28)
                                    xor sync_block_old_old(36)  xor sync_block_old_old(44) xor sync_block_old_old(52) xor sync_block_old_old(60) xor sync_hdr_old_old(1));

  last_bip(2) <= ( bip_out_old(2)  xor sync_block_old_old(5)   xor sync_block_old_old(13) xor sync_block_old_old(21) xor sync_block_old_old(29)
                                    xor sync_block_old_old(37)  xor sync_block_old_old(45) xor sync_block_old_old(53) xor sync_block_old_old(61));

  last_bip(1) <= ( bip_out_old(1)  xor sync_block_old_old(6)   xor sync_block_old_old(14) xor sync_block_old_old(22) xor sync_block_old_old(30)
                                    xor sync_block_old_old(38)  xor sync_block_old_old(46) xor sync_block_old_old(54) xor sync_block_old_old(62));

  last_bip(0) <= ( bip_out_old(0)  xor sync_block_old_old(7)   xor sync_block_old_old(15) xor sync_block_old_old(23) xor sync_block_old_old(31)
                                    xor sync_block_old_old(39)  xor sync_block_old_old(47) xor sync_block_old_old(55) xor sync_block_old_old(63));

  -- seta o valor BIP esta OK
  bip_ok <= '1' when (last_bip = data_in(24 to 31)) else '0';

end behav_bip_calculator;
