library ieee;
use ieee.std_logic_1164.all;

package interface_defs is

  constant IDLE       : std_logic_vector(7 downto 0) := x"07";
  constant PREAMBLE   : std_logic_vector(7 downto 0) := x"55";
  constant SEQUENCE   : std_logic_vector(7 downto 0) := x"9c";
  constant SFD        : std_logic_vector(7 downto 0) := x"d5";
  constant START      : std_logic_vector(7 downto 0) := x"fb";
  constant TERMINATE  : std_logic_vector(7 downto 0) := x"fd";
  constant ERROR      : std_logic_vector(7 downto 0) := x"fe";

  subtype LANE0 is natural range 7 downto 0;
  subtype LANE1 is natural range 15 downto 8;
  subtype LANE2 is natural range 23 downto 16;
  subtype LANE3 is natural range 31 downto 24;
  subtype LANE4 is natural range 39 downto 32;
  subtype LANE5 is natural range 47 downto 40;
  subtype LANE6 is natural range 55 downto 48;
  subtype LANE7 is natural range 63 downto 56;
  
end interface_defs;
