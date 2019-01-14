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
  logical_lane_int <= "000" when data_in(63 downto 40) = SYNC_LANE0_LOW and data_in(31 downto 8) = SYNC_LANE0_HIGH else
                      "001" when data_in(63 downto 40) = SYNC_LANE1_LOW and data_in(31 downto 8) = SYNC_LANE1_HIGH else
                      "010" when data_in(63 downto 40) = SYNC_LANE2_LOW and data_in(31 downto 8) = SYNC_LANE2_HIGH else
                      "011" when data_in(63 downto 40) = SYNC_LANE3_LOW and data_in(31 downto 8) = SYNC_LANE3_HIGH else
                      "100";
  sync_ok <= '0' when logical_lane_int = "100" else '1';
  logical_lane <= logical_lane_int;
end behav_sync_lane;

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- LANE NUMBER REG MODULE
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
  process(ck,rst) is
  begin
    if(rst = '0') then
      lane_reg <= "100";
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

    lane_0_valid_in  : in std_logic;
    lane_1_valid_in  : in std_logic;
    lane_2_valid_in  : in std_logic;
    lane_3_valid_in  : in std_logic;

    pcs_0_data_out  : out std_logic_vector(63 downto 0);
    pcs_1_data_out  : out std_logic_vector(63 downto 0);
    pcs_2_data_out  : out std_logic_vector(63 downto 0);
    pcs_3_data_out  : out std_logic_vector(63 downto 0);

    pcs_0_header_out  : out std_logic_vector(1 downto 0);
    pcs_1_header_out  : out std_logic_vector(1 downto 0);
    pcs_2_header_out  : out std_logic_vector(1 downto 0);
    pcs_3_header_out  : out std_logic_vector(1 downto 0);

    pcs_0_valid_out   : out std_logic;
    pcs_1_valid_out   : out std_logic;
    pcs_2_valid_out   : out std_logic;
    pcs_3_valid_out   : out std_logic;

    pcs_0_alignment_out   : out std_logic;
    pcs_1_alignment_out   : out std_logic;
    pcs_2_alignment_out   : out std_logic;
    pcs_3_alignment_out   : out std_logic;

    fifo_empty_0  : out std_logic;
    fifo_empty_1  : out std_logic;
    fifo_empty_2  : out std_logic;
    fifo_empty_3  : out std_logic

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
      valid_0  : std_logic;
      valid_1  : std_logic;
      valid_2  : std_logic;
      valid_3  : std_logic;
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
      valid_0  : std_logic;
      valid_1  : std_logic;
      valid_2  : std_logic;
      valid_3  : std_logic;
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
      valid_0  : std_logic;
      valid_1  : std_logic;
      valid_2  : std_logic;
      valid_3  : std_logic;
      wen_0 : std_logic;
      wen_1 : std_logic;
      wen_2 : std_logic;
      wen_3 : std_logic;
      read_from_fifos : std_logic;
    end record;

    type out_regs is record
    -- block_0   : std_logic_vector(66 downto 0);
    -- block_1   : std_logic_vector(66 downto 0);
    -- block_2   : std_logic_vector(66 downto 0);
    -- block_3   : std_logic_vector(66 downto 0);
      block_0   : std_logic_vector(67 downto 0);
      block_1   : std_logic_vector(67 downto 0);
      block_2   : std_logic_vector(67 downto 0);
      block_3   : std_logic_vector(67 downto 0);
    end record;

    type fsm_state is (S_INIT, S_END, S_SYNC, S_TRANSMIT);
    signal CURRENT_STATE, NEXT_STATE: fsm_state;

    signal reset_n : std_logic;

    signal barreira_skew : barreira_0;
    signal barreira_bip  : barreira_1;
    signal barreira_xbar : barreira_2;
    signal out_data      : out_regs;

    signal logical_lane_0_int : std_logic_vector(2 downto 0);
    signal logical_lane_1_int : std_logic_vector(2 downto 0);
    signal logical_lane_2_int : std_logic_vector(2 downto 0);
    signal logical_lane_3_int : std_logic_vector(2 downto 0);

    signal is_sync_0_int : std_logic;
    signal is_sync_1_int : std_logic;
    signal is_sync_2_int : std_logic;
    signal is_sync_3_int : std_logic;

    signal read_from_fifos_int :std_logic;
    signal read_from_fifos_reg :std_logic;

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

    -- signal shuffle_out_0 : std_logic_vector(66 downto 0);
    -- signal shuffle_out_1 : std_logic_vector(66 downto 0);
    -- signal shuffle_out_2 : std_logic_vector(66 downto 0);
    -- signal shuffle_out_3 : std_logic_vector(66 downto 0);
    signal shuffle_out_0 : std_logic_vector(67 downto 0);
    signal shuffle_out_1 : std_logic_vector(67 downto 0);
    signal shuffle_out_2 : std_logic_vector(67 downto 0);
    signal shuffle_out_3 : std_logic_vector(67 downto 0);

    signal almost_f_0,almost_e_0,empty_0,full_0 : std_logic;
    -- signal fifo_out_0 : std_logic_vector(66 downto 0);
    -- signal fifo_in_0  : std_logic_vector(66 downto 0);
    signal fifo_out_0 : std_logic_vector(67 downto 0);
    signal fifo_in_0  : std_logic_vector(67 downto 0);

    signal RDCOUNT_0 : std_logic_vector(8 downto 0);
    signal WRCOUNT_0 : std_logic_vector(8 downto 0);

    signal almost_f_1,almost_e_1,empty_1,full_1 : std_logic;
    -- signal fifo_out_1 : std_logic_vector(66 downto 0);
    -- signal fifo_in_1  : std_logic_vector(66 downto 0);
    signal fifo_out_1 : std_logic_vector(67 downto 0);
    signal fifo_in_1  : std_logic_vector(67 downto 0);

    signal RDCOUNT_1 : std_logic_vector(8 downto 0);
    signal WRCOUNT_1 : std_logic_vector(8 downto 0);

    signal almost_f_2,almost_e_2,empty_2,full_2 : std_logic;
    -- signal fifo_out_2 : std_logic_vector(66 downto 0);
    -- signal fifo_in_2  : std_logic_vector(66 downto 0);
    signal fifo_out_2 : std_logic_vector(67 downto 0);
    signal fifo_in_2  : std_logic_vector(67 downto 0);

    signal RDCOUNT_2 : std_logic_vector(8 downto 0);
    signal WRCOUNT_2 : std_logic_vector(8 downto 0);

    signal almost_f_3,almost_e_3,empty_3,full_3 : std_logic;
    -- signal fifo_out_3 : std_logic_vector(66 downto 0);
    -- signal fifo_in_3  : std_logic_vector(66 downto 0);
    signal fifo_out_3 : std_logic_vector(67 downto 0);
    signal fifo_in_3  : std_logic_vector(67 downto 0);

    signal RDCOUNT_3 : std_logic_vector(8 downto 0);
    signal WRCOUNT_3 : std_logic_vector(8 downto 0);

    signal fifo_wen_0 : std_logic;
    signal fifo_wen_1 : std_logic;
    signal fifo_wen_2 : std_logic;
    signal fifo_wen_3 : std_logic;

    signal val_lane_0     : std_logic;
    signal val_lane_1     : std_logic;
    signal val_lane_2     : std_logic;
    signal val_lane_3     : std_logic;
    signal val_block_0_d0 : std_logic;
    signal val_block_1_d0 : std_logic;
    signal val_block_2_d0 : std_logic;
    signal val_block_3_d0 : std_logic;

