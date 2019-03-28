library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_unsigned.all;
  use ieee.std_logic_arith.all;
  use ieee.numeric_std.all;

entity alignment_removal is
  port(
    clk       : in std_logic;
    rst       : in std_logic;

    is_alig_0 : in std_logic;
    is_alig_1 : in std_logic;
    is_alig_2 : in std_logic;
    is_alig_3 : in std_logic;
    valid_0   : in std_logic;
    valid_1   : in std_logic;
    valid_2   : in std_logic;
    valid_3   : in std_logic;

    header_0  : in  std_logic_vector(1 downto 0);
    header_1  : in  std_logic_vector(1 downto 0);
    header_2  : in  std_logic_vector(1 downto 0);
    header_3  : in  std_logic_vector(1 downto 0);
    data_0    : in  std_logic_vector(63 downto 0);
    data_1    : in  std_logic_vector(63 downto 0);
    data_2    : in  std_logic_vector(63 downto 0);
    data_3    : in  std_logic_vector(63 downto 0);

    dscr_0    : in  std_logic_vector(65 downto 0);
    dscr_1    : in  std_logic_vector(65 downto 0);
    dscr_2    : in  std_logic_vector(65 downto 0);
    dscr_3    : in  std_logic_vector(65 downto 0);

    rx_fill_pcs0    : in std_logic_vector(8 downto 0);
    rx_fill_pcs1    : in std_logic_vector(8 downto 0);
    rx_fill_pcs2    : in std_logic_vector(8 downto 0);
    rx_fill_pcs3    : in std_logic_vector(8 downto 0);

    vvalid_0_out  : out  std_logic;
    vvalid_1_out  : out  std_logic;
    vvalid_2_out  : out  std_logic;
    vvalid_3_out  : out  std_logic;
    header_0_out  : out  std_logic_vector(1 downto 0);
    header_1_out  : out  std_logic_vector(1 downto 0);
    header_2_out  : out  std_logic_vector(1 downto 0);
    header_3_out  : out  std_logic_vector(1 downto 0);
    data_0_out    : out  std_logic_vector(63 downto 0);
    data_1_out    : out  std_logic_vector(63 downto 0);
    data_2_out    : out  std_logic_vector(63 downto 0);
    data_3_out    : out  std_logic_vector(63 downto 0);


    dscr_en_ipg : out std_logic;

    -- valid_0_out : out std_logic;
    -- valid_1_out : out std_logic;
    -- valid_2_out : out std_logic;
    -- valid_3_out : out std_logic;

    ddscr_0_out  : out  std_logic_vector(65 downto 0);
    ddscr_1_out  : out  std_logic_vector(65 downto 0);
    ddscr_2_out  : out  std_logic_vector(65 downto 0);
    ddscr_3_out  : out  std_logic_vector(65 downto 0);

    -- não usadas
    dscr_0_out  : out  std_logic_vector(65 downto 0);
    dscr_1_out  : out  std_logic_vector(65 downto 0);
    dscr_2_out  : out  std_logic_vector(65 downto 0);
    dscr_3_out  : out  std_logic_vector(65 downto 0)

    -- gap     : out std_logic;
    -- setIPG  : out std_logic
  );
end entity;


