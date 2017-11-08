library ieee;
  use ieee.std_logic_1164.all;

entity mii_shifter is
  port(
  -- INPUTS
      in_1            : in std_logic_vector(255 downto 0);
      -- in_0            : in std_logic_vector(255 downto 0);
      in_0            : in std_logic_vector(223 downto 0);

  --CTRL
      ctrl_reg_shift  : in std_logic_vector(2 downto 0);

  --OUTPUTS
      data_out        : out std_logic_vector(255 downto 0)
      );
end entity;

architecture behav_mii_shifter of mii_shifter is

  begin

                --in_1(255 downto 0)                          when ctrl_reg_shift = "000" else -- 0 desloc
    data_out <= in_0( 31 downto 0)  & in_1(255 downto  32)  when ctrl_reg_shift = "001" else -- 1 desloc

                in_0( 63 downto 0)  & in_1(255 downto  64)  when ctrl_reg_shift = "010" else -- 2 desloc
                in_0( 95 downto 0)  & in_1(255 downto  96)  when ctrl_reg_shift = "011" else -- 3 desloc

                in_0( 127 downto 0) & in_1(255 downto 128)  when ctrl_reg_shift = "100" else -- 4 desloc
                in_0( 159 downto 0) & in_1(255 downto 160)  when ctrl_reg_shift = "101" else -- 5 desloc

                in_0( 191 downto 0) & in_1(255 downto 192)  when ctrl_reg_shift = "110" else -- 6 desloc
                in_0( 223 downto 0) & in_1(255 downto 224)  when ctrl_reg_shift = "111" else -- 7 desloc

                in_1(255 downto 0); -- Default e 0 desloc...


  end behav_mii_shifter;
