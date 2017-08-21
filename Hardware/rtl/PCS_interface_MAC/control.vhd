library ieee;
  use ieee.std_logic_1164.all;

use work.interface_defs.all;


entity control is
  port (
    xgmii_rxc_0 : in  std_logic_vector( 7 downto 0);
    xgmii_rxd_0 : in  std_logic_vector(63 downto 0);
    xgmii_rxc_1 : in  std_logic_vector( 7 downto 0);
    xgmii_rxd_1 : in  std_logic_vector(63 downto 0);
    xgmii_rxc_2 : in  std_logic_vector( 7 downto 0);
    xgmii_rxd_2 : in  std_logic_vector(63 downto 0);
    xgmii_rxc_3 : in  std_logic_vector( 7 downto 0);
    xgmii_rxd_3 : in  std_logic_vector(63 downto 0);
    ctrl_delay  : out std_logic;
    shift_out   : out std_logic_vector(2 downto 0)
  );
end entity;

architecture behav_control of control is
  signal teste : std_logic_vector(7 downto 0);
begin

  teste <= xgmii_rxd_3(LANE0);

end architecture;
