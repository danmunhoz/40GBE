library ieee;
  use ieee.std_logic_1164.all;

entity mii_shift_register is
  port(
  -- INPUTS
      clk             : in std_logic;
      rst_n           : in std_logic;

      xgmii_rxd_0     : in std_logic_vector(63 downto 0);
      xgmii_rxd_1     : in std_logic_vector(63 downto 0);
      xgmii_rxd_2     : in std_logic_vector(63 downto 0);
      xgmii_rxd_3     : in std_logic_vector(63 downto 0);

  --Ctrl mux
      ctrl            : in std_logic_vector( 1 downto 0); -- ctrl=00 -->  out_1 <= reg_previus
                                                          -- ctrl=01 -->  out_1 <= reg_previus(7bytes) + reg_delay(1byte)
                                                          -- ctrl=10 -->  out_1 <= reg_previus(6bytes) + reg_delay(2byte)
  --OUTPUTS
      out_0           : out std_logic_vector(255 downto 0);
      out_1           : out std_logic_vector(255 downto 0)
      );
end entity;

architecture behav_mii_shift_register of mii_shift_register is
    signal reg_current_D   : std_logic_vector(255 downto 0);
    signal reg_current_Q   : std_logic_vector(255 downto 0);
    signal reg_previous_Q  : std_logic_vector(255 downto 0);
    signal reg_delay_Q     : std_logic_vector(127 downto 0);

  begin

    reg_current_D <= xgmii_rxd_3 & xgmii_rxd_2 & xgmii_rxd_1 & xgmii_rxd_0;

    reg_current : entity work.regnbit generic map (size=>256)
      port map(
                ck  =>  clk,
                rst =>  rst_n,
                ce  =>  rst_n,
                D   =>  reg_current_D,
                Q   =>  reg_current_Q
              );

    reg_previous : entity work.regnbit generic map (size=>256)
      port map(
                ck  =>  clk,
                rst =>  rst_n,
                ce  =>  rst_n,
                D   =>  reg_current_Q,
                Q   =>  reg_previous_Q
              );

    reg_delay    : entity work.regnbit generic map (size=>128)
      port map(
                ck  =>  clk,
                rst =>  rst_n,
                ce  =>  rst_n,
                D   =>  reg_previous_Q(255 downto 128),
                Q   =>  reg_delay_Q
              );

    mux_out_0:  out_0 <= reg_current_Q;

    mux_out_1:  out_1 <= reg_previous_Q(223 downto 0) & reg_delay_Q(95 downto 64)  when ctrl="01" else
                         reg_previous_Q(191 downto 0) & reg_delay_Q(127 downto 64)  when ctrl="10" else
                         reg_previous_Q(127 downto 0) & reg_delay_Q                when ctrl="11" else
                         reg_previous_Q;

end behav_mii_shift_register;
