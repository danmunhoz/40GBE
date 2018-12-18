library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use ieee.std_logic_unsigned.all;
  --use work.PKG_CODES.all;
  --use work.lane_defs.all;
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


  entity crc_rx_sfifo is
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



  architecture behav_crc_rx_sfifo of crc_rx_sfifo is

    TYPE states_crc is (IDLE, D128, EOP);
    signal ns_crc, ps_crc : states_crc;

    signal crc_value      : std_logic_vector(31 downto 0);
    signal crc_final      : std_logic_vector(31 downto 0);
    signal crc_reg        : std_logic_vector(31 downto 0);
    signal crc_received   : std_logic_vector(31 downto 0);

    signal sop_d1  : std_logic;
    signal eop_d1  : std_logic_vector(  4 downto 0);
    signal data_d1 : std_logic_vector(127 downto 0);

    signal sop_d2  : std_logic;
    signal eop_d2  : std_logic_vector(  4 downto 0);
    signal data_d2 : std_logic_vector(127 downto 0);

    signal eop_d3  : std_logic_vector(  4 downto 0);


  begin

    aux_regs: process(clk_312, rst_n)
    begin
      if rst_n = '0' then
        sop_d1   <= '0';
        eop_d1   <= (others=>'0');
        data_d1  <= (others=>'0');
        sop_d2   <= '0';
        eop_d2   <= (others=>'0');
        data_d2  <= (others=>'0');

        eop_d3  <= (others=>'0');

      elsif clk_312'event and clk_312 = '1' then
        sop_d1   <= mac_sop;
        eop_d1   <= mac_eop;
        data_d1  <= mac_data;
        sop_d2   <= sop_d1;
        eop_d2   <= eop_d1;
        data_d2  <= data_d1;

        eop_d3   <= eop_d2;

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

    next_state_decoder: process(rst_n, ps_crc, data_d1, sop_d1, eop_d1)
    begin
      if rst_n = '0' then
        -- ns_crc <= IDLE;
        --
      else
        case ps_crc is
          when IDLE =>
              if sop_d1 = '1' then
                ns_crc <= D128;
              else
                ns_crc <= IDLE;
              end if;

          when D128 =>  -- inicia o calculo do crc com
              if  sop_d1 = '1' then
                -- ns_crc <= IDLE;
              elsif eop_d1(4) = '0' then
                ns_crc <= D128;
              elsif (eop_d1(4) = '1' and eop_d1(3 downto 0) > x"4") then
                ns_crc <= EOP;
              elsif (eop_d1(4) = '1' and eop_d1(3 downto 0) < x"5") then
                -- quando o estado D128 já calcula o ultimo valor para o CRC
                ns_crc <= IDLE;
              end if;

          when EOP => -- confere com o CRC gerado no TX
              if sop_d1 = '1' then
                ns_crc <= D128;
              else
                ns_crc <= IDLE;
              end if;
        end case;
      end if;
    end process;


    output_decoder: process(ps_crc, clk_312, rst_n)
    begin
      if rst_n = '0' then
        crc_reg <= (others=>'1');
        crc_received <= (others=>'0');

      elsif clk_312'event and clk_312 = '1' then

        case ps_crc is

          when IDLE =>
            crc_reg <= x"FFFFFFFF";
            -- crc_value <= (others = '1');
            -- crc_reg <= nextCRC32_D128(reverse(data_d2), x"FFFFFFFF");

          when D128 =>
            -- crc_reg <= nextCRC32_D128(reverse(data_d2), crc_reg);
            if (eop_d1(4) = '1' and eop_d1(3 downto 0) < x"5") then
              case eop_d1(3 downto 0) is
                when x"0" =>  crc_reg <= nextCRC32_D96(reverse(data_d2(  95 downto 0)), crc_reg);
                              crc_received <= data_d2(127 downto 96); -- certo
                              -- crc_received <= data_d2(127 downto 96);
                when x"1" =>  crc_reg <= nextCRC32_D104(reverse(data_d2(103 downto 0)), crc_reg);
                              crc_received <= data_d1(7 downto 0) & data_d2(127 downto 104);
                              -- crc_received <= data_d1(7 downto 0) & data_d2(127 downto 104);
                when x"2" =>  crc_reg <= nextCRC32_D112(reverse(data_d2(111 downto 0)), crc_reg);
                              crc_received <= data_d1(15 downto 0) & data_d2(127 downto 112);
                              -- crc_received <= data_d1(15 downto 0) & data_d2(127 downto 112);
                when x"3" =>  crc_reg <= nextCRC32_D120(reverse(data_d2(119 downto 0)), crc_reg);
                              crc_received <= data_d1(23 downto 0) & data_d2(127 downto 120);
                              -- crc_received <= data_d1(23 downto 0) & data_d2(127 downto 120);
                when x"4" =>  crc_reg <= nextCRC32_D128(reverse(data_d2(127 downto 0)), crc_reg);
                              crc_received <= data_d1(31 downto 0);
                              -- crc_received <= data_d1(31 downto 0);
                when others => null;
              end case;

            else

              -- crc_reg <= nextCRC32_D128(reverse(data_d2), crc_reg);
              if (eop_d3(4) = '1') then
                crc_reg <=  nextCRC32_D128(reverse(data_d2), x"FFFFFFFF");
              else
                crc_reg <=  nextCRC32_D128(reverse(data_d2), crc_reg);
              end if;

            end if;


          when EOP =>
              case eop_d2(3 downto 0) is
                -- when x"0" => null;  -- valor para calc do crc no ciclo anterior, estes valores no CRc correspondem ao CRc de comparação e FD
                -- when x"1" => null;  -- valor para calc do crc no ciclo anterior, estes valores no CRc correspondem ao CRc de comparação e FD
                -- when x"2" => null;  -- valor para calc do crc no ciclo anterior, estes valores no CRc correspondem ao CRc de comparação e FD
                -- when x"3" => null;  -- valor para calc do crc no ciclo anterior, estes valores no CRc correspondem ao CRc de comparação e FD
                -- when x"4" => null;  -- valor para calc do crc no ciclo anterior, estes valores no CRc correspondem ao CRc de comparação e FD

                when x"5" =>  crc_reg <= nextCRC32_D8(reverse(data_d2(  7 downto 0)), crc_reg);
                              crc_received <= data_d2(39 downto 8);
                when x"6" =>  crc_reg <= nextCRC32_D16(reverse(data_d2(15 downto 0)), crc_reg);
                              crc_received <= data_d2(47 downto 16);
                when x"7" =>  crc_reg <= nextCRC32_D24(reverse(data_d2(23 downto 0)), crc_reg);
                              crc_received <= data_d2(55 downto 24);
                when x"8" =>  crc_reg <= nextCRC32_D32(reverse(data_d2(31 downto 0)), crc_reg);
                              crc_received <= data_d2(63 downto 32);

                when x"9" =>  crc_reg <= nextCRC32_D40(reverse(data_d2(39 downto 0)), crc_reg);
                              crc_received <= data_d2(71 downto 40);
                when x"A" =>  crc_reg <= nextCRC32_D48(reverse(data_d2(47 downto 0)), crc_reg);
                              crc_received <= data_d2(79 downto 48);
                when x"B" =>  crc_reg <= nextCRC32_D56(reverse(data_d2(55 downto 0)), crc_reg);
                              crc_received <= data_d2(87 downto 56);
                when x"C" =>  crc_reg <= nextCRC32_D64(reverse(data_d2(63 downto 0)), crc_reg);
                              crc_received <= data_d2(95 downto 64);

                when x"D" =>  crc_reg <= nextCRC32_D72(reverse(data_d2(71 downto 0)), crc_reg);
                              crc_received <= data_d2(103 downto 72);
                when x"E" =>  crc_reg <= nextCRC32_D80(reverse(data_d2(79 downto 0)), crc_reg);
                              crc_received <= data_d2(111 downto 80);
                when x"F" =>  crc_reg <= nextCRC32_D88(reverse(data_d2(87 downto 0)), crc_reg);
                              crc_received <= data_d2(119 downto 88);
                when others => null;
              end case;

        end case;
      end if;
    end process;

  end behav_crc_rx_sfifo;
