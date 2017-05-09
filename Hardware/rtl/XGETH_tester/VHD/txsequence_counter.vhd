----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 09/10/2015 07:59:53 PM
-- Design Name:
-- Module Name: TXSEQUENCE_COUNTER - Behavioral
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description:
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
----------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library UNISIM;
--use IEEE.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity txsequence_counter is
  Port(
      clk_161_in : in STD_LOGIC;
      reset_n_in : in STD_LOGIC;
      tx_sequence_out : out STD_LOGIC_VECTOR(6 DOWNTO 0);
      DATA_PAUSE:      out STD_LOGIC
      );

end txsequence_counter;

architecture Behavioral of txsequence_counter is

signal txseq_counter_r : unsigned(8 downto 0);

begin

  process(clk_161_in,reset_n_in)

  begin
      if (rising_edge(clk_161_in)) then
          if reset_n_in = '0' or txseq_counter_r = 32 then
              txseq_counter_r <= (others =>'0');
          else
              txseq_counter_r <= txseq_counter_r + 1;

          end if;
      end if;
  end process;

  tx_sequence_out(6)           <= '0';
  tx_sequence_out(5 downto 0)  <= std_logic_vector(txseq_counter_r(5 downto 0));

  DATA_PAUSE <= '0' when txseq_counter_r = x"20" else '1'; -- pause at 32 packets


end Behavioral;
