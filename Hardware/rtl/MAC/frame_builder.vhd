library ieee;
  use ieee.std_logic_1164.all;

package PKG_CODES is
  constant SFD            : std_logic_vector(7 downto 0) := x"d5";
  constant PREAM_8        : std_logic_vector(7 downto 0) := x"55";
  constant START          : std_logic_vector(7 downto 0) := x"fb";
  constant TERMINATE      : std_logic_vector(7 downto 0) := x"fd";
  constant CODE_ERROR     : std_logic_vector(7 downto 0) := x"fe";
  constant CODE_CTRL_IDLE : std_logic_vector(7 downto 0) := x"ff";
  constant CODE_IDLE      : std_logic_vector(7 downto 0) := x"07";
  constant LANE_ERROR     : std_logic_vector(63 downto 0) := CODE_ERROR & CODE_ERROR & CODE_ERROR & CODE_ERROR & CODE_ERROR & CODE_ERROR & CODE_ERROR & CODE_ERROR;
  constant PREAMBLE       : std_logic_vector(63 downto 0) := START & PREAM_8 & PREAM_8 & PREAM_8 & PREAM_8 & PREAM_8 & PREAM_8 & SFD;
  constant LANE_IDLE      : std_logic_vector(63 downto 0) := CODE_IDLE & CODE_IDLE & CODE_IDLE & CODE_IDLE & CODE_IDLE & CODE_IDLE & CODE_IDLE & CODE_IDLE;
end PKG_CODES;

library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use ieee.std_logic_unsigned.all;
  use work.PKG_CODES.all;
  use work.PCK_CRC32_D8.all;
  use work.PCK_CRC32_D32.all;
  use work.PCK_CRC32_D64.all;
  use work.PCK_CRC32_D128.all;
  use work.PCK_CRC32_D256.all;
  use work.lane_defs.all;
  use work.rev_func.all;

entity frame_builder is
  port(
    -- INPUTS
  clk       : in std_logic;
  rst       : in std_logic;
  data_in   : in std_logic_vector(255 downto 0);
  eop_in    : in std_logic_vector(5 downto 0);
  sop_in    : in std_logic_vector(1 downto 0);
  val_in    : in std_logic;
  almost_f  : in std_logic;
  almost_e  : in std_logic;
    --OUTPUTS
  ren_out   : out std_logic;
  wen_out   : out std_logic;
  frame_out : out std_logic_vector(255 downto 0);
  eop_out   : out std_logic_vector(5 downto 0);
  sop_out   : out std_logic_vector(1 downto 0);
  val_out   : out std_logic
  );
end entity;

