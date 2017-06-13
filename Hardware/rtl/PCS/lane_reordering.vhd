library ieee;
use ieee.std_logic_1164.all;

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Generic register
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
library IEEE;
use IEEE.std_logic_1164.all;

entity regnbit is
           generic(
           size : integer := 32;
           INIT_VALUE : STD_LOGIC_VECTOR(63 downto 0) := (others=>'0') );
           port(  ck, rst, ce : in std_logic;
                  D : in  STD_LOGIC_VECTOR (size-1 downto 0);
                  Q : out STD_LOGIC_VECTOR (size-1 downto 0)
               );
end regnbit;
architecture regn of regnbit is
begin
  process(ck, rst)
  begin
       if rst = '0' then
              Q <= INIT_VALUE(size-1 downto 0);
       elsif ck'event and ck = '0' then
           if ce = '1' then
              Q <= D;
           end if;
       end if;
  end process;
end regn;

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Bit register
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
library IEEE;
use IEEE.std_logic_1164.all;

entity reg_bit is
           generic(
              INIT_VALUE : std_logic := '0' );
           port(  ck, rst, ce : in std_logic;
                  D : in  std_logic;
                  Q : out std_logic
               );
end reg_bit;
architecture reg of reg_bit is
begin
  process(ck, rst)
  begin
       if rst = '0' then
              Q <= INIT_VALUE;
       elsif ck'event and ck = '0' then
           if ce = '1' then
              Q <= D;
           end if;
       end if;
  end process;
end reg;

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- BIP CHECKER MODULE
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
library ieee;
use ieee.std_logic_1164.all;
entity bip_calculator is
  port(
    data_in      : in std_logic_vector(63 downto 0);
    header_in    : in std_logic_vector(1 downto 0);
    enable       : in std_logic;
    bip_ok       : out std_logic
  );
end entity;
architecture behav_bip_calculator of bip_calculator is
begin
end behav_bip_calculator;

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- SYNC BLOCK MODULE
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
library ieee;
use ieee.std_logic_1164.all;
entity sync_lane is
  port(
    data_in      : in std_logic_vector(63 downto 0);
    header_in    : in std_logic_vector(1 downto 0);
    logical_lane : out std_logic_vector(2 downto 0);
    sync_ok      : out std_logic
  );
end entity;
architecture behav_sync_lane of sync_lane is
  constant SYNC_LANE0_LOW  : std_logic_vector(23 downto 0) := "100100000111011001000111";
  constant SYNC_LANE1_LOW  : std_logic_vector(23 downto 0) := "111100001100010011100110";
  constant SYNC_LANE2_LOW  : std_logic_vector(23 downto 0) := "110001010110010110011011";
  constant SYNC_LANE3_LOW  : std_logic_vector(23 downto 0) := "101000100111100100111101";
  constant SYNC_LANE0_HIGH : std_logic_vector(23 downto 0) := "011011111000100110111000";
  constant SYNC_LANE1_HIGH : std_logic_vector(23 downto 0) := "000011110011101100011001";
  constant SYNC_LANE2_HIGH : std_logic_vector(23 downto 0) := "001110101001101001100100";
  constant SYNC_LANE3_HIGH : std_logic_vector(23 downto 0) := "010111011000011011000010";
  signal logical_lane_int  : std_logic_vector(2 downto 0);
begin
  logical_lane_int <= "000" when data_in(63 downto 40) = SYNC_LANE0_HIGH and data_in(31 downto 8) = SYNC_LANE0_LOW else
                      "001" when data_in(63 downto 40) = SYNC_LANE1_HIGH and data_in(31 downto 8) = SYNC_LANE1_LOW else
                      "010" when data_in(63 downto 40) = SYNC_LANE2_HIGH and data_in(31 downto 8) = SYNC_LANE2_LOW else
                      "011" when data_in(63 downto 40) = SYNC_LANE3_HIGH and data_in(31 downto 8) = SYNC_LANE3_LOW else
                      "100";
  sync_ok <= '0' when logical_lane_int = "100" else '1';
  logical_lane <= logical_lane_int;
