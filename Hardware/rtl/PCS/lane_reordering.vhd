library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity lane_reorder is
  port
  (
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

architecture behav of lane_reorder is
-- DEFINES
    type fsm_state is (S_INIT, S_END, S_SYNC, S_TRANSMIT);
    signal CURRENT_STATE, NEXT_STATE: fsm_state;

    function check_sync_block(data_block: in std_logic_vector(63 downto 0)) return std_logic is
    begin
       case data_block is
         when (others=>'1') => return '1';
         when (others=>'0') => return '0';
         when others => return '0';
       end case;
    end check_sync_block;  --
--

-- GENERAL
    signal lane_sync    : std_logic_vector(3 downto 0) := (others=>'0');
    signal lane_0_skew  : std_logic_vector(5 downto 0) := (others=>'0');
    signal lane_1_skew  : std_logic_vector(5 downto 0) := (others=>'0');
    signal lane_2_skew  : std_logic_vector(5 downto 0) := (others=>'0');
    signal lane_3_skew  : std_logic_vector(5 downto 0) := (others=>'0');



--

begin
    FSM_CTRL:
    process(reset, clock)
    begin
      if reset = '1' then
        CURRENT_STATE <= S_INIT;
      elsif rising_edge(clock) then
        CURRENT_STATE <= NEXT_STATE;
      end if;
    end process;

    FSM_SEQ:
    process(reset, clock)
    begin
    if reset = '1' then

    elsif rising_edge(clock) then
        case CURRENT_STATE is

            when S_INIT =>

            when S_SYNC =>
                lane_sync(0) <= check_sync_block(lane_0_data_in);
                lane_sync(1) <= check_sync_block(lane_1_data_in);
                lane_sync(2) <= check_sync_block(lane_2_data_in);
                lane_sync(3) <= check_sync_block(lane_3_data_in);

            when S_END  =>

            when others =>

        end case;
    end if;
    end process;

    FSM_COMB:
    process
    begin
        case CURRENT_STATE is

            when S_INIT =>
                if reset = '0' then
                    NEXT_STATE <= S_SYNC;
                else
                    NEXT_STATE <= CURRENT_STATE;
                end if;

            when S_SYNC =>
                if lane_sync = "1111" then
                    NEXT_STATE <= S_TRANSMIT;

                else

                end if;

            when S_END  =>

            when others =>

        end case;

    end process;
end behav;
