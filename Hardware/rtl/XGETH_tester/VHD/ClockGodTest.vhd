library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
----------------------------------RECEIVER---------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

entity clockgodtest is
end clockgodtest;

architecture arch_clockgodtest of clockgodtest is
signal clock : std_logic :='0';
begin

clock <= not clock after 10 ns;
end arch_clockgodtest;
