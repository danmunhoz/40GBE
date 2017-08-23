library ieee;
  use ieee.std_logic_1164.all;

entity mii_shifter is
  port(
  -- INPUTS
      clk             : in std_logic;
      rst_n           : in std_logic;

      in_1            : in std_logic_vector(255 downto 0);
      in_0            : in std_logic_vector(255 downto 0);

  --CTRL
      ctrl_reg_shift  : in std_logic_vector(2 downto 0);

  --OUTPUTS
      out_data        : out std_logic_vector(255 downto 0)
      );
end entity;

architecture behav_mii_shifter of mii_shifter is

  begin

    out_data <= in_0(255 downto 0)                          when ctrl_reg_shift = "000" else
                in_0(255 downto 32)  & in_1(255 downto 224) when ctrl_reg_shift = "001" else
                in_0(255 downto 64)  & in_1(255 downto 192) when ctrl_reg_shift = "010" else
                in_0(255 downto 96)  & in_1(255 downto 160) when ctrl_reg_shift = "011" else
                in_0(255 downto 128) & in_1(255 downto 128) when ctrl_reg_shift = "100" else
                in_0(255 downto 160) & in_1(255 downto 96)  when ctrl_reg_shift = "101" else
                in_0(255 downto 192) & in_1(255 downto 64)  when ctrl_reg_shift = "110" else
                in_0(255 downto 224) & in_1(255 downto 32)  when ctrl_reg_shift = "111";



    --shifter :process(ctrl_reg_shift)
                --begin
                  --case ctrl_reg_shift is

                      --when "000" => out_data <= in_0(255 downto 0);
                      --when "001" => out_data <= in_0(255 downto 32)  & in_1(255 downto 224);
                      --when "010" => out_data <= in_0(255 downto 64)  & in_1(255 downto 192);
                      --when "011" => out_data <= in_0(255 downto 96)  & in_1(255 downto 160);
                      --when "100" => out_data <= in_0(255 downto 128) & in_1(255 downto 128);
                      --when "101" => out_data <= in_0(255 downto 160) & in_1(255 downto 96);
                      --when "110" => out_data <= in_0(255 downto 192) & in_1(255 downto 64);
                      --when "111" => out_data <= in_0(255 downto 224) & in_1(255 downto 32);
                      --when others => out_data <= (others => '0');

                  --end case;
              --end process;


  end behav_mii_shifter;

  --when "000" => out_data <= in_0(255 downto 0);
  --when "001" => out_data <= in_0(255 downto 31)  & in_1(255 downto 223);
  --when "010" => out_data <= in_0(255 downto 63)  & in_1(255 downto 191);
  --when "011" => out_data <= in_0(255 downto 95)  & in_1(255 downto 159);
  --when "100" => out_data <= in_0(255 downto 127) & in_1(255 downto 127);
  --when "101" => out_data <= in_0(255 downto 159) & in_1(255 downto 95);
  --when "110" => out_data <= in_0(255 downto 191) & in_1(255 downto 63);
  --when "111" => out_data <= in_0(255 downto 223) & in_1(255 downto 31);
  --when others => out_data <= (others => '0');
