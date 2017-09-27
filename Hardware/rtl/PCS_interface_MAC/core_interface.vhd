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
      mac_data        : out std_logic_vector(127 downto 0);
      mac_sop         : out std_logic;
      mac_eop         : out std_logic_vector(4 downto 0)
    );
end entity;

architecture behav_core_interface of core_interface is

    signal ctrl_mux_delay      : std_logic_vector(  1 downto 0);
    signal ctrl_shift_reg      : std_logic_vector(  2 downto 0);
    signal eop_line_offset     : std_logic_vector(  5 downto 0);
    signal shift_reg_out_0     : std_logic_vector(255 downto 0);
    signal shift_reg_out_1     : std_logic_vector(255 downto 0);
    signal shifter_out         : std_logic_vector(255 downto 0);
    signal fifo_wen            : std_logic;
    signal fifo_ren            : std_logic;
    signal fifo_empty          : std_logic;
    signal fifo_full           : std_logic;
    signal is_sop_control      : std_logic;
    signal eop_addr            : std_logic_vector(5 downto 0);

  begin

    controller: entity work.control port map(
          clk             => clk_156,
          rst_n           => rst_n,
          xgmii_rxc_0     => xgmii_rxc_0,
          xgmii_rxd_0     => xgmii_rxd_0,
          xgmii_rxc_1     => xgmii_rxc_1,
          xgmii_rxd_1     => xgmii_rxd_1,
          xgmii_rxc_2     => xgmii_rxc_2,
          xgmii_rxd_2     => xgmii_rxd_2,
          xgmii_rxc_3     => xgmii_rxc_3,
          xgmii_rxd_3     => xgmii_rxd_3,
          ctrl_delay      => ctrl_mux_delay,
          shift_out       => ctrl_shift_reg,
          is_sop          => is_sop_control,
          eop_location_out=> eop_addr,
          wen_fifo        => fifo_wen
    );

    shift_reg: entity work.mii_shift_register port map(
          clk           => clk_156,
          rst_n         => rst_n,
          xgmii_rxd_0   => xgmii_rxd_0,
          xgmii_rxd_1   => xgmii_rxd_1,
          xgmii_rxd_2   => xgmii_rxd_2,
          xgmii_rxd_3   => xgmii_rxd_3,
          ctrl          => ctrl_mux_delay,
          out_0         => shift_reg_out_0,
          out_1         => shift_reg_out_1
    );

    shifter: entity work.mii_shifter port map(
          clk             => clk_156,
          rst_n           => rst_n,
          in_1            => shift_reg_out_1,
          in_0            => shift_reg_out_0,
          ctrl_reg_shift  => ctrl_shift_reg,
          out_data        => shifter_out
    );

    fifo_ren <= '0', '1' after 400 ns; -- Waiting for mac
    fifo: entity work.ring_fifo port map(
          clk_w      => clk_156,
          clk_r      => clk_312,
          rst_n      => rst_n,
          data_in    => shifter_out,
          data_out   => mac_data,
          is_sop_in  => is_sop_control,
          eop_addr_in=> eop_addr,
          is_sop_out => mac_sop,
          eop_addr_out=> mac_eop,
          wen        => fifo_wen,
          ren        => fifo_ren,
          empty      => fifo_empty,
          full       => fifo_full
    );

end behav_core_interface;
