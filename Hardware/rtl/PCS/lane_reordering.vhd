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
       if rst = '1' then
              Q <= INIT_VALUE(size-1 downto 0);
       elsif ck'event and ck = '0' then
           if ce = '1' then
              Q <= D;
           end if;
       end if;
  end process;
end regn;

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
  logical_lane_int <= "000" when data_in(63 downto 40) = SYNC_LANE0_HIGH and data_in(23 downto 0) = SYNC_LANE0_LOW else
                      "001" when data_in(63 downto 40) = SYNC_LANE1_HIGH and data_in(23 downto 0) = SYNC_LANE1_LOW else
                      "010" when data_in(63 downto 40) = SYNC_LANE2_HIGH and data_in(23 downto 0) = SYNC_LANE2_LOW else
                      "011" when data_in(63 downto 40) = SYNC_LANE3_HIGH and data_in(23 downto 0) = SYNC_LANE3_LOW else
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
    if(ck'event and ck ='1') then
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

    type barreira is record
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
      read_from_fifos : std_logic;
    end record;

    type fsm_state is (S_INIT, S_END, S_SYNC, S_TRANSMIT);
    signal CURRENT_STATE, NEXT_STATE: fsm_state;

    signal logical_lane_0_int : std_logic_vector(2 downto 0);
    signal logical_lane_1_int : std_logic_vector(2 downto 0);
    signal logical_lane_2_int : std_logic_vector(2 downto 0);
    signal logical_lane_3_int : std_logic_vector(2 downto 0);

    signal barreira_skew : barreira;

    signal sync_ok_0 : std_logic;
    signal sync_ok_1 : std_logic;
    signal sync_ok_2 : std_logic;
    signal sync_ok_3 : std_logic;

begin

  --==============================================================================
  -- first_stage - FIND SYNC BLOCK and ACCOUNT FOR SKEW
  --==============================================================================
  lane_0: entity work.sync_lane port map(data_in => lane_0_data_in,header_in => lane_0_header_in,
    sync_ok => sync_ok_0, logical_lane => logical_lane_0_int);

  lane_1: entity work.sync_lane port map(data_in => lane_1_data_in, header_in => lane_1_header_in,
    sync_ok => sync_ok_1, logical_lane => logical_lane_1_int);

  lane_2: entity work.sync_lane port map(data_in => lane_2_data_in, header_in => lane_2_header_in,
    sync_ok => sync_ok_2, logical_lane => logical_lane_2_int);

  lane_3: entity work.sync_lane port map(data_in => lane_3_data_in, header_in => lane_3_header_in,
    sync_ok => sync_ok_3, logical_lane => logical_lane_3_int);

  logical_lane_0 : entity work.last_lane_reg port map(ck => clock, rst=>reset, sync_ok => sync_ok_0,
    logical_lane => logical_lane_0_int, logical_lane_reg => barreira_skew.logical_lane_0);

  logical_lane_1 : entity work.last_lane_reg port map(ck => clock, rst=>reset, sync_ok => sync_ok_1,
    logical_lane => logical_lane_1_int, logical_lane_reg => barreira_skew.logical_lane_1);

  logical_lane_2 : entity work.last_lane_reg port map(ck => clock, rst=>reset, sync_ok => sync_ok_2,
    logical_lane => logical_lane_2_int, logical_lane_reg => barreira_skew.logical_lane_2);

  logical_lane_3 : entity work.last_lane_reg port map(ck => clock, rst=>reset, sync_ok => sync_ok_3,
    logical_lane => logical_lane_3_int, logical_lane_reg => barreira_skew.logical_lane_3);

  -- reg_skew_read: entity work.regnbit port map (ck=>clock, rst=>reset, ce=>'1', D=> , Q=>barreira_skew.read_from_fifos);

  reg_skew_data_0:      entity work.regnbit generic map (size=>64) port map (ck=>clock, rst=>reset, ce=>'1', D=>lane_0_data_in, Q=>barreira_skew.data_0);
  reg_skew_header_0:    entity work.regnbit generic map (size=>2)  port map (ck=>clock, rst=>reset, ce=>'1', D=>lane_0_header_in, Q=>barreira_skew.header_0);

  reg_skew_data_1:      entity work.regnbit generic map (size=>64) port map (ck=>clock, rst=>reset, ce=>'1', D=>lane_1_data_in, Q=>barreira_skew.data_1);
  reg_skew_header_1:    entity work.regnbit generic map (size=>2)  port map (ck=>clock, rst=>reset, ce=>'1', D=>lane_1_header_in, Q=>barreira_skew.header_1);

  reg_skew_data_2:      entity work.regnbit generic map (size=>64) port map (ck=>clock, rst=>reset, ce=>'1', D=>lane_2_data_in, Q=>barreira_skew.data_2);
  reg_skew_header_2:    entity work.regnbit generic map (size=>2)  port map (ck=>clock, rst=>reset, ce=>'1', D=>lane_2_header_in, Q=>barreira_skew.header_2);

  reg_skew_data_3:      entity work.regnbit generic map (size=>64) port map (ck=>clock, rst=>reset, ce=>'1', D=>lane_3_data_in, Q=>barreira_skew.data_3);
  reg_skew_header_3:    entity work.regnbit generic map (size=>2)  port map (ck=>clock, rst=>reset, ce=>'1', D=>lane_3_header_in, Q=>barreira_skew.header_3);

  --==============================================================================
  -- second_stage - CHECKS BIP 
  --==============================================================================

end behav_lane_reorder;
