library ieee;
  use ieee.std_logic_1164.all;

package lane_defs is
  subtype LANE0  is natural range 7 downto 0;
  subtype LANE1  is natural range 15 downto 8;
  subtype LANE2  is natural range 23 downto 16;
  subtype LANE3  is natural range 31 downto 24;
  subtype LANE4  is natural range 39 downto 32;
  subtype LANE5  is natural range 47 downto 40;
  subtype LANE6  is natural range 55 downto 48;
  subtype LANE7  is natural range 63 downto 56;
  subtype LANE8  is natural range 71 downto 64;
  subtype LANE9  is natural range 79 downto 72;
  subtype LANE10 is natural range 87 downto 80;
  subtype LANE11 is natural range 95 downto 88;
  subtype LANE12 is natural range 103 downto 96;
  subtype LANE13 is natural range 111 downto 104;
  subtype LANE14 is natural range 119 downto 112;
  subtype LANE15 is natural range 127 downto 120;
end lane_defs;

library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_unsigned.all;
  use ieee.numeric_std.all;
library UNISIM;
  use UNISIM.vcomponents.all;
library UNIMACRO;
  use unimacro.Vcomponents.all;
use work.PCK_CRC32_D8.all;
use work.PCK_CRC32_D64.all;
use work.PCK_CRC32_D128.all;
use work.lane_defs.all;

entity crc_rx is
  port(
  -- INPUTS
  clk_312         : in std_logic;
  rst_n           : in std_logic;
  mac_data        : in std_logic_vector(127 downto 0);
  mac_sop         : in std_logic;
  mac_eop         : in std_logic_vector(4 downto 0);

  --OUTPUTS
  app_data        : out std_logic_vector(127 downto 0);
  app_sop         : out std_logic;
  app_eop         : out std_logic_vector(4 downto 0);
  crc_ok          : out std_logic
  );
end entity;

