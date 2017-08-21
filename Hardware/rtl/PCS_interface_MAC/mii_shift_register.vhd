library ieee;
  use ieee.sdt_logic_1164.all;

entity mii_shift_register is
  port(
  -- INPUTS
      clk             : in std_logic;
      rst             : in std_logic;

      ---ctrl            : in std_logic_vector( 1 downto 0);

      xgmii_rxc_0     : in std_logic_vector( 7 downto 0);
      xgmii_rxd_0     : in std_logic_vector(63 downto 0);

      xgmii_rxc_1     : in std_logic_vector( 7 downto 0);
      xgmii_rxd_1     : in std_logic_vector(63 downto 0);

      xgmii_rxc_2     : in std_logic_vector( 7 downto 0);
      xgmii_rxd_2     : in std_logic_vector(63 downto 0);

      xgmii_rxc_3     : in std_logic_vector( 7 downto 0);
      xgmii_rxd_3     : in std_logic_vector(63 downto 0);

  --Ctrl mux
      CTRL            : in  std_logic_vector(0 downto 1);

  --OUTPUTS
      out_0         : out std_logic_vector(0 to 255);
      out_1         : out std_logic_vector(0 to 255);
      );
end entity;

architecture behav_mii_shift_register of mii_shift_register is

  begin

    reg_current : entity work.regnbit generic map (size=>256) port map (
                                                                      ck  =>  clk,  rst =>  rst,
                                                                      ce  =>  '1',
                                                                      D   =>  xgmii_rxd_0(0 to 63) & xgmii_rxd_1(0 to 63) &
                                                                              xgmii_rxd_2(0 to 63) & xgmii_rxd_3(0 to 63),
                                                                      Q   =>  out_1(0 to 255)
                                                                      );

    reg_previous : entity work.regnbit generic map (size=>256) port map (
                                                                      ck  =>  clk,  rst =>  rst,
                                                                      ce  =>  '1',
                                                                      D   =>  out_1(0 to 255),
                                                                      Q   =>  out_2(0 to 255)
                                                                      );

    reg_delay    : entity work.regnbit generic map (size=>64) port map (
                                                                      ck  =>  clk,
                                                                      rst =>  rst,
                                                                      ce  =>  '1',
                                                                      D   =>  out_2(192 to 255),
                                                                      Q   =>  out_3(0 to 63)
                                                                      );

  CTRL_i <= CTRL

  case CTRL_i is

  when 0       =>  out_0 <= out_2(0 to 192) & out_2(192 to 255) ;

  when 1       =>  out_0 <= out_2(0 to 192) & out_3(0 to 63);

  when others =>  Z <= 'X';
  end case;


end behav_mii_shift_register;
