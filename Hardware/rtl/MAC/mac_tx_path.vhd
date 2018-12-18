library ieee;
  use ieee.std_logic_1164.all;

entity mac_tx_path is
  port(
  -- INPUTS
      clk_156  : in std_logic;
      rst_n    : in std_logic;
      data_in  : in std_logic_vector(255 downto 0);
      sop_in   : in std_logic_vector(1 downto 0);
      eop_in   : in std_logic;
      mod_in   : in std_logic_vector(4 downto 0);
      val_in   : in std_logic;

  --OUTPUTS
      mii_data_0 : out std_logic_vector(63 downto 0);
      mii_ctrl_0 : out std_logic_vector( 7 downto 0);
      mii_data_1 : out std_logic_vector(63 downto 0);
      mii_ctrl_1 : out std_logic_vector( 7 downto 0);
      mii_data_2 : out std_logic_vector(63 downto 0);
      mii_ctrl_2 : out std_logic_vector( 7 downto 0);
      mii_data_3 : out std_logic_vector(63 downto 0);
      mii_ctrl_3 : out std_logic_vector( 7 downto 0)
    );
end entity;

architecture behav_mac_tx_path of mac_tx_path is
    signal w_eop_fifo_0  : std_logic_vector(5 downto 0);
    signal val_in_reg    : std_logic;
    signal val_in_reg2   : std_logic;

    signal r_data_fifo_0 : std_logic_vector(255 downto 0);
    signal r_eop_fifo_0  : std_logic_vector(5 downto 0);
    signal r_sop_fifo_0  : std_logic_vector(1 downto 0);
    signal r_val_fifo_0  : std_logic;
    signal wen_fifo_0    : std_logic;
    signal ren_fifo_0    : std_logic;
    signal empty_fifo_0  : std_logic;
    signal full_fifo_0   : std_logic;
    signal almost_e_fifo_0 : std_logic;
    signal almost_f_fifo_0 : std_logic;

    signal w_frame_fifo_1 : std_logic_vector(255 downto 0);
    signal w_eop_fifo_1  : std_logic_vector(5 downto 0);
    signal w_sop_fifo_1  : std_logic_vector(1 downto 0);
    signal w_val_fifo_1  : std_logic;
    signal wen_fifo_1    : std_logic;
    signal ren_fifo_1    : std_logic;
    signal empty_fifo_1  : std_logic;
    signal full_fifo_1   : std_logic;
    signal r_frame_fifo_1 : std_logic_vector(255 downto 0);
    signal r_eop_fifo_1  : std_logic_vector(5 downto 0);
    signal r_sop_fifo_1  : std_logic_vector(1 downto 0);
    signal r_val_fifo_1  : std_logic;
    signal almost_e_fifo_1  : std_logic;
    signal almost_f_fifo_1  : std_logic;

  begin
    -- ENCODINGS
    --  SOP:
    --    00 - Invalid value
    --    01 - Invalid value
    --    10 - Packet starting at byte 0
    --    11 - Packet starting at byte 16
    --
    --  EOP:
    --    100000 - No eop at this cycle
    --    0xxxxx - Packet ending at byte xxxxx
    --

    process(clk_156, rst_n)
    begin
      if rst_n = '0' then
        val_in_reg <= '0';
        val_in_reg2 <= '0';
      elsif clk_156'event and clk_156 = '1' then
        val_in_reg <= val_in;
        val_in_reg2 <= val_in_reg;
      end if;
    end process;
    wen_fifo_0 <= val_in or val_in_reg2;
    w_eop_fifo_0 <= eop_in & mod_in;

    payload_in: entity work.data_frame_fifo port map(
      clk      => clk_156,
      rst_n    => rst_n,

      data_in  => data_in,
      eop_in   => w_eop_fifo_0,
      sop_in   => sop_in,
      val_in   => val_in,
      wen      => wen_fifo_0,
      full     => full_fifo_0,

      data_out => r_data_fifo_0,
      eop_out  => r_eop_fifo_0,
      sop_out  => r_sop_fifo_0,
      val_out  => r_val_fifo_0,
      ren      => ren_fifo_0,
      empty    => empty_fifo_0,
      almost_e => almost_e_fifo_0,
      almost_f => almost_f_fifo_0
    );

    frame: entity work.frame_builder port map(
      clk      => clk_156,
      rst      => rst_n,

      data_in  => r_data_fifo_0,
      sop_in   => r_sop_fifo_0,
      eop_in   => r_eop_fifo_0,
      val_in   => r_val_fifo_0,
      almost_e => almost_e_fifo_0,
      almost_f => almost_f_fifo_0,

      ren_out => ren_fifo_0,
      wen_out => wen_fifo_1,
      frame_out => w_frame_fifo_1,
      eop_out   => w_eop_fifo_1,
      sop_out   => w_sop_fifo_1,
      val_out   => w_val_fifo_1
    );

    frame_out: entity work.data_frame_fifo port map(
      clk      => clk_156,
      rst_n    => rst_n,
      -- provalvelmente vai entrar clock e rst do MII

      data_in  => w_frame_fifo_1,
      eop_in   => w_eop_fifo_1,
      sop_in   => w_sop_fifo_1,
      val_in   => w_val_fifo_1,
      wen      => w_val_fifo_1,
      ren      => ren_fifo_1,

      data_out => r_frame_fifo_1,
      eop_out  => r_eop_fifo_1,
      sop_out  => r_sop_fifo_1,
      val_out  => r_val_fifo_1,
      almost_f => almost_f_fifo_1,
      full     => full_fifo_1,
      almost_e => almost_e_fifo_1,
      empty    => empty_fifo_1
    );

    mii: entity work.mii_if port map(
      clk      => clk_156,
      rst      => rst_n,

      data_in  => r_frame_fifo_1,
      eop_in   => r_eop_fifo_1,
      sop_in   => r_sop_fifo_1,
      val_in   => r_val_fifo_1,
      almost_e => almost_e_fifo_1,
      almost_f => almost_f_fifo_1,
      empty    => empty_fifo_1,
      full     => full_fifo_1,

      ren_out  => ren_fifo_1,
      mii_data_0_out => mii_data_0,
      mii_ctrl_0_out => mii_ctrl_0,
      mii_data_1_out => mii_data_1,
      mii_ctrl_1_out => mii_ctrl_1,
      mii_data_2_out => mii_data_2,
      mii_ctrl_2_out => mii_ctrl_2,
      mii_data_3_out => mii_data_3,
      mii_ctrl_3_out => mii_ctrl_3
    );

end behav_mac_tx_path;