architecture behav_crc_rx of crc_rx is

  TYPE states_crc is (IDLE, D128, D64, D8_0, D8_1, D8_2, D8_3, D8_4, D8_5, D8_6, D8_7, CHECK);
  signal ns_crc, ps_crc : states_crc;

  signal use_d128  : std_logic;
  signal use_d64   : std_logic;
  signal use_d8    : std_logic;

  signal crc_reg   : std_logic_vector(31 downto 0);
  signal d64_reg   : std_logic_vector(63 downto 0);  -- store higher 64 bits, so crc d8
                                                     -- has time to perform calculations
  signal d64_low   : std_logic;                      -- Indicates wheather d8 will use low or high part
  signal valid_frame : std_logic;           -- 1 from SOP to EOP. Enables crc processes
  -- signal byte_cnt  : std_logic_vector(2 downto 0);

  -- signal crc_final  : std_logic_vector(31 downto 0);
  signal crc_value  : std_logic_vector(31 downto 0);
  signal d8_done    : std_logic;
  signal d8_bytes   : std_logic_vector(2 downto 0);

  signal input_reg : std_logic_vector(127 downto 0);
  signal input_reg_reg : std_logic_vector(127 downto 0);
  signal eop_reg   : std_logic_vector(4 downto 0);
  signal sop_reg   : std_logic;

  signal fifo_data_out  : std_logic_vector(127 downto 0);
  signal fifo_eop_out   : std_logic_vector(4 downto 0);
  signal fifo_sop_out   : std_logic;

  signal do_l : std_logic_vector(63 downto 0);
  signal do_h : std_logic_vector(69 downto 0);
  signal di_h : std_logic_vector(69 downto 0);
  signal almost_empty_l : std_logic;
  signal almost_empty_h : std_logic;
  signal almost_full_l  : std_logic;
  signal almost_full_h  : std_logic;
  signal full_l : std_logic;
  signal full_h : std_logic;
  signal empty_l : std_logic;
  signal empty_h : std_logic;
  signal ren : std_logic;
  signal wen : std_logic;
  signal ren_int : std_logic;
  signal wen_int : std_logic;
  signal rdcnt_l : std_logic_vector(8 downto 0);
  signal rdcnt_h : std_logic_vector(8 downto 0);
  signal wrcnt_l : std_logic_vector(8 downto 0);
  signal wrcnt_h : std_logic_vector(8 downto 0);
  signal rst : std_logic;
  signal fifo_delay : std_logic_vector(2 downto 0);


  begin
    rst <= not rst_n;
    fifo_data_out <= do_h(69 downto 6) & do_l;
    fifo_eop_out <= do_h(5 downto 1);
    fifo_sop_out <= do_h(0);
    di_h <= mac_data(127 downto 64) & mac_eop & mac_sop;

    ren <= ren_int;
    wen <= wen_int;

    -- Hold fifo. Needed to wait for at most 8 cycles
    FIFO_hold_l : FIFO_SYNC_MACRO
    generic map (
      DEVICE => "7SERIES",
      ALMOST_FULL_OFFSET => X"0080", -- Sets almost full threshold
      ALMOST_EMPTY_OFFSET => X"0080", -- Sets the almost empty threshold
      DATA_WIDTH => 64,
      FIFO_SIZE => "36Kb")
    port map (
      ALMOSTEMPTY => almost_empty_l,
      ALMOSTFULL => almost_full_l,
      DO => do_l,
      EMPTY => empty_l,
      FULL => full_l,
      RDCOUNT => rdcnt_l,
      RDERR => open,
      WRCOUNT => wrcnt_l,
      WRERR => open,
      CLK => clk_312,
      DI => mac_data(63 downto 0),
      RDEN => ren,
      RST => rst,
      WREN => wen
    );
    FIFO_hold_h : FIFO_SYNC_MACRO
    generic map (
      DEVICE => "7SERIES",
      ALMOST_FULL_OFFSET => X"0080", -- Sets almost full threshold
      ALMOST_EMPTY_OFFSET => X"0080", -- Sets the almost empty threshold
      DATA_WIDTH => 70,
      FIFO_SIZE => "36Kb")
    port map (
      ALMOSTEMPTY => almost_empty_h,
      ALMOSTFULL => almost_full_h,
      DO => do_h,
      EMPTY => empty_h,
      FULL => full_h,
      RDCOUNT => rdcnt_h,
      RDERR => open,
      WRCOUNT => wrcnt_h,
      WRERR => open,
      CLK => clk_312,
      DI => di_h,
      RDEN => ren,
      RST => rst,
      WREN => wen
    );

    aux_regs: process(clk_312, rst_n, ps_crc)
    begin
      if rst_n = '0' then
        d64_reg <= (others=>'0');
        -- crc_value <= (others => '0');
        input_reg <= (others=>'0');
        input_reg_reg <= (others=>'0');
        eop_reg <= (others=>'0');
        sop_reg <= '0';
      elsif clk_312'event and clk_312 = '1' then
        input_reg <= fifo_data_out;
        input_reg_reg <= input_reg;
        sop_reg <= fifo_sop_out;

        -- Saves the received crc value and EOP position
        -- if fifo_sop_out = '1' then
        --   crc_value <= (others => '0');
        -- end if;

        if fifo_eop_out(4) = '1' then
          eop_reg <= fifo_eop_out;
        end if;

        -- Saves the 64 bits necesseries for d8 crc
        -- if ps_crc = D64 then
          if fifo_eop_out(4) = '1' then
            if d64_low = '1' then
              d64_reg <= input_reg (63 downto 0);
            else
              d64_reg <= input_reg (127 downto 64);
            end if;
          end if;
        -- end if;
      end if;
    end process;

    sync_proc: process(clk_312, rst_n)
    begin
      if rst_n = '0' then
        ps_crc <= IDLE;
      elsif clk_312'event and clk_312 = '1' then
        ps_crc <= ns_crc;
      end if;
    end process;

    -- process to control crc modules and fifos
    sop_eop_decoder: process(clk_312, rst_n, fifo_eop_out, fifo_sop_out)
    begin
      if rst_n = '0' then
        use_d128 <= '0';
        use_d64 <= '0';
        use_d8 <= '0';
        d8_bytes <= "000";
        valid_frame <= '0';
        crc_value <= (others => '0');
      elsif clk_312'event and clk_312 = '1' then

        if fifo_sop_out = '1' then -- Frame starting now
          valid_frame <= '1';
          crc_value <= (others => '0');
        end if;

        if fifo_eop_out(4) = '1' then -- End of a frame
          valid_frame <= '0';
          use_d128 <= '0';
          -- Now, find out where it is
          case fifo_eop_out(3 downto 0) is
            when x"0" =>
              use_d128 <= '0';
              use_d64 <= '0';
              use_d8 <= '1';
              d64_low <= '1';
              d8_bytes <= "000";
              crc_value <= input_reg(LANE15) & input_reg(LANE14) & input_reg(LANE13) & input_reg(LANE12);
            when x"1" =>
              use_d128 <= '0';
              use_d64 <= '0';
              use_d8 <= '1';
              d64_low <= '1';
              d8_bytes <= "000";
              crc_value <= fifo_data_out(LANE0) & input_reg(LANE15) & input_reg(LANE14) & input_reg(LANE13);
            when x"2" =>
              use_d128 <= '0';
              use_d64 <= '0';
              use_d8 <= '1';
              d64_low <= '1';
              d8_bytes <= "000";
              crc_value <= fifo_data_out(LANE1) & fifo_data_out(LANE0) & fifo_data_out(LANE15) & fifo_data_out(LANE14);
            when x"3" =>
              use_d128 <= '0';
              use_d64 <= '0';
              use_d8 <= '1';
              d64_low <= '1';
              d8_bytes <= "000";
              crc_value <= fifo_data_out(LANE2) & fifo_data_out(LANE1) & fifo_data_out(LANE0) & fifo_data_out(LANE15);
            when x"4" =>
              use_d128 <= '0';
              use_d64 <= '0';
              use_d8 <= '0';
              d64_low <= '1';
              d8_bytes <= "000";
              crc_value <=  fifo_data_out(LANE3) & fifo_data_out(LANE2) & fifo_data_out(LANE1) & fifo_data_out(LANE0);
            when x"5" =>
              use_d128 <= '0';
              use_d64 <= '0';
              use_d8 <= '1';
              d64_low <= '1';
              d8_bytes <= "001";
              crc_value <= fifo_data_out(LANE4) & fifo_data_out(LANE3) & fifo_data_out(LANE2) & fifo_data_out(LANE1);
            when x"6" =>
              use_d128 <= '0';
              use_d64 <= '0';
              use_d8 <= '1';
              d64_low <= '1';
              d8_bytes <= "010";
              crc_value <= fifo_data_out(LANE5) & fifo_data_out(LANE4) & fifo_data_out(LANE3) & fifo_data_out(LANE2);
            when x"7" =>
              use_d128 <= '0';
              use_d64 <= '0';
              use_d8 <= '1';
              d64_low <= '1';
              d8_bytes <= "011";
              crc_value <= fifo_data_out(LANE6) & fifo_data_out(LANE5) & fifo_data_out(LANE4) & fifo_data_out(LANE3);
            when x"8" =>
              use_d128 <= '0';
              use_d64 <= '0';
              use_d8 <= '1';
              d64_low <= '0';
              d8_bytes <= "100";
              crc_value <= fifo_data_out(LANE7) & fifo_data_out(LANE6) & fifo_data_out(LANE5) & fifo_data_out(LANE4);
            when x"9" =>
              use_d128 <= '0';
              use_d64 <= '0';
              use_d8 <= '1';
              d64_low <= '0';
              d8_bytes <= "101";
              crc_value <= fifo_data_out(LANE8) & fifo_data_out(LANE7) & fifo_data_out(LANE6) & fifo_data_out(LANE5);
            when x"A" =>
              use_d128 <= '0';
              use_d64 <= '0';
              use_d8 <= '1';
              d64_low <= '0';
              d8_bytes <= "110";
              crc_value <= fifo_data_out(LANE9) & fifo_data_out(LANE8) & fifo_data_out(LANE7) & fifo_data_out(LANE6);
            when x"B" =>
              use_d128 <= '0';
              use_d64 <= '0';
              use_d8 <= '1';
              d64_low <= '0';
              d8_bytes <= "111";
              crc_value <= fifo_data_out(LANE10) & fifo_data_out(LANE9) & fifo_data_out(LANE8) & fifo_data_out(LANE7);
            when x"C" =>
              use_d128 <= '0';
              use_d64 <= '1';
              use_d8 <= '0';
              d64_low <= '0';
              d8_bytes <= "000";
              crc_value <= fifo_data_out(LANE11) & fifo_data_out(LANE10) & fifo_data_out(LANE9) & fifo_data_out(LANE8);
            when x"D" =>
              use_d128 <= '0';
              use_d64 <= '1';
              use_d8 <= '1';
              d64_low <= '0';
              d8_bytes <= "001";
              crc_value <= fifo_data_out(LANE12) & fifo_data_out(LANE11) & fifo_data_out(LANE10) & fifo_data_out(LANE9);
            when x"E" =>
              use_d128 <= '0';
              use_d64 <= '1';
              use_d8 <= '1';
              d64_low <= '0';
              d8_bytes <= "010";
              crc_value <= fifo_data_out(LANE13) & fifo_data_out(LANE12) & fifo_data_out(LANE11) & fifo_data_out(LANE10);
            when x"F" =>
              use_d128 <= '0';
              use_d64 <= '1';
              use_d8 <= '1';
              d64_low <= '0';
              d8_bytes <= "011";
              crc_value <= fifo_data_out(LANE14) & fifo_data_out(LANE13) & fifo_data_out(LANE12) & fifo_data_out(LANE11);
            when others => null;
          end case;
        elsif valid_frame = '1' or fifo_sop_out = '1' then
          use_d128 <= '1';
          use_d64  <= '0';
          use_d8   <= '0';
        else
          use_d128 <= '0';
          use_d64  <= '0';
          use_d8   <= '0';
          -- d8_bytes <= "111";
        end if;
      end if;
    end process;

    next_state_decoder: process(rst_n, ps_crc, use_d128, use_d64, use_d8, fifo_sop_out)
    begin
      if rst_n = '0' then
        ren_int <= '0';
        wen_int <= '0';
      else
        ren_int <= '1';
        wen_int <= '1';

        case ps_crc is
          when IDLE =>
            -- if use_d128 = '1' then
            if fifo_sop_out = '1' then
              ns_crc <= D128;
            else
              ns_crc <= IDLE;
            end if;

          when D128 =>
            if use_d64 = '0' and use_d8 = '1' then
              ns_crc <= D8_0;
            elsif use_d64 = '1' and use_d8 = '1' then
              ns_crc <= D64;
            elsif fifo_eop_out(3 downto 0) = x"4" or fifo_eop_out(3 downto 0) = x"C" then
              ns_crc <= CHECK;
            else
              ns_crc <= D128;
            end if;

          when D64 =>
            ns_crc <= D8_0;
            ren_int <= '0';

          when D8_0 =>
            ns_crc <= D8_1;
            ren_int <= '0';

          when D8_1 =>
            if d8_done = '1' then
              ns_crc <= CHECK;
            else
              ns_crc <= D8_2;
            end if;
            ren_int <= '0';

          when D8_2 =>
            if d8_done = '1' then
              ns_crc <= CHECK;
            else
              ns_crc <= D8_3;
            end if;
            ren_int <= '0';

          when D8_3 =>
            if d8_done = '1' then
              ns_crc <= CHECK;
            else
              ns_crc <= D8_4;
            end if;
            ren_int <= '0';

          when D8_4 =>
            if d8_done = '1' then
              ns_crc <= CHECK;
            else
              ns_crc <= D8_5;
            end if;
            ren_int <= '0';

          when D8_5 =>
            if d8_done = '1' then
              ns_crc <= CHECK;
            else
              ns_crc <= D8_6;
            end if;
            ren_int <= '0';

          when D8_6 =>
            if d8_done = '1' then
              ns_crc <= CHECK;
            else
              ns_crc <= D8_7;
            end if;
            ren_int <= '0';

          when D8_7 =>
            if d8_done = '1' then
              ns_crc <= CHECK;
            else
              ns_crc <= CHECK;
            end if;
            ren_int <= '0';

          when CHECK =>
            -- Por enquanto...
            ns_crc <= IDLE;

          when others => ns_crc <= IDLE;
        end case;
      end if;
    end process;

    output_decoder: process(ps_crc, clk_312, rst_n)
    begin
      if rst_n = '0' then
        crc_reg <= (others=>'0');
        d8_done <= '0';
      elsif clk_312'event and clk_312 = '1' then
        case ps_crc is
          when IDLE =>
            crc_reg <= (others=>'0');
            d8_done <= '0';
          when D128 =>
            crc_reg <= nextCRC32_D128(input_reg, crc_reg);
            d8_done <= '0';
          when D64 =>
            crc_reg <= nextCRC32_D64(input_reg(63 downto 0), crc_reg);
            d8_done <= '0';
          when D8_0 =>
            crc_reg <= nextCRC32_D8(d64_reg(LANE0), crc_reg);
            d8_done <= '0';
          when D8_1 =>
            if d8_bytes > "000" then
              crc_reg <= nextCRC32_D8(d64_reg(LANE1), crc_reg);
              d8_done <= '0';
            else
              d8_done <= '1';
            end if;
          when D8_2 =>
            if d8_bytes > "001" then
              crc_reg <= nextCRC32_D8(d64_reg(LANE2), crc_reg);
              d8_done <= '0';
            else
              d8_done <= '1';
            end if;
          when D8_3 =>
            if d8_bytes > "010" then
              crc_reg <= nextCRC32_D8(d64_reg(LANE3), crc_reg);
              d8_done <= '0';
            else
              d8_done <= '1';
            end if;
          when D8_4 =>
            if d8_bytes > "011" then
              crc_reg <= nextCRC32_D8(d64_reg(LANE4), crc_reg);
              d8_done <= '0';
            else
              d8_done <= '1';
            end if;
          when D8_5 =>
            if d8_bytes > "100" then
              crc_reg <= nextCRC32_D8(d64_reg(LANE5), crc_reg);
              d8_done <= '0';
            else
              d8_done <= '1';
            end if;
          when D8_6 =>
            if d8_bytes > "101" then
              crc_reg <= nextCRC32_D8(d64_reg(LANE6), crc_reg);
              d8_done <= '0';
            else
              d8_done <= '1';
            end if;
          when D8_7 =>
            if d8_bytes > "110" then
              crc_reg <= nextCRC32_D8(d64_reg(LANE7), crc_reg);
              d8_done <= '0';
            else
              d8_done <= '1';
            end if;
          when CHECK =>
            if crc_reg = crc_value then
              crc_ok <= '1';
            else
              crc_ok <= '0';
            end if;
          when others => crc_reg <= (others=>'0');
        end case;
      end if;
    end process;

    --
    -- -- process to perform crc byte by byte using nextCRC32_D8
    -- -- It will use crc_reg, so input fifo must be not enabled
    -- calc_d8: process(clk_312, rst_n)
    -- begin
    --   if rst_n = '0' then
    --     s_d8 <= INIT;
    --
    --   elsif clk_312'event and clk_312 = '1' then
    --         case s_d8 is
    --           when INIT =>
    --             byte_cnt <= (others=>'0');
    --             crc_final <= (others=>'0');
    --             d8_done  <= '0';
    --             if use_d8 = '1' then
    --               s_d8 <= CALC;
    --             end if;
    --           when CALC =>
    --             if byte_cnt < (eop_reg(3 downto 0) - 4) then -- CRC value is not used in the crc calculation
    --               case byte_cnt is
    --                 when "000" => crc_final <= nextCRC32_D8(d64_reg(LANE0), crc_reg);
    --                 when "001" => crc_final <= nextCRC32_D8(d64_reg(LANE1), crc_final);
    --                 when "010" => crc_final <= nextCRC32_D8(d64_reg(LANE2), crc_final);
    --                 when "011" => crc_final <= nextCRC32_D8(d64_reg(LANE3), crc_final);
    --                 when "100" => crc_final <= nextCRC32_D8(d64_reg(LANE4), crc_final);
    --                 when "101" => crc_final <= nextCRC32_D8(d64_reg(LANE5), crc_final);
    --                 when "110" => crc_final <= nextCRC32_D8(d64_reg(LANE6), crc_final);
    --                 when "111" => crc_final <= nextCRC32_D8(d64_reg(LANE7), crc_final);
    --                 when others => null;
    --               end case;
    --               byte_cnt <= byte_cnt + 1;
    --             else
    --               s_d8 <= INIT;
    --             end if;
    --           when others => null;
    --       end case;
    --   end if;
    -- end process;
end behav_crc_rx;