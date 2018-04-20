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
    signal ps_crc;

    type frame_fsm_states is (IDLE, WAIT_CRC, PREAM, READ_FIFO, EOP, IPG);
    signal ps_frame, ns_frame;

    signal data : std_logic_vector(255 downto 0);
    signal eop  : std_logic_vector(  5 downto 0);
    signal sop  : std_logic;
    signal val  : std_logic;
    signal ren  : std_logic;
    signal wen  : std_logic;

  begin
    input_regs: process(clk, rst)
    begin
      if rst = '0' then
        data <= (others=>'0');
        eop <=  (others=>'0');
        sop <= '0';
        val <= '0';
        -- ren <= '0';
        -- wen <= '0';
      elsif clk'event and clk = '1' then
        data <= data_in;
        eop <= eop_in;
        sop <= sop_in;
        val <= val_in;
        -- ren <= ren_in
        -- wen <= wen_in
      end if;
    end process;

    -- CRC FINITE STATE MACHINE
    -- Will start calculating as soon as a new payload arrives. At the end of
    -- the reception of data, will output de frame crc value.


    -- FRAME FINITE STATE MACHINE
    -- At the beginning of a new payload, wait for some time so the crc is ready
    -- by the end of the transmission. Then, outputs the preamble and SFD followed
    -- by the data coming from data_in. Finally, finishes the frame writing the
    -- crc value.
    sync_proc_frame: process(clk, rst)
    begin
      if rst = '0' then
        ps_frame <= IDLE;
      elsif clk'event and clk = '1' then
        ps_frame <= ns_frame;
      end if;
    end process;

    frame_decoder: process(ps_frame, eop_in, sop_in, data_in)
    begin
      case ps_frame is
        when IDLE =>
        when WAIT_CRC =>
        when PREAM =>
        when READ_FIFO =>
        when EOP =>
        when IPG =>
        when others =>
      end case;
    end process;

    ns_decoder: process(ps_frame, eop_in, sop_in, data_in)
    begin
      case ps_frame is
        when IDLE =>
        when WAIT_CRC =>
        when PREAM =>
        when READ_FIFO =>
        when EOP =>
        when IPG =>
        when others =>
      end case;
    end process;


  end behav_frame_builder;
