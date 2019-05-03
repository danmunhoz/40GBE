Library IEEE;
USE IEEE.Std_logic_1164.all;
USE ieee.numeric_std.ALL;

entity memory_array is
  generic (
        TAM := 64;
        ARRAY_LENGHT := 40
  );
   port(
      data_out : out std_logic_vector(TAM-1 downto 0);
      rptr: in  std_logic_vector(5 downto 0);
      clk :in std_logic;
      fifo_we: in std_logic;
      wptr :in  std_logic_vector(5 downto 0);
      data_in: in std_logic_vector(TAM-1 downto 0)
   );
end memory_array;
architecture Behavioral of memory_array is
 type mem_array is array (0 to ARRAY_LENGHT-1) of std_logic_vector(TAM-1 downto 0);
 signal data_out_reg: mem_array;
begin

  data_out <= data_out_reg(to_integer(unsigned(rptr(3 downto 0))));
 process(clk)
 begin
     if(rising_edge(clk)) then
       if(fifo_we='1') then
          data_out_reg(to_integer(unsigned(wptr(3 downto 0)))) <= data_in;
       end if;
     end if;
 end process;

end Behavioral;
