library ieee;
  use ieee.std_logic_1164.all;

library unisim;
  use unisim.VCOMPONENTS.all;
library unimacro;

entity reorder_fifo is
  port(
  -- INPUTS
      clk                   : in std_logic;
      rst                   : in std_logic;
      ren                   : in std_logic;
      wen                   : in std_logic;
      data_in               : in std_logic_vector(65 downto 0);

  -- OUTPUTS
      almost_f              : out std_logic;
      full                  : out std_logic;
      almost_e              : out std_logic;
      empty                 : out std_logic;
      data_out              : out std_logic_vector(65 downto 0)
      );
end entity;

architecture behav_fifo_reorder of reorder_fifo is

  component generic_fifo is

    generic(
      DWIDTH                : integer := 66;
      AWIDTH                : integer := 6;
      -- RAM_DEPTH          : integer := 20;
      REGISTER_READ         : integer := 1;
      EARLY_READ            : integer := 1;
      CLOCK_CROSSING        : integer := 0;
      ALMOST_EMPTY_THRESH   : integer := 1;
      ALMOST_FULL_THRESH    : integer := 7;
      MEM_TYPE              : integer := 1
    );

    port(
      --  RW FIFO
      wclk            : in std_logic;
      wrst_n          : in std_logic;
      wen             : in std_logic;
      wdata           : in std_logic_vector(65 downto 0);

      wfull           : out std_logic;
      walmost_full    : out std_logic;

      --  RD FIFO
      rclk            : in std_logic;
      rrst_n          : in std_logic;
      ren             : in std_logic;

      rdata           : out std_logic_vector (65 downto 0);
      rempty          : out std_logic;
      ralmost_empty   : out std_logic
    );

  end component;

begin

  reorder_generic_fifo: generic_fifo port map(
                                          wclk          =>  clk,
                                          wrst_n        =>  rst,
                                          wen           =>  wen,
                                          wdata         =>  data_in,

                                          wfull         =>  full,
                                          walmost_full  =>  almost_f,

                                          rclk          =>  clk,
                                          rrst_n        =>  rst,
                                          ren           =>  ren,

                                          rdata         =>  data_out,
                                          rempty        =>  empty,
                                          ralmost_empty =>  almost_e
                                          );

end behav_fifo_reorder;
