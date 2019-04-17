library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use ieee.std_logic_unsigned.all;
  use work.PKG_CODES.all;
  use work.rev_func.all;

entity mii_if is
  port (
    clk      : in std_logic;
    rst      : in std_logic;

    data_in  : in std_logic_vector(255 downto 0);
    eop_in   : in std_logic_vector(  5 downto 0);
    sop_in   : in std_logic_vector(  1 downto 0);
    val_in   : in std_logic;
    almost_e : in std_logic;
    almost_f : in std_logic;
    empty    : in std_logic;
    full     : in std_logic;

    ren_out    : out std_logic;
    mii_data_0_out : out std_logic_vector(63 downto 0);
    mii_ctrl_0_out : out std_logic_vector( 7 downto 0);
    mii_data_1_out : out std_logic_vector(63 downto 0);
    mii_ctrl_1_out : out std_logic_vector( 7 downto 0);
    mii_data_2_out : out std_logic_vector(63 downto 0);
    mii_ctrl_2_out : out std_logic_vector( 7 downto 0);
    mii_data_3_out : out std_logic_vector(63 downto 0);
    mii_ctrl_3_out : out std_logic_vector( 7 downto 0)
  );
end entity;


architecture behav_mii_if of mii_if is
  type mii_fsm_states is (S_IDLE, S_TX, S_IPG, S_EOP, S_SET_IPG, S_WAIT_1C, S_ERROR);
  signal ps_mii : mii_fsm_states;
  signal ns_mii : mii_fsm_states;

  signal reading   : std_logic;
  signal ren_int   : std_logic;
  signal ren_int_o : std_logic;
  signal shift     : std_logic_vector(1 downto 0);
  signal fifo_wait : std_logic;

  signal eop_in_o   : std_logic_vector(5 downto 0);
  signal eop_in_o_o : std_logic_vector(5 downto 0);
  signal sop_in_o   : std_logic_vector(1 downto 0);
  signal sop_in_o_o : std_logic_vector(1 downto 0);

  signal data_0_o : std_logic_vector(63 downto 0);
  signal data_1_o : std_logic_vector(63 downto 0);
  signal data_2_o : std_logic_vector(63 downto 0);
  signal data_3_o : std_logic_vector(63 downto 0);
  signal data_0_o_o : std_logic_vector(63 downto 0);
  signal data_1_o_o : std_logic_vector(63 downto 0);
  signal data_2_o_o : std_logic_vector(63 downto 0);
  signal data_3_o_o : std_logic_vector(63 downto 0);

  signal inv_data_0 : std_logic_vector(63 downto 0);
  signal inv_ctrl_0 : std_logic_vector( 7 downto 0);
  signal inv_data_1 : std_logic_vector(63 downto 0);
  signal inv_ctrl_1 : std_logic_vector( 7 downto 0);
  signal inv_data_2 : std_logic_vector(63 downto 0);
  signal inv_ctrl_2 : std_logic_vector( 7 downto 0);
  signal inv_data_3 : std_logic_vector(63 downto 0);
  signal inv_ctrl_3 : std_logic_vector( 7 downto 0);

  signal mii_data_0 : std_logic_vector(63 downto 0);
  signal mii_ctrl_0 : std_logic_vector( 7 downto 0);
  signal mii_data_1 : std_logic_vector(63 downto 0);
  signal mii_ctrl_1 : std_logic_vector( 7 downto 0);
  signal mii_data_2 : std_logic_vector(63 downto 0);
  signal mii_ctrl_2 : std_logic_vector( 7 downto 0);
  signal mii_data_3 : std_logic_vector(63 downto 0);
  signal mii_ctrl_3 : std_logic_vector( 7 downto 0);




  begin


    mii_ctrl_0_out <= mii_ctrl_0;
    mii_data_0_out <= mii_data_0;
    mii_ctrl_1_out <= mii_ctrl_1;
    mii_data_1_out <= mii_data_1;
    mii_ctrl_2_out <= mii_ctrl_2;
    mii_data_2_out <= mii_data_2;
    mii_ctrl_3_out <= mii_ctrl_3;
    mii_data_3_out <= mii_data_3;

    -- Invertendo MII para o PCS
    -- mii_ctrl_0_out <= x"01" when (mii_data_0 = x"FB555555555555D5") else reverse(mii_ctrl_0);
    -- mii_data_0_out <= mii_data_0( 7 downto  0) & mii_data_0(15 downto  8) & mii_data_0(23 downto 16) & mii_data_0(31 downto 24) &
                     -- mii_data_0(39 downto 32) & mii_data_0(47 downto 40) & mii_data_0(55 downto 48) & mii_data_0(63 downto 56);
    -- mii_ctrl_1_out <= reverse(mii_ctrl_1);
    -- mii_data_1_out <= mii_data_1( 7 downto  0) & mii_data_1(15 downto  8) & mii_data_1(23 downto 16) & mii_data_1(31 downto 24) &
                     -- mii_data_1(39 downto 32) & mii_data_1(47 downto 40) & mii_data_1(55 downto 48) & mii_data_1(63 downto 56);
    -- mii_ctrl_2_out <= x"01" when (mii_data_2 = x"FB555555555555D5") else reverse(mii_ctrl_2);
    -- mii_data_2_out <= mii_data_2( 7 downto  0) & mii_data_2(15 downto  8) & mii_data_2(23 downto 16) & mii_data_2(31 downto 24) &
                     -- mii_data_2(39 downto 32) & mii_data_2(47 downto 40) & mii_data_2(55 downto 48) & mii_data_2(63 downto 56);
    -- mii_ctrl_3_out <= reverse(mii_ctrl_3);
    -- mii_data_3_out <= mii_data_3( 7 downto  0) & mii_data_3(15 downto  8) & mii_data_3(23 downto 16) & mii_data_3(31 downto 24) &
                     -- mii_data_3(39 downto 32) & mii_data_3(47 downto 40) & mii_data_3(55 downto 48) & mii_data_3(63 downto 56);

