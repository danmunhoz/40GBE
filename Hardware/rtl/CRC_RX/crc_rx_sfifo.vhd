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
    almost_e        : in std_logic;
    ren             : out std_logic;

    --OUTPUTS
    app_data        : out std_logic_vector(127 downto 0);
    app_sop         : out std_logic;
    app_val         : out std_logic;
    app_eop         : out std_logic_vector(4 downto 0);
    crc_ok          : out std_logic
    );
  end entity;



  architecture behav_crc_rx_sfifo of crc_rx_sfifo is

    TYPE states_crc is (IDLE, D128, EOP, NOT_READING);
    signal ns_crc, ps_crc : states_crc;




    signal ren_int        : std_logic;

    signal crc_value      : std_logic_vector(31 downto 0);
    signal crc_final      : std_logic_vector(31 downto 0);
    signal crc_reg        : std_logic_vector(31 downto 0);
    signal crc_received   : std_logic_vector(31 downto 0);
    signal crc_done       : std_logic;
    signal crc_ok_int     : std_logic;

    signal sop_d1  : std_logic;
    signal eop_d1  : std_logic_vector(  4 downto 0);
    signal data_d1 : std_logic_vector(127 downto 0);

    signal sop_d2  : std_logic;
    signal eop_d2  : std_logic_vector(  4 downto 0);
    signal data_d2 : std_logic_vector(127 downto 0);

    signal eop_d3  : std_logic_vector(  4 downto 0);

    signal pkg_counter : integer; -- PARA SIMULAÇÃO
    signal pkg_counter_fail : integer; -- PARA SIMULAÇÃO
    signal pkt_id   : integer; -- PARA SIMULAÇÃO


    ----------OUTPUT --- TESTE DO Receiver


    TYPE states_val is (IDLE, VAL_UP);
    signal val_state: states_val;

    signal data_out : std_logic_vector(127 downto 0);
    signal sop_out  : std_logic;
    signal val_out  : std_logic;
    signal eop_out  : std_logic_vector(4 downto 0);
    signal mac_eop_reg : std_logic;

  begin
    ---------------------------------------
    ---------------------------------------
    --------RECEIVER-------------
    data_out <= mac_data;
    app_data <= data_out;

    sop_out  <= mac_sop;
    app_sop  <= sop_out;

    app_val  <= val_out;

    eop_out  <= mac_eop;
    app_eop  <= eop_out;

    val_proc : process(mac_eop,mac_sop)
    begin
      val_out <= '0';
          case val_state is
            when IDLE =>
              val_out <= '0';
              if mac_sop = '1' then
                val_state <= VAL_UP;
                val_out <= '1';
              end if;
            when VAL_UP =>
              val_out <= '1';
              if mac_eop_reg ='1' then
                val_state <= IDLE;
                val_out <= '0';
              end if;
          end case;
    end process;
  ---------------------------------------
  ---------------------------------------
    ren <= ren_int;
    crc_ok <= crc_ok_int;
    crc_ok_int <= '1' when crc_received = crc_reg and crc_done = '1' else '0';

    DEBUG: process(rst_n, clk_312)
    begin
      if rst_n = '0' then
        pkg_counter <= 0;
        pkg_counter_fail <= 0;
        pkt_id <= 0;

      elsif clk_312'event and clk_312 = '1' then
        if sop_d2 = '1' then
          pkt_id <= to_integer(unsigned(mac_data(63 downto 0)));
        end if;

        if crc_ok_int = '0' and crc_done = '1' then
          report "CRC_FALHOU @ "&time'image(now);
          pkg_counter_fail <= pkg_counter_fail + 1;
        elsif crc_ok_int = '1' and crc_done = '1' then
          pkg_counter <= pkg_counter+1;
          if (pkg_counter mod 100) = 0 then
            report "PKT RECVD (CRC OK) => "&integer'image(pkg_counter)&" |  PKT RECVD (CRC NOK) => "&integer'image(pkg_counter_fail)&" |  PKTS LOST/COMING => "&integer'image(pkt_id-pkg_counter)&" @ "&time'image(now);
          end if;
        end if;
      end if;
    end process;

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

    next_state_decoder: process(rst_n, ps_crc, data_d1, sop_d1, eop_d1,
                                almost_e, mac_sop)
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
              if almost_e = '1' and mac_sop = '0' and sop_d1 = '0' then
                ns_crc <= NOT_READING;
              elsif sop_d1 = '1' then
                ns_crc <= D128;
              else
                ns_crc <= IDLE;
              end if;

          WHEN NOT_READING =>
            if almost_e = '1' then
              ns_crc <= NOT_READING;
            else
              ns_crc <= IDLE;
            end if;

        end case;
      end if;
    end process;


    output_decoder: process(clk_312, rst_n)
    begin
      if rst_n = '0' then
        crc_reg <= (others=>'1');
        crc_received <= (others=>'0');
        crc_done <= '0';
        ren_int <= '0';
        mac_eop_reg <= '0';

      elsif clk_312'event and clk_312 = '1' then
        crc_done <= '0';
        ren_int <= '1';
        mac_eop_reg <= mac_eop(4);
        case ps_crc is
          when IDLE =>
            crc_reg <= x"FFFFFFFF";
            -- crc_value <= (others = '1');
            -- crc_reg <= nextCRC32_D128(reverse(data_d2), x"FFFFFFFF");
            -- if almost_e = '1' and mac_sop = '0' and sop_d1 = '0' then
            --   ren_int <= '0';
            -- end if;
            mac_eop_reg <= mac_eop(4);

          when D128 =>
          mac_eop_reg <= mac_eop(4);

            -- crc_reg <= nextCRC32_D128(reverse(data_d2), crc_reg);
            if (eop_d1(4) = '1' and eop_d1(3 downto 0) < x"5") then
              crc_done <= '1';
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
              mac_eop_reg <= mac_eop(4);

              -- crc_reg <= nextCRC32_D128(reverse(data_d2), crc_reg);
              if (eop_d3(4) = '1') then
                crc_reg <=  nextCRC32_D128(reverse(data_d2), x"FFFFFFFF");
              else
                crc_reg <=  nextCRC32_D128(reverse(data_d2), crc_reg);
              end if;

            end if;


          when EOP =>
            mac_eop_reg <= mac_eop(4);

              crc_done <= '1';
              if almost_e = '1' and mac_sop = '0' and sop_d1 = '0' then
                ren_int <= '0';
              end if;
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

            when NOT_READING =>
              ren_int <= '0';
              mac_eop_reg <= mac_eop(4);


        end case;
      end if;
    end process;


  end behav_crc_rx_sfifo;
