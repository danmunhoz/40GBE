library ieee;
  use ieee.std_logic_1164.all;

package PKG_CODES is
  constant SFD        : std_logic_vector(7 downto 0) := x"d5";
  constant PREAM_8    : std_logic_vector(7 downto 0) := x"55";
  constant START      : std_logic_vector(7 downto 0) := x"fb";
  constant TERMINATE  : std_logic_vector(7 downto 0) := x"fd";
  constant CODE_ERROR : std_logic_vector(7 downto 0) := x"fe";
  constant LANE_ERROR : std_logic_vector(63 downto 0) := CODE_ERROR & CODE_ERROR & CODE_ERROR & CODE_ERROR & CODE_ERROR & CODE_ERROR & CODE_ERROR & CODE_ERROR;
  constant PREAMBLE   : std_logic_vector(63 downto 0) := START & PREAM_8 & PREAM_8 & PREAM_8 & PREAM_8 & PREAM_8 & PREAM_8 & SFD;
end PKG_CODES;

library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use ieee.std_logic_unsigned.all;
use work.PKG_CODES.all;

entity frame_builder is
  port(
    -- INPUTS
  clk       : in std_logic;
  rst       : in std_logic;
  data_in   : in std_logic_vector(255 downto 0);
  eop_in    : in std_logic_vector(  5 downto 0);
  sop_in    : in std_logic;
  val_in    : in std_logic;
  almost_f  : in std_logic;
  almost_e  : in std_logic;
    --OUTPUTS
  ren_out   : out std_logic;
  wen_out   : out std_logic;
  frame_out : out std_logic_vector(255 downto 0);
  eop_out   : out std_logic_vector(  5 downto 0);
  sop_out   : out std_logic;
  val_out   : out std_logic
  );
end entity;

architecture behav_frame_builder of frame_builder is

    type crc_fsm_states is (S_IDLE, S_D128, S_D64, S_D8_0, S_D8_1, S_D8_2, S_D8_3, S_D8_4, S_D8_5, S_D8_6, S_D8_7, S_DONE);
    signal ps_crc : crc_fsm_states;

    type frame_fsm_states is (S_IDLE, S_WAIT_CRC, S_PREAM, S_READ_FIFO, S_EOP, S_IPG, S_ERROR);
    signal ps_frame : frame_fsm_states;
    signal ns_frame : frame_fsm_states;

    signal data_0 : std_logic_vector(63 downto 0);
    signal data_1 : std_logic_vector(63 downto 0);
    signal data_2 : std_logic_vector(63 downto 0);
    signal data_3 : std_logic_vector(63 downto 0);
    signal data_3_o : std_logic_vector(63 downto 0);

    signal eop_reg_in : std_logic_vector( 5 downto 0);
    signal sop_reg_in : std_logic;
    signal val_reg_in : std_logic;
    signal frame_reg  : std_logic_vector(255 downto 0);

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
        eop_reg_in <=  (others=>'0');
        sop_reg_in <= '0';
        val_reg_in <= '0';
        -- ren <= '0';
        -- wen <= '0';
      elsif clk'event and clk = '1' then
        if (enable_regs = '1') then
          data_0 <= data_in(63 downto 0);
          data_1 <= data_in(127 downto 64);
          data_2 <= data_in(191 downto 128);
          data_3 <= data_in(255 downto 192);
          data_3_o <= data_3;
          eop_reg_in <= eop_in;
          sop_reg_in <= sop_in;
          val_reg_in <= val_in;
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

    frame_output_decoder: process(ps_frame, eop_reg_in, sop_reg_in, val_reg_in, data_0, data_1, data_2, data_3, almost_e)
    begin
      enable_regs <= '1';
      frame_out <= (others=>'0');
      eop_out <= (others=>'0');
      sop_out <= '0';
      val_out <= '0';
      ren <= '0';
      wen <= '0';

      case ps_frame is
        when S_IDLE =>
          ren <= '1';

          if (sop_reg_in = '1') then
            enable_regs <= '0'; -- So that CRC has time to calculate it
            ren <= '0';
          end if;

          wait_cnt <= "000";

        when S_WAIT_CRC =>
          if (wait_cnt <= "111") then
            wait_cnt <= wait_cnt + 1;
          end if;

        when S_PREAM =>
          frame_reg <= data_2 & data_1 & data_0 & PREAMBLE;
          eop_out <= "100000";
          sop_out <= '1';
          val_out <= '1';

          ren <= '1';
          wen <= '1';

        when S_READ_FIFO =>
          frame_reg <= data_2 & data_1 & data_0 & data_3_o;
          eop_out <= "100000";
          sop_out <= '0';
          val_out <= '1';

          ren <= '1';
          wen <= '1';

        when S_EOP =>
          frame_reg <= data_2 & data_1 & data_0 & PREAMBLE;
          eop_out <= eop_reg_in;
          sop_out <= '0';
          val_out <= '1';

        when S_IPG =>
          frame_reg <= LANE_ERROR & LANE_ERROR & LANE_ERROR & LANE_ERROR; -- Nao lembro do codigo de IDLE

        when S_ERROR =>
          frame_reg <= LANE_ERROR & LANE_ERROR & LANE_ERROR & LANE_ERROR;

        when others => null;
      end case;

      -- Safety measures...
      if (almost_e = '1') then
        ren <= '0';
      end if;
      if (almost_f = '1') then
        wen <= '0';
      end if;

    end process;

    frame_ns_decoder: process(ps_frame, eop_reg_in, sop_reg_in, data_0, data_1, data_2, data_3)
    begin
      case ps_frame is
        when S_IDLE =>
          if (sop_reg_in = '1') then
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
          if (eop_reg_in = "10000") then
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

        when S_ERROR =>
        when others => null;
      end case;
    end process;


  end behav_frame_builder;