end behav_sync_lane;

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- SYNC BLOCK COUNTER MODULE
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
library ieee;
use ieee.std_logic_1164.all;
entity last_lane_reg is
  port(
    ck               : in std_logic;
    rst              : in std_logic;
    sync_ok          : in std_logic;
    logical_lane     : in std_logic_vector(2 downto 0);
    logical_lane_reg : out std_logic_vector(2 downto 0)
  );
end entity;
architecture behav_last_lane_reg of last_lane_reg is
  signal lane_reg : std_logic_vector(2 downto 0);
begin
  process(ck) is
  begin
    if(rst = '0') then
      lane_reg <= (others =>'0');
    elsif(ck'event and ck ='1') then
        if(sync_ok = '1') then
          lane_reg <= logical_lane;
        else
          lane_reg <= lane_reg;
        end if;
    end if;
  end process;
  logical_lane_reg <= lane_reg;
end behav_last_lane_reg;

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- LANE REORDER MODULE
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
library ieee;
use ieee.std_logic_1164.all;
library unisim;
use unisim.VCOMPONENTS.all;
library unimacro;


entity lane_reorder is
  port(
    clock           : in std_logic;
    reset           : in std_logic;

    lane_0_data_in  : in std_logic_vector(63 downto 0);
    lane_1_data_in  : in std_logic_vector(63 downto 0);
    lane_2_data_in  : in std_logic_vector(63 downto 0);
    lane_3_data_in  : in std_logic_vector(63 downto 0);

    lane_0_header_in  : in std_logic_vector(1 downto 0);
    lane_1_header_in  : in std_logic_vector(1 downto 0);
    lane_2_header_in  : in std_logic_vector(1 downto 0);
    lane_3_header_in  : in std_logic_vector(1 downto 0);

    pcs_0_data_out  : out std_logic_vector(63 downto 0);
    pcs_1_data_out  : out std_logic_vector(63 downto 0);
    pcs_2_data_out  : out std_logic_vector(63 downto 0);
    pcs_3_data_out  : out std_logic_vector(63 downto 0);

    pcs_0_header_out  : out std_logic_vector(1 downto 0);
    pcs_1_header_out  : out std_logic_vector(1 downto 0);
    pcs_2_header_out  : out std_logic_vector(1 downto 0);
    pcs_3_header_out  : out std_logic_vector(1 downto 0)
  );
end entity;

architecture behav_lane_reorder of lane_reorder is
    function check_sync_block(data_block: in std_logic_vector(63 downto 0)) return std_logic is
    begin
       case data_block is
         when (others=>'1') => return '1';
         when (others=>'0') => return '0';
         when others => return '0';
       end case;
    end check_sync_block;

    type barreira_0 is record
      data_0   : std_logic_vector(63 downto 0);
      data_1   : std_logic_vector(63 downto 0);
      data_2   : std_logic_vector(63 downto 0);
      data_3   : std_logic_vector(63 downto 0);
      header_0 : std_logic_vector(1 downto 0);
      header_1 : std_logic_vector(1 downto 0);
      header_2 : std_logic_vector(1 downto 0);
      header_3 : std_logic_vector(1 downto 0);
      logical_lane_0 : std_logic_vector(2 downto 0);
      logical_lane_1 : std_logic_vector(2 downto 0);
      logical_lane_2 : std_logic_vector(2 downto 0);
      logical_lane_3 : std_logic_vector(2 downto 0);
      is_sync_0 : std_logic;
      is_sync_1 : std_logic;
      is_sync_2 : std_logic;
      is_sync_3 : std_logic;
      -- read_from_fifos : std_logic;
    end record;

    type barreira_1 is record
      data_0   : std_logic_vector(63 downto 0);
      data_1   : std_logic_vector(63 downto 0);
      data_2   : std_logic_vector(63 downto 0);
      data_3   : std_logic_vector(63 downto 0);
      header_0 : std_logic_vector(1 downto 0);
      header_1 : std_logic_vector(1 downto 0);
      header_2 : std_logic_vector(1 downto 0);
      header_3 : std_logic_vector(1 downto 0);
      logical_lane_0 : std_logic_vector(2 downto 0);
      logical_lane_1 : std_logic_vector(2 downto 0);
      logical_lane_2 : std_logic_vector(2 downto 0);
      logical_lane_3 : std_logic_vector(2 downto 0);
      is_sync_0 : std_logic;
      is_sync_1 : std_logic;
      is_sync_2 : std_logic;
      is_sync_3 : std_logic;
      bip_ok_0 : std_logic;
      bip_ok_1 : std_logic;
      bip_ok_2 : std_logic;
      bip_ok_3 : std_logic;
      read_from_fifos : std_logic;
    end record;

    type barreira_2 is record
      data_0   : std_logic_vector(63 downto 0);
      data_1   : std_logic_vector(63 downto 0);
      data_2   : std_logic_vector(63 downto 0);
      data_3   : std_logic_vector(63 downto 0);
      header_0 : std_logic_vector(1 downto 0);
      header_1 : std_logic_vector(1 downto 0);
      header_2 : std_logic_vector(1 downto 0);
      header_3 : std_logic_vector(1 downto 0);
      wen_0 : std_logic;
      wen_1 : std_logic;
      wen_2 : std_logic;
      wen_3 : std_logic;
      read_from_fifos : std_logic;
    end record;

    type fsm_state is (S_INIT, S_END, S_SYNC, S_TRANSMIT);
    signal CURRENT_STATE, NEXT_STATE: fsm_state;

    signal reset_n : std_logic;

    signal barreira_skew : barreira_0;
    signal barreira_bip  : barreira_1;
    signal barreira_xbar : barreira_2;

    signal logical_lane_0_int : std_logic_vector(2 downto 0);
    signal logical_lane_1_int : std_logic_vector(2 downto 0);
    signal logical_lane_2_int : std_logic_vector(2 downto 0);
    signal logical_lane_3_int : std_logic_vector(2 downto 0);

    signal is_sync_0_int : std_logic;
    signal is_sync_1_int : std_logic;
    signal is_sync_2_int : std_logic;
    signal is_sync_3_int : std_logic;

    signal read_from_fifos_int :std_logic;

    signal enable_lane_0 : std_logic;
    signal enable_lane_1 : std_logic;
    signal enable_lane_2 : std_logic;
    signal enable_lane_3 : std_logic;

    signal bip_lane_0_int : std_logic;
    signal bip_lane_1_int : std_logic;
    signal bip_lane_2_int : std_logic;
    signal bip_lane_3_int : std_logic;

    signal wen_0_int : std_logic;
    signal wen_1_int : std_logic;
    signal wen_2_int : std_logic;
    signal wen_3_int : std_logic;

    signal shuffle_in_0 : std_logic_vector(65 downto 0);
    signal shuffle_in_1 : std_logic_vector(65 downto 0);
    signal shuffle_in_2 : std_logic_vector(65 downto 0);
    signal shuffle_in_3 : std_logic_vector(65 downto 0);

    signal shuffle_out_0 : std_logic_vector(65 downto 0);
    signal shuffle_out_1 : std_logic_vector(65 downto 0);
    signal shuffle_out_2 : std_logic_vector(65 downto 0);
    signal shuffle_out_3 : std_logic_vector(65 downto 0);

    signal almost_f_0,almost_e_0,empty_0,full_0 : std_logic;
    signal fifo_out_0 : std_logic_vector(65 downto 0);
    signal fifo_in_0  : std_logic_vector(65 downto 0);

    signal RDCOUNT_0 : std_logic_vector(8 downto 0);
    signal WRCOUNT_0 : std_logic_vector(8 downto 0);

    signal almost_f_1,almost_e_1,empty_1,full_1 : std_logic;
    signal fifo_out_1 : std_logic_vector(65 downto 0);
    signal fifo_in_1  : std_logic_vector(65 downto 0);

    signal RDCOUNT_1 : std_logic_vector(8 downto 0);
    signal WRCOUNT_1 : std_logic_vector(8 downto 0);

    signal almost_f_2,almost_e_2,empty_2,full_2 : std_logic;
    signal fifo_out_2 : std_logic_vector(65 downto 0);
    signal fifo_in_2  : std_logic_vector(65 downto 0);

    signal RDCOUNT_2 : std_logic_vector(8 downto 0);
    signal WRCOUNT_2 : std_logic_vector(8 downto 0);

    signal almost_f_3,almost_e_3,empty_3,full_3 : std_logic;
    signal fifo_out_3 : std_logic_vector(65 downto 0);
    signal fifo_in_3  : std_logic_vector(65 downto 0);

    signal RDCOUNT_3 : std_logic_vector(8 downto 0);
    signal WRCOUNT_3 : std_logic_vector(8 downto 0);

begin
  reset_n <= not reset;

  --==============================================================================
  -- first_stage - FIND SYNC BLOCK and ACCOUNT FOR SKEW
  --==============================================================================
  lane_0: entity work.sync_lane port map(data_in => lane_0_data_in,header_in => lane_0_header_in,
    sync_ok => is_sync_0_int, logical_lane => logical_lane_0_int);

  lane_1: entity work.sync_lane port map(data_in => lane_1_data_in, header_in => lane_1_header_in,
    sync_ok => is_sync_1_int, logical_lane => logical_lane_1_int);

  lane_2: entity work.sync_lane port map(data_in => lane_2_data_in, header_in => lane_2_header_in,
    sync_ok => is_sync_2_int, logical_lane => logical_lane_2_int);

  lane_3: entity work.sync_lane port map(data_in => lane_3_data_in, header_in => lane_3_header_in,
    sync_ok => is_sync_3_int, logical_lane => logical_lane_3_int);

  logical_lane_0 : entity work.last_lane_reg port map(ck => clock, rst=>reset, sync_ok => is_sync_0_int,
    logical_lane => logical_lane_0_int, logical_lane_reg => barreira_skew.logical_lane_0);

  logical_lane_1 : entity work.last_lane_reg port map(ck => clock, rst=>reset, sync_ok => is_sync_1_int,
    logical_lane => logical_lane_1_int, logical_lane_reg => barreira_skew.logical_lane_1);

  logical_lane_2 : entity work.last_lane_reg port map(ck => clock, rst=>reset, sync_ok => is_sync_2_int,
    logical_lane => logical_lane_2_int, logical_lane_reg => barreira_skew.logical_lane_2);

  logical_lane_3 : entity work.last_lane_reg port map(ck => clock, rst=>reset, sync_ok => is_sync_3_int,
    logical_lane => logical_lane_3_int, logical_lane_reg => barreira_skew.logical_lane_3);

  -- read_from_fifos_int <= '0' when () else '1';
  -- reg_skew_read: entity work.regnbit port map (ck=>clock, rst=>reset, ce=>'1', D=>read_from_fifos_int, Q=>barreira_skew.read_from_fifos);

  reg_skew_data_0:      entity work.regnbit generic map (size=>64) port map (ck=>clock, rst=>reset, ce=>'1', D=>lane_0_data_in,   Q=>barreira_skew.data_0);
  reg_skew_header_0:    entity work.regnbit generic map (size=>2)  port map (ck=>clock, rst=>reset, ce=>'1', D=>lane_0_header_in, Q=>barreira_skew.header_0);
  reg_skew_is_sync_0:   entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>is_sync_0_int, Q=>barreira_skew.is_sync_0);

  reg_skew_data_1:      entity work.regnbit generic map (size=>64) port map (ck=>clock, rst=>reset, ce=>'1', D=>lane_1_data_in,   Q=>barreira_skew.data_1);
  reg_skew_header_1:    entity work.regnbit generic map (size=>2)  port map (ck=>clock, rst=>reset, ce=>'1', D=>lane_1_header_in, Q=>barreira_skew.header_1);
  reg_skew_is_sync_1:   entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>is_sync_1_int, Q=>barreira_skew.is_sync_1);

  reg_skew_data_2:      entity work.regnbit generic map (size=>64) port map (ck=>clock, rst=>reset, ce=>'1', D=>lane_2_data_in,   Q=>barreira_skew.data_2);
  reg_skew_header_2:    entity work.regnbit generic map (size=>2)  port map (ck=>clock, rst=>reset, ce=>'1', D=>lane_2_header_in, Q=>barreira_skew.header_2);
  reg_skew_is_sync_2:   entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>is_sync_2_int, Q=>barreira_skew.is_sync_2);

  reg_skew_data_3:      entity work.regnbit generic map (size=>64) port map (ck=>clock, rst=>reset, ce=>'1', D=>lane_3_data_in,   Q=>barreira_skew.data_3);
  reg_skew_header_3:    entity work.regnbit generic map (size=>2)  port map (ck=>clock, rst=>reset, ce=>'1', D=>lane_3_header_in, Q=>barreira_skew.header_3);
  reg_skew_is_sync_3:   entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>is_sync_3_int, Q=>barreira_skew.is_sync_3);

  --==============================================================================
  -- second_stage - CHECKS BIP
  --==============================================================================

  -- Só habilita leitura após todas lanes estiverem syncadas
  read_from_fifos_int <= '0' when (barreira_skew.logical_lane_0 = "100" and barreira_skew.logical_lane_1 = "100" and
                                   barreira_skew.logical_lane_2 = "100" and barreira_skew.logical_lane_3 = "100") else '1';

  -- descarta todos blocos até a chegada do primeiro block sync
  enable_lane_0 <= '0' when barreira_skew.logical_lane_0 = "100" else '1';
  enable_lane_1 <= '0' when barreira_skew.logical_lane_1 = "100" else '1';
  enable_lane_2 <= '0' when barreira_skew.logical_lane_2 = "100" else '1';
  enable_lane_3 <= '0' when barreira_skew.logical_lane_3 = "100" else '1';

  -- calcula BIP
  reg_bip_lane_0: entity work.bip_calculator port map (enable => enable_lane_0, data_in => barreira_skew.data_0, header_in => barreira_skew.header_0, bip_ok => bip_lane_0_int);
  reg_bip_lane_1: entity work.bip_calculator port map (enable => enable_lane_1, data_in => barreira_skew.data_1, header_in => barreira_skew.header_1, bip_ok => bip_lane_1_int);
  reg_bip_lane_2: entity work.bip_calculator port map (enable => enable_lane_2, data_in => barreira_skew.data_2, header_in => barreira_skew.header_2, bip_ok => bip_lane_2_int);
  reg_bip_lane_3: entity work.bip_calculator port map (enable => enable_lane_3, data_in => barreira_skew.data_3, header_in => barreira_skew.header_3, bip_ok => bip_lane_3_int);

  reg_bip_read_lanes: entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>read_from_fifos_int, Q=>barreira_bip.read_from_fifos);

  reg_bip_data_0:       entity work.regnbit generic map (size=>64) port map (ck=>clock, rst=>reset, ce=>'1', D=>barreira_skew.data_0,    Q=>barreira_bip.data_0);
  reg_bip_header_0:     entity work.regnbit generic map (size=>2)  port map (ck=>clock, rst=>reset, ce=>'1', D=>barreira_skew.header_0,  Q=>barreira_bip.header_0);
  reg_bip_is_sync_0:    entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>barreira_skew.is_sync_0, Q=>barreira_bip.is_sync_0);
  reg_bip_bip_ok_0:     entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>bip_lane_0_int, Q=>barreira_bip.bip_ok_0);
  reg_bip_logic_lane_0: entity work.regnbit generic map (size=>3)  port map (ck=>clock, rst=>reset, ce=>'1', D=>barreira_skew.logical_lane_0,  Q=>barreira_bip.logical_lane_0);

  reg_bip_data_1:       entity work.regnbit generic map (size=>64) port map (ck=>clock, rst=>reset, ce=>'1', D=>barreira_skew.data_1,    Q=>barreira_bip.data_1);
  reg_bip_header_1:     entity work.regnbit generic map (size=>2)  port map (ck=>clock, rst=>reset, ce=>'1', D=>barreira_skew.header_1,  Q=>barreira_bip.header_1);
  reg_bip_is_sync_1:    entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>barreira_skew.is_sync_1, Q=>barreira_bip.is_sync_1);
  reg_bip_bip_ok_1:     entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>bip_lane_1_int, Q=>barreira_bip.bip_ok_1);
  reg_bip_logic_lane_1: entity work.regnbit generic map (size=>3)  port map (ck=>clock, rst=>reset, ce=>'1', D=>barreira_skew.logical_lane_1,  Q=>barreira_bip.logical_lane_1);

  reg_bip_data_2:       entity work.regnbit generic map (size=>64) port map (ck=>clock, rst=>reset, ce=>'1', D=>barreira_skew.data_2,    Q=>barreira_bip.data_2);
  reg_bip_header_2:     entity work.regnbit generic map (size=>2)  port map (ck=>clock, rst=>reset, ce=>'1', D=>barreira_skew.header_2,  Q=>barreira_bip.header_2);
  reg_bip_is_sync_2:    entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>barreira_skew.is_sync_2, Q=>barreira_bip.is_sync_2);
  reg_bip_bip_ok_2:     entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>bip_lane_2_int, Q=>barreira_bip.bip_ok_2);
  reg_bip_logic_lane_2: entity work.regnbit generic map (size=>3)  port map (ck=>clock, rst=>reset, ce=>'1', D=>barreira_skew.logical_lane_2,  Q=>barreira_bip.logical_lane_2);

  reg_bip_data_3:       entity work.regnbit generic map (size=>64) port map (ck=>clock, rst=>reset, ce=>'1', D=>barreira_skew.data_3,    Q=>barreira_bip.data_3);
  reg_bip_header_3:     entity work.regnbit generic map (size=>2)  port map (ck=>clock, rst=>reset, ce=>'1', D=>barreira_skew.header_3,  Q=>barreira_bip.header_3);
  reg_bip_is_sync_3:    entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>barreira_skew.is_sync_3, Q=>barreira_bip.is_sync_3);
  reg_bip_bip_ok_3:     entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>bip_lane_3_int, Q=>barreira_bip.bip_ok_3);
  reg_bip_logic_lane_3: entity work.regnbit generic map (size=>3)  port map (ck=>clock, rst=>reset, ce=>'1', D=>barreira_skew.logical_lane_3,  Q=>barreira_bip.logical_lane_3);

  --==============================================================================
  -- third_stage - SHUFFLE NETWORK
  --==============================================================================
  shuffle_in_0 <= (barreira_bip.header_0 & barreira_bip.data_0);
  shuffle_in_1 <= (barreira_bip.header_1 & barreira_bip.data_1);
  shuffle_in_2 <= (barreira_bip.header_2 & barreira_bip.data_2);
  shuffle_in_3 <= (barreira_bip.header_3 & barreira_bip.data_3);

  shuffle_lanes: entity work.shuffle port map (
      in_0   => shuffle_in_0,
      in_1   => shuffle_in_1,
      in_2   => shuffle_in_2,
      in_3   => shuffle_in_3,
      lane_0 => (barreira_bip.logical_lane_0(1 downto 0)),
      lane_1 => (barreira_bip.logical_lane_1(1 downto 0)),
      lane_2 => (barreira_bip.logical_lane_2(1 downto 0)),
      lane_3 => (barreira_bip.logical_lane_3(1 downto 0)),
      out_0  => shuffle_out_0,
      out_1  => shuffle_out_1,
      out_2  => shuffle_out_2,
      out_3  => shuffle_out_3
  );

  wen_0_int <= '0' when barreira_bip.is_sync_0 = '1' else '1';
  wen_1_int <= '0' when barreira_bip.is_sync_1 = '1' else '1';
  wen_2_int <= '0' when barreira_bip.is_sync_2 = '1' else '1';
  wen_3_int <= '0' when barreira_bip.is_sync_3 = '1' else '1';

  reg_xbar_read_lanes: entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>barreira_bip.read_from_fifos, Q=>barreira_xbar.read_from_fifos);

  reg_xbar_data_0:       entity work.regnbit generic map (size=>64) port map (ck=>clock, rst=>reset, ce=>'1', D=>shuffle_out_0(63 downto 0),  Q=>barreira_xbar.data_0);
  reg_xbar_header_0:     entity work.regnbit generic map (size=>2)  port map (ck=>clock, rst=>reset, ce=>'1', D=>shuffle_out_0(65 downto 64), Q=>barreira_xbar.header_0);
  reg_xbar_wen_0:        entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>wen_0_int, Q=>barreira_xbar.wen_0);

  reg_xbar_data_1:       entity work.regnbit generic map (size=>64) port map (ck=>clock, rst=>reset, ce=>'1', D=>shuffle_out_1(63 downto 0),  Q=>barreira_xbar.data_1);
  reg_xbar_header_1:     entity work.regnbit generic map (size=>2)  port map (ck=>clock, rst=>reset, ce=>'1', D=>shuffle_out_1(65 downto 64), Q=>barreira_xbar.header_1);
  reg_xbar_wen_1:        entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>wen_1_int, Q=>barreira_xbar.wen_1);


  reg_xbar_data_2:       entity work.regnbit generic map (size=>64) port map (ck=>clock, rst=>reset, ce=>'1', D=>shuffle_out_2(63 downto 0),  Q=>barreira_xbar.data_2);
  reg_xbar_header_2:     entity work.regnbit generic map (size=>2)  port map (ck=>clock, rst=>reset, ce=>'1', D=>shuffle_out_2(65 downto 64), Q=>barreira_xbar.header_2);
  reg_xbar_wen_2:        entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>wen_2_int, Q=>barreira_xbar.wen_2);

  reg_xbar_data_3:       entity work.regnbit generic map (size=>64) port map (ck=>clock, rst=>reset, ce=>'1', D=>shuffle_out_3(63 downto 0),  Q=>barreira_xbar.data_3);
  reg_xbar_header_3:     entity work.regnbit generic map (size=>2)  port map (ck=>clock, rst=>reset, ce=>'1', D=>shuffle_out_3(65 downto 64), Q=>barreira_xbar.header_3);
  reg_xbar_wen_3:        entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>wen_3_int, Q=>barreira_xbar.wen_3);


  --==============================================================================
  -- forth_stage - FIFOS
  --==============================================================================
  -- descarta bloco de sync

  fifo_0 : entity work.FIFO_DUALCLOCK_MACRO
  generic map ( DATA_WIDTH => 66, FIFO_SIZE => "36Kb")
  port map(
    ALMOSTEMPTY => almost_e_0,
    ALMOSTFULL  => almost_f_0,
    DO          => fifo_out_0,
    EMPTY       => empty_0,
    FULL        => full_0,
    RDCOUNT     => RDCOUNT_0,
    RDERR       => open,
    WRCOUNT     => WRCOUNT_0,
    WRERR       => open,

    DI          => fifo_in_0,
    RDCLK       => clock,
    RDEN        => barreira_xbar.read_from_fifos, --USAR ESSE SINAL CERTO!!!
    RST         => reset_n,
    WRCLK       => clock,
    WREN        => barreira_xbar.wen_0
  );

  fifo_in_0 <= barreira_xbar.header_0 & barreira_xbar.data_0;
  pcs_0_header_out <= fifo_out_0(65 downto 64);
  pcs_0_data_out <= fifo_out_0(63 downto 0);

  fifo_1 : entity work.FIFO_DUALCLOCK_MACRO
  generic map ( DATA_WIDTH => 66, FIFO_SIZE => "36Kb")
  port map(
    ALMOSTEMPTY => almost_e_1,
    ALMOSTFULL  => almost_f_1,
    DO          => fifo_out_1,
    EMPTY       => empty_1,
    FULL        => full_1,
    RDCOUNT     => RDCOUNT_1,
    RDERR       => open,
    WRCOUNT     => WRCOUNT_1,
    WRERR       => open,

    DI          => fifo_in_1,
    RDCLK       => clock,
    RDEN        => barreira_xbar.read_from_fifos,
    RST         => reset_n,
    WRCLK       => clock,
    WREN        => barreira_xbar.wen_1
  );

  fifo_in_1 <= barreira_xbar.header_1 & barreira_xbar.data_1;
  pcs_1_header_out <= fifo_out_1(65 downto 64);
  pcs_1_data_out <= fifo_out_1(63 downto 0);

  fifo_2 : entity work.FIFO_DUALCLOCK_MACRO
  generic map ( DATA_WIDTH => 66, FIFO_SIZE => "36Kb")
  port map(
    ALMOSTEMPTY => almost_e_2,
    ALMOSTFULL  => almost_f_2,
    DO          => fifo_out_2,
    EMPTY       => empty_2,
    FULL        => full_2,
    RDCOUNT     => RDCOUNT_2,
    RDERR       => open,
    WRCOUNT     => WRCOUNT_2,
    WRERR       => open,

    DI          => fifo_in_2,
    RDCLK       => clock,
    RDEN        => barreira_xbar.read_from_fifos, --USAR ESSE SINAL CERTO!!!
    RST         => reset_n,
    WRCLK       => clock,
    WREN        => barreira_xbar.wen_2
  );

  fifo_in_2 <= barreira_xbar.header_2 & barreira_xbar.data_2;
  pcs_2_header_out <= fifo_out_2(65 downto 64);
  pcs_2_data_out <= fifo_out_2(63 downto 0);

  fifo_3 : entity work.FIFO_DUALCLOCK_MACRO
  generic map ( DATA_WIDTH => 66, FIFO_SIZE => "36Kb")
  port map(
    ALMOSTEMPTY => almost_e_3,
    ALMOSTFULL  => almost_f_3,
    DO          => fifo_out_3,
    EMPTY       => empty_3,
    FULL        => full_3,
    RDCOUNT     => RDCOUNT_3,
    RDERR       => open,
    WRCOUNT     => WRCOUNT_3,
    WRERR       => open,

    DI          => fifo_in_3,
    RDCLK       => clock,
    RDEN        => barreira_xbar.read_from_fifos, --USAR ESSE SINAL CERTO!!!
    RST         => reset_n,
    WRCLK       => clock,
    WREN        => barreira_xbar.wen_3
  );

  fifo_in_3 <= barreira_xbar.header_3 & barreira_xbar.data_3;
  pcs_3_header_out <= fifo_out_3(65 downto 64);
  pcs_3_data_out <= fifo_out_3(63 downto 0);
end behav_lane_reorder;
