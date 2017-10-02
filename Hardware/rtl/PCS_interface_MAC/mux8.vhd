
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
library unisim;
use unisim.vcomponents.all;

entity mux8 is
  Port (  data_in : in std_logic_vector(7 downto 0);
              sel : in std_logic_vector(2 downto 0);
         data_out : out std_logic);
end mux8;

architecture a1 of mux8 is
  component LUT6 is
  generic(
     INIT : bit_vector := X"0000000000000000");
  port(
    O : out std_ulogic;
    I0 : in std_ulogic;
    I1 : in std_ulogic;
    I2 : in std_ulogic;
    I3 : in std_ulogic;
    I4 : in std_ulogic;
    I5 : in std_ulogic);
  end component;

  component MUXF7 is
  port(
    O : out std_ulogic;

    I0 : in std_ulogic;
    I1 : in std_ulogic;
    S  : in std_ulogic
    );
end component;

signal data_selection : std_logic_vector(2 downto 0);
  constant INIT_lut_6 : bit_vector := X"FF00F0F0CCCCAAAA";
begin

  -- selection0_lut: entity unisim.LUT6
  selection0_lut: LUT6
  generic map (INIT => INIT_lut_6)
  port map( I0 => data_in(0),
            I1 => data_in(1),
            I2 => data_in(2),
            I3 => data_in(3),
            I4 => sel(0),
            I5 => sel(1),
             O => data_selection(0));


  -- selection1_lut: entity unisim.LUT6
  selection1_lut: LUT6
  generic map (INIT => INIT_lut_6)
  port map( I0 => data_in(4),
            I1 => data_in(5),
            I2 => data_in(6),
            I3 => data_in(7),
            I4 => sel(0),
            I5 => sel(1),
             O => data_selection(1));


  -- combiner0_muxf7: entity unisim.MUXF7
  combiner0_muxf7: MUXF7
  port map( I0 => data_selection(0),
            I1 => data_selection(1),
             S => sel(2),
             O => data_out );


end a1;
