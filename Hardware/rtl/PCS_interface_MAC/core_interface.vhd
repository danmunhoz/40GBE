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
      ren             : in std_logic;

  --OUTPUTS
      mac_data        : out std_logic_vector(127 downto 0);
      mac_sop         : out std_logic;
      mac_eop         : out std_logic_vector(4 downto 0);
      mac_val         : out std_logic;
      fifo_full       : out std_logic;
      fifo_empty      : out std_logic;
      fifo_almost_f   : out std_logic;
      fifo_almost_e   : out std_logic
    );
end entity;

architecture behav_core_interface of core_interface is

    signal ctrl_mux_delay      : std_logic_vector(  1 downto 0);
    signal ctrl_shift_reg      : std_logic_vector(  2 downto 0);
    signal eop_line_offset     : std_logic_vector(  5 downto 0);
    signal shift_reg_out_0     : std_logic_vector(255 downto 0);
    signal shift_reg_out_1     : std_logic_vector(255 downto 0);
    signal shifter_out         : std_logic_vector(255 downto 0);
    signal shifter_out_ut      : std_logic_vector(255 downto 0);
    signal fifo_wen            : std_logic;
    signal fifo_almost_f_int   : std_logic;
    signal is_sop_control      : std_logic;
    signal eop_addr            : std_logic_vector(5 downto 0);

    signal ff256_sop           : std_logic_vector(1 downto 0);

  begin

    fifo_almost_f <= fifo_almost_f_int;

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
          almost_f        => fifo_almost_f_int,
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
          in_0            => shift_reg_out_0,
          in_1            => shift_reg_out_1,
          ctrl_reg_shift  => ctrl_shift_reg,
          data_out        => shifter_out
    );

    -- fifo: entity work.ring_fifo port map(
    fifo_b: entity work.ring_fifo_bram port map(
          clk_w        => clk_156,
          clk_r        => clk_312,
          rst_n        => rst_n,
          data_in      => shifter_out,
          is_sop_in    => is_sop_control,
          eop_addr_in  => eop_addr,
          data_out     => mac_data,
          data_val     => mac_val,
          is_sop_out   => mac_sop,
          eop_addr_out => mac_eop,
          wen          => fifo_wen,
          ren          => ren,
          empty        => fifo_empty,
          full         => fifo_full,
          almost_f     => fifo_almost_f_int,
          almost_e     => fifo_almost_e
    );


    --      TANAUAN TESTANDO COM BARRAMENTO DE DE SAIDA 256 BITS
    --

    --  ff256_sop : signal std_logic_vector(1 downto 0);

    ff256_sop <= is_sop_control & '0';

    fifo_256 : entity work.data_frame_fifo port map (
    --INPUTS
    clk        => clk_156,      -- : in std_logic;
    rst_n      => rst_n,        -- : in std_logic;
    data_in    => shifter_out,    -- : in std_logic_vector(255 downto 0);
    eop_in     => eop_addr,     -- : in std_logic_vector(5 downto 0);
    sop_in     => ff256_sop,    -- : in std_logic_vector(1 downto 0);
    val_in     => '0' ,   --  ???         -- : in std_logic;
    ren        => ren,          -- : in std_logic;
    wen        => fifo_wen,     -- : in std_logic;
    --OUTPUTS
    data_out   => open,-- : out std_logic_vector(255 downto 0);
    eop_out    => open,-- : out std_logic_vector(  5 downto 0);
    sop_out    => open,-- : out std_logic_vector(1 downto 0);
    val_out    => open,-- : out std_logic;

    almost_e   => open,-- : out std_logic;
    almost_f   => open,-- : out std_logic;
    full       => open,-- : out std_logic;
    empty      => open -- : out std_logic



    );

end behav_core_interface;
