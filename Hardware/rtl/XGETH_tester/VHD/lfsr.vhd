library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity lfsr is
  generic
  (
    DATA_SIZE   : integer := 64;
    LFSR_WIDTH  : integer := 64 
  );

  port
  (
    clock               : in  std_logic; 
    reset               : in  std_logic; 
    seed                : in  std_logic_vector(63 downto 0);
    valid_seed          : in  std_logic;
    polynomial          : in  std_logic_vector(1 downto 0);
    data_in             : in  std_logic_vector(63 downto 0);
    start               : in  std_logic;
    data_out            : out std_logic_vector(63 downto 0)
    
  );
end lfsr;

architecture arch_lfsr of lfsr is

  -------------------------------------------------------------------------------
  -- Debug
  -------------------------------------------------------------------------------
  attribute mark_debug : string;
  
  type lfsr_table is array (0 to 63) of std_logic_vector (63 downto 0); 

  signal reg_i           : std_logic_vector(63 downto 0);
 -- attribute mark_debug of reg_i : signal is "true";

  signal linear_feedback : lfsr_table;

  signal bit1, bit2: integer := 0;

begin
  --para lfsr 23 bits: 22 e 17
  --para lfsr 31 bits: 30 e 27


  linear_feedback(0) <= (reg_i(bit1) xor reg_i(bit2)) & reg_i(63 downto 1) when reset = '1' else (others=>'0');
  generate_lfsr : for i in 1 to 63 generate 
    linear_feedback(i) <= (linear_feedback(i-1)(bit1) xor linear_feedback(i-1)(bit2)) & linear_feedback(i-1)(63 downto 1) when reset = '1' else (others=>'0');
  end generate generate_lfsr;

  process (clock, reset)
  begin
    if rising_edge(clock) then
      if valid_seed = '1' then
        reg_i <= seed;
      elsif start = '1' then
        reg_i <= data_in;
      else 
        reg_i <= reg_i;
      end if;
    end if;
  end process;

  process(polynomial)
  begin
      if(polynomial="00") then
        bit1 <= 30;
        bit2 <= 27;
      elsif(polynomial="01") then
        bit1 <= 22;
        bit2 <= 17;
      elsif(polynomial="10") then
        bit1 <= 14;
        bit2 <= 13;
      elsif(polynomial="11") then
        bit1 <= 6;
        bit2 <= 5;
      else 
        bit1 <= 30;
        bit2 <= 27;
      end if;
  end process;

  data_out <= linear_feedback(63) when reset = '1' else (others=>'0');

end arch_lfsr;