architecture behav_alignment_removal of alignment_removal is

  constant IPG          : std_logic_vector(65 downto 0) := "000000000000000000000000000000000000000000000000000000000001111001";
  constant SOP          : std_logic_vector(65 downto 0) := "110101010101010101010101010101010101010101010101010101010111100001";
  constant N_BLOCKS     : natural := 512 ;
  constant N_BLOCKS_GAP : natural := N_BLOCKS-30 ;

  type states is (INIT, NORMAL, WAIT_EOP, SOP_IPG, SWITCH_NW, WAIT_ALIG, SWITCH_WN);
  signal ps :states;

  signal cont       : std_logic_vector(13 downto 0);

  signal dscr_0_d : std_logic_vector(65 downto 0);
  signal dscr_1_d : std_logic_vector(65 downto 0);
  signal dscr_2_d : std_logic_vector(65 downto 0);
  signal dscr_3_d : std_logic_vector(65 downto 0);

  signal dscr_0_d2 : std_logic_vector(65 downto 0);
  signal dscr_1_d2 : std_logic_vector(65 downto 0);
  signal dscr_2_d2 : std_logic_vector(65 downto 0);
  signal dscr_3_d2 : std_logic_vector(65 downto 0);


  signal valid_0_d : std_logic;
  signal valid_1_d : std_logic;
  signal valid_2_d : std_logic;
  signal valid_3_d : std_logic;

  signal valid_0_d2 : std_logic;
  signal valid_1_d2 : std_logic;
  signal valid_2_d2 : std_logic;
  signal valid_3_d2 : std_logic;

  signal vvv_0 : std_logic;
  signal vvv_1 : std_logic;
  signal vvv_2 : std_logic;
  signal vvv_3 : std_logic;

  -- signal valid_0_d2 : std_logic;
  -- signal valid_1_d2 : std_logic;
  -- signal valid_2_d2 : std_logic;
  -- signal valid_3_d2 : std_logic;

  signal gap      :  std_logic;
  signal setIPG   :  std_logic;

  signal scrm_0 : std_logic_vector(67 downto 0);
  signal scrm_1 : std_logic_vector(67 downto 0);
  signal scrm_2 : std_logic_vector(67 downto 0);
  signal scrm_3 : std_logic_vector(67 downto 0);

  signal scrm_0_d : std_logic_vector(67 downto 0);
  signal scrm_1_d : std_logic_vector(67 downto 0);
  signal scrm_2_d : std_logic_vector(67 downto 0);
  signal scrm_3_d : std_logic_vector(67 downto 0);


  signal out_view_0 : std_logic_vector(66 downto 0);
  signal out_view_1 : std_logic_vector(66 downto 0);
  signal out_view_2 : std_logic_vector(66 downto 0);
  signal out_view_3 : std_logic_vector(66 downto 0);

  signal flag_align   : std_logic;
  signal flag_align_d : std_logic;
  signal flag_ipg     : std_logic;
  signal flag_setipg  : std_logic;
  signal flag_setipg_d: std_logic;

  signal dscr_en_ipg_sig  : std_logic;
  signal lane_ipg     : std_logic_vector(2 downto 0);
  signal lane_ipg_d   : std_logic_vector(2 downto 0);

  signal is_alig_0_out : std_logic;
  signal is_alig_1_out : std_logic;
  signal is_alig_2_out : std_logic;
  signal is_alig_3_out : std_logic;

  signal flag_en_down  :std_logic;

