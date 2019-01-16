library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_unsigned.all;
  use ieee.std_logic_arith.all;
  use ieee.numeric_std.all;

entity pcs_alignment is
  port(
      clk_161             : in std_logic;
      clk_156             : in std_logic;
      rst                 : in std_logic;
      lane_0_header_in    : in std_logic_vector(1  downto 0);
      lane_1_header_in    : in std_logic_vector(1  downto 0);
      lane_2_header_in    : in std_logic_vector(1  downto 0);
      lane_3_header_in    : in std_logic_vector(1  downto 0);
      lane_0_data_in      : in std_logic_vector(63 downto 0);
      lane_1_data_in      : in std_logic_vector(63 downto 0);
      lane_2_data_in      : in std_logic_vector(63 downto 0);
      lane_3_data_in      : in std_logic_vector(63 downto 0);
      tx_sequence_cnt_in  : in std_logic_vector(6  downto 0);
      scr_en_in           : in std_logic;

      tx_encoded_pcs0     : in std_logic_vector(65 downto 0);
      tx_encoded_pcs1     : in std_logic_vector(65 downto 0);
      tx_encoded_pcs2     : in std_logic_vector(65 downto 0);
      tx_encoded_pcs3     : in std_logic_vector(65 downto 0);

      tx_wr_pcs           : out std_logic;
      pause_scr_alignm    : out std_logic;
      lane_0_valid_out    : out std_logic;
      lane_1_valid_out    : out std_logic;
      lane_2_valid_out    : out std_logic;
      lane_3_valid_out    : out std_logic;
      lane_0_header_out   : out std_logic_vector(1  downto 0);
      lane_1_header_out   : out std_logic_vector(1  downto 0);
      lane_2_header_out   : out std_logic_vector(1  downto 0);
      lane_3_header_out   : out std_logic_vector(1  downto 0);
      lane_0_data_out     : out std_logic_vector(63 downto 0);
      lane_1_data_out     : out std_logic_vector(63 downto 0);
      lane_2_data_out     : out std_logic_vector(63 downto 0);
      lane_3_data_out     : out std_logic_vector(63 downto 0);
      tx_sequence_cnt_out : out std_logic_vector(6  downto 0)
      );
end entity;

