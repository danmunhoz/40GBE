library ieee;
  use ieee.std_logic_1164.all;

entity core_interface is
  port(
  -- INPUTS
      clk_156         : in std_logic;
      clk_312         : in std_logic;
      rst_n           : in std_logic;
      xgmii_rxc_0     : in std_logic_vector( 7 downto 0);
      xgmii_rxd_0     : in std_logic_vector(63 downto 0);
      xgmii_rxc_1     : in std_logic_vector( 7 downto 0);
      xgmii_rxd_1     : in std_logic_vector(63 downto 0);
      xgmii_rxc_2     : in std_logic_vector( 7 downto 0);
      xgmii_rxd_2     : in std_logic_vector(63 downto 0);
      xgmii_rxc_3     : in std_logic_vector( 7 downto 0);
      xgmii_rxd_3     : in std_logic_vector(63 downto 0);
  --OUTPUTS
      mac_data        : out std_logic_vector(127 downto 0)
    );
end entity;

architecture behav_core_interface of core_interface is
    signal shift_reg_ctrl      : std_logic;
    signal shift_reg_out_0     : std_logic_vector(255 downto 0);
    signal shift_reg_out_1     : std_logic_vector(255 downto 0);

  begin
    shift_reg: entity work.mii_shift_register port map(
          clk           => clk_156,
          rst_n         => rst_n,
          xgmii_rxc_0   => xgmii_rxc_0,
          xgmii_rxd_0   => xgmii_rxd_0,
          xgmii_rxc_1   => xgmii_rxc_1,
          xgmii_rxd_1   => xgmii_rxd_1,
          xgmii_rxc_2   => xgmii_rxc_2,
          xgmii_rxd_2   => xgmii_rxd_2,
          xgmii_rxc_3   => xgmii_rxc_3,
          xgmii_rxd_3   => xgmii_rxd_3,
          ctrl          => shift_reg_ctrl,
          out_0         => shift_reg_out_0,
          out_1         => shift_reg_out_1

    );

end behav_core_interface;