begin

  --   30 ciclos é o suficiente para ter um EOP
  -- ONEPROC_FSM: process (clk, rst)
  -- begin
  --   if rst = '0' then
  --     ps <= INIT;
  --
  --     dscr_0_d <= IPG;
  --     dscr_1_d <= IPG;
  --     dscr_2_d <= IPG;
  --     dscr_3_d <= IPG;
  --     dscr_0_d2 <= IPG;
  --     dscr_1_d2 <= IPG;
  --     dscr_2_d2 <= IPG;
  --     dscr_3_d2 <= IPG;
  --     dscr_0_out <= IPG;
  --     dscr_1_out <= IPG;
  --     dscr_2_out <= IPG;
  --     dscr_3_out <= IPG;
  --
  --     valid_0_d <= '0';
  --     valid_1_d <= '0';
  --     valid_2_d <= '0';
  --     valid_3_d <= '0';
  --     valid_0_d2 <= '0';
  --     valid_1_d2 <= '0';
  --     valid_2_d2 <= '0';
  --     valid_3_d2 <= '0';
  --     valid_0_out <= '0';
  --     valid_1_out <= '0';
  --     valid_2_out <= '0';
  --     valid_3_out <= '0';
  --
  --
  --     cont <= (others=> '0');
  --     gap <= '0';
  --     setIPG <= '0';
  --
  --   elsif (clk'event and clk = '1') then
  --     dscr_0_d <= dscr_0;
  --     dscr_1_d <= dscr_1;
  --     dscr_2_d <= dscr_2;
  --     dscr_3_d <= dscr_3;
  --     dscr_0_d2 <= dscr_0_d;
  --     dscr_1_d2 <= dscr_1_d;
  --     dscr_2_d2 <= dscr_2_d;
  --     dscr_3_d2 <= dscr_3_d;
  --
  --     valid_0_d <= valid_0 and not is_alig_0;
  --     valid_1_d <= valid_1 and not is_alig_1;
  --     valid_2_d <= valid_2 and not is_alig_2;
  --     valid_3_d <= valid_3 and not is_alig_3;
  --     valid_0_d2 <= valid_0_d;
  --     valid_1_d2 <= valid_1_d;
  --     valid_2_d2 <= valid_2_d;
  --     valid_3_d2 <= valid_3_d;
  --
  --     case (ps) is
  --       when INIT =>
  --         if valid_0 = '1' or valid_1 = '1' or valid_2 = '1' or valid_3 = '1' then
  --           ps <= NORMAL;
  --         else
  --           ps <= INIT;
  --         end if;
  --
  --       when NORMAL =>
  --         gap <= '0';
  --         setIPG <= '0';
  --         if (cont = N_BLOCKS_GAP) then
  --           ps <= WAIT_EOP;
  --           cont <= (others=>'0');
  --         else
  --           cont <= cont + 1;
  --         end if;
  --
  --         dscr_0_out <= dscr_0_d;
  --         dscr_1_out <= dscr_1_d;
  --         dscr_2_out <= dscr_2_d;
  --         dscr_3_out <= dscr_3_d;
  --
  --         valid_0_out <= valid_0_d;
  --         valid_1_out <= valid_1_d;
  --         valid_2_out <= valid_2_d;
  --         valid_3_out <= valid_3_d;
  --
  --       when WAIT_EOP =>
  --         gap <= '0';
  --         setIPG <= '0';
  --         dscr_0_out <= dscr_0_d;
  --         dscr_1_out <= dscr_1_d;
  --         dscr_2_out <= dscr_2_d;
  --         dscr_3_out <= dscr_3_d;
  --         valid_0_out <= valid_0_d;
  --         valid_1_out <= valid_1_d;
  --         valid_2_out <= valid_2_d;
  --         valid_3_out <= valid_3_d;
  --
  --         if (dscr_0 = IPG or dscr_1 = IPG or dscr_2 = IPG or dscr_3 = IPG) then
  --           gap <= '1';
  --           setIPG <= '1';
  --           if (dscr_0 = SOP or dscr_1 = SOP or dscr_2 = SOP or dscr_3 = SOP) then
  --             ps <= SOP_IPG;
  --           else
  --             ps <= WAIT_ALIG;
  --           end if;
  --         end if;
  --
  --         if dscr_3 = IPG then
  --           dscr_0_out <= dscr_0_d;
  --           dscr_1_out <= dscr_1_d;
  --           dscr_2_out <= dscr_2_d;
  --           dscr_3_out <= dscr_3_d;
  --         elsif dscr_2 = IPG then
  --           dscr_0_out <= dscr_0_d;
  --           dscr_1_out <= dscr_1_d;
  --           dscr_2_out <= dscr_2_d;
  --           dscr_3_out <= IPG;
  --
  --           valid_3_out <= '1';
  --         elsif dscr_1 = IPG then
  --           dscr_0_out <= dscr_0_d;
  --           dscr_1_out <= dscr_1_d;
  --           dscr_2_out <= IPG;
  --           dscr_3_out <= IPG;
  --
  --           valid_2_out <= '1';
  --           valid_3_out <= '1';
  --         elsif dscr_0 = IPG then
  --           dscr_0_out <= dscr_0_d;
  --           dscr_1_out <= IPG;
  --           dscr_2_out <= IPG;
  --           dscr_3_out <= IPG;
  --
  --           valid_1_out <= '1';
  --           valid_2_out <= '1';
  --           valid_3_out <= '1';
  --         else
  --           dscr_0_out <= dscr_0_d;
  --           dscr_1_out <= dscr_1_d;
  --           dscr_2_out <= dscr_2_d;
  --           dscr_3_out <= dscr_3_d;
  --
  --           valid_0_out <= '1';
  --           valid_1_out <= '1';
  --           valid_2_out <= '1';
  --           valid_3_out <= '1';
  --         end if;
  --
  --       when SOP_IPG =>
  --         gap <= '1';
  --         setIPG <= '0';
  --         ps <= WAIT_ALIG;
  --         if dscr_3 = SOP then
  --           dscr_0_out <= IPG;
  --           dscr_1_out <= IPG;
  --           dscr_2_out <= IPG;
  --           dscr_3_out <= dscr_3_d;
  --         elsif dscr_2 = SOP then
  --           dscr_0_out <= IPG;
  --           dscr_1_out <= IPG;
  --           dscr_2_out <= dscr_2_d;
  --           dscr_3_out <= dscr_3_d;
  --         elsif dscr_1 = SOP then
  --           dscr_0_out <= IPG;
  --           dscr_1_out <= dscr_1_d;
  --           dscr_2_out <= dscr_2_d;
  --           dscr_3_out <= dscr_3_d;
  --         else
  --           dscr_0_out <= dscr_0_d;
  --           dscr_1_out <= dscr_1_d;
  --           dscr_2_out <= dscr_2_d;
  --           dscr_3_out <= dscr_3_d;
  --         end if;
  --
  --       when SWITCH_NW =>
  --         gap <= '1';
  --         setIPG <= '1';
  --         dscr_0_out <= dscr_0_d2;
  --         dscr_1_out <= dscr_1_d2;
  --         dscr_2_out <= dscr_2_d2;
  --         dscr_3_out <= dscr_3_d2;
  --
  --
  --       when WAIT_ALIG =>
  --         gap <= '1';
  --         setIPG <= '0';
  --         if (is_alig_0 = '1' or is_alig_1 = '1' or is_alig_2 = '1' or is_alig_3 = '1') then
  --           --  gap <= '0';
  --           --  ps <= NORMAL;
  --           gap <= '0';
  --           ps <= NORMAL;
  --           valid_0_out <= '0';
  --           valid_1_out <= '0';
  --           valid_2_out <= '0';
  --           valid_3_out <= '0';
  --         end if;
  --         dscr_0_out <= dscr_0_d2;
  --         dscr_1_out <= dscr_1_d2;
  --         dscr_2_out <= dscr_2_d2;
  --         dscr_3_out <= dscr_3_d2;
  --
  --         valid_0_out <= valid_0_d2;
  --         valid_1_out <= valid_1_d2;
  --         valid_2_out <= valid_2_d2;
  --         valid_3_out <= valid_3_d2;
  --
  --       when SWITCH_WN=>
  --         gap <= '0';
  --         ps <= NORMAL;
  --         dscr_0_out <= dscr_0_d;
  --         dscr_1_out <= dscr_1_d;
  --         dscr_2_out <= dscr_2_d;
  --         dscr_3_out <= dscr_3_d;
  --
  --         valid_0_out <= valid_0_d;
  --         valid_1_out <= valid_1_d;
  --         valid_2_out <= valid_2_d;
  --         valid_3_out <= valid_3_d;
  --
  --     end case;
  --
  --   end if;
  -- end process;


  dscr_en_ipg <= dscr_en_ipg_sig;

  scrm_0 <= is_alig_0 & valid_0 & header_0 & data_0;
  scrm_1 <= is_alig_1 & valid_1 & header_1 & data_1;
  scrm_2 <= is_alig_2 & valid_2 & header_2 & data_2;
  scrm_3 <= is_alig_3 & valid_3 & header_3 & data_3;

  reg_dscr_0: entity work.regnbit generic map (size=>68) port map (ck=>clk, rst=>rst, ce=>'1', D=>scrm_0,  Q=>scrm_0_d);
  reg_dscr_1: entity work.regnbit generic map (size=>68) port map (ck=>clk, rst=>rst, ce=>'1', D=>scrm_1,  Q=>scrm_1_d);
  reg_dscr_2: entity work.regnbit generic map (size=>68) port map (ck=>clk, rst=>rst, ce=>'1', D=>scrm_2,  Q=>scrm_2_d);
  reg_dscr_3: entity work.regnbit generic map (size=>68) port map (ck=>clk, rst=>rst, ce=>'1', D=>scrm_3,  Q=>scrm_3_d);


  process (clk, rst)
  begin

    if rst = '0' then
      flag_align  <= '0';
      flag_align_d <= '0';
      flag_setipg_d <= '0';
      lane_ipg_d <= "000";
      flag_en_down <= '0';

    elsif (clk'event and clk = '1') then
      flag_setipg_d <= flag_setipg;
      lane_ipg_d <= lane_ipg;
      flag_align_d <= flag_align;

      flag_en_down <= '0';
      -- if ((is_alig_0 = '1' or is_alig_1 = '1' or is_alig_2 = '1' or is_alig_3 = '1') and flag_setipg = '0') then
      --   flag_align <= '1';
      -- elsif (flag_setipg = '1') then
      --   flag_align <= '0';
      -- end if;

      -- if ((rx_fill_pcs0 > 117 ) and (flag_align_d = '0')) then

--      if ((rx_fill_pcs0 > 117 )) then
--        flag_align <= '0';
--      elsif ((is_alig_0 = '1' or is_alig_1 = '1' or is_alig_2 = '1' or is_alig_3 = '1') and flag_setipg = '0') then

      if ((is_alig_0 = '1') and (flag_setipg = '0') and (rx_fill_pcs0 < 118)) then
        flag_align <= '1';

      elsif ((is_alig_0 = '1') and (flag_setipg = '0') and (rx_fill_pcs0 > 117)) then
        flag_en_down <= '1';

      elsif (flag_setipg = '1') then
        flag_align <= '0';
      end if;

    end if;
  end process;



process (flag_setipg, flag_setipg_d, dscr_0, dscr_1, dscr_2, dscr_3, flag_en_down)
begin
  dscr_en_ipg_sig <= '1';
  ddscr_0_out <= dscr_0;
  ddscr_1_out <= dscr_1;
  ddscr_2_out <= dscr_2;
  ddscr_3_out <= dscr_3;
  lane_ipg <= "100";

  if flag_en_down = '1' then
    dscr_en_ipg_sig <= '0';
  end if;

  if flag_setipg = '1' then
    if dscr_3 = IPG then
      dscr_en_ipg_sig <= '0';
      ddscr_0_out <= dscr_0;
      ddscr_1_out <= dscr_1;
      ddscr_2_out <= dscr_2;
      ddscr_3_out <= IPG;
      lane_ipg <= "011";

    elsif dscr_2 = IPG then
      dscr_en_ipg_sig <= '0';
      ddscr_0_out <= dscr_0;
      ddscr_1_out <= dscr_1;
      ddscr_2_out <= IPG;
      ddscr_3_out <= IPG;
      lane_ipg <= "010";

    elsif dscr_1 = IPG then
      dscr_en_ipg_sig <= '0';
      ddscr_0_out <= dscr_0;
      ddscr_1_out <= IPG;
      ddscr_2_out <= IPG;
      ddscr_3_out <= IPG;
      lane_ipg <= "001";

    elsif dscr_0 = IPG then
      dscr_en_ipg_sig <= '0';
      ddscr_0_out <= IPG;
      ddscr_1_out <= IPG;
      ddscr_2_out <= IPG;
      ddscr_3_out <= IPG;
      lane_ipg <= "000";
    end if;

  elsif flag_setipg_d = '1' then
    if lane_ipg_d = "000" then
      dscr_en_ipg_sig <= '1';
      ddscr_0_out <= IPG;
      ddscr_1_out <= dscr_1;
      ddscr_2_out <= dscr_2;
      ddscr_3_out <= dscr_3;

    elsif lane_ipg_d = "001" then
      dscr_en_ipg_sig <= '1';
      ddscr_0_out <= IPG;
      ddscr_1_out <= IPG;
      ddscr_2_out <= dscr_2;
      ddscr_3_out <= dscr_3;

    elsif lane_ipg_d = "010" then
      dscr_en_ipg_sig <= '1';
      ddscr_0_out <= IPG;
      ddscr_1_out <= IPG;
      ddscr_2_out <= IPG;
      ddscr_3_out <= dscr_3;

    elsif lane_ipg_d = "011" then
      dscr_en_ipg_sig <= '1';
      ddscr_0_out <= IPG;
      ddscr_1_out <= IPG;
      ddscr_2_out <= IPG;
      ddscr_3_out <= IPG;
    end if;

  end if;
end process;



  flag_ipg  <=    '1' when (dscr_0 = IPG or dscr_1 = IPG or dscr_2 = IPG or dscr_3 = IPG) else
                  '0';

  flag_setipg <=  '1' when (flag_align = '1' and flag_ipg = '1') else '0';


  ------------------------------------------------------------------------------
  -- out_view_0 <=     scrm_0_d when flag_align = '0' else
  --                   scrm_0;
  -- out_view_1 <=     scrm_1_d when flag_align = '0' else
  --                   scrm_1;
  -- out_view_2 <=     scrm_2_d when flag_align = '0' else
  --                   scrm_2;
  -- out_view_3 <=     scrm_3_d when flag_align = '0' else
  --                   scrm_3;

  header_0_out  <=  scrm_0_d(65 downto 64) when flag_align = '0' else
                    scrm_0(65 downto 64);
  data_0_out    <=  scrm_0_d(63 downto 0)  when flag_align = '0' else
                    scrm_0(63 downto 0);
  -- vvalid_0_out  <=  scrm_0_d(66)           when flag_align = '0' else
                    -- scrm_0(66);

  is_alig_0_out <=  scrm_0_d(67)           when flag_align = '0' else
                    scrm_0(67);



  header_1_out  <=  scrm_1_d(65 downto 64) when flag_align = '0' else
                    scrm_1(65 downto 64);
  data_1_out    <=  scrm_1_d(63 downto 0)  when flag_align = '0' else
                    scrm_1(63 downto 0);
  -- vvalid_1_out  <=  scrm_1_d(66)           when flag_align = '0' else
                    -- scrm_1(66);

  is_alig_1_out <=  scrm_1_d(67)           when flag_align = '0' else
                    scrm_1(67);



  header_2_out  <=  scrm_2_d(65 downto 64) when flag_align = '0' else
                    scrm_2(65 downto 64);
  data_2_out    <=  scrm_2_d(63 downto 0)  when flag_align = '0' else
                    scrm_2(63 downto 0);
  -- vvalid_2_out  <=  scrm_2_d(66)           when flag_align = '0' else
                    -- scrm_2(66);

  is_alig_2_out <=  scrm_2_d(67)           when flag_align = '0' else
                    scrm_2(67);


  header_3_out  <=  scrm_3_d(65 downto 64) when flag_align = '0' else
                    scrm_3(65 downto 64);
  data_3_out    <=  scrm_3_d(63 downto 0)  when flag_align = '0' else
                    scrm_3(63 downto 0);
  -- vvalid_3_out  <=  scrm_3_d(66)           when flag_align = '0' else
                    -- scrm_3(66);

  is_alig_3_out <=  scrm_3_d(67)           when flag_align = '0' else
                    scrm_3(67);








  vvalid_0_out  <=   scrm_0_d(66)and (not scrm_0_d(67))            when flag_align = '0' else
              scrm_0(66)  and (not scrm_0(67));

  vvalid_1_out  <=   scrm_1_d(66)and (not scrm_1_d(67))            when flag_align = '0' else
              scrm_1(66)  and (not scrm_1(67));

  vvalid_2_out  <=   scrm_2_d(66)and (not scrm_2_d(67))            when flag_align = '0' else
              scrm_2(66)  and (not scrm_2(67));

  vvalid_3_out  <=   scrm_3_d(66)and (not scrm_3_d(67))            when flag_align = '0' else
              scrm_3(66)  and (not scrm_3(67));

  -- vvv_0  <=   scrm_0_d(66)and (not scrm_0_d(67))            when flag_align = '0' else
  --             scrm_0(66)  and (not scrm_0(67));
  --
  -- vvv_1  <=   scrm_1_d(66)and (not scrm_1_d(67))            when flag_align = '0' else
  --             scrm_1(66)  and (not scrm_1(67));
  --
  -- vvv_2  <=   scrm_2_d(66)and (not scrm_2_d(67))            when flag_align = '0' else
  --             scrm_2(66)  and (not scrm_2(67));
  --
  -- vvv_3  <=   scrm_3_d(66)and (not scrm_3_d(67))            when flag_align = '0' else
  --             scrm_3(66)  and (not scrm_3(67));



end behav_alignment_removal;
