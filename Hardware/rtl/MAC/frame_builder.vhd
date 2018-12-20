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
  constant PREAMBLE       : std_logic_vector(63 downto 0) := SFD & PREAM_8 & PREAM_8 & PREAM_8 & PREAM_8 & PREAM_8 & PREAM_8 & START;
  -- constant PREAMBLE       : std_logic_vector(63 downto 0) := START & PREAM_8 & PREAM_8 & PREAM_8 & PREAM_8 & PREAM_8 & PREAM_8 & SFD;
  constant LANE_IDLE      : std_logic_vector(63 downto 0) := CODE_IDLE & CODE_IDLE & CODE_IDLE & CODE_IDLE & CODE_IDLE & CODE_IDLE & CODE_IDLE & CODE_IDLE;
end PKG_CODES;

library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use ieee.std_logic_unsigned.all;
  use work.PKG_CODES.all;
  use work.lane_defs.all;
  use work.rev_func.all;

  use work.PCK_CRC32_D8.all;
  use work.PCK_CRC32_D16.all;
  use work.PCK_CRC32_D24.all;
  use work.PCK_CRC32_D32.all;
  use work.PCK_CRC32_D40.all;
  use work.PCK_CRC32_D48.all;
  use work.PCK_CRC32_D56.all;
  use work.PCK_CRC32_D64.all;
  use work.PCK_CRC32_D72.all;
  use work.PCK_CRC32_D80.all;
  use work.PCK_CRC32_D88.all;
  use work.PCK_CRC32_D96.all;
  use work.PCK_CRC32_D104.all;
  use work.PCK_CRC32_D112.all;
  use work.PCK_CRC32_D120.all;
  use work.PCK_CRC32_D128.all;
  use work.PCK_CRC32_D136.all;
  use work.PCK_CRC32_D144.all;
  use work.PCK_CRC32_D152.all;
  use work.PCK_CRC32_D160.all;
  use work.PCK_CRC32_D168.all;
  use work.PCK_CRC32_D176.all;
  use work.PCK_CRC32_D184.all;
  use work.PCK_CRC32_D192.all;
  use work.PCK_CRC32_D200.all;
  use work.PCK_CRC32_D208.all;
  use work.PCK_CRC32_D216.all;
  use work.PCK_CRC32_D224.all;
  use work.PCK_CRC32_D232.all;
  use work.PCK_CRC32_D240.all;
  use work.PCK_CRC32_D248.all;
  use work.PCK_CRC32_D256.all;

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

    constant ZEROS : std_logic_vector(255 downto 0) := (others=>'0');

    constant DATA_NVAL : std_logic_vector(255 downto 0) := (others=>'0');
    constant EOP_NVAL  : std_logic_vector(5 downto 0)   := (others=>'0');
    constant SOP_NVAL  : std_logic_vector(1 downto 0)   := (others=>'0');
    constant VAL_NVAL  : std_logic := '0';

    type crc_fsm_states is (S_IDLE, S_D256, S_D128, S_EOP, S_EOP_N);
    signal ps_crc : crc_fsm_states;
    signal ns_crc : crc_fsm_states;

    type frame_fsm_states is (S_IDLE, S_PREAM, S_READ_FIFO, S_EOP, S_EOP_N,
                              S_ERROR, S_WAIT_FIFO, S_WAIT_NOT_EMPTY);
    signal ps_frame : frame_fsm_states;
    signal ns_frame : frame_fsm_states;

    signal data_mux   : std_logic_vector(255 downto 0);
    signal eop_mux    : std_logic_vector(5 downto 0);
    signal sop_mux    : std_logic_vector(1 downto 0);
    signal val_mux    : std_logic;

    signal data_in_reg : std_logic_vector(255 downto 0);
    signal data_in_int : std_logic_vector(255 downto 0);
    signal data_0 : std_logic_vector(63 downto 0);
    signal data_1 : std_logic_vector(63 downto 0);
    signal data_2 : std_logic_vector(63 downto 0);
    signal data_3 : std_logic_vector(63 downto 0);
    signal data_0_o : std_logic_vector(63 downto 0);
    signal data_1_o : std_logic_vector(63 downto 0);
    signal data_2_o : std_logic_vector(63 downto 0);
    signal data_3_o : std_logic_vector(63 downto 0);

    signal data_3_oo : std_logic_vector(63 downto 0);

    signal data_fifo_out : std_logic_vector(255 downto 0);
    signal eop_fifo_out : std_logic_vector(5 downto 0);
    signal sop_fifo_out : std_logic_vector(1 downto 0);
    signal val_fifo_out : std_logic;

    signal eop_reg_reg_in : std_logic_vector(5 downto 0);
    signal eop_reg_in : std_logic_vector(5 downto 0);
    signal sop_reg_in : std_logic_vector(1 downto 0);
    signal sop_reg_reg_in : std_logic_vector(1 downto 0);
    signal val_reg_in : std_logic;

    signal sop_int    : std_logic_vector(1 downto 0);
    signal val_int    : std_logic;
    signal eop_int    : std_logic_vector(5 downto 0);
    signal eop_int_reg : std_logic_vector(5 downto 0);
    signal frame_int  : std_logic_vector(255 downto 0);

    signal frame_int_next  : std_logic_vector(255 downto 0);
    signal frame_int_next_o : std_logic_vector(255 downto 0);
    signal use_frame_next : std_logic;
    signal use_frame_next_reg : std_logic;
    signal last_in  : std_logic_vector(255 downto 0);
    signal last_eop : std_logic_vector(4 downto 0);
    signal deficit  : std_logic;
    signal deficit_reg : std_logic;

    signal ren_int         : std_logic;
    signal ren_int_reg     : std_logic;

    signal ren_hold      : std_logic;
    signal wen_hold      : std_logic;
    signal full_hold     : std_logic;
    signal empty_hold    : std_logic;
    signal almost_e_hold : std_logic;
    signal almost_f_hold : std_logic;
    signal almost_e_d    : std_logic;

    signal enable_wait_cnt : std_logic;
    signal wait_cnt : std_logic_vector(2 downto 0);

    signal frame_shift : std_logic; -- Indicates whether the packet started at byte 0 or 16
    signal one_deficit : std_logic;
    signal one_deficit_reg : std_logic;

    signal crc_by_byte : std_logic_vector(4 downto 0);
    signal data_range : integer;
    signal crc_final : std_logic_vector(31 downto 0);
    signal crc_reg : std_logic_vector(31 downto 0);

    signal flag_wait_fifo     : std_logic;
    signal flag_wait_fifo_d   : std_logic;

  begin

    data_mux <= data_in when ren_int = '1' else DATA_NVAL;
    eop_mux <= eop_in   when ren_int = '1' else EOP_NVAL;
    sop_mux <= sop_in   when ren_int = '1' else SOP_NVAL;
    val_mux <= val_in   when ren_int = '1' else VAL_NVAL;

    ren_out <= ren_int when rst = '1' else '0';
    wen_out <= wen_hold when rst = '1' else '0';
    frame_out <= frame_int_next when use_frame_next_reg = '1' and use_frame_next = '0' else frame_int;
    eop_out <= eop_int;
    sop_out <= sop_int;
    val_out <= val_int;

    -- crc_final <= not(reverse(crc_reg));
    -- crc_final <= crc_reg;

    -- Converte endianismo para pcs
    -- data_in_int <= data_mux(199 downto 192) & data_mux(207 downto 200) & data_mux(215 downto 208) & data_mux(223 downto 216) &
    --                data_mux(231 downto 224) & data_mux(239 downto 232) & data_mux(247 downto 240) & data_mux(255 downto 248) &

    --                data_mux(135 downto 128) & data_mux(143 downto 136) & data_mux(151 downto 144) & data_mux(159 downto 152) &
    --                data_mux(167 downto 160) & data_mux(175 downto 168) & data_mux(183 downto 176) & data_mux(191 downto 184) &

    --                data_mux( 71 downto  64) & data_mux( 79 downto  72) & data_mux( 87 downto  80) & data_mux( 95 downto  88) &
    --                data_mux(103 downto  96) & data_mux(111 downto 104) & data_mux(119 downto 112) & data_mux(127 downto 120) &

    --                data_mux( 7 downto  0) & data_mux(15 downto  8) & data_mux(23 downto 16) & data_mux(31 downto 24) &
    --                data_mux(39 downto 32) & data_mux(47 downto 40) & data_mux(55 downto 48) & data_mux(63 downto 56);

    data_in_int <=  data_mux;

    input_regs: process(clk, rst)
    begin
      if rst = '0' then
        data_in_reg <= (others=>'0');
        data_0 <= (others=>'0');
        data_1 <= (others=>'0');
        data_2 <= (others=>'0');
        data_3 <= (others=>'0');
        data_3_o <= (others=>'0');
        data_3_oo <= (others=>'0');
        data_2_o <= (others=>'0');
        data_1_o <= (others=>'0');
        data_0_o <= (others=>'0');
        eop_int_reg <= (others=>'0');
        eop_reg_in <=  (others=>'0');
        eop_reg_reg_in <=  (others=>'0');
        sop_reg_in <= (others=>'0');
        sop_reg_reg_in <= (others=>'0');
        val_reg_in <= '0';
        frame_shift <= '0';
        wait_cnt <= "000";
        use_frame_next_reg <= '0';
        one_deficit_reg <= '0';
        frame_int_next_o <= (others=>'0');
        ren_int_reg <= '0';
        deficit_reg <= '0';
        flag_wait_fifo_d <= '0';
        almost_e_d <= '0';
        crc_final <= (others=>'0');

      elsif clk'event and clk = '1' then

        frame_int_next_o <= frame_int_next;
        data_0 <= data_in_reg(63 downto 0);
        data_1 <= data_in_reg(127 downto 64);
        data_2 <= data_in_reg(191 downto 128);
        data_3 <= data_in_reg(255 downto 192);
        eop_reg_in <= eop_mux;
        eop_reg_reg_in <= eop_reg_in;
        sop_reg_in <= sop_mux;
        sop_reg_reg_in <= sop_reg_in;
        val_reg_in <= val_mux;
        data_0_o <= data_0;
        data_1_o <= data_1;
        data_2_o <= data_2;
        data_3_o <= data_3;
        data_3_oo <= data_3_o;
        ren_int_reg <= ren_int;
        deficit_reg <= deficit;
        almost_e_d <= almost_e;
        crc_final <= crc_reg;

        if sop_reg_reg_in /= "00" then
          flag_wait_fifo_d <= flag_wait_fifo;
        end if;

        if ren_int = '1' then
          data_in_reg <= data_mux;
        end if;

        -- if (ps_frame = S_WAIT_FIFO) then
          -- data_3_o <= data_3_o;
        -- else
          -- data_3_o <= data_3;
        -- end if;

        use_frame_next_reg <= use_frame_next;
        if (eop_reg_reg_in > 19) then
          eop_int_reg <= eop_reg_reg_in - 20;
        end if;

        if (sop_reg_in = "10") then
        -- Update
          frame_shift <= '0';
        elsif (sop_reg_in = "11") then
        -- Update
          frame_shift <= '1';
        elsif (val_mux = '1') then
        -- Keep it accross the packet
          frame_shift <= frame_shift;
        else
        -- Default
          frame_shift <= '0';
        end if;

        if (sop_reg_in(1) = '1') then
          one_deficit_reg <= one_deficit;
        else
          one_deficit_reg <= one_deficit_reg;
        end if;

        if (enable_wait_cnt = '1') then
          wait_cnt <= wait_cnt + 1;
        end if;

      end if;
    end process;

    -- CRC FINITE STATE MACHINE
    -- Will start calculating as soon as a new payload arrives. At the end of
    -- the reception of data, will output de frame crc value.
    sinc_proc_crc: process(clk, rst)
    begin
      if rst = '0' then
        ps_crc <= S_IDLE;
      elsif clk'event and clk = '1' then
        ps_crc <= ns_crc;
      end if;
    end process;

    crc_output_decoder: process(clk, rst)
    begin
      if rst = '0' then
        crc_reg <= (others=>'1');
        ren_int <= '0';
        last_in <= (others=>'0');
        last_eop <= (others=>'0');
        crc_by_byte <= (others=>'0');

      elsif clk'event and clk = '1' then
        -- ren_int <= '0';

        last_in <= data_3 & data_2 & data_1 & data_0;

        case ps_crc is
          when S_IDLE =>
            -- if (almost_e = '1') then
            -- -- if (almost_e = '1' and val_in = '0') then
            --   ren_int <= '0';
            -- else
            --   ren_int <= '1';
            -- end if;
            ren_int <= '1';

            -- Para nao perder um ciclo
            if (sop_mux = "10") then
              crc_reg <= nextCRC32_D256(reverse(data_in_int), crc_reg);
            elsif (sop_mux = "11") then
              crc_reg <= nextCRC32_D128(reverse(data_in_int(255 downto 128)), crc_reg);
            end if;

          when S_D256 =>
            if ren_int_reg = '1' then
              if (almost_e = '1' and eop_mux(5) = '0') then
                ren_int <= '0';
              else
                ren_int <= '1';
              end if;

              -- Para quando nao passou pelo S_DONE
              if (sop_mux = "10") then
                crc_reg <= nextCRC32_D256(reverse(data_mux), x"FFFFFFFF");
              elsif (sop_mux = "11") then
                crc_reg <= nextCRC32_D128(reverse(data_mux(255 downto 128)), x"FFFFFFFF");
              elsif (eop_mux(5) = '0') then
                case eop_mux(4 downto 0) is
                  when "00000" =>
                    crc_reg <= nextCRC32_D8(reverse(data_mux(7 downto 0)), crc_reg);
                  when "00001" =>
                    crc_reg <= nextCRC32_D16(reverse(data_mux(15 downto 0)), crc_reg);
                  when "00010" =>
                    crc_reg <= nextCRC32_D24(reverse(data_mux(23 downto 0)), crc_reg);
                  when "00011" =>
                    crc_reg <= nextCRC32_D32(reverse(data_mux(31 downto 0)), crc_reg);
                  when "00100" =>
                    crc_reg <= nextCRC32_D40(reverse(data_mux(39 downto 0)), crc_reg);
                  when "00101" =>
                    crc_reg <= nextCRC32_D48(reverse(data_mux(47 downto 0)), crc_reg);
                  when "00110" =>
                    crc_reg <= nextCRC32_D56(reverse(data_mux(55 downto 0)), crc_reg);
                  when "00111" =>
                    crc_reg <= nextCRC32_D64(reverse(data_mux(63 downto 0)), crc_reg);
                  when "01000" =>
                    crc_reg <= nextCRC32_D72(reverse(data_mux(71 downto 0)), crc_reg);
                  when "01001" =>
                    crc_reg <= nextCRC32_D80(reverse(data_mux(79 downto 0)), crc_reg);
                  when "01010" =>
                    crc_reg <= nextCRC32_D88(reverse(data_mux(87 downto 0)), crc_reg);
                  when "01011" =>
                    crc_reg <= nextCRC32_D96(reverse(data_mux(95 downto 0)), crc_reg);
                  when "01100" =>
                    crc_reg <= nextCRC32_D104(reverse(data_mux(103 downto 0)), crc_reg);
                  when "01101" =>
                    crc_reg <= nextCRC32_D112(reverse(data_mux(111 downto 0)), crc_reg);
                  when "01110" =>
                    crc_reg <= nextCRC32_D120(reverse(data_mux(119 downto 0)), crc_reg);
                  when "01111" =>
                    crc_reg <= nextCRC32_D128(reverse(data_mux(127 downto 0)), crc_reg);
                  when "10000" =>
                    crc_reg <= nextCRC32_D136(reverse(data_mux(135 downto 0)), crc_reg);
                  when "10001" =>
                    crc_reg <= nextCRC32_D144(reverse(data_mux(143 downto 0)), crc_reg);
                  when "10010" =>
                    crc_reg <= nextCRC32_D152(reverse(data_mux(151 downto 0)), crc_reg);
                  when "10011" =>
                    crc_reg <= nextCRC32_D160(reverse(data_mux(159 downto 0)), crc_reg);
                  when "10100" =>
                    crc_reg <= nextCRC32_D168(reverse(data_mux(167 downto 0)), crc_reg);
                  when "10101" =>
                    crc_reg <= nextCRC32_D176(reverse(data_mux(175 downto 0)), crc_reg);
                  when "10110" =>
                    crc_reg <= nextCRC32_D184(reverse(data_mux(183 downto 0)), crc_reg);
                  when "10111" =>
                    crc_reg <= nextCRC32_D192(reverse(data_mux(191 downto 0)), crc_reg);
                  when "11000" =>
                    crc_reg <= nextCRC32_D200(reverse(data_mux(199 downto 0)), crc_reg);
                  when "11001" =>
                    crc_reg <= nextCRC32_D208(reverse(data_mux(207 downto 0)), crc_reg);
                  when "11010" =>
                    crc_reg <= nextCRC32_D216(reverse(data_mux(215 downto 0)), crc_reg);
                  when "11011" =>
                    crc_reg <= nextCRC32_D224(reverse(data_mux(223 downto 0)), crc_reg);
                  when "11100" =>
                    crc_reg <= nextCRC32_D232(reverse(data_mux(231 downto 0)), crc_reg);
                  when "11101" =>
                    crc_reg <= nextCRC32_D240(reverse(data_mux(239 downto 0)), crc_reg);
                  when "11110" =>
                    crc_reg <= nextCRC32_D248(reverse(data_mux(247 downto 0)), crc_reg);
                  when "11111" =>
                    crc_reg <= nextCRC32_D256(reverse(data_mux(255 downto 0)), crc_reg);
                  when others =>
                end case;
              else
                crc_reg <= nextCRC32_D256(reverse(data_mux), crc_reg);
              end if;

            else
            end if; -- testando a não atualização do crc

          when S_D128 =>
            ren_int <= '1';
            -- Packet started at higher half
            crc_reg <= nextCRC32_D128(reverse(data_in_int(255 downto 128)), crc_reg);

          when S_EOP =>
            crc_reg <= (others=>'1');
            if eop_reg_in >= "10100" and eop_reg_in < "100000" and sop_mux = "10" then -- tanauan eop acima do 20ºbyte
              ren_int <= '0';
            end if;
            if (almost_e = '1') then
            -- if (almost_e = '1' and val_in = '0' ) then
              ren_int <= '0';
            else
              ren_int <= '1';
            end if;
            if sop_mux = "10" then
              crc_reg <= nextCRC32_D256(reverse(data_mux), x"FFFFFFFF");
            elsif sop_mux = "11" then
              crc_reg <= nextCRC32_D128(reverse(data_mux(255 downto 128)), x"FFFFFFFF");
            end if;

          when S_EOP_N =>
            ren_int <= '0';

          when others => null;

        end case;
      end if;
    end process;

    crc_ns_decoder: process(ps_crc, data_in_int, eop_mux, sop_mux, almost_e)
    begin

      case ps_crc is
        when S_IDLE =>
          -- if (sop_mux = "10" and almost_e = '0') then
          if (sop_mux = "10" ) then
            -- Wiat until there is no risk in start reading
            ns_crc <= S_D256;
          -- elsif (sop_mux = "11" and almost_e = '0') then
          elsif (sop_mux = "11") then
            -- ns_crc <= S_D128;
            ns_crc <= S_D256;
          else
            ns_crc <= S_IDLE;
          end if;

        when S_D256 =>
          if (eop_mux(5) = '0') then
            ns_crc <= S_EOP;
          else
            ns_crc <= S_D256;
          end if;

        when S_D128 =>
          ns_crc <= S_D256;

        when S_EOP =>
          -- if (eop_reg_in(4 downto 0) >= "01100") then
          --   ns_crc <= S_EOP_N;
          if (almost_e = '1') then
            ns_crc <= S_EOP;
          elsif (sop_mux = "10") then
            ns_crc <= S_D256;
          elsif (sop_mux = "11") then
            -- ns_crc <= S_D128;
            ns_crc <= S_D256;
          else
            ns_crc <= S_IDLE;
          end if;

        when S_EOP_N =>
          ns_crc <= S_IDLE;

      end case;
    end process;


    -- FRAME FINITE STATE MACHINE
    -- At the beginning of a new payload, wait for some time so the crc is ready
    -- by the end of the transmission. Then, outputs the preamble and SFD followed
    -- by the data coming from data_in_int. Finally, finishes the frame writing the
    -- crc value. Note that IPG control is done by the mii_if module

    sync_proc_frame: process(clk, rst)
    begin
      if rst = '0' then
        ps_frame <= S_IDLE;
      elsif clk'event and clk = '1' then
        ps_frame <= ns_frame;
      end if;
    end process;

    frame_output_decoder: process(ps_frame, eop_reg_in, sop_reg_in, val_reg_in,
                                  data_0, data_1, data_2, data_3, almost_e, sop_reg_in,
                                  data_0_o, data_1_o, data_2_o, data_3_o, wait_cnt,
                                  eop_reg_reg_in, flag_wait_fifo_d, crc_final,
                                  sop_reg_reg_in)
    begin
      enable_wait_cnt <= '0';
      frame_int <= (others=>'0');
      frame_int_next <= (others=>'0');
      eop_int <= "100000";
      sop_int <= "00";
      val_int <= '0';
      ren_hold <= '0';
      wen_hold <= '0';
      use_frame_next <= '0';
      one_deficit <= '0';
      deficit <= '0';
      flag_wait_fifo <= '0';


      case ps_frame is
        when S_IDLE =>
          ren_hold <= '1';

          -- if (sop_reg_in = "10" or sop_reg_in = "11") then
          if (sop_fifo_out = "10" or sop_fifo_out = "11") then
            -- enable_wait_cnt <= '0'; -- So that CRC has time to calculate it
            ren_hold <= '0';
          end if;

        when S_PREAM =>
          eop_int <= "100000";
          val_int <= '1';
          ren_hold <= '1';
          wen_hold <= '1';

          if (frame_shift = '0' and one_deficit_reg = '0') then
            frame_int <= data_2 & data_1 & data_0 & PREAMBLE;
            sop_int <= "10";
          elsif (frame_shift = '1' and one_deficit_reg = '0') then
            frame_int <= data_2 & PREAMBLE & data_1 & data_0;
            sop_int <= "11";
          -- else
          --   frame_int <= data_0 & data_3_o & data_2_o & PREAMBLE;
          --   -- sop_int <= "10";
          end if;

        when S_READ_FIFO =>
          eop_int <= "100000";
          val_int <= '1';
          ren_hold <= '1';
          wen_hold <= '1';
          sop_int <= "00";
          if flag_wait_fifo_d = '1' then
            -- frame_int <= data_2_o & data_1_o & data_0_o & data_3_o;
            frame_int <= data_2_o & data_1_o & data_0_o & data_3_oo;
          else
            frame_int <= data_2 & data_1 & data_0 & data_3_o;
          end if;

        when S_EOP =>
          sop_int <= "00";
          val_int <= '1';
          eop_int <= '0' & eop_reg_reg_in(4 downto 0) + 8 + 4;

          case eop_reg_reg_in(4 downto 0) is
            when "00000" =>
                frame_int <= ZEROS(255 downto 104) & crc_final & data_0(7 downto 0) & data_3_o;

            when "00001" =>
                frame_int <= ZEROS(255 downto 112) & crc_final & data_0(15 downto 0) & data_3_o;

            when "00010" =>
                frame_int <= ZEROS(255 downto 120) & crc_final & data_0(23 downto 0) & data_3_o;

            when "00011" =>
                frame_int <= ZEROS(255 downto 128) & crc_final & data_0(31 downto 0) & data_3_o;

            when "00100" =>
                frame_int <= ZEROS(255 downto 136) & crc_final & data_0(39 downto 0) & data_3_o;

            when "00101" =>
                frame_int <= ZEROS(255 downto 144) & crc_final & data_0(47 downto 0) & data_3_o;

            when "00110" =>
                frame_int <= ZEROS(255 downto 152) & crc_final & data_0(55 downto 0) & data_3_o;

            when "00111" =>
                frame_int <= ZEROS(255 downto 160) & crc_final & data_0 & data_3_o;

            when "01000" =>
                frame_int <= ZEROS(255 downto 168) & crc_final & data_1(7 downto 0) & data_0 & data_3_o;

            when "01001" =>
                frame_int <= ZEROS(255 downto 176) & crc_final & data_1(15 downto 0) & data_0 & data_3_o;

            when "01010" =>
                frame_int <= ZEROS(255 downto 184) & crc_final & data_1(23 downto 0) & data_0 & data_3_o;

            when "01011" =>
                frame_int <= ZEROS(255 downto 192) & crc_final & data_1(31 downto 0) & data_0 & data_3_o;

            when "01100" =>
                frame_int <= ZEROS(255 downto 200) & crc_final & data_1(39 downto 0) & data_0 & data_3_o;

            when "01101" =>
                frame_int <= ZEROS(255 downto 208) & crc_final & data_1(47 downto 0) & data_0 & data_3_o;

            when "01110" =>
                frame_int <= ZEROS(255 downto 216) & crc_final & data_1(55 downto 0) & data_0 & data_3_o;

            when "01111" =>
                frame_int <= ZEROS(255 downto 224) & crc_final & data_1 & data_0 & data_3_o;

            when "10000" =>
                frame_int <= ZEROS(255 downto 232) & crc_final & data_2(7 downto 0) & data_1 & data_0 & data_3_o;

            when "10001" =>
                frame_int <= ZEROS(255 downto 240) & crc_final & data_2(15 downto 0) & data_1 & data_0 & data_3_o;

            when "10010" =>
                frame_int <= ZEROS(255 downto 248) & crc_final & data_2(23 downto 0) & data_1 & data_0 & data_3_o;

            when "10011" =>
                frame_int <= crc_final & data_2(31 downto 0) & data_1 & data_0 & data_3_o;

            when "10100" =>
                frame_int <= crc_final(23 downto 0) & data_2(39 downto 0) & data_1 & data_0 & data_3_o;
                use_frame_next <= '1';
                frame_int_next <= ZEROS(255 downto 8) & crc_final(31 downto 24);
                eop_int <= "100000";
                one_deficit <= '1';

            when "10101" =>
                frame_int <= crc_final(15 downto 0) & data_2(47 downto 0) & data_1 & data_0 & data_3_o;
                use_frame_next <= '1';
                frame_int_next <= ZEROS(255 downto 16) & crc_final(31 downto 16);
                eop_int <= "100000";
                one_deficit <= '1';

            when "10110" =>
                frame_int <= crc_final(7 downto 0) & data_2(55 downto 0) & data_1 & data_0 & data_3_o;
                use_frame_next <= '1';
                frame_int_next <= ZEROS(255 downto 24) & crc_final(31 downto 8);
                eop_int <= "100000";
                one_deficit <= '1';

            when "10111" =>
                frame_int <= data_2 & data_1 & data_0 & data_3_o;
                use_frame_next <= '1';
                frame_int_next <= ZEROS(255 downto 32) & crc_final;
                eop_int <= "100000";
                one_deficit <= '1';

            when "11000" =>
                frame_int <= data_2 & data_1 & data_0 & data_3_o;
                use_frame_next <= '1';
                frame_int_next <= ZEROS(255 downto 40) & crc_final & data_3(7 downto 0);
                eop_int <= "100000";
                one_deficit <= '1';

            when "11001" =>
                frame_int <= data_2 & data_1 & data_0 & data_3_o;
                use_frame_next <= '1';
                frame_int_next <= ZEROS(255 downto 48) & crc_final & data_3(15 downto 0);
                eop_int <= "100000";
                one_deficit <= '1';

            when "11010" =>
                frame_int <= data_2 & data_1 & data_0 & data_3_o;
                use_frame_next <= '1';
                frame_int_next <= ZEROS(255 downto 56) & crc_final & data_3(23 downto 0);
                eop_int <= "100000";
                one_deficit <= '1';

            when "11011" =>
                frame_int <= data_2 & data_1 & data_0 & data_3_o;
                use_frame_next <= '1';
                frame_int_next <= ZEROS(255 downto 64) & crc_final & data_3(31 downto 0);
                eop_int <= "100000";
                one_deficit <= '1';

            when "11100" =>
                frame_int <= data_2 & data_1 & data_0 & data_3_o;
                use_frame_next <= '1';
                frame_int_next <= ZEROS(255 downto 72) & crc_final & data_3(39 downto 0);
                eop_int <= "100000";
                one_deficit <= '1';

            when "11101" =>
                frame_int <= data_2 & data_1 & data_0 & data_3_o;
                use_frame_next <= '1';
                frame_int_next <= ZEROS(255 downto 80) & crc_final & data_3(47 downto 0);
                eop_int <= "100000";
                one_deficit <= '1';

            when "11110" =>
                frame_int <= data_2 & data_1 & data_0 & data_3_o;
                use_frame_next <= '1';
                frame_int_next <= ZEROS(255 downto 88) & crc_final & data_3(55 downto 0);
                eop_int <= "100000";
                one_deficit <= '1';

            when "11111" =>
                frame_int <= data_2 & data_1 & data_0 & data_3_o;
                use_frame_next <= '1';
                frame_int_next <= ZEROS(255 downto 96) & crc_final & data_3;
                eop_int <= "100000";
                one_deficit <= '1';

            when others =>
          end case;

        when S_EOP_N =>
          deficit <= '1';
          val_int <= '1';
          eop_int <=  '0' & eop_int_reg(4 downto 0);
          if sop_reg_reg_in = "11" then
          -- if sop_reg_in = "11" then
            frame_int_next <= data_2 & PREAMBLE & frame_int_next_o(127 downto 0);
            sop_int <= "11";
          else
            frame_int_next <= frame_int_next_o(255 downto 0);
            sop_int <= "00";
          end if;

          if sop_reg_in = "10" then
            flag_wait_fifo <= '1';
          end if;

        when S_WAIT_NOT_EMPTY =>
          if sop_reg_reg_in = "10" then
            flag_wait_fifo <= '1';
          end if;

        when S_WAIT_FIFO =>
          frame_int <= data_2_o & data_1_o & data_0_o & PREAMBLE;
          eop_int <= "100000";
          sop_int <= "10";
          val_int <= '1';
          -- sop_shifted <= '0';


        when S_ERROR =>
          frame_int <= LANE_ERROR & LANE_ERROR & LANE_ERROR & LANE_ERROR;
          eop_int <= "100000";
          sop_int <= "00";
          val_int <= '0';

        when others => null;
      end case;
    end process;

    frame_ns_decoder: process(ps_frame, eop_reg_in, eop_reg_reg_in, sop_reg_in,
                              data_0, data_1, data_2, data_3, wait_cnt, sop_reg_in,
                              almost_e_d, deficit_reg, flag_wait_fifo_d)
    begin
      case ps_frame is
        when S_IDLE =>
          if (sop_reg_in = "10" or sop_reg_in = "11") then
          -- If there is a packet starting at either lower or higher half
            ns_frame <= S_PREAM;
          end if;

        when S_PREAM =>
          ns_frame <= S_READ_FIFO;

        when S_READ_FIFO =>
          if flag_wait_fifo_d = '1' then
            if (eop_reg_reg_in = "100000") then
              ns_frame <= S_READ_FIFO;
            else
              ns_frame <= S_EOP;
            end if;
          else
            if (eop_reg_in = "100000") then
              ns_frame <= S_READ_FIFO;
            else
              ns_frame <= S_EOP;
            end if;
          end if;

        when S_EOP =>
          if eop_reg_reg_in(4 downto 0) >= "10100" then
            ns_frame <= S_EOP_N;
          -- elsif almost_e = '1' then
          elsif almost_e_d = '1' then
            ns_frame <= S_WAIT_NOT_EMPTY;
          elsif sop_reg_in(1) = '1' then
            ns_frame <= S_PREAM;
          else
            ns_frame <= S_IDLE;
          end if;

        when S_EOP_N =>
          -- if almost_e = '1' then
          if almost_e_d = '1' then
            ns_frame <= S_WAIT_NOT_EMPTY;
          elsif sop_reg_in(1) = '1' then   -- aproveita o ciclo: 64b_data + Preambulo
            ns_frame <= S_PREAM;
          elsif sop_reg_reg_in = "11" then   -- aproveita o ciclo: 64b_data + Preambulo
          -- elsif sop_reg_in = "11" then   -- aproveita o ciclo: 64b_data + Preambulo
            ns_frame <= S_READ_FIFO;
          elsif sop_reg_reg_in = "10" then  -- segura um ciclo para manter alinhamento
            ns_frame <= S_WAIT_FIFO;
          else
            ns_frame <= S_IDLE;
          end if;

        when S_WAIT_FIFO =>
          ns_frame <= S_READ_FIFO;

        when S_ERROR =>
          ns_frame <= S_IDLE;

        when S_WAIT_NOT_EMPTY =>
          -- if almost_e = '1' then
          if almost_e_d = '1' then
            ns_frame <= S_WAIT_NOT_EMPTY;
          elsif deficit_reg = '1' then
            if sop_reg_reg_in = "11" then   -- aproveita o ciclo: 64b_data + Preambulo
              ns_frame <= S_READ_FIFO;
            elsif sop_reg_reg_in = "10" then  -- segura um ciclo para manter alinhamento
              ns_frame <= S_WAIT_FIFO;
            else
              ns_frame <= S_IDLE;
            end if;
          else
            if eop_reg_reg_in(4 downto 0) >= "10100" then
              ns_frame <= S_EOP_N;
            elsif sop_reg_in(1) = '1' then
              ns_frame <= S_PREAM;
            else
              ns_frame <= S_IDLE;
            end if;
          end if;

      end case;
    end process;

  end behav_frame_builder;
