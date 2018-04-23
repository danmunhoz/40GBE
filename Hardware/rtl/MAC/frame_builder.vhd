library ieee;
  use ieee.std_logic_1164.all;

package PKG_PREAM is
  constant SFD   : std_logic_vector(7 downto 0) := x"d5";
  constant P_8   : std_logic_vector(7 downto 0) := x"55";
  constant START : std_logic_vector(7 downto 0) := x"fb";
  constant PREAMBLE : std_logic_vector(63 downto 0) := START & P_8 & P_8 & P_8 & P_8 & P_8 & P_8 & SFD;
end PKG_PREAM;

library ieee;
  use ieee.std_logic_1164.all;
use work.PKG_PREAM.all;

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

    type crc_fsm_states is (S_IDLE, S_D128, S_D64, S_D8_0, S_D8_1, S_D8_2, S_D8_3, S_D8_4, S_D8_5, S_D8_6, S_D8_7, S_DONE);
    signal ps_crc;

    type frame_fsm_states is (S_IDLE, S_WAIT_CRC, S_PREAM, S_READ_FIFO, S_EOP, S_IPG);
    signal ps_frame, ns_frame;

    signal data_0 : std_logic_vector(63 downto 0);
    signal data_1 : std_logic_vector(63 downto 0);
    signal data_2 : std_logic_vector(63 downto 0);
    signal data_3 : std_logic_vector(63 downto 0);
    signal data_3_o : std_logic_vector(63 downto 0);
    signal eop  : std_logic_vector( 5 downto 0);
    signal sop  : std_logic;
    signal val  : std_logic;
    signal ren  : std_logic;
    signal wen  : std_logic;

    signal enable_regs : std_logic;
    signal wait_cnt : std_logic_vector(2 downto 0);

    signal ipg_deficit : std_logic_vector(2 downto 0); -- HOW BIG CAN IT BE?

  begin
    input_regs: process(clk, rst)
    begin
      if rst = '0' then
        data_0 <= (others=>'0');
        data_1 <= (others=>'0');
        data_2 <= (others=>'0');
        data_3 <= (others=>'0');
        data_3_o <= (others=>'0');
        eop <=  (others=>'0');
        sop <= '0';
        val <= '0';
        -- ren <= '0';
        -- wen <= '0';
      elsif clk'event and clk = '1' then
        if (enable_regs = '1')
          data_0 <= data_in(63 downto 0);
          data_1 <= data_in(127 downto 64);
          data_2 <= data_in(191 downto 128);
          data_3 <= data_in(255 downto 192);
          data_3_o <= data_3;
          eop <= eop_in;
          sop <= sop_in;
          val <= val_in;
          -- ren <= ren_in
          -- wen <= wen_in
        end if;
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
        ps_frame <= S_IDLE;
      elsif clk'event and clk = '1' then
        ps_frame <= ns_frame;
      end if;
    end process;

    frame_decoder: process(ps_frame, eop, sop, data)
    begin
      enable_regs <= '1';
      frame_out <= (others=>'0');
      eop_out <= (others=>'0');
      sop_out <= '0';
      val_out <= '0';
      case ps_frame is
        when S_IDLE =>
          if (sop = '1') then
            enable_regs <= '0'; -- So that CRC has time to calculate it
          end if;
          wait_cnt <= "000";

        when S_WAIT_CRC =>
          if (wait_cnt = "111") then
            ns_frame <= S_PREAM;
          else
            wait_cnt <= wait_cnt + 1;
          end if;

        when S_PREAM =>
          frame_out <= data_2 & data_1 & data_0 &
        when S_READ_FIFO =>
        when S_EOP =>
        when S_IPG =>
        when others =>
      end case;
    end process;

    ns_decoder: process(ps_frame, eop, sop, data)
    begin
      case ps_frame is
        when S_IDLE =>
          if (sop = '1') then
            ns_frame <= S_WAIT_CRC;
          end if;

        when S_WAIT_CRC =>
          if (wait_cnt = "111") then
            ns_frame <= S_PREAM;
          else
            ns_frame <= S_WAIT_CRC;
          end if;

        when S_PREAM =>
          ns_frame <= S_READ_FIFO;

        when S_READ_FIFO =>
          if (eop = "10000") Then
            ns_frame <= S_READ_FIFO;
          else
            ns_frame <= S_EOP;
          end if;

        when S_EOP =>
          ns_frame <= S_IPG;

        when S_IPG =>
          if (ipg_deficit = "000") then
            ns_frame <= S_IDLE;
          else
            ns_frame <= S_IPG;
          end if;
        when others =>
      end case;
    end process;


  end behav_frame_builder;