begin
  reset_n <= not reset;

  sync_block: process (clock,reset)
  begin
      if reset = '0' then
        val_block_0_d0 <= '0';
        val_block_1_d0 <= '0';
        val_block_2_d0 <= '0';
        val_block_3_d0 <= '0';
        val_lane_0 <= '0';
        val_lane_1 <= '0';
        val_lane_2 <= '0';
        val_lane_3 <= '0';
      elsif clock 'event and clock = '1' then
        val_block_0_d0 <= lane_0_valid_in;
        val_block_1_d0 <= lane_1_valid_in;
        val_block_2_d0 <= lane_2_valid_in;
        val_block_3_d0 <= lane_3_valid_in;
      end if;

      if lane_0_valid_in = '1' and val_block_0_d0 = '0' then
        val_lane_0 <= '1';
        val_lane_1 <= '1';
        val_lane_2 <= '1';
        val_lane_3 <= '1';
      end if;
    end process;

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

  reg_skew_data_0:      entity work.regnbit generic map (size=>64) port map (ck=>clock, rst=>reset, ce=>'1', D=>lane_0_data_in,   Q=>barreira_skew.data_0);
  reg_skew_header_0:    entity work.regnbit generic map (size=>2)  port map (ck=>clock, rst=>reset, ce=>'1', D=>lane_0_header_in, Q=>barreira_skew.header_0);
  reg_skew_valid_0:     entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>lane_0_valid_in, Q=>barreira_skew.valid_0);
  reg_skew_is_sync_0:   entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>is_sync_0_int, Q=>barreira_skew.is_sync_0);

  reg_skew_data_1:      entity work.regnbit generic map (size=>64) port map (ck=>clock, rst=>reset, ce=>'1', D=>lane_1_data_in,   Q=>barreira_skew.data_1);
  reg_skew_header_1:    entity work.regnbit generic map (size=>2)  port map (ck=>clock, rst=>reset, ce=>'1', D=>lane_1_header_in, Q=>barreira_skew.header_1);
  reg_skew_valid_1:     entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>lane_1_valid_in, Q=>barreira_skew.valid_1);
  reg_skew_is_sync_1:   entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>is_sync_1_int, Q=>barreira_skew.is_sync_1);

  reg_skew_data_2:      entity work.regnbit generic map (size=>64) port map (ck=>clock, rst=>reset, ce=>'1', D=>lane_2_data_in,   Q=>barreira_skew.data_2);
  reg_skew_header_2:    entity work.regnbit generic map (size=>2)  port map (ck=>clock, rst=>reset, ce=>'1', D=>lane_2_header_in, Q=>barreira_skew.header_2);
  reg_skew_valid_2:     entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>lane_2_valid_in, Q=>barreira_skew.valid_2);
  reg_skew_is_sync_2:   entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>is_sync_2_int, Q=>barreira_skew.is_sync_2);

  reg_skew_data_3:      entity work.regnbit generic map (size=>64) port map (ck=>clock, rst=>reset, ce=>'1', D=>lane_3_data_in,   Q=>barreira_skew.data_3);
  reg_skew_header_3:    entity work.regnbit generic map (size=>2)  port map (ck=>clock, rst=>reset, ce=>'1', D=>lane_3_header_in, Q=>barreira_skew.header_3);
  reg_skew_valid_3:     entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>lane_3_valid_in, Q=>barreira_skew.valid_3);
  reg_skew_is_sync_3:   entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>is_sync_3_int, Q=>barreira_skew.is_sync_3);

  --==============================================================================
  -- second_stage - CHECKS BIP
  --==============================================================================

  -- Só habilita leitura após todas lanes estiverem syncadas
  read_from_fifos_int <= '0' when (barreira_skew.logical_lane_0 = "100" or barreira_skew.logical_lane_1 = "100" or
                                   barreira_skew.logical_lane_2 = "100" or barreira_skew.logical_lane_3 = "100")
                                  else '1';

  -- descarta todos blocos até a chegada do primeiro block sync
  enable_lane_0 <= '0' when barreira_skew.logical_lane_0 = "100" else '1';
  enable_lane_1 <= '0' when barreira_skew.logical_lane_1 = "100" else '1';
  enable_lane_2 <= '0' when barreira_skew.logical_lane_2 = "100" else '1';
  enable_lane_3 <= '0' when barreira_skew.logical_lane_3 = "100" else '1';

  -- calcula BIP
  -- bip_calculator_0: entity work.bip_calculator port map (clk => clock, rst => reset, enable => enable_lane_0,
  --          data_in => barreira_bip.data_0, header_in => barreira_bip.header_0, valid_in => barreira_bip.valid_0, is_sync => barreira_skew.is_sync_0, bip_ok => bip_lane_0_int);
  --
  -- bip_calculator_1: entity work.bip_calculator port map (clk => clock, rst => reset, enable => enable_lane_1,
  --          data_in => barreira_bip.data_1, header_in => barreira_bip.header_1, valid_in => barreira_bip.valid_1, is_sync => barreira_skew.is_sync_1, bip_ok => bip_lane_1_int);
  --
  -- bip_calculator_2: entity work.bip_calculator port map (clk => clock, rst => reset, enable => enable_lane_2,
  --          data_in => barreira_bip.data_2, header_in => barreira_bip.header_2, valid_in => barreira_bip.valid_2, is_sync => barreira_skew.is_sync_2, bip_ok => bip_lane_2_int);
  --
  -- bip_calculator_3: entity work.bip_calculator port map (clk => clock, rst => reset, enable => enable_lane_3,
  --          data_in => barreira_bip.data_3, header_in => barreira_bip.header_3, valid_in => barreira_bip.valid_3, is_sync => barreira_skew.is_sync_3, bip_ok => bip_lane_3_int);
  bip_calculator_0: entity work.bip_calculator port map (clk => clock, rst => reset, enable => enable_lane_0,
           data_in => barreira_bip.data_0, header_in => barreira_bip.header_0, valid_in => barreira_bip.valid_0, is_sync => barreira_bip.is_sync_0, bip_ok => bip_lane_0_int);

  bip_calculator_1: entity work.bip_calculator port map (clk => clock, rst => reset, enable => enable_lane_1,
           data_in => barreira_bip.data_1, header_in => barreira_bip.header_1, valid_in => barreira_bip.valid_1, is_sync => barreira_bip.is_sync_1, bip_ok => bip_lane_1_int);

  bip_calculator_2: entity work.bip_calculator port map (clk => clock, rst => reset, enable => enable_lane_2,
           data_in => barreira_bip.data_2, header_in => barreira_bip.header_2, valid_in => barreira_bip.valid_2, is_sync => barreira_bip.is_sync_2, bip_ok => bip_lane_2_int);

  bip_calculator_3: entity work.bip_calculator port map (clk => clock, rst => reset, enable => enable_lane_3,
           data_in => barreira_bip.data_3, header_in => barreira_bip.header_3, valid_in => barreira_bip.valid_3, is_sync => barreira_bip.is_sync_3, bip_ok => bip_lane_3_int);


  reg_bip_read_lanes: entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>read_from_fifos_int, Q=>barreira_bip.read_from_fifos);

  reg_bip_data_0:       entity work.regnbit generic map (size=>64) port map (ck=>clock, rst=>reset, ce=>'1', D=>barreira_skew.data_0,    Q=>barreira_bip.data_0);
  reg_bip_header_0:     entity work.regnbit generic map (size=>2)  port map (ck=>clock, rst=>reset, ce=>'1', D=>barreira_skew.header_0,  Q=>barreira_bip.header_0);
  reg_bip_valid_0:      entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>barreira_skew.valid_0, Q=>barreira_bip.valid_0);
  -- reg_bip_valid_0:      entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>lane_0_valid_in, Q=>barreira_bip.valid_0);
  reg_bip_is_sync_0:    entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>barreira_skew.is_sync_0, Q=>barreira_bip.is_sync_0);
  reg_bip_bip_ok_0:     entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>bip_lane_0_int, Q=>barreira_bip.bip_ok_0);
  reg_bip_logic_lane_0: entity work.regnbit generic map (size=>3)  port map (ck=>clock, rst=>reset, ce=>'1', D=>barreira_skew.logical_lane_0,  Q=>barreira_bip.logical_lane_0);

  reg_bip_data_1:       entity work.regnbit generic map (size=>64) port map (ck=>clock, rst=>reset, ce=>'1', D=>barreira_skew.data_1,    Q=>barreira_bip.data_1);
  reg_bip_header_1:     entity work.regnbit generic map (size=>2)  port map (ck=>clock, rst=>reset, ce=>'1', D=>barreira_skew.header_1,  Q=>barreira_bip.header_1);
  reg_bip_valid_1:      entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>barreira_skew.valid_1, Q=>barreira_bip.valid_1);
  -- reg_bip_valid_1:      entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>lane_1_valid_in, Q=>barreira_bip.valid_1);
  reg_bip_is_sync_1:    entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>barreira_skew.is_sync_1, Q=>barreira_bip.is_sync_1);
  reg_bip_bip_ok_1:     entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>bip_lane_1_int, Q=>barreira_bip.bip_ok_1);
  reg_bip_logic_lane_1: entity work.regnbit generic map (size=>3)  port map (ck=>clock, rst=>reset, ce=>'1', D=>barreira_skew.logical_lane_1,  Q=>barreira_bip.logical_lane_1);

  reg_bip_data_2:       entity work.regnbit generic map (size=>64) port map (ck=>clock, rst=>reset, ce=>'1', D=>barreira_skew.data_2,    Q=>barreira_bip.data_2);
  reg_bip_header_2:     entity work.regnbit generic map (size=>2)  port map (ck=>clock, rst=>reset, ce=>'1', D=>barreira_skew.header_2,  Q=>barreira_bip.header_2);
  reg_bip_valid_2:      entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>barreira_skew.valid_2, Q=>barreira_bip.valid_2);
  -- reg_bip_valid_2:      entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>lane_2_valid_in, Q=>barreira_bip.valid_2);
  reg_bip_is_sync_2:    entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>barreira_skew.is_sync_2, Q=>barreira_bip.is_sync_2);
  reg_bip_bip_ok_2:     entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>bip_lane_2_int, Q=>barreira_bip.bip_ok_2);
  reg_bip_logic_lane_2: entity work.regnbit generic map (size=>3)  port map (ck=>clock, rst=>reset, ce=>'1', D=>barreira_skew.logical_lane_2,  Q=>barreira_bip.logical_lane_2);

  reg_bip_data_3:       entity work.regnbit generic map (size=>64) port map (ck=>clock, rst=>reset, ce=>'1', D=>barreira_skew.data_3,    Q=>barreira_bip.data_3);
  reg_bip_header_3:     entity work.regnbit generic map (size=>2)  port map (ck=>clock, rst=>reset, ce=>'1', D=>barreira_skew.header_3,  Q=>barreira_bip.header_3);
  reg_bip_valid_3:      entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>barreira_skew.valid_3, Q=>barreira_bip.valid_3);
  -- reg_bip_valid_3:      entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>lane_3_valid_in, Q=>barreira_bip.valid_3);
  reg_bip_is_sync_3:    entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>barreira_skew.is_sync_3, Q=>barreira_bip.is_sync_3);
  reg_bip_bip_ok_3:     entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>bip_lane_3_int, Q=>barreira_bip.bip_ok_3);
  reg_bip_logic_lane_3: entity work.regnbit generic map (size=>3)  port map (ck=>clock, rst=>reset, ce=>'1', D=>barreira_skew.logical_lane_3,  Q=>barreira_bip.logical_lane_3);

  -- Inicia escrita apos respectivo alinhamento e não escreve palavras de alinhamento
  -- wen_0_int <= '0' when barreira_skew.is_sync_0 = '1' or barreira_skew.logical_lane_0 = "100" else '1';
  -- wen_1_int <= '0' when barreira_skew.is_sync_1 = '1' or barreira_skew.logical_lane_1 = "100" else '1';
  -- wen_2_int <= '0' when barreira_skew.is_sync_2 = '1' or barreira_skew.logical_lane_2 = "100" else '1';
  -- wen_3_int <= '0' when barreira_skew.is_sync_3 = '1' or barreira_skew.logical_lane_3 = "100" else '1';
  -- -- wen_0_int <= '0' when barreira_skew.is_sync_0 = '1' else '1';
  -- -- wen_1_int <= '0' when barreira_skew.is_sync_1 = '1' else '1';
  -- -- wen_2_int <= '0' when barreira_skew.is_sync_2 = '1' else '1';
  -- -- wen_3_int <= '0' when barreira_skew.is_sync_3 = '1' else '1';

  -- Tanauan
  -- wen_0_int <= '0' when barreira_skew.is_sync_0 = '1' or barreira_bip.valid_0 = '0' else '1';
  -- wen_1_int <= '0' when barreira_skew.is_sync_1 = '1' or barreira_bip.valid_1 = '0' else '1';
  -- wen_2_int <= '0' when barreira_skew.is_sync_2 = '1' or barreira_bip.valid_2 = '0' else '1';
  -- wen_3_int <= '0' when barreira_skew.is_sync_3 = '1' or barreira_bip.valid_3 = '0' else '1';
  -- -- wen_0_int <= '0' when barreira_skew.is_sync_0 = '1' or lane_0_valid_in = '0' else '1';
  -- -- wen_1_int <= '0' when barreira_skew.is_sync_1 = '1' or lane_1_valid_in = '0' else '1';
  -- -- wen_2_int <= '0' when barreira_skew.is_sync_2 = '1' or lane_2_valid_in = '0' else '1';
  -- -- wen_3_int <= '0' when barreira_skew.is_sync_3 = '1' or lane_3_valid_in = '0' else '1';

  -- não grava repetição nas fifos
  -- wen_0_int <= '0' when is_sync_0_int = '1' or lane_0_valid_in = '0' else '1';
  -- wen_1_int <= '0' when is_sync_1_int = '1' or lane_1_valid_in = '0' else '1';
  -- wen_2_int <= '0' when is_sync_2_int = '1' or lane_2_valid_in = '0' else '1';
  -- wen_3_int <= '0' when is_sync_3_int = '1' or lane_3_valid_in = '0' else '1';

  --tanauan
  -- wen_0_int <= '0' when is_sync_0_int = '1' or val_lane_0 = '0' else '1';
  -- wen_1_int <= '0' when is_sync_1_int = '1' or val_lane_1 = '0' else '1';
  -- wen_2_int <= '0' when is_sync_2_int = '1' or val_lane_2 = '0' else '1';
  -- wen_3_int <= '0' when is_sync_3_int = '1' or val_lane_3 = '0' else '1';

  -- wen_0_int <= '0' when barreira_skew.is_sync_0 = '1' or val_lane_0 = '0' else '1';
  -- wen_1_int <= '0' when barreira_skew.is_sync_1 = '1' or val_lane_1 = '0' else '1';
  -- wen_2_int <= '0' when barreira_skew.is_sync_2 = '1' or val_lane_2 = '0' else '1';
  -- wen_3_int <= '0' when barreira_skew.is_sync_3 = '1' or val_lane_3 = '0' else '1';
  wen_0_int <= '0' when val_lane_0 = '0' else '1';
  wen_1_int <= '0' when val_lane_1 = '0' else '1';
  wen_2_int <= '0' when val_lane_2 = '0' else '1';
  wen_3_int <= '0' when val_lane_3 = '0' else '1';



  reg_xbar_read_lanes: entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>barreira_bip.read_from_fifos, Q=>barreira_xbar.read_from_fifos);

  -- reg_xbar_data_0:       entity work.regnbit generic map (size=>64) port map (ck=>clock, rst=>reset, ce=>'1', D=>shuffle_out_0(63 downto 0),  Q=>barreira_xbar.data_0);
  -- reg_xbar_header_0:     entity work.regnbit generic map (size=>2)  port map (ck=>clock, rst=>reset, ce=>'1', D=>shuffle_out_0(65 downto 64), Q=>barreira_xbar.header_0);
  -- reg_xbar_valid_0:      entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>, Q=>barreira_xbar.valid_0);
  reg_xbar_wen_0:        entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>wen_0_int, Q=>barreira_xbar.wen_0);

  -- reg_xbar_data_1:       entity work.regnbit generic map (size=>64) port map (ck=>clock, rst=>reset, ce=>'1', D=>shuffle_out_1(63 downto 0),  Q=>barreira_xbar.data_1);
  -- reg_xbar_header_1:     entity work.regnbit generic map (size=>2)  port map (ck=>clock, rst=>reset, ce=>'1', D=>shuffle_out_1(65 downto 64), Q=>barreira_xbar.header_1);
  -- reg_xbar_valid_1:      entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>, Q=>barreira_xbar.valid_1);
  reg_xbar_wen_1:        entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>wen_1_int, Q=>barreira_xbar.wen_1);


  -- reg_xbar_data_2:       entity work.regnbit generic map (size=>64) port map (ck=>clock, rst=>reset, ce=>'1', D=>shuffle_out_2(63 downto 0),  Q=>barreira_xbar.data_2);
  -- reg_xbar_header_2:     entity work.regnbit generic map (size=>2)  port map (ck=>clock, rst=>reset, ce=>'1', D=>shuffle_out_2(65 downto 64), Q=>barreira_xbar.header_2);
  -- reg_xbar_valid_2:      entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>, Q=>barreira_xbar.valid_2);
  reg_xbar_wen_2:        entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>wen_2_int, Q=>barreira_xbar.wen_2);

  -- reg_xbar_data_3:       entity work.regnbit generic map (size=>64) port map (ck=>clock, rst=>reset, ce=>'1', D=>shuffle_out_3(63 downto 0),  Q=>barreira_xbar.data_3);
  -- reg_xbar_header_3:     entity work.regnbit generic map (size=>2)  port map (ck=>clock, rst=>reset, ce=>'1', D=>shuffle_out_3(65 downto 64), Q=>barreira_xbar.header_3);
  -- reg_xbar_valid_3:      entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>, Q=>barreira_xbar.valid_3);
  reg_xbar_wen_3:        entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>wen_3_int, Q=>barreira_xbar.wen_3);

  reg_read_lanes: entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>barreira_xbar.read_from_fifos, Q=>read_from_fifos_reg);

  --==============================================================================
  -- third_stage - BUFFERS
  --==============================================================================

  fifo_0 : entity work.reorder_fifo
  port map (
 				clk       	=> 	clock,
				rst_n     	=> 	reset_n,
				wen 				=> 	barreira_xbar.wen_0,
				data_in    	=> 	fifo_in_0,
				full       	=> 	full_0,
				almost_f   	=> 	almost_f_0,
        ren					=>	read_from_fifos_reg,
        data_out    =>	out_data.block_0,
        empty       =>	fifo_empty_0,
				almost_e    =>	almost_e_0
  );
  -- fifo_in_0 <= (others => '0') when barreira_skew.logical_lane_0 = "100" else
  --              barreira_bip.valid_0 & barreira_bip.header_0 & barreira_bip.data_0;
  -- fifo_in_0 <= (others => '0') when barreira_bip.valid_0 = '0' else
  --              barreira_bip.valid_0 & barreira_bip.header_0 & barreira_bip.data_0;
  -- fifo_in_0 <=  (others => '0') when val_lane_0 = '0' else
  --               '0' & barreira_bip.header_0 & barreira_bip.data_0 when barreira_bip.is_sync_0 = '1' else
  --               barreira_bip.valid_0 & barreira_bip.header_0 & barreira_bip.data_0;
  fifo_in_0 <=  (others => '0') when val_lane_0 = '0' else
                barreira_bip.is_sync_0 & barreira_bip.valid_0 & barreira_bip.header_0 & barreira_bip.data_0;

  fifo_1 : entity work.reorder_fifo
  port map (
			clk       	=> 	clock,
 			rst_n     	=> 	reset_n,
 			wen 				=> 	barreira_xbar.wen_1,
      -- wen 				=> 	fifo_wen_1,
 			data_in    	=> 	fifo_in_1,
 			full       	=> 	full_1,
 			almost_f   	=> 	almost_f_1,
      ren					=>	read_from_fifos_reg,
      data_out    =>	out_data.block_1,
      empty       =>	fifo_empty_1,
 			almost_e    =>	almost_e_1
  );
  -- fifo_in_1 <= (others => '0') when barreira_skew.logical_lane_1 = "100" else
  --               barreira_bip.valid_1 & barreira_bip.header_1 & barreira_bip.data_1;
  -- fifo_in_1 <= (others => '0') when barreira_bip.valid_1 = '0' else
  --              barreira_bip.valid_1 & barreira_bip.header_1 & barreira_bip.data_1;

  -- fifo_in_1 <= (others => '0') when val_lane_1 = '0' else
  --              barreira_bip.valid_1 & barreira_bip.header_1 & barreira_bip.data_1;
  -- fifo_in_1 <=  (others => '0') when val_lane_1 = '0' else
  --               '0' & barreira_bip.header_1 & barreira_bip.data_1 when barreira_bip.is_sync_1 = '1' else
  --               barreira_bip.valid_1 & barreira_bip.header_1 & barreira_bip.data_1;
  fifo_in_1 <=  (others => '0') when val_lane_1 = '0' else
                barreira_bip.is_sync_1 & barreira_bip.valid_1 & barreira_bip.header_1 & barreira_bip.data_1;

  fifo_2 : entity work.reorder_fifo
  port map (
 				clk       	=> 	clock,
				rst_n      	=> 	reset_n,
				wen 				=> 	barreira_xbar.wen_2,
				data_in    	=> 	fifo_in_2,
				full       	=> 	full_2,
				almost_f   	=> 	almost_f_2,
        ren					=>	read_from_fifos_reg,
        data_out    =>	out_data.block_2,
        empty       =>	fifo_empty_2,
				almost_e    =>	almost_e_2
  );
  -- fifo_in_2 <= (others => '0') when barreira_skew.logical_lane_2 = "100" else
  --              barreira_bip.valid_2 & barreira_bip.header_2 & barreira_bip.data_2;
  -- fifo_in_2 <= (others => '0') when barreira_bip.valid_2 = '0' else
  --              barreira_bip.valid_2 & barreira_bip.header_2 & barreira_bip.data_2;

  -- fifo_in_2 <= (others => '0') when val_lane_2 = '0' else
  --              barreira_bip.valid_2 & barreira_bip.header_2 & barreira_bip.data_2;
  -- fifo_in_2 <=  (others => '0') when val_lane_2 = '0' else
  --               '0' & barreira_bip.header_2 & barreira_bip.data_2 when barreira_bip.is_sync_2 = '1' else
  --               barreira_bip.valid_2 & barreira_bip.header_2 & barreira_bip.data_2;
  fifo_in_2 <=  (others => '0') when val_lane_2 = '0' else
                barreira_bip.is_sync_2 & barreira_bip.valid_2 & barreira_bip.header_2 & barreira_bip.data_2;


  fifo_3 : entity work.reorder_fifo
  port map (
 				clk       	=> 	clock,
				rst_n     	=> 	reset_n,
				wen 				=> 	barreira_xbar.wen_3,
				data_in    	=> 	fifo_in_3,
				full       	=> 	full_3,
				almost_f   	=> 	almost_f_3,
        ren					=>	read_from_fifos_reg,
        data_out    =>	out_data.block_3,
        empty       =>	fifo_empty_3,
				almost_e    =>	almost_e_3
  );
  -- fifo_in_3 <= (others => '0') when barreira_skew.logical_lane_3 = "100" else
  --              barreira_bip.valid_3 & barreira_bip.header_3 & barreira_bip.data_3;
  -- fifo_in_3 <= (others => '0') when barreira_bip.valid_3 = '0' else
  --              barreira_bip.valid_3 & barreira_bip.header_3 & barreira_bip.data_3;

  -- fifo_in_3 <= (others => '0') when val_lane_3 = '0' else
  --              barreira_bip.valid_3 & barreira_bip.header_3 & barreira_bip.data_3;

  --fifo_in_3 <=  (others => '0') when val_lane_3 = '0' else
  --              '0' & barreira_bip.header_3 & barreira_bip.data_3 when barreira_bip.is_sync_3 = '1' else
  --              barreira_bip.valid_3 & barreira_bip.header_3 & barreira_bip.data_3;

  fifo_in_3 <=  (others => '0') when val_lane_3 = '0' else
                barreira_bip.is_sync_3 & barreira_bip.valid_3 & barreira_bip.header_3 & barreira_bip.data_3;

 --==============================================================================
 -- fourth_stage - SHUFFLE NETWORK
 --==============================================================================

  shuffle_lanes: entity work.shuffle port map (
      in_0   => out_data.block_0,
      in_1   => out_data.block_1,
      in_2   => out_data.block_2,
      in_3   => out_data.block_3,
      lane_0 => (barreira_bip.logical_lane_0(1 downto 0)),
      lane_1 => (barreira_bip.logical_lane_1(1 downto 0)),
      lane_2 => (barreira_bip.logical_lane_2(1 downto 0)),
      lane_3 => (barreira_bip.logical_lane_3(1 downto 0)),
      out_0  => shuffle_out_0,
      out_1  => shuffle_out_1,
      out_2  => shuffle_out_2,
      out_3  => shuffle_out_3
  );

  reg_out_data_0:       entity work.regnbit generic map (size=>64) port map (ck=>clock, rst=>reset, ce=>'1', D=>shuffle_out_0(63 downto 0),  Q=>pcs_0_data_out);
  reg_out_header_0:     entity work.regnbit generic map (size=>2)  port map (ck=>clock, rst=>reset, ce=>'1', D=>shuffle_out_0(65 downto 64), Q=>pcs_0_header_out);
  reg_out_valid_0:      entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>shuffle_out_0(66),  Q=>pcs_0_valid_out);
  reg_out_alignment_0:  entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>shuffle_out_0(67),  Q=>pcs_0_alignment_out);

  reg_out_data_1:       entity work.regnbit generic map (size=>64) port map (ck=>clock, rst=>reset, ce=>'1', D=>shuffle_out_1(63 downto 0),  Q=>pcs_1_data_out);
  reg_out_header_1:     entity work.regnbit generic map (size=>2)  port map (ck=>clock, rst=>reset, ce=>'1', D=>shuffle_out_1(65 downto 64), Q=>pcs_1_header_out);
  reg_out_valid_1:      entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>shuffle_out_1(66),  Q=>pcs_1_valid_out);
  reg_out_alignment_1:  entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>shuffle_out_1(67),  Q=>pcs_1_alignment_out);

  reg_out_data_2:       entity work.regnbit generic map (size=>64) port map (ck=>clock, rst=>reset, ce=>'1', D=>shuffle_out_2(63 downto 0),  Q=>pcs_2_data_out);
  reg_out_header_2:     entity work.regnbit generic map (size=>2)  port map (ck=>clock, rst=>reset, ce=>'1', D=>shuffle_out_2(65 downto 64), Q=>pcs_2_header_out);
  reg_out_valid_2:      entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>shuffle_out_2(66),  Q=>pcs_2_valid_out);
  reg_out_alignment_2:  entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>shuffle_out_2(67),  Q=>pcs_2_alignment_out);

  reg_out_data_3:       entity work.regnbit generic map (size=>64) port map (ck=>clock, rst=>reset, ce=>'1', D=>shuffle_out_3(63 downto 0),  Q=>pcs_3_data_out);
  reg_out_header_3:     entity work.regnbit generic map (size=>2)  port map (ck=>clock, rst=>reset, ce=>'1', D=>shuffle_out_3(65 downto 64), Q=>pcs_3_header_out);
  reg_out_valid_3:      entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>shuffle_out_3(66),  Q=>pcs_3_valid_out);
  reg_out_alignment_3:  entity work.reg_bit port map (ck=>clock, rst=>reset, ce=>'1', D=>shuffle_out_3(67),  Q=>pcs_3_alignment_out);
end behav_lane_reorder;
