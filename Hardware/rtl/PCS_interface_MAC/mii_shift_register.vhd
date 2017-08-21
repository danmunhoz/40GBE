library ieee;
  use ieee.std_logic_1164.all;

entity mii_shift_register is
  port(
  -- INPUTS
      clk             : in std_logic;
      rst             : in std_logic;

      xgmii_rxc_0     : in std_logic_vector( 7 downto 0);
      xgmii_rxd_0     : in std_logic_vector(63 downto 0);

      xgmii_rxc_1     : in std_logic_vector( 7 downto 0);
      xgmii_rxd_1     : in std_logic_vector(63 downto 0);

      xgmii_rxc_2     : in std_logic_vector( 7 downto 0);
      xgmii_rxd_2     : in std_logic_vector(63 downto 0);

      xgmii_rxc_3     : in std_logic_vector( 7 downto 0);
      xgmii_rxd_3     : in std_logic_vector(63 downto 0);

  --Ctrl mux
      ctrl            : in  std_logic;

  --OUTPUTS
      out_0         : out std_logic_vector(255 downto 0);
      out_1         : out std_logic_vector(255 downto 0)
      );
end entity;

architecture behav_mii_shift_register of mii_shift_register is
    signal reg_current_D   : std_logic_vector(255 downto 0);
    signal reg_current_Q   : std_logic_vector(255 downto 0);
    signal reg_previous_Q  : std_logic_vector(255 downto 0);
    signal reg_delay_Q     : std_logic_vector( 63 downto 0);
    signal out_2           : std_logic_vector( 63 downto 0);  --:=(others=>'0'); --arrumar
    signal rst_n           : std_logic;
  begin

    rst_n <= not rst;
    reg_current_D <= xgmii_rxd_3 & xgmii_rxd_2 & xgmii_rxd_1 & xgmii_rxd_0;

    reg_current : entity work.regnbit generic map (size=>256) port map (
                                                                        ck  =>  clk,  rst =>  rst,
                                                                        ce  =>  '1',
                                                                        D   =>  reg_current_D,
                                                                        Q   =>  reg_current_Q
                                                                      );

    reg_previous : entity work.regnbit generic map (size=>256) port map (
                                                                        ck  =>  clk,  rst =>  rst,
                                                                        ce  =>  '1',
                                                                        D   =>  reg_current_Q,
                                                                        Q   =>  reg_previous_Q
                                                                      );

    reg_delay    : entity work.regnbit generic map (size=>64) port map (
                                                                        ck  =>  clk,
                                                                        rst =>  rst,
                                                                        ce  =>  '1',
                                                                        D   =>  reg_previous_Q(255 downto 192),
                                                                        Q   =>  reg_delay_Q
                                                                      );

    out_0 <= reg_current_Q;
    out_1 <= reg_previous_Q;
    out_2 <= reg_delay_Q;

    -- CTRL_i <= CTRL
    --
    -- case CTRL_i is
    --
    -- when 0       =>  out_0 <= out_2(0 to 192) & out_2(192 to 255) ;
    --
    -- when 1       =>  out_0 <= out_2(0 to 192) & out_3(0 to 63);
    --
    -- when others =>  Z <= 'X';
    -- end case ;

end behav_mii_shift_register;
