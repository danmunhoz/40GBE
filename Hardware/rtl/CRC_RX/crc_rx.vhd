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
package rev_func is
  function reverse (data_in: std_logic_vector) return std_logic_vector;
end rev_func;
package body rev_func is
  function reverse (data_in:  std_logic_vector) return std_logic_vector is
    variable data_out : std_logic_vector(data_in'range);
    alias temp: std_logic_vector(data_in'reverse_range) is data_in;
  begin
    for i in temp'range loop
      data_out(i) := temp(i);
    end loop;
    return data_out;
  end reverse;
end rev_func;

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
use work.rev_func.all;

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
  app_val         : out std_logic;
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
  signal crc_final  : std_logic_vector(31 downto 0);
  signal crc_done    : std_logic;
  signal d8_bytes   : std_logic_vector(2 downto 0);
  signal delay_cnt  : std_logic_vector(2 downto 0);

  signal input_reg : std_logic_vector(127 downto 0);
  signal eop_last   : std_logic_vector(4 downto 0);
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
  signal clk_312_n : std_logic;
  signal fifo_delay : std_logic_vector(2 downto 0);

  signal frame_len : std_logic_vector(13 downto 0);
  signal byte_counter : std_logic_vector(13 downto 0);

  begin
    rst <= not rst_n;
    clk_312_n <= not clk_312;
    fifo_data_out <= do_h(69 downto 6) & do_l;
    fifo_eop_out <= do_h(5 downto 1);
    fifo_sop_out <= do_h(0);
    di_h <= mac_data(127 downto 64) & mac_eop & mac_sop;

    ren <= ren_int;
    wen <= wen_int;

    crc_final <= not(reverse(crc_reg));

    crc_ok <= '1' when crc_done = '1' and crc_final = crc_value else '0';

    app_val  <= '1' when sop_reg = '1' or valid_frame = '1' else '0';
    app_data <= input_reg when sop_reg = '1' or valid_frame = '1' else (others=>'0');
    app_sop  <= sop_reg;
    app_eop  <= eop_reg when valid_frame = '1' else (others=>'0');

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
      CLK => clk_312_n,
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
      CLK => clk_312_n,
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
        eop_last <= (others=>'0');
        eop_reg <= (others=>'0');
        sop_reg <= '0';
        frame_len <= (others=>'0');

      elsif clk_312'event and clk_312 = '1' then
        input_reg <= fifo_data_out;
        sop_reg <= fifo_sop_out;
        eop_reg <= fifo_eop_out;

        -- Saves the received crc value and EOP position
        -- if fifo_sop_out = '1' then
        --   crc_value <= (others => '0');
        -- end if;

        if eop_reg(4) = '1' then
          eop_last <= eop_reg;
        end if;

        -- Saves the 64 bits necesseries for d8 crc
        -- if ps_crc = D64 then
          if eop_reg(4) = '1' then
            if d64_low = '0' then
              d64_reg <= input_reg (63 downto 0);
            else
              d64_reg <= input_reg (127 downto 64);
            end if;
          end if;
        -- end if;

        if eop_reg(4) = '1' then
          frame_len <= byte_counter;
        end if;

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
    sop_eop_decoder: process(clk_312, rst_n, eop_reg, sop_reg)
    begin
      if rst_n = '0' then
        use_d128 <= '0';
        use_d64 <= '0';
        use_d8 <= '0';
        d8_bytes <= "000";
        valid_frame <= '0';
        d64_low <= '1';
        crc_value <= (others => '0');
      elsif clk_312'event and clk_312 = '1' then

        if sop_reg = '1' then -- Frame starting now
          valid_frame <= '1';
          crc_value <= (others => '0');
        end if;

        use_d64 <= '0';
        use_d8 <= '0';
        d64_low <= '0';

        if eop_reg(4) = '1' then -- End of a frame
          valid_frame <= '0';
          use_d128 <= '0';
          -- Now, find out where it is
          case eop_reg(3 downto 0) is
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
              crc_value <= input_reg(LANE0) & input_reg(LANE15) & input_reg(LANE14) & input_reg(LANE13);
            when x"2" =>
              use_d128 <= '0';
              use_d64 <= '0';
              use_d8 <= '1';
              d64_low <= '1';
              d8_bytes <= "000";
              crc_value <= input_reg(LANE1) & input_reg(LANE0) & input_reg(LANE15) & input_reg(LANE14);
            when x"3" =>
              use_d128 <= '0';
              use_d64 <= '0';
              use_d8 <= '1';
              d64_low <= '1';
              d8_bytes <= "000";
              crc_value <= input_reg(LANE2) & input_reg(LANE1) & input_reg(LANE0) & input_reg(LANE15);
            when x"4" =>
              use_d128 <= '0';
              use_d64 <= '0';
              use_d8 <= '0';
              d64_low <= '1';
              d8_bytes <= "000";
              crc_value <=  input_reg(LANE3) & input_reg(LANE2) & input_reg(LANE1) & input_reg(LANE0);
            when x"5" =>
              use_d128 <= '0';
              use_d64 <= '0';
              use_d8 <= '1';
              d64_low <= '1';
              d8_bytes <= "001";
              crc_value <= input_reg(LANE4) & input_reg(LANE3) & input_reg(LANE2) & input_reg(LANE1);
            when x"6" =>
              use_d128 <= '0';
              use_d64 <= '0';
              use_d8 <= '1';
              d64_low <= '1';
              d8_bytes <= "010";
              crc_value <= input_reg(LANE5) & input_reg(LANE4) & input_reg(LANE3) & input_reg(LANE2);
            when x"7" =>
              use_d128 <= '0';
              use_d64 <= '0';
              use_d8 <= '1';
              d64_low <= '1';
              d8_bytes <= "011";
              crc_value <= input_reg(LANE6) & input_reg(LANE5) & input_reg(LANE4) & input_reg(LANE3);
            when x"8" =>
              use_d128 <= '0';
              use_d64 <= '0';
              use_d8 <= '1';
              d64_low <= '0';
              d8_bytes <= "100";
              crc_value <= input_reg(LANE7) & input_reg(LANE6) & input_reg(LANE5) & input_reg(LANE4);
            when x"9" =>
              use_d128 <= '0';
              use_d64 <= '0';
              use_d8 <= '1';
              d64_low <= '0';
              d8_bytes <= "101";
              crc_value <= input_reg(LANE8) & input_reg(LANE7) & input_reg(LANE6) & input_reg(LANE5);
            when x"A" =>
              use_d128 <= '0';
              use_d64 <= '0';
              use_d8 <= '1';
              d64_low <= '0';
              d8_bytes <= "110";
              crc_value <= input_reg(LANE9) & input_reg(LANE8) & input_reg(LANE7) & input_reg(LANE6);
            when x"B" =>
              use_d128 <= '0';
              use_d64 <= '0';
              use_d8 <= '1';
              d64_low <= '0';
              d8_bytes <= "111";
              crc_value <= input_reg(LANE10) & input_reg(LANE9) & input_reg(LANE8) & input_reg(LANE7);
            when x"C" =>
              use_d128 <= '0';
              use_d64 <= '1';
              use_d8 <= '0';
              d64_low <= '0';
              d8_bytes <= "000";
              crc_value <= input_reg(LANE11) & input_reg(LANE10) & input_reg(LANE9) & input_reg(LANE8);
            when x"D" =>
              use_d128 <= '0';
              use_d64 <= '1';
              use_d8 <= '1';
              d64_low <= '0';
              d8_bytes <= "001";
              crc_value <= input_reg(LANE12) & input_reg(LANE11) & input_reg(LANE10) & input_reg(LANE9);
            when x"E" =>
              use_d128 <= '0';
              use_d64 <= '1';
              use_d8 <= '1';
              d64_low <= '0';
              d8_bytes <= "010";
              crc_value <= input_reg(LANE13) & input_reg(LANE12) & input_reg(LANE11) & input_reg(LANE10);
            when x"F" =>
              use_d128 <= '0';
              use_d64 <= '1';
              use_d8 <= '1';
              d64_low <= '0';
              d8_bytes <= "011";
              crc_value <= input_reg(LANE14) & input_reg(LANE13) & input_reg(LANE12) & input_reg(LANE11);
            when others => null;
          end case;
        elsif valid_frame = '1' or sop_reg = '1' then
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

    next_state_decoder: process(rst_n, ps_crc, use_d128, use_d64, use_d8, sop_reg, eop_reg, fifo_delay)
    begin
      if rst_n = '0' then
        ren_int <= '0';
        wen_int <= '0';
      else
        ren_int <= '1';
        wen_int <= '1';

        case ps_crc is
          when IDLE =>
            -- if fifo_delay = "111" then
            --   ren_int <= '1';
              if sop_reg = '1' then
                ns_crc <= D128;
              else
                ns_crc <= IDLE;
              end if;
            -- else
            --   ns_crc <= IDLE;
            --   ren_int <= '0';
            -- end if;

          when D128 =>
            if use_d64 = '0' and use_d8 = '1' then
              ns_crc <= D8_0;
            elsif use_d64 = '1' and use_d8 = '1' then
              ns_crc <= D64;
            elsif eop_reg(3 downto 0) = x"4" then
              ns_crc <= CHECK;
              ren_int <= '0';
            elsif eop_reg(3 downto 0) = x"C" or eop_reg(3 downto 0) = x"D" or
               eop_reg(3 downto 0) = x"E" or eop_reg(3 downto 0) = x"F" then
              ns_crc <= CHECK;
              ren_int <= '0';
            else
              ns_crc <= D128;
            end if;

          when D64 =>
            if d8_bytes = "000" then
              ns_crc <= CHECK;
              ren_int <= '0';
            else
              ns_crc <= D8_0;
              ren_int <= '0';
            end if;

          when D8_0 =>
            ns_crc <= D8_1;
            ren_int <= '0';

          when D8_1 =>
            if crc_done = '1' then
              ns_crc <= CHECK;
            else
              ns_crc <= D8_2;
            end if;
            ren_int <= '0';

          when D8_2 =>
            if crc_done = '1' then
              ns_crc <= CHECK;
            else
              ns_crc <= D8_3;
            end if;
            ren_int <= '0';

          when D8_3 =>
            if crc_done = '1' then
              ns_crc <= CHECK;
            else
              ns_crc <= D8_4;
            end if;
            ren_int <= '0';

          when D8_4 =>
            if crc_done = '1' then
              ns_crc <= CHECK;
            else
              ns_crc <= D8_5;
            end if;
            ren_int <= '0';

          when D8_5 =>
            if crc_done = '1' then
              ns_crc <= CHECK;
            else
              ns_crc <= D8_6;
            end if;
            ren_int <= '0';

          when D8_6 =>
            if crc_done = '1' then
              ns_crc <= CHECK;
            else
              ns_crc <= D8_7;
            end if;
            ren_int <= '0';

          when D8_7 =>
            ns_crc <= CHECK;
            ren_int <= '0';
          when CHECK =>
            -- Por enquanto...
            ren_int <= '0';
            -- if sop_reg = '1' then
            --   ns_crc <= D128;
            -- else
              ns_crc <= IDLE;
            -- end if;

          when others => ns_crc <= IDLE;
        end case;
      end if;
    end process;

    output_decoder: process(ps_crc, clk_312, rst_n)
    begin
      if rst_n = '0' then
        crc_reg <= (others=>'1');
        crc_done <= '0';
        fifo_delay <= (others=>'0');
        byte_counter <= (others=>'0');

      elsif clk_312'event and clk_312 = '1' then
        crc_done <= '0';
        case ps_crc is

          when IDLE =>
            if fifo_delay < "111" then
              fifo_delay <= fifo_delay + 1;
            end if;
            if sop_reg = '1' then
              crc_reg <= nextCRC32_D128(reverse(input_reg), crc_reg);
              byte_counter <= "00000000010000"; --16
            end if;

          when D128 =>
            if eop_reg(4 downto 0) = x"10" or eop_reg(3 downto 0) = x"1" or
               eop_reg(3 downto 0) = x"2" or eop_reg(3 downto 0) = x"3" or
               eop_reg(3 downto 0) = x"4" then -- falta
              crc_done <= '1';
              -- byte_counter <= byte_counter + 1;

            elsif eop_reg(3 downto 0) = x"5" then -- falta
              byte_counter <= byte_counter + 1;

            elsif eop_reg(3 downto 0) = x"6" then -- falta
              byte_counter <= byte_counter + 2;

            elsif eop_reg(3 downto 0) = x"7" then -- falta
              byte_counter <= byte_counter + 3;

            elsif eop_reg(3 downto 0) = x"C" then
              crc_reg <= nextCRC32_D64(reverse(input_reg(63 downto 0)), crc_reg);
              crc_done <= '1';
              byte_counter <= byte_counter + 8;

            elsif eop_reg(3 downto 0) = x"D" then -- falta byte 8
              crc_reg <= nextCRC32_D64(reverse(input_reg(63 downto 0)), crc_reg);
              crc_done <= '1';
              byte_counter <= byte_counter + 9;

            elsif eop_reg(3 downto 0) = x"E" then -- falta byte 8 e 9
              crc_reg <= nextCRC32_D64(reverse(input_reg(63 downto 0)), crc_reg);
              crc_done <= '1';
              byte_counter <= byte_counter + 10;

            elsif eop_reg(3 downto 0) = x"F" then -- falta byte 8,9 e A
              crc_reg <= nextCRC32_D64(reverse(input_reg(63 downto 0)), crc_reg);
              crc_done <= '1';
              byte_counter <= byte_counter + 11;

            elsif eop_reg(4) = '0' then -- No EOP, keep going
              crc_reg <= nextCRC32_D128(reverse(input_reg), crc_reg);
              byte_counter <= byte_counter + 16;

            else -- eRROR
              crc_done <= '1';
            end if;

          when D64 =>
            crc_reg <= nextCRC32_D64(reverse(d64_reg), crc_reg);
            byte_counter <= byte_counter + 8;
            crc_done <= '1';

          when D8_0 =>
            crc_reg <= nextCRC32_D8(reverse(d64_reg(LANE0)), crc_reg);
            byte_counter <= byte_counter + 1;

          when D8_1 =>
            if d8_bytes > "001" then
              crc_reg <= nextCRC32_D8(reverse(d64_reg(LANE1)), crc_reg);
              byte_counter <= byte_counter + 1;
            else
              crc_done <= '1';
            end if;

          when D8_2 =>
            if d8_bytes > "010" then
              crc_reg <= nextCRC32_D8(reverse(d64_reg(LANE2)), crc_reg);
              byte_counter <= byte_counter + 1;
            else
              crc_done <= '1';
            end if;

          when D8_3 =>
            if d8_bytes > "011" then
              crc_reg <= nextCRC32_D8(reverse(d64_reg(LANE3)), crc_reg);
              byte_counter <= byte_counter + 1;
            else
              crc_done <= '1';
            end if;

          when D8_4 =>
            if d8_bytes > "100" then
              crc_reg <= nextCRC32_D8(reverse(d64_reg(LANE4)), crc_reg);
              byte_counter <= byte_counter + 1;
            else
              crc_done <= '1';
            end if;

          when D8_5 =>
            if d8_bytes > "101" then
              crc_reg <= nextCRC32_D8(reverse(d64_reg(LANE5)), crc_reg);
              byte_counter <= byte_counter + 1;
            else
              crc_done <= '1';
            end if;

          when D8_6 =>
            if d8_bytes > "110" then
              crc_reg <= nextCRC32_D8(reverse(d64_reg(LANE6)), crc_reg);
              byte_counter <= byte_counter + 1;
            else
              crc_done <= '1';
            end if;

          when D8_7 =>
            if d8_bytes >= "111" then
              crc_reg <= nextCRC32_D8(reverse(d64_reg(LANE7)), crc_reg);
              byte_counter <= byte_counter + 1;
            else
              crc_done <= '1';
            end if;

          when CHECK =>
            -- crc_done <= '1';
            crc_reg <= (others=>'1');
            fifo_delay <= (others=>'0');
          when others => crc_reg <= (others=>'0');
        end case;
      end if;
    end process;
end behav_crc_rx;