architecture behav_frame_builder of frame_builder is

    type crc_fsm_states is (S_IDLE, S_D256, S_D128_64, S_D128, S_D64, S_D32, S_D8, S_DONE);
    signal ps_crc : crc_fsm_states;
    signal ns_crc : crc_fsm_states;

    type frame_fsm_states is (S_IDLE, S_WAIT_CRC, S_PREAM, S_READ_FIFO, S_EOP, S_ERROR);
    signal ps_frame : frame_fsm_states;
    signal ns_frame : frame_fsm_states;

    signal data_0 : std_logic_vector(63 downto 0);
    signal data_1 : std_logic_vector(63 downto 0);
    signal data_2 : std_logic_vector(63 downto 0);
    signal data_3 : std_logic_vector(63 downto 0);
    signal data_2_o : std_logic_vector(63 downto 0);
    signal data_3_o : std_logic_vector(63 downto 0);

    signal data_fifo_out : std_logic_vector(255 downto 0);
    signal eop_fifo_out : std_logic_vector(5 downto 0);
    signal sop_fifo_out : std_logic_vector(1 downto 0);
    signal val_fifo_out : std_logic;

    signal eop_reg_in : std_logic_vector(5 downto 0);
    signal sop_reg_in : std_logic_vector(1 downto 0);
    signal val_reg_in : std_logic;

    signal sop_int    : std_logic_vector(1 downto 0);
    signal val_int    : std_logic;
    signal eop_int    : std_logic_vector(5 downto 0);
    signal frame_int  : std_logic_vector(255 downto 0);

    signal ren_in  : std_logic;

    signal ren_hold  : std_logic;
    signal wen_hold  : std_logic;

    signal enable_regs : std_logic;
    signal wait_cnt : std_logic_vector(2 downto 0);

    signal frame_shift : std_logic; -- Indicates whether the packet started at byte 0 or 16

    signal crc_by_byte : std_logic_vector(2 downto 0);
    signal crc_final : std_logic_vector(31 downto 0);
    signal crc_reg : std_logic_vector(31 downto 0);
    signal crc_done : std_logic;

  begin

    ren_out <= ren_in when rst = '1' else '0';
    wen_out <= wen_hold when rst = '1' else '0';
    frame_out <= frame_int;
    eop_out <= eop_int;
    sop_out <= sop_int;
    val_out <= val_int;

    crc_final <= not(reverse(crc_reg));

    input_regs: process(clk, rst)
    begin
      if rst = '0' then
        data_0 <= (others=>'0');
        data_1 <= (others=>'0');
        data_2 <= (others=>'0');
        data_3 <= (others=>'0');
        data_3_o <= (others=>'0');
        data_2_o <= (others=>'0');
        eop_reg_in <=  (others=>'0');
        sop_reg_in <= (others=>'0');
        val_reg_in <= '0';
        frame_shift <= '0';
      elsif clk'event and clk = '1' then
        data_0 <= data_fifo_out(63 downto 0);
        data_1 <= data_fifo_out(127 downto 64);
        data_2 <= data_fifo_out(191 downto 128);
        data_3 <= data_fifo_out(255 downto 192);
        data_3_o <= data_3;
        data_2_o <= data_2;
        eop_reg_in <= eop_fifo_out;
        sop_reg_in <= sop_fifo_out;
        val_reg_in <= val_fifo_out;

        if (sop_fifo_out = "10") then
        -- Update
          frame_shift <= '0';
        elsif (sop_fifo_out = "11") then
        -- Update
          frame_shift <= '1';
        elsif (val_fifo_out = '1') then
        -- Keep it accross the packet
          frame_shift <= frame_shift;
        else
        -- Default
          frame_shift <= '0';
        end if;

      end if;
    end process;

    -- HOLD FIFO
    hold_fifo: entity work.data_frame_fifo port map(
      clk      => clk,
      rst_n    => rst,

      data_in  => data_in,
      eop_in   => eop_in,
      sop_in   => sop_in,
      val_in   => val_in,
      wen      => val_in,
      full     => open,
      empty    => open,
      almost_e => open,
      almost_f => open,
      ren      => ren_hold,
      data_out => data_fifo_out,
      eop_out  => eop_fifo_out,
      sop_out  => sop_fifo_out,
      val_out  => val_fifo_out
      );

    -- CRC FINITE STATE MACHINE
    -- Will start calculating as soon as a new payload arrives. At the end of
    -- the reception of data, will output de frame crc value.
    sunc_proc_crc: process(clk, rst)
    begin
      if rst = '0' then
        ps_crc <= S_IDLE;
      elsif clk'event and clk = '1' then
        ps_crc <= ns_crc;
      end if;
    end process;

    crc_output_decoder: process(ps_crc, clk, rst, almost_e)
    begin
      if rst = '0' then
        crc_reg <= (others=>'1');
        crc_done <= '0';
        ren_in <= '0';

      elsif clk'event and clk = '1' then
        ren_in <= '0';
        crc_done <= '0';

        case ps_crc is
          when S_IDLE =>
            if (almost_e = '1') then
              ren_in <= '0';
            else
              ren_in <= '1';
            end if;

          when S_D256 =>
            ren_in <= '1';
            crc_reg <= nextCRC32_D256(reverse(data_in), crc_reg);

          when S_D128_64 =>
            ren_in <= '1';
            crc_reg <= nextCRC32_D256(reverse(data_in(127 downto 0)), crc_reg);

          when S_D128 =>
            ren_in <= '1';
            crc_reg <= nextCRC32_D128(reverse(data_in(127 downto 0)), crc_reg);

          when S_D64 =>
            ren_in <= '1';
            crc_reg <= nextCRC32_D64(reverse(data_in(63 downto 0)), crc_reg);

          when S_D32 =>
            ren_in <= '1';
            crc_reg <= nextCRC32_D32(reverse(data_in(31 downto 0)), crc_reg);

          when S_D8 =>
            ren_in <= '1';
            crc_done <= '1';
            crc_reg <= nextCRC32_D8(reverse(data_in(7 downto 0)), crc_reg);

          when S_DONE =>
            ren_in <= '0';
            crc_reg <= (others=>'1');

          when others => null;
        end case;
      end if;
    end process;

    crc_ns_decoder: process(ps_crc, data_in, eop_in, sop_in, almost_e)
    begin

      case ps_crc is
        when S_IDLE =>
          if (sop_in = "10") then
            ns_crc <= S_D256;
          elsif (sop_in = "11") then
            ns_crc <= S_D128;
          else
            ns_crc <= S_IDLE;
          end if;

        when S_D256 =>
          if (eop_in(5) = '0') then
            -- Valid EOP

            if (eop_in(4 downto 0) <= "00011") then
              ns_crc <= S_D8;
              -- crc_by_byte <= eop_in(2 downto 0);    -- EOP locations from 0 to 3

            elsif (eop_in(4 downto 0) <= "00111") then
              ns_crc <= S_D32;
              -- crc_by_byte <= eop_in(2 downto 0);    -- EOP locations from 4 to 7

            elsif (eop_in(4 downto 0) <= "01111") then
              ns_crc <= S_D64;
              -- crc_by_byte <= eop_in(2 downto 0);   -- EOP locations from 8 to 15

            elsif (eop_in(4 downto 0) <= "10111") then
              ns_crc <= S_D128;
              -- crc_by_byte <= eop_in(2 downto 0);   -- EOP locations from 16 to 23

            elsif (eop_in(4 downto 0) <= "11111") then
              ns_crc <= S_D128_64;
              -- crc_by_byte <= eop_in(2 downto 0);  -- EOP locations from 24 to 31

            else
              ns_crc <= S_D256;
            end if;

          else
            ns_crc <= S_D256;
          end if;

        when S_D128_64 =>
          ns_crc <= S_D64;

        when S_D128 =>
          ns_crc <= S_D8;

        when S_D64 =>
          ns_crc <= S_D8;

        when S_D32 =>
          ns_crc <= S_D8;

        when S_D8 =>
          ns_crc <= S_DONE;

        when S_DONE =>
          -- if (almost_e = '1') then
            -- Wait some time here so the input fifo fill up
            -- ns_crc <= S_DONE;
          -- else
            ns_crc <= S_IDLE;
          -- end if;

        when others => null;
      end case;
    end process;


    -- FRAME FINITE STATE MACHINE
    -- At the beginning of a new payload, wait for some time so the crc is ready
    -- by the end of the transmission. Then, outputs the preamble and SFD followed
    -- by the data coming from data_in. Finally, finishes the frame writing the
    -- crc value. Note that IPG control is done by the mii_if module

    sync_proc_frame: process(clk, rst)
    begin
      if rst = '0' then
        ps_frame <= S_IDLE;
      elsif clk'event and clk = '1' then
        ps_frame <= ns_frame;
      end if;
    end process;

    frame_output_decoder: process(ps_frame, eop_reg_in, sop_reg_in, val_reg_in, data_0, data_1, data_2, data_3, almost_e, wait_cnt)
    begin
      enable_regs <= '1';
      frame_int <= (others=>'0');
      eop_int <= "100000";
      sop_int <= "00";
      val_int <= '0';
      ren_hold <= '0';
      wen_hold <= '0';

      case ps_frame is
        when S_IDLE =>
          ren_hold <= '1';
          wait_cnt <= "000";

          if (sop_reg_in = "10" or sop_reg_in = "11") then
            -- enable_regs <= '0'; -- So that CRC has time to calculate it
            ren_hold <= '0';
          end if;

        when S_WAIT_CRC =>
          enable_regs <= '0';

          if (wait_cnt < "111") then
            wait_cnt <= wait_cnt + 1;
          end if;

        when S_PREAM =>
          eop_int <= "100000";
          val_int <= '1';
          ren_hold <= '1';
          wen_hold <= '1';

          if (frame_shift = '0') then
            frame_int <= data_2 & data_1 & data_0 & PREAMBLE;
            sop_int <= "10";
          else
            frame_int <= data_2 & PREAMBLE & data_1 & data_0;
            sop_int <= "11";
          end if;

        when S_READ_FIFO =>
          eop_int <= "100000";
          val_int <= '1';
          ren_hold <= '1';
          wen_hold <= '1';
          sop_int <= "00";

          if (frame_shift = '0') then
            frame_int <= data_2 & data_1 & data_0 & data_3_o;
          else
            frame_int <= data_1 & data_0 & data_2_o & data_3_o;
          end if;

        when S_EOP =>
          sop_int <= "00";
          val_int <= '1';

          if (frame_shift = '0') then
            frame_int <= data_2 & data_1 & data_0 & data_3_o;
            eop_int <= eop_reg_in + 8;
          else
            frame_int <= data_1 & data_0 & data_3_o & data_2_o;
            eop_int <= eop_reg_in + 16;
          end if;

        when S_ERROR =>
          frame_int <= LANE_ERROR & LANE_ERROR & LANE_ERROR & LANE_ERROR;
          eop_int <= "100000";
          sop_int <= "00";
          val_int <= '0';

        when others => null;
      end case;
    end process;

    frame_ns_decoder: process(ps_frame, eop_reg_in, sop_reg_in, data_0, data_1, data_2, data_3, wait_cnt)
    begin
      case ps_frame is
        when S_IDLE =>
          if (sop_reg_in = "10" or sop_reg_in = "11") then
          -- If there is a packet starting at either lower or higher half
            ns_frame <= S_WAIT_CRC;
          end if;

        when S_WAIT_CRC =>
          if (wait_cnt < "111") then
            ns_frame <= S_WAIT_CRC;
          else
            ns_frame <= S_PREAM;
          end if;

        when S_PREAM =>
          ns_frame <= S_READ_FIFO;

        when S_READ_FIFO =>
          if (eop_reg_in = "100000") then
            ns_frame <= S_READ_FIFO;
          else
            ns_frame <= S_EOP;
          end if;

          if (sop_reg_in /= "00") then
            ns_frame <= S_ERROR;
          end if;

        when S_EOP =>
          ns_frame <= S_IDLE;

        when S_ERROR =>
          ns_frame <= S_IDLE;

        when others => null;

      end case;
    end process;


  end behav_frame_builder;
