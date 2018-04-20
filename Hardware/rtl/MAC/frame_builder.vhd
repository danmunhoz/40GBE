library ieee;
  use ieee.std_logic_1164.all;

entity frame_builder is
  port(
    -- INPUTS
  clk       : in std_logic;
  rst       : in std_logic;
  data_in   : in std_logic_vector(255 downto 0);
  eop_in    : in std_logic_vector(  5 downto 0);
  sop_in    : in std_logic;
  val_in    : in std_logic;
  ren       : in std_logic;
  wen       : in std_logic;
    --OUTPUTS
  frame_out : out std_logic_vector(255 downto 0);
  eop_out   : out std_logic_vector(  5 downto 0);
  sop_out   : out std_logic;
  val_out   : out std_logic
  );
end entity;

architecture behav_frame_builder of frame_builder is

    type crc_fsm_states is (IDLE, D128, D64, D8_0, D8_1, D8_2, D8_3, D8_4, D8_5, D8_6, D8_7, DONE);
    signal ps_crc :
  begin

  end behav_frame_builder;