architecture behav_pcs_alignment of pcs_alignment is
    --  Intervalo de blocos para ser inserido alinhamento
    constant N_BLOCKS       : natural := 511 ;

    constant IPG          : std_logic_vector(65 downto 0) := "000000000000000000000000000000000000000000000000000000000001111001";

    constant sync_lane0_high  : std_logic_vector(23 downto 0):= x"907647";
    constant sync_lane1_high  : std_logic_vector(23 downto 0):= x"f0c4e6";
    constant sync_lane2_high  : std_logic_vector(23 downto 0):= x"c5659b";
    constant sync_lane3_high  : std_logic_vector(23 downto 0):= x"a2793d";
    constant sync_lane0_low   : std_logic_vector(23 downto 0):= x"6f89b8";
    constant sync_lane1_low   : std_logic_vector(23 downto 0):= x"0f3b19";
    constant sync_lane2_low   : std_logic_vector(23 downto 0):= x"3a9a64";
    constant sync_lane3_low   : std_logic_vector(23 downto 0):= x"5d86c2";

    signal lane_0_header    : std_logic_vector( 1 downto 0);
    signal lane_1_header    : std_logic_vector( 1 downto 0);
    signal lane_2_header    : std_logic_vector( 1 downto 0);
    signal lane_3_header    : std_logic_vector( 1 downto 0);
    signal lane_0_data      : std_logic_vector(63 downto 0);
    signal lane_1_data      : std_logic_vector(63 downto 0);
    signal lane_2_data      : std_logic_vector(63 downto 0);
    signal lane_3_data      : std_logic_vector(63 downto 0);
    signal tx_sequence_cnt  : std_logic_vector(6 downto 0);

    signal count            : std_logic_vector(13 downto 0);
    signal count_out        : std_logic_vector(13 downto 0);

    signal bip_l0           : std_logic_vector(7 downto 0);
    signal bip_l1           : std_logic_vector(7 downto 0);
    signal bip_l2           : std_logic_vector(7 downto 0);
    signal bip_l3           : std_logic_vector(7 downto 0);

    signal bip_test         : std_logic_vector(7 downto 0);
    signal scr_en           : std_logic;
    signal scr_en_o         : std_logic;

    signal IPGonTX          : std_logic;
    signal flag_align       : std_logic;


    signal is_alignment_oo  : std_logic;
    signal is_alignment_o   : std_logic;
    signal is_alignment     : std_logic;

  begin

    pause_scr_alignm <= is_alignment;

    att_REG: process(clk_161, rst)
    begin
      if rst = '0' then
        lane_0_header <= "10";
        lane_1_header <= "10";
        lane_2_header <= "10";
        lane_3_header <= "10";
        is_alignment_o <= '0';
        is_alignment_oo <= '0';
        lane_0_data   <= (others => '0');
        lane_1_data   <= (others => '0');
        lane_2_data   <= (others => '0');
        lane_3_data   <= (others => '0');
        tx_sequence_cnt <= (others => '0');
        scr_en <= '0';
        scr_en_o <= '0';

      elsif clk_161'event and clk_161 = '1' then
        lane_0_header <= lane_0_header_in;
        lane_1_header <= lane_1_header_in;
        lane_2_header <= lane_2_header_in;
        lane_3_header <= lane_3_header_in;
        lane_0_data   <= lane_0_data_in;
        lane_1_data   <= lane_1_data_in;
        lane_2_data   <= lane_2_data_in;
        lane_3_data   <= lane_3_data_in;
        is_alignment_o <= is_alignment;
        is_alignment_oo <= is_alignment_o;
        tx_sequence_cnt <= tx_sequence_cnt_in;
        scr_en <= scr_en_in;
        scr_en_o <= scr_en;
      end if;
    end process;

    count_alignment: process (clk_161, rst)
    begin

      if rst = '0' then
        is_alignment <= '0';
        count <= (others => '0');

      elsif clk_161'event and clk_161 = '1' then
        count <= count + '1';
        if count = (N_BLOCKS - 2) then
          is_alignment <= '1';
        elsif count = (N_BLOCKS - 1) then
          count <= (others => '0');
          is_alignment <= '0';
        else
        end if;

      end if;
    end process;


    att_outputs: process (clk_161, rst)
    begin

      if rst = '0' then
        lane_0_valid_out <= '0';
        lane_1_valid_out <= '0';
        lane_3_valid_out <= '0';
        lane_2_valid_out <= '0';
        lane_0_header_out <= "10";
        lane_1_header_out <= "10";
        lane_2_header_out <= "10";
        lane_3_header_out <= "10";
        lane_0_data_out <= (others => '0');
        lane_1_data_out <= (others => '0');
        lane_2_data_out <= (others => '0');
        lane_3_data_out <= (others => '0');
        tx_sequence_cnt_out <= (others => '0');
        count_out <= (others => '0');

      elsif clk_161'event and clk_161 = '1' then
        if is_alignment_o = '1' then
          lane_0_data_out <=  sync_lane0_high & bip_l0 &
                              sync_lane0_low  & not bip_l0;
          lane_1_data_out <=  sync_lane1_high & bip_l1 &
                              sync_lane1_low  & not bip_l1;
          lane_2_data_out <=  sync_lane2_high & bip_l2 &
                              sync_lane2_low  & not bip_l2;
          lane_3_data_out <=  sync_lane3_high & bip_l3 &
                              sync_lane3_low  & not bip_l3;
          lane_0_header_out <= "10";
          lane_1_header_out <= "10";
          lane_2_header_out <= "10";
          lane_3_header_out <= "10";
          lane_0_valid_out <= '1';
          lane_1_valid_out <= '1';
          lane_2_valid_out <= '1';
          lane_3_valid_out <= '1';
          count_out <= (others => '0');
          tx_sequence_cnt_out <= tx_sequence_cnt;

        else
          lane_0_header_out <= lane_0_header;
          lane_1_header_out <= lane_1_header;
          lane_2_header_out <= lane_2_header;
          lane_3_header_out <= lane_3_header;
          lane_0_data_out <= lane_0_data;
          lane_1_data_out <= lane_1_data;
          lane_2_data_out <= lane_2_data;
          lane_3_data_out <= lane_3_data;
          tx_sequence_cnt_out <= tx_sequence_cnt;
          count_out <= count_out +1;

          if tx_sequence_cnt = x"20" and scr_en_o = '1' and scr_en = '0' and scr_en_in = '1' then
            lane_0_valid_out <= '0';
            lane_1_valid_out <= '0';
            lane_2_valid_out <= '0';
            lane_3_valid_out <= '0';

          elsif ((scr_en_o = '0' and scr_en = '0' and scr_en_in = '0') or
                 (scr_en_o = '0' and scr_en = '0' and scr_en_in = '1') or
                 (scr_en_o = '0' and scr_en = '1' and scr_en_in = '1'))
                 and tx_sequence_cnt /= x"00" and is_alignment_oo = '0' then
            lane_0_valid_out <= '0';
            lane_1_valid_out <= '0';
            lane_2_valid_out <= '0';
            lane_3_valid_out <= '0';

          elsif (tx_sequence_cnt = x"00" and count = ("00" & x"002")) then
            lane_0_valid_out <= '0';
            lane_1_valid_out <= '0';
            lane_2_valid_out <= '0';
            lane_3_valid_out <= '0';

          elsif (scr_en_o = '0' and scr_en = '0' and scr_en_in = '0') then
            lane_0_valid_out <= '0';
            lane_1_valid_out <= '0';
            lane_2_valid_out <= '0';
            lane_3_valid_out <= '0';

          elsif (scr_en_in = '1' and scr_en = '1' and scr_en_o = '0' and
                 tx_sequence_cnt = x"01" and is_alignment_oo = '1') then
            -- Quando ha marcado de alinhamento entre pausa do PCS
            lane_0_valid_out <= '0';
            lane_1_valid_out <= '0';
            lane_2_valid_out <= '0';
            lane_3_valid_out <= '0';

          else
            lane_0_valid_out <= '1';
            lane_1_valid_out <= '1';
            lane_2_valid_out <= '1';
            lane_3_valid_out <= '1';

          end if;
        end if;
      end if;
    end process;

    IPGonTX <=  '1' when ( (tx_encoded_pcs0 = IPG) and (tx_encoded_pcs1 = IPG) and
                           (tx_encoded_pcs2 = IPG) and (tx_encoded_pcs3 = IPG) ) else
                '0';

    tx_wr_pcs <= '0' when flag_align = '1' and IPGonTX = '1' else '1';

    flag_reg: process (clk_156, rst)
    begin
      if rst = '0' then
        flag_align <= '0';
      elsif clk_156 = '1' and clk_156'event then

        if is_alignment = '1' then
          flag_align <= '1';
        elsif IPGonTX = '1' and flag_align = '1' then
          flag_align <= '0';
        end if;

      end if;

    end process;

     calc_bip: process (clk_161, rst)
     begin

        if rst = '0' then
          bip_l0 <= (others=>'0');
          bip_l1 <= (others=>'0');
          bip_l2 <= (others=>'0');
          bip_l3 <= (others=>'0');

          bip_test <= (others=>'0');

        elsif clk_161'event and clk_161 = '1' then
          if (scr_en_o = '1' and is_alignment_o = '0' and tx_sequence_cnt /=  x"00" ) then
            -- Calculo do BIP

            --    LANE 0
            --
            bip_l0(7) <= ( bip_l0(7)  xor lane_0_data(56) xor lane_0_data(48) xor lane_0_data(40) xor lane_0_data(32)
                                      xor lane_0_data(24) xor lane_0_data(16) xor lane_0_data( 8) xor lane_0_data( 0));
            bip_l0(6) <= ( bip_l0(6)  xor lane_0_data(57) xor lane_0_data(49) xor lane_0_data(41) xor lane_0_data(33)
                                      xor lane_0_data(25) xor lane_0_data(17) xor lane_0_data( 9) xor lane_0_data( 1));
            bip_l0(5) <= ( bip_l0(5)  xor lane_0_data(58) xor lane_0_data(50) xor lane_0_data(42) xor lane_0_data(34)
                                      xor lane_0_data(26) xor lane_0_data(18) xor lane_0_data(10) xor lane_0_data( 2));
            bip_l0(4) <= ( bip_l0(4)  xor lane_0_data(59) xor lane_0_data(51) xor lane_0_data(43) xor lane_0_data(35)
                                      xor lane_0_data(27) xor lane_0_data(19) xor lane_0_data(11) xor lane_0_data( 3) xor lane_0_header(0));
            bip_l0(3) <= ( bip_l0(3)  xor lane_0_data(60) xor lane_0_data(52) xor lane_0_data(44) xor lane_0_data(36)
                                      xor lane_0_data(28) xor lane_0_data(20) xor lane_0_data(12) xor lane_0_data( 4) xor lane_0_header(1));
            bip_l0(2) <= ( bip_l0(2)  xor lane_0_data(61) xor lane_0_data(53) xor lane_0_data(45) xor lane_0_data(37)
                                      xor lane_0_data(29) xor lane_0_data(21) xor lane_0_data(13) xor lane_0_data( 5));
            bip_l0(1) <= ( bip_l0(1)  xor lane_0_data(62) xor lane_0_data(54) xor lane_0_data(46) xor lane_0_data(38)
                                      xor lane_0_data(30) xor lane_0_data(22) xor lane_0_data(14) xor lane_0_data( 6));
            bip_l0(0) <= ( bip_l0(0)  xor lane_0_data(63) xor lane_0_data(55) xor lane_0_data(47) xor lane_0_data(39)
                                      xor lane_0_data(31) xor lane_0_data(23) xor lane_0_data(15) xor lane_0_data( 7));

            --    LANE 1
            --
            bip_l1(7) <= ( bip_l1(7)  xor lane_1_data(56) xor lane_1_data(48) xor lane_1_data(40) xor lane_1_data(32)
                                      xor lane_1_data(24) xor lane_1_data(16) xor lane_1_data( 8) xor lane_1_data( 0));
            bip_l1(6) <= ( bip_l1(6)  xor lane_1_data(57) xor lane_1_data(49) xor lane_1_data(41) xor lane_1_data(33)
                                      xor lane_1_data(25) xor lane_1_data(17) xor lane_1_data( 9) xor lane_1_data( 1));
            bip_l1(5) <= ( bip_l1(5)  xor lane_1_data(58) xor lane_1_data(50) xor lane_1_data(42) xor lane_1_data(34)
                                      xor lane_1_data(26) xor lane_1_data(18) xor lane_1_data(10) xor lane_1_data( 2));
            bip_l1(4) <= ( bip_l1(4)  xor lane_1_data(59) xor lane_1_data(51) xor lane_1_data(43) xor lane_1_data(35)
                                      xor lane_1_data(27) xor lane_1_data(19) xor lane_1_data(11) xor lane_1_data( 3) xor lane_1_header(0));
            bip_l1(3) <= ( bip_l1(3)  xor lane_1_data(60) xor lane_1_data(52) xor lane_1_data(44) xor lane_1_data(36)
                                      xor lane_1_data(28) xor lane_1_data(20) xor lane_1_data(12) xor lane_1_data( 4) xor lane_1_header(1));
            bip_l1(2) <= ( bip_l1(2)  xor lane_1_data(61) xor lane_1_data(53) xor lane_1_data(45) xor lane_1_data(37)
                                      xor lane_1_data(29) xor lane_1_data(21) xor lane_1_data(13) xor lane_1_data( 5));
            bip_l1(1) <= ( bip_l1(1)  xor lane_1_data(62) xor lane_1_data(54) xor lane_1_data(46) xor lane_1_data(38)
                                      xor lane_1_data(30) xor lane_1_data(22) xor lane_1_data(14) xor lane_1_data( 6));
            bip_l1(0) <= ( bip_l1(0)  xor lane_1_data(63) xor lane_1_data(55) xor lane_1_data(47) xor lane_1_data(39)
                                      xor lane_1_data(31) xor lane_1_data(23) xor lane_1_data(15) xor lane_1_data( 7));

            --    LANE 2
            --
            bip_l2(7) <= ( bip_l2(7)  xor lane_2_data(56) xor lane_2_data(48) xor lane_2_data(40) xor lane_2_data(32)
                                      xor lane_2_data(24) xor lane_2_data(16) xor lane_2_data( 8) xor lane_2_data( 0));
            bip_l2(6) <= ( bip_l2(6)  xor lane_2_data(57) xor lane_2_data(49) xor lane_2_data(41) xor lane_2_data(33)
                                      xor lane_2_data(25) xor lane_2_data(17) xor lane_2_data( 9) xor lane_2_data( 1));
            bip_l2(5) <= ( bip_l2(5)  xor lane_2_data(58) xor lane_2_data(50) xor lane_2_data(42) xor lane_2_data(34)
                                      xor lane_2_data(26) xor lane_2_data(18) xor lane_2_data(10) xor lane_2_data( 2));
            bip_l2(4) <= ( bip_l2(4)  xor lane_2_data(59) xor lane_2_data(51) xor lane_2_data(43) xor lane_2_data(35)
                                      xor lane_2_data(27) xor lane_2_data(19) xor lane_2_data(11) xor lane_2_data( 3) xor lane_2_header(0));
            bip_l2(3) <= ( bip_l2(3)  xor lane_2_data(60) xor lane_2_data(52) xor lane_2_data(44) xor lane_2_data(36)
                                      xor lane_2_data(28) xor lane_2_data(20) xor lane_2_data(12) xor lane_2_data( 4) xor lane_2_header(1));
            bip_l2(2) <= ( bip_l2(2)  xor lane_2_data(61) xor lane_2_data(53) xor lane_2_data(45) xor lane_2_data(37)
                                      xor lane_2_data(29) xor lane_2_data(21) xor lane_2_data(13) xor lane_2_data( 5));
            bip_l2(1) <= ( bip_l2(1)  xor lane_2_data(62) xor lane_2_data(54) xor lane_2_data(46) xor lane_2_data(38)
                                      xor lane_2_data(30) xor lane_2_data(22) xor lane_2_data(14) xor lane_2_data( 6));
            bip_l2(0) <= ( bip_l2(0)  xor lane_2_data(63) xor lane_2_data(55) xor lane_2_data(47) xor lane_2_data(39)
                                      xor lane_2_data(31) xor lane_2_data(23) xor lane_2_data(15) xor lane_2_data( 7));

            --    LANE 3
            --
            bip_l3(7) <= ( bip_l3(7)  xor lane_3_data(56) xor lane_3_data(48) xor lane_3_data(40) xor lane_3_data(32)
                                      xor lane_3_data(24) xor lane_3_data(16) xor lane_3_data( 8) xor lane_3_data( 0));
            bip_l3(6) <= ( bip_l3(6)  xor lane_3_data(57) xor lane_3_data(49) xor lane_3_data(41) xor lane_3_data(33)
                                      xor lane_3_data(25) xor lane_3_data(17) xor lane_3_data( 9) xor lane_3_data( 1));
            bip_l3(5) <= ( bip_l3(5)  xor lane_3_data(58) xor lane_3_data(50) xor lane_3_data(42) xor lane_3_data(34)
                                      xor lane_3_data(26) xor lane_3_data(18) xor lane_3_data(10) xor lane_3_data( 2));
            bip_l3(4) <= ( bip_l3(4)  xor lane_3_data(59) xor lane_3_data(51) xor lane_3_data(43) xor lane_3_data(35)
                                      xor lane_3_data(27) xor lane_3_data(19) xor lane_3_data(11) xor lane_3_data( 3) xor lane_3_header(0));
            bip_l3(3) <= ( bip_l3(3)  xor lane_3_data(60) xor lane_3_data(52) xor lane_3_data(44) xor lane_3_data(36)
                                      xor lane_3_data(28) xor lane_3_data(20) xor lane_3_data(12) xor lane_3_data( 4) xor lane_3_header(1));
            bip_l3(2) <= ( bip_l3(2)  xor lane_3_data(61) xor lane_3_data(53) xor lane_3_data(45) xor lane_3_data(37)
                                      xor lane_3_data(29) xor lane_3_data(21) xor lane_3_data(13) xor lane_3_data( 5));
            bip_l3(1) <= ( bip_l3(1)  xor lane_3_data(62) xor lane_3_data(54) xor lane_3_data(46) xor lane_3_data(38)
                                      xor lane_3_data(30) xor lane_3_data(22) xor lane_3_data(14) xor lane_3_data( 6));
            bip_l3(0) <= ( bip_l3(0)  xor lane_3_data(63) xor lane_3_data(55) xor lane_3_data(47) xor lane_3_data(39)
                                      xor lane_3_data(31) xor lane_3_data(23) xor lane_3_data(15) xor lane_3_data( 7));

          elsif (scr_en_o = '1' and is_alignment_o = '1'  ) or
                (scr_en_o = '0' and is_alignment_o = '1' and tx_sequence_cnt = x"00") then
            --
            --    LANE 0
            bip_l0(7) <= (sync_lane0_high(16) xor sync_lane0_high( 8) xor sync_lane0_high( 0) xor bip_l0(0) xor
                          sync_lane0_low(16)  xor sync_lane0_low( 8)  xor sync_lane0_low( 0)  xor (not bip_l0(0)));
            bip_l0(6) <= (sync_lane0_high(17) xor sync_lane0_high( 9) xor sync_lane0_high( 1) xor bip_l0(1) xor
                          sync_lane0_low(17)  xor sync_lane0_low( 9)  xor sync_lane0_low( 1)  xor (not bip_l0(1)));
            bip_l0(5) <= (sync_lane0_high(18) xor sync_lane0_high(10) xor sync_lane0_high( 2) xor bip_l0(2) xor
                          sync_lane0_low(18)  xor sync_lane0_low(10)  xor sync_lane0_low( 2)  xor (not bip_l0(2)));
            bip_l0(4) <= (sync_lane0_high(19) xor sync_lane0_high(11) xor sync_lane0_high( 3) xor bip_l0(3) xor
                          sync_lane0_low(19)  xor sync_lane0_low(11)  xor sync_lane0_low( 3)  xor (not bip_l0(3)) xor '0');
            bip_l0(3) <= (sync_lane0_high(20) xor sync_lane0_high(12) xor sync_lane0_high( 4) xor bip_l0(4) xor
                          sync_lane0_low(20)  xor sync_lane0_low(12)  xor sync_lane0_low( 4)  xor (not bip_l0(4)) xor '1');
            bip_l0(2) <= (sync_lane0_high(21) xor sync_lane0_high(13) xor sync_lane0_high( 5) xor bip_l0(5) xor
                          sync_lane0_low(21)  xor sync_lane0_low(13)  xor sync_lane0_low( 5)  xor (not bip_l0(5)));
            bip_l0(1) <= (sync_lane0_high(22) xor sync_lane0_high(14) xor sync_lane0_high( 6) xor bip_l0(6) xor
                          sync_lane0_low(22)  xor sync_lane0_low(14)  xor sync_lane0_low( 6)  xor (not bip_l0(6)));
            bip_l0(0) <= (sync_lane0_high(23) xor sync_lane0_high(15) xor sync_lane0_high( 7) xor bip_l0(7) xor
                          sync_lane0_low(23)  xor sync_lane0_low(15)  xor sync_lane0_low( 7)  xor (not bip_l0(7)));
            --
            --    LANE 1
            bip_l1(7) <= (sync_lane1_high(16) xor sync_lane1_high( 8) xor sync_lane1_high( 0) xor bip_l1(0) xor
                          sync_lane1_low(16)  xor sync_lane1_low( 8)  xor sync_lane1_low( 0)  xor (not bip_l1(0)));
            bip_l1(6) <= (sync_lane1_high(17) xor sync_lane1_high( 9) xor sync_lane1_high( 1) xor bip_l1(1) xor
                          sync_lane1_low(17)  xor sync_lane1_low( 9)  xor sync_lane1_low( 1)  xor (not bip_l1(1)));
            bip_l1(5) <= (sync_lane1_high(18) xor sync_lane1_high(10) xor sync_lane1_high( 2) xor bip_l1(2) xor
                          sync_lane1_low(18)  xor sync_lane1_low(10)  xor sync_lane1_low( 2)  xor (not bip_l1(2)));
            bip_l1(4) <= (sync_lane1_high(19) xor sync_lane1_high(11) xor sync_lane1_high( 3) xor bip_l1(3) xor
                          sync_lane1_low(19)  xor sync_lane1_low(11)  xor sync_lane1_low( 3)  xor (not bip_l1(3)) xor '0');
            bip_l1(3) <= (sync_lane1_high(20) xor sync_lane1_high(12) xor sync_lane1_high( 4) xor bip_l1(4) xor
                          sync_lane1_low(20)  xor sync_lane1_low(12)  xor sync_lane1_low( 4)  xor (not bip_l1(4)) xor '1');
            bip_l1(2) <= (sync_lane1_high(21) xor sync_lane1_high(13) xor sync_lane1_high( 5) xor bip_l1(5) xor
                          sync_lane1_low(21)  xor sync_lane1_low(13)  xor sync_lane1_low( 5)  xor (not bip_l1(5)));
            bip_l1(1) <= (sync_lane1_high(22) xor sync_lane1_high(14) xor sync_lane1_high( 6) xor bip_l1(6) xor
                          sync_lane1_low(22)  xor sync_lane1_low(14)  xor sync_lane1_low( 6)  xor (not bip_l1(6)));
            bip_l1(0) <= (sync_lane1_high(23) xor sync_lane1_high(15) xor sync_lane1_high( 7) xor bip_l1(7) xor
                          sync_lane1_low(23)  xor sync_lane1_low(15)  xor sync_lane1_low( 7)  xor (not bip_l1(7)));

            --
            --    LANE 2
            bip_l2(7) <= (sync_lane2_high(16) xor sync_lane2_high( 8) xor sync_lane2_high( 0) xor bip_l2(0) xor
                          sync_lane2_low(16)  xor sync_lane2_low( 8)  xor sync_lane2_low( 0)  xor (not bip_l2(0)));
            bip_l2(6) <= (sync_lane2_high(17) xor sync_lane2_high( 9) xor sync_lane2_high( 1) xor bip_l2(1) xor
                          sync_lane2_low(17)  xor sync_lane2_low( 9)  xor sync_lane2_low( 1)  xor (not bip_l2(1)));
            bip_l2(5) <= (sync_lane2_high(18) xor sync_lane2_high(10) xor sync_lane2_high( 2) xor bip_l2(2) xor
                          sync_lane2_low(18)  xor sync_lane2_low(10)  xor sync_lane2_low( 2)  xor (not bip_l2(2)));
            bip_l2(4) <= (sync_lane2_high(19) xor sync_lane2_high(11) xor sync_lane2_high( 3) xor bip_l2(3) xor
                          sync_lane2_low(19)  xor sync_lane2_low(11)  xor sync_lane2_low( 3)  xor (not bip_l2(3)) xor '0');
            bip_l2(3) <= (sync_lane2_high(20) xor sync_lane2_high(12) xor sync_lane2_high( 4) xor bip_l2(4) xor
                          sync_lane2_low(20)  xor sync_lane2_low(12)  xor sync_lane2_low( 4)  xor (not bip_l2(4)) xor '1');
            bip_l2(2) <= (sync_lane2_high(21) xor sync_lane2_high(13) xor sync_lane2_high( 5) xor bip_l2(5) xor
                          sync_lane2_low(21)  xor sync_lane2_low(13)  xor sync_lane2_low( 5)  xor (not bip_l2(5)));
            bip_l2(1) <= (sync_lane2_high(22) xor sync_lane2_high(14) xor sync_lane2_high( 6) xor bip_l2(6) xor
                          sync_lane2_low(22)  xor sync_lane2_low(14)  xor sync_lane2_low( 6)  xor (not bip_l2(6)));
            bip_l2(0) <= (sync_lane2_high(23) xor sync_lane2_high(15) xor sync_lane2_high( 7) xor bip_l2(7) xor
                          sync_lane2_low(23)  xor sync_lane2_low(15)  xor sync_lane2_low( 7)  xor (not bip_l2(7)));

            --
            --    LANE 3
            bip_l3(7) <= (sync_lane3_high(16) xor sync_lane3_high( 8) xor sync_lane3_high( 0) xor bip_l3(0) xor
                          sync_lane3_low(16)  xor sync_lane3_low( 8)  xor sync_lane3_low( 0)  xor (not bip_l3(0)));
            bip_l3(6) <= (sync_lane3_high(17) xor sync_lane3_high( 9) xor sync_lane3_high( 1) xor bip_l3(1) xor
                          sync_lane3_low(17)  xor sync_lane3_low( 9)  xor sync_lane3_low( 1)  xor (not bip_l3(1)));
            bip_l3(5) <= (sync_lane3_high(18) xor sync_lane3_high(10) xor sync_lane3_high( 2) xor bip_l3(2) xor
                          sync_lane3_low(18)  xor sync_lane3_low(10)  xor sync_lane3_low( 2)  xor (not bip_l3(2)));
            bip_l3(4) <= (sync_lane3_high(19) xor sync_lane3_high(11) xor sync_lane3_high( 3) xor bip_l3(3) xor
                          sync_lane3_low(19)  xor sync_lane3_low(11)  xor sync_lane3_low( 3)  xor (not bip_l3(3)) xor '0');
            bip_l3(3) <= (sync_lane3_high(20) xor sync_lane3_high(12) xor sync_lane3_high( 4) xor bip_l3(4) xor
                          sync_lane3_low(20)  xor sync_lane3_low(12)  xor sync_lane3_low( 4)  xor (not bip_l3(4)) xor '1');
            bip_l3(2) <= (sync_lane3_high(21) xor sync_lane3_high(13) xor sync_lane3_high( 5) xor bip_l3(5) xor
                          sync_lane3_low(21)  xor sync_lane3_low(13)  xor sync_lane3_low( 5)  xor (not bip_l3(5)));
            bip_l3(1) <= (sync_lane3_high(22) xor sync_lane3_high(14) xor sync_lane3_high( 6) xor bip_l3(6) xor
                          sync_lane3_low(22)  xor sync_lane3_low(14)  xor sync_lane3_low( 6)  xor (not bip_l3(6)));
            bip_l3(0) <= (sync_lane3_high(23) xor sync_lane3_high(15) xor sync_lane3_high( 7) xor bip_l3(7) xor
                          sync_lane3_low(23)  xor sync_lane3_low(15)  xor sync_lane3_low( 7)  xor (not bip_l3(7)));

          elsif (scr_en_o = '0' and is_alignment_oo = '1' and tx_sequence_cnt /=  x"00" and tx_sequence_cnt /=  x"01") then
            -- usando o valor do alinhamento anterior para iniciar nova sequencia de calc do bip
            --
            --    LANE 0
            bip_l0(7) <= ( bip_l0(7)  xor lane_0_data(56) xor lane_0_data(48) xor lane_0_data(40) xor lane_0_data(32)
                                      xor lane_0_data(24) xor lane_0_data(16) xor lane_0_data( 8) xor lane_0_data( 0));
            bip_l0(6) <= ( bip_l0(6)  xor lane_0_data(57) xor lane_0_data(49) xor lane_0_data(41) xor lane_0_data(33)
                                      xor lane_0_data(25) xor lane_0_data(17) xor lane_0_data( 9) xor lane_0_data( 1));
            bip_l0(5) <= ( bip_l0(5)  xor lane_0_data(58) xor lane_0_data(50) xor lane_0_data(42) xor lane_0_data(34)
                                      xor lane_0_data(26) xor lane_0_data(18) xor lane_0_data(10) xor lane_0_data( 2));
            bip_l0(4) <= ( bip_l0(4)  xor lane_0_data(59) xor lane_0_data(51) xor lane_0_data(43) xor lane_0_data(35)
                                      xor lane_0_data(27) xor lane_0_data(19) xor lane_0_data(11) xor lane_0_data( 3) xor lane_0_header(0));
            bip_l0(3) <= ( bip_l0(3)  xor lane_0_data(60) xor lane_0_data(52) xor lane_0_data(44) xor lane_0_data(36)
                                      xor lane_0_data(28) xor lane_0_data(20) xor lane_0_data(12) xor lane_0_data( 4) xor lane_0_header(1));
            bip_l0(2) <= ( bip_l0(2)  xor lane_0_data(61) xor lane_0_data(53) xor lane_0_data(45) xor lane_0_data(37)
                                      xor lane_0_data(29) xor lane_0_data(21) xor lane_0_data(13) xor lane_0_data( 5));
            bip_l0(1) <= ( bip_l0(1)  xor lane_0_data(62) xor lane_0_data(54) xor lane_0_data(46) xor lane_0_data(38)
                                      xor lane_0_data(30) xor lane_0_data(22) xor lane_0_data(14) xor lane_0_data( 6));
            bip_l0(0) <= ( bip_l0(0)  xor lane_0_data(63) xor lane_0_data(55) xor lane_0_data(47) xor lane_0_data(39)
                                      xor lane_0_data(31) xor lane_0_data(23) xor lane_0_data(15) xor lane_0_data( 7));
            --
            --    LANE 1
            bip_l1(7) <= ( bip_l1(7)  xor lane_1_data(56) xor lane_1_data(48) xor lane_1_data(40) xor lane_1_data(32)
                                      xor lane_1_data(24) xor lane_1_data(16) xor lane_1_data( 8) xor lane_1_data( 0));
            bip_l1(6) <= ( bip_l1(6)  xor lane_1_data(57) xor lane_1_data(49) xor lane_1_data(41) xor lane_1_data(33)
                                      xor lane_1_data(25) xor lane_1_data(17) xor lane_1_data( 9) xor lane_1_data( 1));
            bip_l1(5) <= ( bip_l1(5)  xor lane_1_data(58) xor lane_1_data(50) xor lane_1_data(42) xor lane_1_data(34)
                                      xor lane_1_data(26) xor lane_1_data(18) xor lane_1_data(10) xor lane_1_data( 2));
            bip_l1(4) <= ( bip_l1(4)  xor lane_1_data(59) xor lane_1_data(51) xor lane_1_data(43) xor lane_1_data(35)
                                      xor lane_1_data(27) xor lane_1_data(19) xor lane_1_data(11) xor lane_1_data( 3) xor lane_1_header(0));
            bip_l1(3) <= ( bip_l1(3)  xor lane_1_data(60) xor lane_1_data(52) xor lane_1_data(44) xor lane_1_data(36)
                                      xor lane_1_data(28) xor lane_1_data(20) xor lane_1_data(12) xor lane_1_data( 4) xor lane_1_header(1));
            bip_l1(2) <= ( bip_l1(2)  xor lane_1_data(61) xor lane_1_data(53) xor lane_1_data(45) xor lane_1_data(37)
                                      xor lane_1_data(29) xor lane_1_data(21) xor lane_1_data(13) xor lane_1_data( 5));
            bip_l1(1) <= ( bip_l1(1)  xor lane_1_data(62) xor lane_1_data(54) xor lane_1_data(46) xor lane_1_data(38)
                                      xor lane_1_data(30) xor lane_1_data(22) xor lane_1_data(14) xor lane_1_data( 6));
            bip_l1(0) <= ( bip_l1(0)  xor lane_1_data(63) xor lane_1_data(55) xor lane_1_data(47) xor lane_1_data(39)
                                      xor lane_1_data(31) xor lane_1_data(23) xor lane_1_data(15) xor lane_1_data( 7));

            --
            --    LANE 2
            bip_l2(7) <= ( bip_l2(7)  xor lane_2_data(56) xor lane_2_data(48) xor lane_2_data(40) xor lane_2_data(32)
                                      xor lane_2_data(24) xor lane_2_data(16) xor lane_2_data( 8) xor lane_2_data( 0));
            bip_l2(6) <= ( bip_l2(6)  xor lane_2_data(57) xor lane_2_data(49) xor lane_2_data(41) xor lane_2_data(33)
                                      xor lane_2_data(25) xor lane_2_data(17) xor lane_2_data( 9) xor lane_2_data( 1));
            bip_l2(5) <= ( bip_l2(5)  xor lane_2_data(58) xor lane_2_data(50) xor lane_2_data(42) xor lane_2_data(34)
                                      xor lane_2_data(26) xor lane_2_data(18) xor lane_2_data(10) xor lane_2_data( 2));
            bip_l2(4) <= ( bip_l2(4)  xor lane_2_data(59) xor lane_2_data(51) xor lane_2_data(43) xor lane_2_data(35)
                                      xor lane_2_data(27) xor lane_2_data(19) xor lane_2_data(11) xor lane_2_data( 3) xor lane_2_header(0));
            bip_l2(3) <= ( bip_l2(3)  xor lane_2_data(60) xor lane_2_data(52) xor lane_2_data(44) xor lane_2_data(36)
                                      xor lane_2_data(28) xor lane_2_data(20) xor lane_2_data(12) xor lane_2_data( 4) xor lane_2_header(1));
            bip_l2(2) <= ( bip_l2(2)  xor lane_2_data(61) xor lane_2_data(53) xor lane_2_data(45) xor lane_2_data(37)
                                      xor lane_2_data(29) xor lane_2_data(21) xor lane_2_data(13) xor lane_2_data( 5));
            bip_l2(1) <= ( bip_l2(1)  xor lane_2_data(62) xor lane_2_data(54) xor lane_2_data(46) xor lane_2_data(38)
                                      xor lane_2_data(30) xor lane_2_data(22) xor lane_2_data(14) xor lane_2_data( 6));
            bip_l2(0) <= ( bip_l2(0)  xor lane_2_data(63) xor lane_2_data(55) xor lane_2_data(47) xor lane_2_data(39)
                                      xor lane_2_data(31) xor lane_2_data(23) xor lane_2_data(15) xor lane_2_data( 7));

            --
            --    LANE 3
            bip_l3(7) <= ( bip_l3(7)  xor lane_3_data(56) xor lane_3_data(48) xor lane_3_data(40) xor lane_3_data(32)
                                      xor lane_3_data(24) xor lane_3_data(16) xor lane_3_data( 8) xor lane_3_data( 0));
            bip_l3(6) <= ( bip_l3(6)  xor lane_3_data(57) xor lane_3_data(49) xor lane_3_data(41) xor lane_3_data(33)
                                      xor lane_3_data(25) xor lane_3_data(17) xor lane_3_data( 9) xor lane_3_data( 1));
            bip_l3(5) <= ( bip_l3(5)  xor lane_3_data(58) xor lane_3_data(50) xor lane_3_data(42) xor lane_3_data(34)
                                      xor lane_3_data(26) xor lane_3_data(18) xor lane_3_data(10) xor lane_3_data( 2));
            bip_l3(4) <= ( bip_l3(4)  xor lane_3_data(59) xor lane_3_data(51) xor lane_3_data(43) xor lane_3_data(35)
                                      xor lane_3_data(27) xor lane_3_data(19) xor lane_3_data(11) xor lane_3_data( 3) xor lane_3_header(0));
            bip_l3(3) <= ( bip_l3(3)  xor lane_3_data(60) xor lane_3_data(52) xor lane_3_data(44) xor lane_3_data(36)
                                      xor lane_3_data(28) xor lane_3_data(20) xor lane_3_data(12) xor lane_3_data( 4) xor lane_3_header(1));
            bip_l3(2) <= ( bip_l3(2)  xor lane_3_data(61) xor lane_3_data(53) xor lane_3_data(45) xor lane_3_data(37)
                                      xor lane_3_data(29) xor lane_3_data(21) xor lane_3_data(13) xor lane_3_data( 5));
            bip_l3(1) <= ( bip_l3(1)  xor lane_3_data(62) xor lane_3_data(54) xor lane_3_data(46) xor lane_3_data(38)
                                      xor lane_3_data(30) xor lane_3_data(22) xor lane_3_data(14) xor lane_3_data( 6));
            bip_l3(0) <= ( bip_l3(0)  xor lane_3_data(63) xor lane_3_data(55) xor lane_3_data(47) xor lane_3_data(39)
                                      xor lane_3_data(31) xor lane_3_data(23) xor lane_3_data(15) xor lane_3_data( 7));

          else
          end if; -- teste para att BIP
        else

        end if;
     end process;


end behav_pcs_alignment;
