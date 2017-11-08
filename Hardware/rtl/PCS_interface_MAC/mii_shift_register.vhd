library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use IEEE.std_logic_unsigned.all;

  library UNISIM;
    use UNISIM.VCOMPONENTS.ALL;

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
      -- out_0           : out std_logic_vector(255 downto 0);
      out_0           : out std_logic_vector(223 downto 0);
      out_1           : out std_logic_vector(255 downto 0)
      );
end entity;

architecture behav_mii_shift_register of mii_shift_register is
    signal reg_current_D   : std_logic_vector(255 downto 0);
    signal reg_current_Q   : std_logic_vector(255 downto 0);
    signal reg_previous_Q  : std_logic_vector(255 downto 0);
    signal reg_delay_Q     : std_logic_vector( 63 downto 0);

    attribute dont_touch : string;
    attribute dont_touch of reg_current,reg_previous,reg_delay : label is "true";

    -- attribute dont_touch : string;
    -- attribute dont_touch of out_0: signal is "true";

    -- attribute keep : string;
    -- attribute keep of out_0 : signal is "true";

  begin

    reg_current_D <= xgmii_rxd_3 & xgmii_rxd_2 & xgmii_rxd_1 & xgmii_rxd_0;

    reg_current: entity work.regnbit generic map (size=>256)
      port map(
                ck  =>  clk,
                rst =>  rst_n,
                ce  =>  rst_n,
                D   =>  reg_current_D,
                Q   =>  reg_current_Q
              );

    reg_previous: entity work.regnbit generic map (size=>256)
      port map(
                ck  =>  clk,
                rst =>  rst_n,
                ce  =>  rst_n,
                D   =>  reg_current_Q,
                Q   =>  reg_previous_Q
              );

    reg_delay: entity work.regnbit generic map (size=>64)
      port map(
                ck  =>  clk,
                rst =>  rst_n,
                ce  =>  rst_n,
                D   =>  reg_previous_Q(255 downto 192),
                Q   =>  reg_delay_Q
              );

    mux_out_0:  out_0 <= reg_current_Q(223 downto 0);

    mux_out_1:  out_1 <= reg_previous_Q(223 downto 0) & reg_delay_Q(63 downto 32)  when ctrl="01" else
                         reg_previous_Q(191 downto 0) & reg_delay_Q                 when ctrl="10" else
                         reg_previous_Q;

end behav_mii_shift_register;
