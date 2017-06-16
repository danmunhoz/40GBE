--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Generic register
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
library IEEE;
use IEEE.std_logic_1164.all;

entity regnbit is
           generic(
           size : integer := 32;
           INIT_VALUE : STD_LOGIC_VECTOR(63 downto 0) := (others=>'0') );
           port(  ck, rst, ce : in std_logic;
                  D : in  STD_LOGIC_VECTOR (size-1 downto 0);
                  Q : out STD_LOGIC_VECTOR (size-1 downto 0)
               );
end regnbit;
architecture regn of regnbit is
begin
  process(ck, rst)
  begin
       if rst = '0' then
              Q <= INIT_VALUE(size-1 downto 0);
       elsif ck'event and ck = '0' then
           if ce = '1' then
              Q <= D;
           end if;
       end if;
  end process;
end regn;

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Bit register
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
library IEEE;
use IEEE.std_logic_1164.all;

entity reg_bit is
           generic(
              INIT_VALUE : std_logic := '0' );
           port(  ck, rst, ce : in std_logic;
                  D : in  std_logic;
                  Q : out std_logic
               );
end reg_bit;
architecture reg of reg_bit is
begin
  process(ck, rst)
  begin
       if rst = '0' then
              Q <= INIT_VALUE;
       elsif ck'event and ck = '0' then
           if ce = '1' then
              Q <= D;
           end if;
       end if;
  end process;
end reg;