-- Controla a Leitura da FIFO que alimenta o módulo
  ctrl_fifo1: process(clk,rst)
  begin
    if rst = '0' then
      reading <= '0';

    elsif clk'event and clk = '1' then
      if almost_e = '0' then
        reading <= '1';
      else
        if eop_in(5) = '0' then
          reading <= '0';
        end if;
      end if;
    end if;
  end process;

  ren_out <= ren_int;
  ren_int <=  '0' when (almost_e = '1' and eop_in(5) = '0')  or fifo_wait = '1'
              else '1';


  RST_SM: process (clk, rst)
  begin
    if rst = '0' then
      ps_mii <= S_ERROR;
      -- shift <= "00";
    elsif clk 'event and clk = '1' then
      ps_mii <= ns_mii;
    end if;
  end process;


  SM_MII: process (ps_mii, reading, val_in, sop_in, eop_in, almost_e)
  begin
    fifo_wait <= '0';
    case ps_mii is

      when S_IDLE =>
        if reading = '1' and val_in = '0' then
          ns_mii <= S_IDLE;
        elsif reading = '1' and val_in = '1' and sop_in(1) = '1' then
          ns_mii <= S_TX;
        else
          --ns_mii <= S_ERROR;
        end if;

      when S_TX =>
        if reading = '1' and val_in = '1' and sop_in(1) = '0' and
           eop_in = "100000" then
          ns_mii <= S_TX;
        elsif reading = '1' and val_in = '1' and eop_in /= "100000" and sop_in(1) = '0' then
          ns_mii <= S_EOP;

        elsif reading = '1' and val_in = '1' and eop_in /= "100000" and sop_in(1) = '1'then
          ns_mii <= S_EOP;
          fifo_wait <= '1';

        else
          --ns_mii <= S_ERROR;
        end if;

      when S_EOP =>
        -- if sop_in(1) = '0' and eop_in < "010100" then -- Garante IPG sem SOP, com EOP < 20°byte
        -- if sop_in(1) = '0' and eop_in < "010011" then -- Garante IPG sem SOP, com EOP < 19°byte
        if sop_in(1) = '0' and eop_in < "010011" and shift = "00" then -- Garante IPG sem SOP, com EOP < 19°byte
          ns_mii <= S_IDLE;

        -- elsif sop_in(1) = '0' and eop_in(4 downto 0) > "01110" and shift = "01" then
          -- ns_mii <= S_IPG;

        -- elsif sop_in(1) = '1' and eop_in_o < "010011" then -- Garante IPG - Tanauan
        --   ns_mii <= S_TX;
        elsif sop_in(1) = '1' and eop_in_o < "010011" and sop_in_o(1) = '0' then
          ns_mii <= S_TX;
        elsif sop_in(1) = '1' and eop_in_o < "001111" and sop_in_o(1) = '1'then
          ns_mii <= S_WAIT_1C;
                                                                                          -- Talvez < 000011
        elsif reading = '1' and val_in = '1' and sop_in = "11" and eop_in < "000100" then -- Garante IPG com SOP e EOP < 3° byte
          ns_mii <= S_IDLE;
        -- elsif sop_in(1) = '0' and eop_in > "010011" then -- EOP > 19ºbyte
        elsif sop_in(1) = '0' and eop_in > "010010" then -- EOP > 18ºbyte
          ns_mii <= S_IPG;
        -- elsif reading = '1' and val_in = '1' and sop_in = "11" and eop_in >= "000100" and shift = "00" then -- Ajusta IPG
        elsif reading = '1' and val_in = '1' and sop_in = "11" and eop_in >= "000011" and shift = "00" then -- Ajusta IPG
          ns_mii <= S_SET_IPG;
        -- elsif reading = '1' and val_in = '1' and eop_in >= "000100" and shift = "01" then -- Pausa 1C e reoderna transmição
        elsif reading = '1' and val_in = '1' and eop_in >= "000011" and shift = "01" then -- Pausa 1C e reoderna transmição
          ns_mii <= S_WAIT_1C;
          fifo_wait <= '1';



        -- Tanauan dia 08/04/19
        --
        -- elsif reading = '1' and val_in = '1' and eop_in_o_o < "000011" and shift = "01" then
        --     ns_mii <= S_IDLE;
      elsif reading = '0' and val_in = '1' and eop_in < "001111" and shift = "01" and sop_in(1)='0' then
          ns_mii <= S_IPG;

        else
          --ns_mii <= S_ERROR;
        end if;

      when S_ERROR =>
        ns_mii <= S_IDLE;
        -- shift <= "00";

      when S_IPG =>
        -- fifo_wait <= '1';

        if almost_e = '1' then
          ns_mii <= S_IPG;
          fifo_wait <= '1';
        -- if sop_in_o(1) = '0' then
        elsif sop_in_o(1) = '0' then
          ns_mii <= S_IDLE;
        else
          ns_mii <= S_TX;
        end if;


      when S_SET_IPG =>
        ns_mii <= S_TX;

      when S_WAIT_1C =>
        if sop_in_o(1) = '1' then
          ns_mii <= S_TX;
        else
          ns_mii <= S_IDLE;
        end if;


      when others =>

    end case;
  end process;


  OUTPUTS_MII: process (ps_mii, reading, val_in, sop_in, eop_in, clk)
  begin
    if clk'event and clk = '1' then

    mii_data_0 <= LANE_IDLE;
    mii_data_1 <= LANE_IDLE;
    mii_data_2 <= LANE_IDLE;
    mii_data_3 <= LANE_IDLE;
    mii_ctrl_0 <= x"ff";
    mii_ctrl_1 <= x"ff";
    mii_ctrl_2 <= x"ff";
    mii_ctrl_3 <= x"ff";
    ---------------------------
    inv_ctrl_0  <= x"ff";
    inv_ctrl_1  <= x"ff";
    inv_ctrl_2  <= x"ff";
    inv_ctrl_3  <= x"ff";
    inv_data_0  <= LANE_IDLE;
    inv_data_1  <= LANE_IDLE;
    inv_data_2  <= LANE_IDLE;
    inv_data_3  <= LANE_IDLE;

    case ps_mii is

      when S_IDLE =>
        case shift is
          when "00" =>
            if sop_in_o = "10" then
              mii_ctrl_0 <= x"01";
              mii_ctrl_1 <= x"00";
              mii_ctrl_2 <= x"00";
              mii_ctrl_3 <= x"00";
              mii_data_0 <= data_0_o;
              mii_data_1 <= data_1_o;
              mii_data_2 <= data_2_o;
              mii_data_3 <= data_3_o;

            elsif sop_in_o = "11" then
              mii_ctrl_0 <= x"ff";
              mii_ctrl_1 <= x"ff";
              mii_ctrl_2 <= x"01";
              mii_ctrl_3 <= x"00";
              mii_data_0 <= LANE_IDLE;
              mii_data_1 <= LANE_IDLE;
              mii_data_2 <= data_2_o;
              mii_data_3 <= data_3_o;
            end if;

          when others => null;
        end case;

      when S_TX =>
        case shift is
          when "00" =>
            if sop_in_o = "10" then
              mii_ctrl_0 <= x"01";
              mii_ctrl_1 <= x"00";
              mii_ctrl_2 <= x"00";
              mii_ctrl_3 <= x"00";
              mii_data_0 <= data_0_o;
              mii_data_1 <= data_1_o;
              mii_data_2 <= data_2_o;
              mii_data_3 <= data_3_o;
              ---------------------------
              inv_ctrl_0  <= x"01";
              inv_ctrl_1  <= x"ff";
              inv_ctrl_2  <= x"ff";
              inv_ctrl_3  <= x"ff";
              inv_data_0  <= data_0_o;
              inv_data_1  <= data_1_o( 7 downto  0) & data_1_o(15 downto  8) & data_1_o(23 downto 16) & data_1_o(31 downto 24) &
                             data_1_o(39 downto 32) & data_1_o(47 downto 40) & data_1_o(55 downto 48) & data_1_o(63 downto 56);
              inv_data_2  <= data_2_o( 7 downto  0) & data_2_o(15 downto  8) & data_2_o(23 downto 16) & data_2_o(31 downto 24) &
                             data_2_o(39 downto 32) & data_2_o(47 downto 40) & data_2_o(55 downto 48) & data_2_o(63 downto 56);
              inv_data_3  <= data_3_o( 7 downto  0) & data_3_o(15 downto  8) & data_3_o(23 downto 16) & data_3_o(31 downto 24) &
                             data_3_o(39 downto 32) & data_3_o(47 downto 40) & data_3_o(55 downto 48) & data_3_o(63 downto 56);


            elsif sop_in_o = "11" then
              mii_ctrl_0 <= x"ff";
              mii_ctrl_1 <= x"ff";
              mii_ctrl_2 <= x"01";
              mii_ctrl_3 <= x"00";
              mii_data_0 <= LANE_IDLE;
              mii_data_1 <= LANE_IDLE;
              mii_data_2 <= data_2_o;
              mii_data_3 <= data_3_o;
              ---------------------------
              inv_ctrl_0 <= x"ff";
              inv_ctrl_1 <= x"ff";
              inv_ctrl_2 <= x"01";
              inv_ctrl_3 <= x"00";
              inv_data_0 <= LANE_IDLE;
              inv_data_1 <= LANE_IDLE;
              inv_data_2  <=  data_2_o( 7 downto  0) & data_2_o(15 downto  8) & data_2_o(23 downto 16) & data_2_o(31 downto 24) &
                              data_2_o(39 downto 32) & data_2_o(47 downto 40) & data_2_o(55 downto 48) & data_2_o(63 downto 56);
              inv_data_3  <=  data_3_o( 7 downto  0) & data_3_o(15 downto  8) & data_3_o(23 downto 16) & data_3_o(31 downto 24) &
                              data_3_o(39 downto 32) & data_3_o(47 downto 40) & data_3_o(55 downto 48) & data_3_o(63 downto 56);

            else
              mii_ctrl_0 <= x"00";
              mii_ctrl_1 <= x"00";
              mii_ctrl_2 <= x"00";
              mii_ctrl_3 <= x"00";
              mii_data_0 <= data_0_o;
              mii_data_1 <= data_1_o;
              mii_data_2 <= data_2_o;
              mii_data_3 <= data_3_o;
              ---------------------------
              inv_ctrl_0  <= x"00";
              inv_ctrl_1  <= x"00";
              inv_ctrl_2  <= x"00";
              inv_ctrl_3  <= x"00";
              inv_data_0  <=  data_0_o( 7 downto  0) & data_0_o(15 downto  8) & data_0_o(23 downto 16) & data_0_o(31 downto 24) &
                              data_0_o(39 downto 32) & data_0_o(47 downto 40) & data_0_o(55 downto 48) & data_0_o(63 downto 56);
              inv_data_1  <=  data_1_o( 7 downto  0) & data_1_o(15 downto  8) & data_1_o(23 downto 16) & data_1_o(31 downto 24) &
                              data_1_o(39 downto 32) & data_1_o(47 downto 40) & data_1_o(55 downto 48) & data_1_o(63 downto 56);
              inv_data_2  <=  data_2_o( 7 downto  0) & data_2_o(15 downto  8) & data_2_o(23 downto 16) & data_2_o(31 downto 24) &
                              data_2_o(39 downto 32) & data_2_o(47 downto 40) & data_2_o(55 downto 48) & data_2_o(63 downto 56);
              inv_data_3  <=  data_3_o( 7 downto  0) & data_3_o(15 downto  8) & data_3_o(23 downto 16) & data_3_o(31 downto 24) &
                              data_3_o(39 downto 32) & data_3_o(47 downto 40) & data_3_o(55 downto 48) & data_3_o(63 downto 56);
            end if;

          when "01" =>  --shift = 01
            if sop_in_o = "10" then
              mii_data_0 <= LANE_IDLE;
              mii_data_1 <= LANE_IDLE;
              mii_data_2 <= data_0_o;
              mii_data_3 <= data_1_o;
              mii_ctrl_0 <= x"ff";
              mii_ctrl_1 <= x"ff";
              mii_ctrl_2 <= x"01";
              mii_ctrl_3 <= x"00";

            -- elsif sop_in_o = "11" then --tanauan dia 04/04/19
            --   mii_data_0 <= LANE_IDLE;
            --   mii_data_1 <= LANE_IDLE;
            --   mii_data_2 <= LANE_IDLE;
            --   mii_data_3 <= LANE_IDLE;
            --   mii_ctrl_0 <= x"ff";
            --   mii_ctrl_1 <= x"ff";
            --   mii_ctrl_2 <= x"ff";
            --   mii_ctrl_3 <= x"ff";

            elsif sop_in_o_o = "11" then
              mii_data_0 <= data_2_o_o;
              mii_data_1 <= data_3_o_o;
              mii_data_2 <= data_0_o;
              mii_data_3 <= data_1_o;
              mii_ctrl_0 <= x"01";
              mii_ctrl_1 <= x"00";
              mii_ctrl_2 <= x"00";
              mii_ctrl_3 <= x"00";
            else
              mii_data_0 <= data_2_o_o;
              mii_data_1 <= data_3_o_o;
              mii_data_2 <= data_0_o;
              mii_data_3 <= data_1_o;
              mii_ctrl_0 <= x"00";
              mii_ctrl_1 <= x"00";
              mii_ctrl_2 <= x"00";
              mii_ctrl_3 <= x"00";
            end if;

            -- mii_data_0 <= data_2_o_o;
            -- mii_data_1 <= data_3_o_o;
            -- mii_data_2 <= data_0_o;
            -- mii_data_3 <= data_1_o;
            -- mii_ctrl_0 <= x"00";
            -- mii_ctrl_1 <= x"00";
            -- mii_ctrl_2 <= x"00";
            -- mii_ctrl_3 <= x"00";

            inv_ctrl_0  <= x"00";
            inv_ctrl_1  <= x"00";
            inv_ctrl_2  <= x"00";
            inv_ctrl_3  <= x"00";
            inv_data_0  <=  data_2_o_o( 7 downto  0) & data_2_o_o(15 downto  8) & data_2_o_o(23 downto 16) & data_2_o_o(31 downto 24) &
                            data_2_o_o(39 downto 32) & data_2_o_o(47 downto 40) & data_2_o_o(55 downto 48) & data_2_o_o(63 downto 56);
            inv_data_1  <=  data_3_o_o( 7 downto  0) & data_3_o_o(15 downto  8) & data_3_o_o(23 downto 16) & data_3_o_o(31 downto 24) &
                            data_3_o_o(39 downto 32) & data_3_o_o(47 downto 40) & data_3_o_o(55 downto 48) & data_3_o_o(63 downto 56);
            inv_data_2  <=  data_0_o( 7 downto  0) & data_0_o(15 downto  8) & data_0_o(23 downto 16) & data_0_o(31 downto 24) &
                            data_0_o(39 downto 32) & data_0_o(47 downto 40) & data_0_o(55 downto 48) & data_0_o(63 downto 56);
            inv_data_3  <=  data_1_o( 7 downto  0) & data_1_o(15 downto  8) & data_1_o(23 downto 16) & data_1_o(31 downto 24) &
                            data_1_o(39 downto 32) & data_1_o(47 downto 40) & data_1_o(55 downto 48) & data_1_o(63 downto 56);

          when "11" =>
            mii_data_0 <= data_0_o_o;
            mii_data_1 <= data_1_o_o;
            mii_data_2 <= data_2_o_o;
            mii_data_3 <= data_3_o_o;
            mii_ctrl_1 <= x"00";
            mii_ctrl_2 <= x"00";
            mii_ctrl_3 <= x"00";
            if sop_in_o = "10" then
              mii_ctrl_0 <= x"01";
              inv_ctrl_0 <= x"01";
            else
              mii_ctrl_0 <= x"00";
              inv_ctrl_0 <= x"00";
            end if;
            ---------------------------
            -- inv_ctrl_0  <= x"00";
            inv_ctrl_1  <= x"00";
            inv_ctrl_2  <= x"00";
            inv_ctrl_3  <= x"00";
            inv_data_0  <=  data_0_o_o( 7 downto  0) & data_0_o_o(15 downto  8) & data_0_o_o(23 downto 16) & data_0_o_o(31 downto 24) &
                            data_0_o_o(39 downto 32) & data_0_o_o(47 downto 40) & data_0_o_o(55 downto 48) & data_0_o_o(63 downto 56);
            inv_data_1  <=  data_1_o_o( 7 downto  0) & data_1_o_o(15 downto  8) & data_1_o_o(23 downto 16) & data_1_o_o(31 downto 24) &
                            data_1_o_o(39 downto 32) & data_1_o_o(47 downto 40) & data_1_o_o(55 downto 48) & data_1_o_o(63 downto 56);
            inv_data_2  <=  data_2_o_o( 7 downto  0) & data_2_o_o(15 downto  8) & data_2_o_o(23 downto 16) & data_2_o_o(31 downto 24) &
                            data_2_o_o(39 downto 32) & data_2_o_o(47 downto 40) & data_2_o_o(55 downto 48) & data_2_o_o(63 downto 56);
            inv_data_3  <=  data_3_o_o( 7 downto  0) & data_3_o_o(15 downto  8) & data_3_o_o(23 downto 16) & data_3_o_o(31 downto 24) &
                            data_3_o_o(39 downto 32) & data_3_o_o(47 downto 40) & data_3_o_o(55 downto 48) & data_3_o_o(63 downto 56);

          when others =>
        end case;

      when S_EOP =>
        case eop_in_o is
          when "000000" =>  if shift = "00" then
                              mii_ctrl_0 <= "11111110"; mii_ctrl_1 <= x"ff"; mii_ctrl_2 <= x"ff"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= x"070707070707FD" & data_0_o(7 downto 0);
                              mii_data_1 <= LANE_IDLE; mii_data_2 <= LANE_IDLE; mii_data_3 <= LANE_IDLE;
                              ------------------------------------
                              inv_ctrl_0 <= "01111111";
                              inv_ctrl_1 <= x"ff";
                              inv_ctrl_2 <= x"ff";
                              inv_ctrl_3 <= x"ff";
                              inv_data_0 <= data_0_o(7 downto 0) & x"FD070707070707";
                              inv_data_1 <= LANE_IDLE;
                              inv_data_2 <= LANE_IDLE;
                              inv_data_3 <= LANE_IDLE;
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= "11111110"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= x"070707070707FD" & data_0_o(7 downto 0); mii_data_3 <= LANE_IDLE;
                              ------------------------------------
                              inv_ctrl_0 <= x"00";
                              inv_ctrl_1 <= x"00";
                              inv_ctrl_2 <= "01111111";
                              inv_ctrl_3 <= x"ff";
                              inv_data_0 <= data_2_o_o( 7 downto  0) & data_2_o_o(15 downto  8) & data_2_o_o(23 downto 16) & data_2_o_o(31 downto 24) &
                                            data_2_o_o(39 downto 32) & data_2_o_o(47 downto 40) & data_2_o_o(55 downto 48) & data_2_o_o(63 downto 56);
                              inv_data_1 <= data_3_o_o( 7 downto  0) & data_3_o_o(15 downto  8) & data_3_o_o(23 downto 16) & data_3_o_o(31 downto 24) &
                                            data_3_o_o(39 downto 32) & data_3_o_o(47 downto 40) & data_3_o_o(55 downto 48) & data_3_o_o(63 downto 56);
                              inv_data_2 <= data_0_o(7 downto 0) & x"FD070707070707";
                              inv_data_3 <= LANE_IDLE;
                            end if;

          when "000001" =>  if shift = "00" then
                              mii_ctrl_0 <= "11111100"; mii_ctrl_1 <= x"ff"; mii_ctrl_2 <= x"ff"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= x"0707070707FD" & data_0_o(15 downto 0);
                              mii_data_1 <= LANE_IDLE; mii_data_2 <= LANE_IDLE; mii_data_3 <= LANE_IDLE;
                              ------------------------------------
                              inv_ctrl_0 <= "00111111";
                              inv_ctrl_1 <= x"ff";
                              inv_ctrl_2 <= x"ff";
                              inv_ctrl_3 <= x"ff";
                              inv_data_0 <= data_0_o(7 downto 0) & data_0_o(15 downto 8) & x"FD0707070707";
                              inv_data_1 <= LANE_IDLE;
                              inv_data_2 <= LANE_IDLE;
                              inv_data_3 <= LANE_IDLE;
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= "11111100"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= x"0707070707FD" & data_0_o(15 downto 0); mii_data_3 <= LANE_IDLE;
                              ------------------------------------
                              inv_ctrl_0 <= x"00";
                              inv_ctrl_1 <= x"00";
                              inv_ctrl_2 <= "00111111";
                              inv_ctrl_3 <= x"ff";
                              inv_data_0 <= data_2_o_o( 7 downto  0) & data_2_o_o(15 downto  8) & data_2_o_o(23 downto 16) & data_2_o_o(31 downto 24) &
                                            data_2_o_o(39 downto 32) & data_2_o_o(47 downto 40) & data_2_o_o(55 downto 48) & data_2_o_o(63 downto 56);
                              inv_data_1 <= data_3_o_o( 7 downto  0) & data_3_o_o(15 downto  8) & data_3_o_o(23 downto 16) & data_3_o_o(31 downto 24) &
                                            data_3_o_o(39 downto 32) & data_3_o_o(47 downto 40) & data_3_o_o(55 downto 48) & data_3_o_o(63 downto 56);
                              inv_data_2 <= data_0_o(7 downto 0) & data_0_o(15 downto 8) & x"FD0707070707";
                              inv_data_3 <= LANE_IDLE;

                              --tanauan dia 08/04/19
                              --
                              if eop_in_o_o = "000001" and sop_in_o_o(1) = '0' then
                                mii_ctrl_0 <= x"ff"; mii_ctrl_1 <= x"ff"; mii_ctrl_2 <= x"ff"; mii_ctrl_3 <= x"ff";
                                mii_data_0 <= LANE_IDLE; mii_data_1 <= LANE_IDLE; mii_data_2 <= LANE_IDLE; mii_data_3 <= LANE_IDLE;
                              end if;

                            end if;


          when "000010" =>  if shift = "00" then
                              mii_ctrl_0 <= "11111000"; mii_ctrl_1 <= x"ff"; mii_ctrl_2 <= x"ff"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= x"07070707FD" & data_0_o(23 downto 0);
                              mii_data_1 <= LANE_IDLE; mii_data_2 <= LANE_IDLE; mii_data_3 <= LANE_IDLE;
                              ------------------------------------
                              inv_ctrl_0 <= "00011111";
                              inv_ctrl_1 <= x"ff";
                              inv_ctrl_2 <= x"ff";
                              inv_ctrl_3 <= x"ff";
                              inv_data_0 <= data_0_o(7 downto 0) & data_0_o(15 downto 8) & data_0_o(23 downto 16) & x"FD07070707";
                              inv_data_1 <= LANE_IDLE;
                              inv_data_2 <= LANE_IDLE;
                              inv_data_3 <= LANE_IDLE;
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= "11111000"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= x"07070707FD" & data_0_o(23 downto 0); mii_data_3 <= LANE_IDLE;
                              ------------------------------------
                              --tanauan dia 08/04/19
                              --
                              if eop_in_o_o = "000010" and sop_in_o_o(1) = '0' then
                                mii_ctrl_0 <= x"ff"; mii_ctrl_1 <= x"ff"; mii_ctrl_2 <= x"ff"; mii_ctrl_3 <= x"ff";
                                mii_data_0 <= LANE_IDLE; mii_data_1 <= LANE_IDLE; mii_data_2 <= LANE_IDLE; mii_data_3 <= LANE_IDLE;
                              end if;

                              inv_ctrl_0 <= x"00";
                              inv_ctrl_1 <= x"00";
                              inv_ctrl_2 <= "00011111";
                              inv_ctrl_3 <= x"ff";
                              inv_data_0 <= data_2_o_o( 7 downto  0) & data_2_o_o(15 downto  8) & data_2_o_o(23 downto 16) & data_2_o_o(31 downto 24) &
                                            data_2_o_o(39 downto 32) & data_2_o_o(47 downto 40) & data_2_o_o(55 downto 48) & data_2_o_o(63 downto 56);
                              inv_data_1 <= data_3_o_o( 7 downto  0) & data_3_o_o(15 downto  8) & data_3_o_o(23 downto 16) & data_3_o_o(31 downto 24) &
                                            data_3_o_o(39 downto 32) & data_3_o_o(47 downto 40) & data_3_o_o(55 downto 48) & data_3_o_o(63 downto 56);
                              inv_data_2 <= data_0_o(7 downto 0) & data_0_o(15 downto 8) & data_0_o(23 downto 16) & x"FD07070707";
                              inv_data_3 <= LANE_IDLE;
                            end if;

          when "000011" =>  if shift = "00" then
                              mii_ctrl_0 <= "11110000"; mii_ctrl_1 <= x"ff"; mii_ctrl_2 <= x"ff"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= x"070707FD" & data_0_o(31 downto 0);
                              mii_data_1 <= LANE_IDLE; mii_data_2 <= LANE_IDLE; mii_data_3 <= LANE_IDLE;
                              ------------------------------------
                              inv_ctrl_0 <= "00001111";
                              inv_ctrl_1 <= x"ff";
                              inv_ctrl_2 <= x"ff";
                              inv_ctrl_3 <= x"ff";
                              inv_data_0 <= data_0_o(7 downto 0) & data_0_o(15 downto 8) & data_0_o(23 downto 16) & data_0_o(31 downto 24) & x"FD070707";
                              inv_data_1 <= LANE_IDLE;
                              inv_data_2 <= LANE_IDLE;
                              inv_data_3 <= LANE_IDLE;
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= "11110000"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= x"070707FD" & data_0_o(31 downto 0); mii_data_3 <= LANE_IDLE;

                              --tanauan dia 08/04/19
                              --
                              if eop_in_o_o = "000011" and sop_in_o_o(1) = '0' then
                                mii_ctrl_0 <= x"ff"; mii_ctrl_1 <= x"ff"; mii_ctrl_2 <= x"ff"; mii_ctrl_3 <= x"ff";
                                mii_data_0 <= LANE_IDLE; mii_data_1 <= LANE_IDLE; mii_data_2 <= LANE_IDLE; mii_data_3 <= LANE_IDLE;
                              end if;
                              ------------------------------------
                              inv_ctrl_0 <= x"00";
                              inv_ctrl_1 <= x"00";
                              inv_ctrl_2 <= "00001111";
                              inv_ctrl_3 <= x"ff";
                              inv_data_0 <= data_2_o_o( 7 downto  0) & data_2_o_o(15 downto  8) & data_2_o_o(23 downto 16) & data_2_o_o(31 downto 24) &
                                            data_2_o_o(39 downto 32) & data_2_o_o(47 downto 40) & data_2_o_o(55 downto 48) & data_2_o_o(63 downto 56);
                              inv_data_1 <= data_3_o_o( 7 downto  0) & data_3_o_o(15 downto  8) & data_3_o_o(23 downto 16) & data_3_o_o(31 downto 24) &
                                            data_3_o_o(39 downto 32) & data_3_o_o(47 downto 40) & data_3_o_o(55 downto 48) & data_3_o_o(63 downto 56);
                              inv_data_2 <= data_0_o(7 downto 0) & data_0_o(15 downto 8) & data_0_o(23 downto 16) & data_0_o(31 downto 24) & x"FD070707";
                              inv_data_3 <= LANE_IDLE;
                            end if;

          when "000100" =>  if shift = "00" then
                              mii_ctrl_0 <= "11100000"; mii_ctrl_1 <= x"ff"; mii_ctrl_2 <= x"ff"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= x"0707FD" & data_0_o(39 downto 0);
                              mii_data_1 <= LANE_IDLE; mii_data_2 <= LANE_IDLE; mii_data_3 <= LANE_IDLE;
                              ------------------------------------
                              inv_ctrl_0 <= "00000111";
                              inv_ctrl_1 <= x"ff";
                              inv_ctrl_2 <= x"ff";
                              inv_ctrl_3 <= x"ff";
                              inv_data_0 <= data_0_o( 7 downto 0)   & data_0_o(15 downto 8) & data_0_o(23 downto 16) & data_0_o(31 downto 24) &
                                            data_0_o(39 downto 32)  & x"FD0707";
                              inv_data_1 <= LANE_IDLE;
                              inv_data_2 <= LANE_IDLE;
                              inv_data_3 <= LANE_IDLE;
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= "11100000"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= x"0707FD" & data_0_o(39 downto 0); mii_data_3 <= LANE_IDLE;
                              ------------------------------------
                              inv_ctrl_0 <= x"00";
                              inv_ctrl_1 <= x"00";
                              inv_ctrl_2 <= "00000111";
                              inv_ctrl_3 <= x"ff";
                              inv_data_0 <= data_2_o_o( 7 downto  0) & data_2_o_o(15 downto  8) & data_2_o_o(23 downto 16) & data_2_o_o(31 downto 24) &
                                            data_2_o_o(39 downto 32) & data_2_o_o(47 downto 40) & data_2_o_o(55 downto 48) & data_2_o_o(63 downto 56);
                              inv_data_1 <= data_3_o_o( 7 downto  0) & data_3_o_o(15 downto  8) & data_3_o_o(23 downto 16) & data_3_o_o(31 downto 24) &
                                            data_3_o_o(39 downto 32) & data_3_o_o(47 downto 40) & data_3_o_o(55 downto 48) & data_3_o_o(63 downto 56);
                              inv_data_2 <= data_0_o( 7 downto  0) & data_0_o(15 downto 8) & data_0_o(23 downto 16) & data_0_o(31 downto 24) &
                                            data_0_o(39 downto 32) & x"FD0707";
                              inv_data_3 <= LANE_IDLE;
                            end if;

          when "000101" =>  if shift = "00" then
                              mii_ctrl_0 <= "11000000"; mii_ctrl_1 <= x"ff"; mii_ctrl_2 <= x"ff"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= x"07FD" & data_0_o(47 downto 0);
                              mii_data_1 <= LANE_IDLE; mii_data_2 <= LANE_IDLE; mii_data_3 <= LANE_IDLE;
                              ------------------------------------
                              inv_ctrl_0 <= "00000011";
                              inv_ctrl_1 <= x"ff";
                              inv_ctrl_2 <= x"ff";
                              inv_ctrl_3 <= x"ff";
                              inv_data_0 <= data_0_o( 7 downto 0)   & data_0_o(15 downto  8) & data_0_o(23 downto 16) & data_0_o(31 downto 24) &
                                            data_0_o(39 downto 32)  & data_0_o(47 downto 40) & x"FD07";
                              inv_data_1 <= LANE_IDLE;
                              inv_data_2 <= LANE_IDLE;
                              inv_data_3 <= LANE_IDLE;
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= "11000000"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= x"07FD" & data_0_o(47 downto 0); mii_data_3 <= LANE_IDLE;
                              ------------------------------------
                              inv_ctrl_0 <= x"00";
                              inv_ctrl_1 <= x"00";
                              inv_ctrl_2 <= "00000011";
                              inv_ctrl_3 <= x"ff";
                              inv_data_0 <= data_2_o_o( 7 downto  0) & data_2_o_o(15 downto  8) & data_2_o_o(23 downto 16) & data_2_o_o(31 downto 24) &
                                            data_2_o_o(39 downto 32) & data_2_o_o(47 downto 40) & data_2_o_o(55 downto 48) & data_2_o_o(63 downto 56);
                              inv_data_1 <= data_3_o_o( 7 downto  0) & data_3_o_o(15 downto  8) & data_3_o_o(23 downto 16) & data_3_o_o(31 downto 24) &
                                            data_3_o_o(39 downto 32) & data_3_o_o(47 downto 40) & data_3_o_o(55 downto 48) & data_3_o_o(63 downto 56);
                              inv_data_2 <= data_0_o( 7 downto  0) & data_0_o(15 downto  8) & data_0_o(23 downto 16) & data_0_o(31 downto 24) &
                                            data_0_o(39 downto 32) & data_0_o(47 downto 40) & x"FD07";
                              inv_data_3 <= LANE_IDLE;
                            end if;

          when "000110" =>  if shift = "00" then
                              mii_ctrl_0 <= "10000000"; mii_ctrl_1 <= x"ff"; mii_ctrl_2 <= x"ff"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= x"FD" & data_0_o(55 downto 0);
                              mii_data_1 <= LANE_IDLE; mii_data_2 <= LANE_IDLE; mii_data_3 <= LANE_IDLE;
                              ------------------------------------
                              inv_ctrl_0 <= "00000001";
                              inv_ctrl_1 <= x"ff";
                              inv_ctrl_2 <= x"ff";
                              inv_ctrl_3 <= x"ff";
                              inv_data_0 <= data_0_o( 7 downto 0)   & data_0_o(15 downto  8) & data_0_o(23 downto 16) & data_0_o(31 downto 24) &
                                            data_0_o(39 downto 32)  & data_0_o(47 downto 40) & data_0_o(55 downto 48) & x"FD";
                              inv_data_1 <= LANE_IDLE;
                              inv_data_2 <= LANE_IDLE;
                              inv_data_3 <= LANE_IDLE;
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= "10000000"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= x"FD" & data_0_o(55 downto 0); mii_data_3 <= LANE_IDLE;
                              ------------------------------------
                              inv_ctrl_0 <= x"00";
                              inv_ctrl_1 <= x"00";
                              inv_ctrl_2 <= "00000001";
                              inv_ctrl_3 <= x"ff";
                              inv_data_0 <= data_2_o_o( 7 downto  0) & data_2_o_o(15 downto  8) & data_2_o_o(23 downto 16) & data_2_o_o(31 downto 24) &
                                            data_2_o_o(39 downto 32) & data_2_o_o(47 downto 40) & data_2_o_o(55 downto 48) & data_2_o_o(63 downto 56);
                              inv_data_1 <= data_3_o_o( 7 downto  0) & data_3_o_o(15 downto  8) & data_3_o_o(23 downto 16) & data_3_o_o(31 downto 24) &
                                            data_3_o_o(39 downto 32) & data_3_o_o(47 downto 40) & data_3_o_o(55 downto 48) & data_3_o_o(63 downto 56);
                              inv_data_2 <= data_0_o( 7 downto  0) & data_0_o(15 downto  8) & data_0_o(23 downto 16) & data_0_o(31 downto 24) &
                                            data_0_o(39 downto 32) & data_0_o(47 downto 40) & data_0_o(55 downto 48) & x"FD";
                              inv_data_3 <= LANE_IDLE;
                            end if;

          when "000111" =>  if shift = "00" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= "11111111"; mii_ctrl_2 <= x"ff"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= data_0_o(63 downto 0);  mii_data_1 <= x"07070707070707FD";
                              mii_data_2 <= LANE_IDLE; mii_data_3 <= LANE_IDLE;
                              ------------------------------------
                              inv_ctrl_0 <= "00000000";
                              inv_ctrl_1 <= x"ff";
                              inv_ctrl_2 <= x"ff";
                              inv_ctrl_3 <= x"ff";
                              inv_data_0 <= data_0_o( 7 downto 0)   & data_0_o(15 downto  8) & data_0_o(23 downto 16) & data_0_o(31 downto 24) &
                                            data_0_o(39 downto 32)  & data_0_o(47 downto 40) & data_0_o(55 downto 48) & data_0_o(63 downto 56);
                              inv_data_1 <= x"FD07070707070707";
                              inv_data_2 <= LANE_IDLE;
                              inv_data_3 <= LANE_IDLE;
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= "00000000"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= data_0_o(63 downto 0); mii_data_3 <= x"07070707070707FD";
                              ------------------------------------
                              inv_ctrl_0 <= x"00";
                              inv_ctrl_1 <= x"00";
                              inv_ctrl_2 <= "00000000";
                              inv_ctrl_3 <= x"ff";
                              inv_data_0 <= data_2_o_o( 7 downto  0) & data_2_o_o(15 downto  8) & data_2_o_o(23 downto 16) & data_2_o_o(31 downto 24) &
                                            data_2_o_o(39 downto 32) & data_2_o_o(47 downto 40) & data_2_o_o(55 downto 48) & data_2_o_o(63 downto 56);
                              inv_data_1 <= data_3_o_o( 7 downto  0) & data_3_o_o(15 downto  8) & data_3_o_o(23 downto 16) & data_3_o_o(31 downto 24) &
                                            data_3_o_o(39 downto 32) & data_3_o_o(47 downto 40) & data_3_o_o(55 downto 48) & data_3_o_o(63 downto 56);
                              inv_data_2 <= data_0_o( 7 downto  0) & data_0_o(15 downto  8) & data_0_o(23 downto 16) & data_0_o(31 downto 24) &
                                            data_0_o(39 downto 32) & data_0_o(47 downto 40) & data_0_o(55 downto 48) & data_0_o(63 downto 56);
                              inv_data_3 <= x"FD07070707070707";
                            end if;

          ---------------------------------------------------------------------------------------------------------------

          when "001000" =>  if shift = "00" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= "11111110"; mii_ctrl_2 <= x"ff"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= data_0_o(63 downto 0); mii_data_1 <= x"070707070707FD" & data_1_o(7 downto 0);
                              mii_data_2 <= LANE_IDLE; mii_data_3 <= LANE_IDLE;
                              ------------------------------------
                              inv_ctrl_0 <= x"00";
                              inv_ctrl_1 <= "01111111";
                              inv_ctrl_2 <= x"ff";
                              inv_ctrl_3 <= x"ff";
                              inv_data_0 <= data_0_o( 7 downto 0)   & data_0_o(15 downto  8) & data_0_o(23 downto 16) & data_0_o(31 downto 24) &
                                            data_0_o(39 downto 32)  & data_0_o(47 downto 40) & data_0_o(55 downto 48) & data_0_o(63 downto 56);
                              inv_data_1 <= data_1_o(7 downto 0) & x"FD070707070707";
                              inv_data_2 <= LANE_IDLE;
                              inv_data_3 <= LANE_IDLE;
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= "11111110";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= data_0_o; mii_data_3 <= x"070707070707FD" & data_1_o(7 downto 0);
                              ------------------------------------
                              inv_ctrl_0 <= x"00";
                              inv_ctrl_1 <= x"00";
                              inv_ctrl_2 <= x"00";
                              inv_ctrl_3 <= "01111111";
                              inv_data_0 <= data_2_o_o( 7 downto  0) & data_2_o_o(15 downto  8) & data_2_o_o(23 downto 16) & data_2_o_o(31 downto 24) &
                                            data_2_o_o(39 downto 32) & data_2_o_o(47 downto 40) & data_2_o_o(55 downto 48) & data_2_o_o(63 downto 56);
                              inv_data_1 <= data_3_o_o( 7 downto  0) & data_3_o_o(15 downto  8) & data_3_o_o(23 downto 16) & data_3_o_o(31 downto 24) &
                                            data_3_o_o(39 downto 32) & data_3_o_o(47 downto 40) & data_3_o_o(55 downto 48) & data_3_o_o(63 downto 56);
                              inv_data_2 <= data_0_o( 7 downto  0) & data_0_o(15 downto  8) & data_0_o(23 downto 16) & data_0_o(31 downto 24) &
                                            data_0_o(39 downto 32) & data_0_o(47 downto 40) & data_0_o(55 downto 48) & data_0_o(63 downto 56);
                              inv_data_3 <= data_1_o(7 downto 0) & x"FD070707070707";
                            end if;

          when "001001" =>  if shift = "00" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= "11111100"; mii_ctrl_2 <= x"ff"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= data_0_o(63 downto 0); mii_data_1 <= x"0707070707FD" & data_1_o(15 downto 0);
                              mii_data_2 <= LANE_IDLE; mii_data_3 <= LANE_IDLE;
                              ------------------------------------
                              inv_ctrl_0 <= x"00";
                              inv_ctrl_1 <= "00111111";
                              inv_ctrl_2 <= x"ff";
                              inv_ctrl_3 <= x"ff";
                              inv_data_0 <= data_0_o( 7 downto 0)  & data_0_o(15 downto  8) & data_0_o(23 downto 16) & data_0_o(31 downto 24) &
                                            data_0_o(39 downto 32) & data_0_o(47 downto 40) & data_0_o(55 downto 48) & data_0_o(63 downto 56);
                              inv_data_1 <= data_1_o( 7 downto 0)  & data_1_o(15 downto  8) & x"FD0707070707";
                              inv_data_2 <= LANE_IDLE;
                              inv_data_3 <= LANE_IDLE;
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= "11111100";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= data_0_o; mii_data_3 <= x"0707070707FD" & data_1_o(15 downto 0);
                              ------------------------------------
                              inv_ctrl_0 <= x"00";
                              inv_ctrl_1 <= x"00";
                              inv_ctrl_2 <= x"00";
                              inv_ctrl_3 <= "00111111";
                              inv_data_0 <= data_2_o_o( 7 downto  0) & data_2_o_o(15 downto  8) & data_2_o_o(23 downto 16) & data_2_o_o(31 downto 24) &
                                            data_2_o_o(39 downto 32) & data_2_o_o(47 downto 40) & data_2_o_o(55 downto 48) & data_2_o_o(63 downto 56);
                              inv_data_1 <= data_3_o_o( 7 downto  0) & data_3_o_o(15 downto  8) & data_3_o_o(23 downto 16) & data_3_o_o(31 downto 24) &
                                            data_3_o_o(39 downto 32) & data_3_o_o(47 downto 40) & data_3_o_o(55 downto 48) & data_3_o_o(63 downto 56);
                              inv_data_2 <= data_0_o( 7 downto  0) & data_0_o(15 downto  8) & data_0_o(23 downto 16) & data_0_o(31 downto 24) &
                                            data_0_o(39 downto 32) & data_0_o(47 downto 40) & data_0_o(55 downto 48) & data_0_o(63 downto 56);
                              inv_data_3 <= data_1_o( 7 downto  0) & data_1_o(15 downto  8) & x"FD0707070707";
                            end if;

          when "001010" =>  if shift = "00" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= "11111000"; mii_ctrl_2 <= x"ff"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= data_0_o(63 downto 0); mii_data_1 <= x"07070707FD" & data_1_o(23 downto 0);
                              mii_data_2 <= LANE_IDLE; mii_data_3 <= LANE_IDLE;
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= "11111000";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= data_0_o; mii_data_3 <= x"07070707FD" & data_1_o(23 downto 0);
                            end if;
          when "001011" =>  if shift = "00" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= "11110000"; mii_ctrl_2 <= x"ff"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= data_0_o(63 downto 0); mii_data_1 <= x"070707FD" & data_1_o(31 downto 0);
                              mii_data_2 <= LANE_IDLE; mii_data_3 <= LANE_IDLE;
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= "11110000";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= data_0_o; mii_data_3 <= x"070707FD" & data_1_o(31 downto 0);
                            end if;
          when "001100" =>  if shift = "00" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= "11100000"; mii_ctrl_2 <= x"ff"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= data_0_o(63 downto 0); mii_data_1 <= x"0707FD" & data_1_o(39 downto 0);
                              mii_data_2 <= LANE_IDLE; mii_data_3 <= LANE_IDLE;
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= "11100000";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= data_0_o; mii_data_3 <= x"0707FD" & data_1_o(39 downto 0);
                            end if;
          when "001101" =>  if shift = "00" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= "11000000"; mii_ctrl_2 <= x"ff"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= data_0_o(63 downto 0); mii_data_1 <= x"07FD" & data_1_o(47 downto 0);
                              mii_data_2 <= LANE_IDLE; mii_data_3 <= LANE_IDLE;
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= "11000000";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= data_0_o; mii_data_3 <= x"07FD" & data_1_o(47 downto 0);
                            end if;
          when "001110" =>  if shift = "00" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= "10000000"; mii_ctrl_2 <= x"ff"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= data_0_o(63 downto 0); mii_data_1 <= x"FD" & data_1_o(55 downto 0);
                              mii_data_2 <= LANE_IDLE; mii_data_3 <= LANE_IDLE;
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= "10000000";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= data_0_o; mii_data_3 <= x"FD" & data_1_o(55 downto 0);
                            end if;
          when "001111" =>  if shift = "00" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= "11111111"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= data_0_o(63 downto 0); mii_data_1 <= data_1_o(63 downto 0);
                              mii_data_2 <= x"07070707070707FD"; mii_data_3 <= LANE_IDLE;
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= "00000000";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= data_0_o; mii_data_3 <= data_1_o(63 downto 0);  -- NECESSÁRIO SINALIZAR FD prox ciclo
                            end if;
          ---------------------------------------------------------------------------------------------------------------
          when "010000" =>  if shift = "00" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= "11111110"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= data_0_o(63 downto 0); mii_data_1 <= data_1_o(63 downto 0);
                              mii_data_2 <= x"070707070707FD" & data_2_o(7 downto 0); mii_data_3 <= LANE_IDLE;
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= x"00";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= data_0_o; mii_data_3 <= data_1_o;
                            end if;
          when "010001" =>  if shift = "00" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= "11111100"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= data_0_o(63 downto 0); mii_data_1 <= data_1_o(63 downto 0);
                              -- mii_data_2 <= x"070707070707" & data_2_o(15 downto 0); mii_data_3 <= LANE_IDLE;
                              mii_data_2 <= x"0707070707FD" & data_2_o(15 downto 0); mii_data_3 <= LANE_IDLE;
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= x"00";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= data_0_o; mii_data_3 <= data_1_o;
                            end if;
          when "010010" =>  if shift = "00" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= "11111000"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= data_0_o(63 downto 0); mii_data_1 <= data_1_o(63 downto 0);
                              -- mii_data_2 <= x"0707070707" & data_2_o(23 downto 0); mii_data_3 <= LANE_IDLE;
                              mii_data_2 <= x"07070707FD" & data_2_o(23 downto 0); mii_data_3 <= LANE_IDLE;
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= x"00";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= data_0_o; mii_data_3 <= data_1_o;
                            end if;
          when "010011" =>  if shift = "00" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= "11110000"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= data_0_o(63 downto 0); mii_data_1 <= data_1_o(63 downto 0);
                              -- mii_data_2 <= x"07070707" & data_2_o(31 downto 0); mii_data_3 <= LANE_IDLE;
                              mii_data_2 <= x"070707FD" & data_2_o(31 downto 0); mii_data_3 <= LANE_IDLE;
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= x"00";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= data_0_o; mii_data_3 <= data_1_o;
                            end if;
          when "010100" =>  if shift = "00" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= "11100000"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= data_0_o(63 downto 0); mii_data_1 <= data_1_o(63 downto 0);
                              -- mii_data_2 <= x"070707" & data_2_o(39 downto 0); mii_data_3 <= LANE_IDLE;
                              mii_data_2 <= x"0707FD" & data_2_o(39 downto 0); mii_data_3 <= LANE_IDLE;
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= x"00";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= data_0_o; mii_data_3 <= data_1_o;
                            end if;
          when "010101" =>  if shift = "00" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= "11000000"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= data_0_o(63 downto 0); mii_data_1 <= data_1_o(63 downto 0);
                              -- mii_data_2 <= x"0707" & data_2_o(47 downto 0); mii_data_3 <= LANE_IDLE;
                              mii_data_2 <= x"07FD" & data_2_o(47 downto 0); mii_data_3 <= LANE_IDLE;
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= x"00";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= data_0_o; mii_data_3 <= data_1_o;
                            end if;
          when "010110" =>  if shift = "00" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= "10000000"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= data_0_o(63 downto 0); mii_data_1 <= data_1_o(63 downto 0);
                              -- mii_data_2 <= x"07" & data_2_o(55 downto 0); mii_data_3 <= LANE_IDLE;
                              mii_data_2 <= x"FD" & data_2_o(55 downto 0); mii_data_3 <= LANE_IDLE;
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= x"00";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= data_0_o; mii_data_3 <= data_1_o;
                            end if;
          when "010111" =>  if shift = "00" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= "00000000"; mii_ctrl_3 <= x"ff";
                              mii_data_0 <= data_0_o(63 downto 0); mii_data_1 <= data_1_o(63 downto 0);
                              mii_data_2 <= data_2_o(63 downto 0); mii_data_3 <= x"07070707070707FD";
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= x"00";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= data_0_o; mii_data_3 <= data_1_o;
                            end if;
          ---------------------------------------------------------------------------------------------------------------
          when "011000" =>  if shift = "00" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= "11111110";
                              mii_data_0 <= data_0_o(63 downto 0); mii_data_1 <= data_1_o(63 downto 0);
                              mii_data_2 <= data_2_o(63 downto 0); mii_data_3 <= x"070707070707FD" & data_3_o(7 downto 0);
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= x"00";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= data_0_o; mii_data_3 <= data_1_o;
                            end if;
          when "011001" =>  if shift = "00" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= "11111100";
                              mii_data_0 <= data_0_o(63 downto 0); mii_data_1 <= data_1_o(63 downto 0);
                              mii_data_2 <= data_2_o(63 downto 0); mii_data_3 <= x"0707070707FD" & data_3_o(15 downto 0);
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= x"00";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= data_0_o; mii_data_3 <= data_1_o;
                            end if;
          when "011010" =>  if shift = "00" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= "11111000";
                              mii_data_0 <= data_0_o(63 downto 0); mii_data_1 <= data_1_o(63 downto 0);
                              mii_data_2 <= data_2_o(63 downto 0); mii_data_3 <= x"07070707FD" & data_3_o(23 downto 0);
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= x"00";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= data_0_o; mii_data_3 <= data_1_o;
                            end if;
          when "011011" =>  if shift = "00" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= "11110000";
                              mii_data_0 <= data_0_o(63 downto 0); mii_data_1 <= data_1_o(63 downto 0);
                              mii_data_2 <= data_2_o(63 downto 0); mii_data_3 <= x"070707FD" & data_3_o(31 downto 0);
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= x"00";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= data_0_o; mii_data_3 <= data_1_o;
                            end if;
          when "011100" =>  if shift = "00" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= "11100000";
                              mii_data_0 <= data_0_o(63 downto 0); mii_data_1 <= data_1_o(63 downto 0);
                              mii_data_2 <= data_2_o(63 downto 0); mii_data_3 <= x"0707FD" & data_3_o(39 downto 0);
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= x"00";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= data_0_o; mii_data_3 <= data_1_o;
                            end if;
          when "011101" =>  if shift = "00" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= "11000000";
                              mii_data_0 <= data_0_o(63 downto 0); mii_data_1 <= data_1_o(63 downto 0);
                              mii_data_2 <= data_2_o(63 downto 0); mii_data_3 <= x"07FD" & data_3_o(47 downto 0);
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= x"00";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= data_0_o; mii_data_3 <= data_1_o;
                            end if;
          when "011110" =>  if shift = "00" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= "10000000";
                              mii_data_0 <= data_0_o(63 downto 0); mii_data_1 <= data_1_o(63 downto 0);
                              mii_data_2 <= data_2_o(63 downto 0); mii_data_3 <= x"FD" & data_3_o(55 downto 0);
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= x"00";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= data_0_o; mii_data_3 <= data_1_o;
                            end if;
          when "011111" =>  if shift = "00" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= "00000000"; -- Não marca FD
                              mii_data_0 <= data_0_o(63 downto 0); mii_data_1 <= data_1_o(63 downto 0);
                              mii_data_2 <= data_2_o(63 downto 0); mii_data_3 <= data_3_o(63 downto 0); -- Necessário botar FD no próx ciclo
                            elsif shift = "01" then
                              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= x"00"; mii_ctrl_2 <= x"00"; mii_ctrl_3 <= x"00";
                              mii_data_0 <= data_2_o_o; mii_data_1 <= data_3_o_o;
                              mii_data_2 <= data_0_o; mii_data_3 <= data_1_o;
                            end if;

          when others =>
        end case;

      when S_ERROR =>
        shift <= "00";
        mii_data_0 <= LANE_ERROR;
        mii_data_1 <= LANE_ERROR;
        mii_data_2 <= LANE_ERROR;
        mii_data_3 <= LANE_ERROR;
        mii_ctrl_0 <= x"fe";
        mii_ctrl_1 <= x"fe";
        mii_ctrl_2 <= x"fe";
        mii_ctrl_3 <= x"fe";

      when S_IPG =>
        mii_data_0 <= LANE_IDLE;
        mii_data_1 <= LANE_IDLE;
        mii_data_2 <= LANE_IDLE;
        mii_data_3 <= LANE_IDLE;
        mii_ctrl_0 <= x"ff";
        mii_ctrl_1 <= x"ff";
        mii_ctrl_2 <= x"ff";
        mii_ctrl_3 <= x"ff";

        -- tanauan testando dia 04/04/19
        --
        if eop_in_o_o = "010011" and (shift = "01") then
          mii_data_0 <= x"070707FD" & data_2_o_o(31 downto 0);
          mii_data_1 <= LANE_IDLE;
          mii_data_2 <= LANE_IDLE;
          mii_data_3 <= LANE_IDLE;
          mii_ctrl_0 <= "11110000";
          mii_ctrl_1 <= x"ff";
          mii_ctrl_2 <= x"ff";
          mii_ctrl_3 <= x"ff";
        end if;

        if eop_in_o_o = "011111" and (shift = "01") then
          mii_data_0 <= data_2_o_o;
          mii_data_1 <= data_3_o_o;
          mii_data_2 <= x"07070707070707FD";
          mii_data_3 <= LANE_IDLE;
          mii_ctrl_0 <= x"00";
          mii_ctrl_1 <= x"00";
          mii_ctrl_2 <= x"ff";
          mii_ctrl_3 <= x"ff";
        end if;




        if eop_in_o_o = "011111" and shift = "00" then
          mii_data_0 <= x"07070707070707FD";
          mii_data_1 <= LANE_IDLE;
          mii_data_2 <= LANE_IDLE;
          mii_data_3 <= LANE_IDLE;
          mii_ctrl_0 <= x"ff";
          mii_ctrl_1 <= x"ff";
          mii_ctrl_2 <= x"ff";
          mii_ctrl_3 <= x"ff";
        end if;

        if sop_in_o(1) = '0' then
          shift <= "00";
        elsif sop_in_o = "10" then
          shift <= "01";
          mii_data_2 <= data_0_o;
          mii_data_3 <= data_1_o;
          mii_ctrl_2 <= x"01";
          mii_ctrl_3 <= x"00";
        elsif sop_in_o = "11" then
          shift <= "01";
          mii_data_2 <= data_2_o;
          mii_data_3 <= data_3_o;
          mii_ctrl_2 <= x"01";
          mii_ctrl_3 <= x"00";
        end if;

      when S_SET_IPG =>
        shift <= "01";
        -- mii_data_0 <= data_2_o_o;
        -- mii_data_1 <= data_3_o_o;
        -- mii_data_2 <= data_0_o;
        -- mii_data_3 <= data_1_o;
        -- mii_ctrl_0 <= x"01";
        -- mii_ctrl_1 <= x"00";
        -- mii_ctrl_2 <= x"00";
        -- mii_ctrl_3 <= x"00";
        mii_data_0 <= LANE_IDLE;
        mii_data_1 <= LANE_IDLE;
        mii_data_2 <= LANE_IDLE;
        mii_data_3 <= LANE_IDLE;
        mii_ctrl_0 <= x"ff";
        mii_ctrl_1 <= x"ff";
        mii_ctrl_2 <= x"ff";
        mii_ctrl_3 <= x"ff";

      when S_WAIT_1C =>
        shift <= "00";
        if eop_in_o_o < "010000" then
          mii_data_0 <= LANE_IDLE;
          mii_data_1 <= LANE_IDLE;
          mii_data_2 <= LANE_IDLE;
          mii_data_3 <= LANE_IDLE;
          mii_ctrl_0 <= x"ff";
          mii_ctrl_1 <= x"ff";
          mii_ctrl_2 <= x"ff";
          mii_ctrl_3 <= x"ff";

        elsif eop_in_o_o >= "010000" then -- talvez ... 00111, a principio dando krep
          case eop_in_o_o is
            when "010000" =>
              mii_ctrl_0 <= "11111110"; mii_ctrl_1 <= x"ff"; mii_ctrl_2 <= x"ff"; mii_ctrl_3 <= x"ff";
              mii_data_0 <= x"070707070707FD" & data_2_o_o(7 downto 0);
              mii_data_1 <= LANE_IDLE; mii_data_2 <= LANE_IDLE; mii_data_3 <= LANE_IDLE;
            when "010001" =>
              mii_ctrl_0 <= "11111100"; mii_ctrl_1 <= x"ff"; mii_ctrl_2 <= x"ff"; mii_ctrl_3 <= x"ff";
              mii_data_0 <= x"0707070707FD" & data_2_o_o(15 downto 0);
              mii_data_1 <= LANE_IDLE; mii_data_2 <= LANE_IDLE; mii_data_3 <= LANE_IDLE;
            when "010010" =>
              mii_ctrl_0 <= "11111000"; mii_ctrl_1 <= x"ff"; mii_ctrl_2 <= x"ff"; mii_ctrl_3 <= x"ff";
              mii_data_0 <= x"07070707FD" & data_2_o_o(23 downto 0);
              mii_data_1 <= LANE_IDLE; mii_data_2 <= LANE_IDLE; mii_data_3 <= LANE_IDLE;
            when "010011" =>
              mii_ctrl_0 <= "11110000"; mii_ctrl_1 <= x"ff"; mii_ctrl_2 <= x"ff"; mii_ctrl_3 <= x"ff";
              mii_data_0 <= x"070707FD" & data_2_o_o(31 downto 0);
              mii_data_1 <= LANE_IDLE; mii_data_2 <= LANE_IDLE; mii_data_3 <= LANE_IDLE;
            when "010100" =>
              mii_ctrl_0 <= "11100000"; mii_ctrl_1 <= x"ff"; mii_ctrl_2 <= x"ff"; mii_ctrl_3 <= x"ff";
              mii_data_0 <= x"0707FD" & data_2_o_o(39 downto 0);
              mii_data_1 <= LANE_IDLE; mii_data_2 <= LANE_IDLE; mii_data_3 <= LANE_IDLE;
            when "010101" =>
              mii_ctrl_0 <= "11000000"; mii_ctrl_1 <= x"ff"; mii_ctrl_2 <= x"ff"; mii_ctrl_3 <= x"ff";
              mii_data_0 <= x"07FD" & data_2_o_o(47 downto 0);
              mii_data_1 <= LANE_IDLE; mii_data_2 <= LANE_IDLE; mii_data_3 <= LANE_IDLE;
            when "010110" =>
              mii_ctrl_0 <= "10000000"; mii_ctrl_1 <= x"ff"; mii_ctrl_2 <= x"ff"; mii_ctrl_3 <= x"ff";
              mii_data_0 <= x"FD" & data_2_o_o(55 downto 0);
              mii_data_1 <= LANE_IDLE; mii_data_2 <= LANE_IDLE; mii_data_3 <= LANE_IDLE;
            when "010111" =>
              mii_ctrl_0 <= "00000000"; mii_ctrl_1 <= x"ff"; mii_ctrl_2 <= x"ff"; mii_ctrl_3 <= x"ff";
              mii_data_0 <= data_2_o_o(63 downto 0); mii_data_1 <= x"07070707070707FD";
              mii_data_2 <= LANE_IDLE; mii_data_3 <= LANE_IDLE;
            ------------------------------------------------------------------------------------------
            when "011000" =>
              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= "11111110"; mii_ctrl_2 <= x"ff"; mii_ctrl_3 <= x"ff";
              mii_data_0 <= data_2_o_o(63 downto 0); mii_data_1 <= x"070707070707FD" & data_3_o_o(7 downto 0);
              mii_data_2 <= LANE_IDLE; mii_data_3 <= LANE_IDLE;
            when "011001" =>
              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= "11111100"; mii_ctrl_2 <= x"ff"; mii_ctrl_3 <= x"ff";
              mii_data_0 <= data_2_o_o(63 downto 0); mii_data_1 <= x"0707070707FD" & data_3_o_o(15 downto 0);
              mii_data_2 <= LANE_IDLE; mii_data_3 <= LANE_IDLE;
            when "011010" =>
              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= "11111000"; mii_ctrl_2 <= x"ff"; mii_ctrl_3 <= x"ff";
              mii_data_0 <= data_2_o_o(63 downto 0); mii_data_1 <= x"07070707FD" & data_3_o_o(23 downto 0);
              mii_data_2 <= LANE_IDLE; mii_data_3 <= LANE_IDLE;
            when "011011" =>
              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= "11110000"; mii_ctrl_2 <= x"ff"; mii_ctrl_3 <= x"ff";
              mii_data_0 <= data_2_o_o(63 downto 0); mii_data_1 <= x"070707FD" & data_3_o_o(31 downto 0);
              mii_data_2 <= LANE_IDLE; mii_data_3 <= LANE_IDLE;
            when "011100" =>
              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= "11100000"; mii_ctrl_2 <= x"ff"; mii_ctrl_3 <= x"ff";
              mii_data_0 <= data_2_o_o(63 downto 0); mii_data_1 <= x"0707FD" & data_3_o_o(39 downto 0);
              mii_data_2 <= LANE_IDLE; mii_data_3 <= LANE_IDLE;
            when "011101" =>
              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= "11000000"; mii_ctrl_2 <= x"ff"; mii_ctrl_3 <= x"ff";
              mii_data_0 <= data_2_o_o(63 downto 0); mii_data_1 <= x"07FD" & data_3_o_o(47 downto 0);
              mii_data_2 <= LANE_IDLE; mii_data_3 <= LANE_IDLE;
            when "011110" =>
              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= "10000000"; mii_ctrl_2 <= x"ff"; mii_ctrl_3 <= x"ff";
              mii_data_0 <= data_2_o_o(63 downto 0); mii_data_1 <= x"FD" & data_3_o_o(55 downto 0);
              mii_data_2 <= LANE_IDLE; mii_data_3 <= LANE_IDLE;
            when "011111" =>
              mii_ctrl_0 <= x"00"; mii_ctrl_1 <= "00000000"; mii_ctrl_2 <= x"ff"; mii_ctrl_3 <= x"ff";
              mii_data_0 <= data_2_o_o(63 downto 0); mii_data_1 <= data_3_o_o(63 downto 0);
              mii_data_2 <= x"07070707070707FD"; mii_data_3 <= LANE_IDLE;

            when others =>
          end case;
        end if;

        if sop_in_o = "11" and sop_in = "00" then
          mii_ctrl_2 <= x"01";
          mii_ctrl_3 <= x"00";
          mii_data_2 <= data_2_o_o;
          mii_data_3 <= data_3_o_o;
        end if;

      when others =>
    end case;
    end if;
  end process;






  REG_LANES: process (clk, rst)
  begin
    if rst = '0' then
      data_0_o <= (others =>'0');
      data_1_o <= (others =>'0');
      data_2_o <= (others =>'0');
      data_3_o <= (others =>'0');
      data_0_o_o <= (others =>'0');
      data_1_o_o <= (others =>'0');
      data_2_o_o <= (others =>'0');
      data_3_o_o <= (others =>'0');
      ren_int_o <= '0';

      sop_in_o_o <= "00";
      sop_in_o <= "00";

    elsif clk'event and clk = '1' then

      ren_int_o <= ren_int;
      if ren_int_o = '1' or eop_in_o(5) = '0' then
        eop_in_o <= eop_in;
        eop_in_o_o <= eop_in_o;
        sop_in_o <= sop_in;
        sop_in_o_o <= sop_in_o;
        data_0_o <= data_in(63 downto 0);
        data_1_o <= data_in(127 downto 64);
        data_2_o <= data_in(191 downto 128);
        data_3_o <= data_in(255 downto 192);
        data_0_o_o <= data_0_o;
        data_1_o_o <= data_1_o;
        data_2_o_o <= data_2_o;
        data_3_o_o <= data_3_o;
      end if;
    end if;
  end process;

end architecture;
