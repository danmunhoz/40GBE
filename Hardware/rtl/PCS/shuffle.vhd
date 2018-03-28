library ieee;
use ieee.std_logic_1164.all;

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- SWITCH MODULE
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--   CIRCUITO :
--
--    a_in  +-------------+  a_out
--   -------+   switch    +--------
--    b_in  |             |  b_out
--   -------+             +--------
--          +------+------+
--                 |
--                ctr
--
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
library IEEE;
use IEEE.std_logic_1164.all;

entity switch is
  generic(
  size : integer := 67 );
  port(
         a_in  : in  std_logic_vector (size-1 downto 0);
         b_in  : in  std_logic_vector (size-1 downto 0);
         a_out : out std_logic_vector (size-1 downto 0);
         b_out : out std_logic_vector (size-1 downto 0);
         ctr   : in  std_logic
      );
end switch;
architecture switch_arch of switch is
begin
  a_out <= a_in when ctr = '0' else b_in;
  b_out <= b_in when ctr = '0' else a_in;
end switch_arch;

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Rede Shuffle
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--
--
--   CIRCUITO:
--
--    in_0  +----------+  k            +----------+  o              +----------+   out_0
--   -------+   SH0    +——-------------+   SH2    +——---------------+   SH4    +——----
--    in_1  |          |  l            |          |  p              |          |   out_1
--   -------+          +--+       +----+          +----+       +----+          +-------
--          +----+-----+   \     /     +----+-----+     \     /     +----+-----+
--               |          \   /           |            \   /           |
--             str[0]        \ /          str[2]          \ /          str[4]
--                         X                            X
--    in_2  +----------+  m  / \       +----------+  q    / \       +----------+   out_2
--   -------+   SH1    +——--+   +------+   SH3    +——----+   +------+   SH5    +——----
--    in_3  |          |  n            |          |  r              |          |   out_3
--   -------+          +---------------+          +-----------------+          +-------
--          +----+-----+               +----+-----+                 +----+-----+
--               |                          |                             |
--             str[1]                     str[3]                        str[5]
--
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

library IEEE;
use IEEE.std_logic_1164.all;

entity shuffle is
  generic(
    size : integer := 67 );
  port(
        -- WHEN USING SYSTEMC TESTBENCH, GO WITH FIXED SIZE INTERFACE :(
        --  in_0   : in  std_logic_vector (size-1 downto 0);
        --  in_1   : in  std_logic_vector (size-1 downto 0);
        --  in_2   : in  std_logic_vector (size-1 downto 0);
        --  in_3   : in  std_logic_vector (size-1 downto 0);
        --  out_0  : out std_logic_vector (size-1 downto 0);
        --  out_1  : out std_logic_vector (size-1 downto 0);
        --  out_2  : out std_logic_vector (size-1 downto 0);
        --  out_3  : out std_logic_vector (size-1 downto 0);
         in_0   : in  std_logic_vector (66 downto 0);
         in_1   : in  std_logic_vector (66 downto 0);
         in_2   : in  std_logic_vector (66 downto 0);
         in_3   : in  std_logic_vector (66 downto 0);
         out_0  : out std_logic_vector (66 downto 0);
         out_1  : out std_logic_vector (66 downto 0);
         out_2  : out std_logic_vector (66 downto 0);
         out_3  : out std_logic_vector (66 downto 0);
         lane_0 : in  std_logic_vector (1 downto 0);
         lane_1 : in  std_logic_vector (1 downto 0);
         lane_2 : in  std_logic_vector (1 downto 0);
         lane_3 : in  std_logic_vector (1 downto 0)
      );
end shuffle;
architecture shuffle_arch of shuffle is
  signal ctr_vec : std_logic_vector (4 downto 0);
  signal m,n,o,p,q,r : std_logic_vector (size-1 downto 0);
  signal lane_vec  : std_logic_vector(7 downto 0);
begin
  lane_vec <= lane_0 & lane_1 & lane_2 & lane_3;

  -- Atribuicao do vetor de controle
  ctr_vec(0) <= '1' when lane_vec = "00100111" or lane_vec = "00110110" or
                         lane_vec = "01100011" or lane_vec = "01110010" or
                         lane_vec = "10001101" or lane_vec = "10011100" or
                         lane_vec = "11001001" or lane_vec = "11011000" else '0';

  ctr_vec(1) <= '1' when lane_vec = "10000111" or lane_vec = "10001101" or
                         lane_vec = "10010011" or lane_vec = "10011100" or
                         lane_vec = "10110001" or lane_vec = "10110100" or
                         lane_vec = "11000110" or lane_vec = "11001001" or
                         lane_vec = "11010010" or lane_vec = "11011000" or
                         lane_vec = "11100001" or lane_vec = "11100100" else '0';

  ctr_vec(2) <= '1' when lane_vec = "00100111" or lane_vec = "00101101" or
                         lane_vec = "00110110" or lane_vec = "00111001" or
                         lane_vec = "01100011" or lane_vec = "01101100" or
                         lane_vec = "01110010" or lane_vec = "01111000" or
                         lane_vec = "10110001" or lane_vec = "10110100" or
                         lane_vec = "11100001" or lane_vec = "11100100" else '0';

  ctr_vec(3) <= '1' when lane_vec = "01001011" or lane_vec = "01001110" or
                         lane_vec = "01100011" or lane_vec = "01101100" or
                         lane_vec = "01110010" or lane_vec = "01111000" or
                         lane_vec = "10000111" or lane_vec = "10001101" or
                         lane_vec = "10110100" or lane_vec = "11000110" or
                         lane_vec = "11001001" or lane_vec = "11100100" else '0';

  ctr_vec(4) <= '1' when lane_vec = "00011110" or lane_vec = "00100111" or
                         lane_vec = "00101101" or lane_vec = "01001110" or
                         lane_vec = "01100011" or lane_vec = "01101100" or
                         lane_vec = "11000110" or lane_vec = "11001001" or
                         lane_vec = "11010010" or lane_vec = "11011000" or
                         lane_vec = "11100001" or lane_vec = "11100100" else '0';

  -- BIT 0 -> Sempre em zero, não vamos instanciar um switch para este...
  switch_1_inst: entity work.switch port map( a_in => in_2, b_in => in_3, a_out => m,     b_out => n,     ctr => ctr_vec(0));
  switch_2_inst: entity work.switch port map( a_in => in_0, b_in => m,    a_out => o,     b_out => p,     ctr => ctr_vec(1));
  switch_3_inst: entity work.switch port map( a_in => in_1, b_in => n,    a_out => q,     b_out => r,     ctr => ctr_vec(2));
  switch_4_inst: entity work.switch port map( a_in => o,    b_in => q,    a_out => out_0, b_out => out_1, ctr => ctr_vec(3));
  switch_5_inst: entity work.switch port map( a_in => p,    b_in => r,    a_out => out_2, b_out => out_3, ctr => ctr_vec(4));

end shuffle_arch;
