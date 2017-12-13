library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use ieee.std_logic_unsigned.all;
  --use work.mac_defs.all;

entity fault_sm_rx is
  port (
    --INPUTS
    clk_xgmii_rx          : in std_logic;
    reset_xgmii_rx_n      : in std_logic;

    local_fault_msg_det   : in std_logic_vector(1 downto 0);
    remote_fault_msg_det  : in std_logic_vector(1 downto 0);
    --OUTPUTS
    status_local_fault_crx    : out std_logic;
    status_remote_fault_crx   : out std_logic
  );
end entity;


architecture behav_fault of fault_sm_rx is
  --Beginning of automatic regs (for this module's undeclared outputs)
  signal reg_status_local_fault_crx   : std_logic := '0';
  signal reg_status_remote_fault_crx  : std_logic := '0';

  signal col_cnt        : std_logic_vector(7 downto 0);
  signal fault_sequence : std_logic_vector(1 downto 0);
  signal last_seq_type  : std_logic_vector(1 downto 0);
  signal link_fault     : std_logic_vector(1 downto 0);
  signal seq_cnt        : std_logic_vector(2 downto 0);
  signal seq_type       : std_logic_vector(1 downto 0);
  signal seq_add        : std_logic_vector(1 downto 0);

  -- CONSTANTS
  constant LINK_FAULT_OK      : std_logic_vector(1 downto 0) := "00";
  constant LINK_FAULT_LOCAL   : std_logic_vector(1 downto 0) := "01";
  constant LINK_FAULT_REMOTE  : std_logic_vector(1 downto 0) := "10";

  type state_type is (SM_INIT, SM_COUNT, SM_FAULT, SM_NEW_FAULT);
  signal current_state :state_type;


  begin

  DETEC_FAULT:process(local_fault_msg_det,remote_fault_msg_det)
  begin

      ---
      -- Fault indication. Indicate remote or local fault
      fault_sequence <= local_fault_msg_det or remote_fault_msg_det;
      ---
      -- Sequence type, local, remote, or ok
      if local_fault_msg_det(1) = '1' or local_fault_msg_det(0) = '1' then
          seq_type <= LINK_FAULT_LOCAL;

      elsif remote_fault_msg_det(1) = '1' or remote_fault_msg_det(0) = '1' then
          seq_type <= LINK_FAULT_REMOTE;

      else
          seq_type <= LINK_FAULT_OK;
      end if;

      ---
      -- Adder for number of faults, if detected in lower 4 lanes and
      -- upper 4 lanes, add 2. That's because we process 64-bit at a time
      -- instead of typically 32-bit xgmii.
      if remote_fault_msg_det(1) = '1' or remote_fault_msg_det(0) = '1' then
          seq_add(0) <= remote_fault_msg_det(1) xor remote_fault_msg_det(0);
          seq_add(1) <= remote_fault_msg_det(1) and remote_fault_msg_det(0);
      else
          seq_add(0) <= local_fault_msg_det(1) xor local_fault_msg_det(0);
          seq_add(1) <= local_fault_msg_det(1) and local_fault_msg_det(0);
      end if;

  end process DETEC_FAULT;


  UPDATE_OUT: process (clk_xgmii_rx, reset_xgmii_rx_n)
  begin

    if (reset_xgmii_rx_n = '0') then    -- Reset
      reg_status_local_fault_crx  <= '0';
      reg_status_remote_fault_crx <= '0';

    else

      ---
      -- Status signal to generate local/remote fault interrupts
      if ((current_state = SM_FAULT) and (link_fault = LINK_FAULT_LOCAL)) then
        reg_status_local_fault_crx  <=  '1';
      else
        reg_status_local_fault_crx  <=  '0';
      end if;

      if ((current_state = SM_FAULT) and (link_fault = LINK_FAULT_REMOTE)) then
        reg_status_remote_fault_crx  <=  '1';
      else
        reg_status_remote_fault_crx  <=  '0';
      end if;

    end if; -- reset
  end process UPDATE_OUT;

  status_local_fault_crx  <= reg_status_local_fault_crx;
  status_remote_fault_crx <= reg_status_remote_fault_crx;


  FSM_PROCESS: process (clk_xgmii_rx, reset_xgmii_rx_n)
  begin

    if (reset_xgmii_rx_n = '0') then    -- Reset
      current_state <= SM_INIT;
      col_cnt <= x"00";                    --8'b0;
      last_seq_type <= LINK_FAULT_OK;      --`LINK_FAULT_OK;
      link_fault <= LINK_FAULT_OK;         --`LINK_FAULT_OK;
      seq_cnt <= "000";                    -- 3'b0;

    else
      if (clk_xgmii_rx' event and clk_xgmii_rx='1') then

        case current_state is

          when SM_INIT =>
              last_seq_type <= seq_type;
              if fault_sequence(1) = '1' or fault_sequence(0) = '1' then
                -- If a fault is detected, capture the type of
                -- fault and start column counter. We need 4 fault
                -- messages in 128 columns to accept the fault.
                if (fault_sequence(0) /= '0') then
                  col_cnt <= x"02";

                else
                  col_cnt <= x"01";
                end if;
                seq_cnt <= '0' & seq_add;
                current_state <= SM_COUNT;

              else
                -- If no faults, stay in INIT and clear counters
                col_cnt <= (others => '0');
                seq_cnt <= (others => '0');
              end if; -- fault_sequence


          when SM_COUNT =>
              col_cnt <= col_cnt + 2;
              seq_cnt <= seq_cnt + ('0'& seq_add);
              if (fault_sequence(0)='0' and col_cnt >= x"7F") then -- >= 127
                -- No new fault in lower lanes and almost
                -- reached the 128 columns count, abort fault.
                current_state <= SM_INIT;

              elsif (col_cnt > x"7F") then
                -- Reached the 128 columns count, abort fault.
                current_state <= SM_INIT;

              elsif fault_sequence(0) = '1' or fault_sequence(1) = '1' then
                -- If fault type has changed, move to NEW_FAULT.
                -- If not, after detecting 4 fault messages move to
                -- FAULT state.
                if ( seq_type /= last_seq_type) then
                  current_state <= SM_NEW_FAULT;

                else
                  if ( (seq_cnt + '1'&seq_add) > 3) then
                    col_cnt <= x"00";
                    link_fault <= seq_type;
                    current_state <= SM_FAULT;
                  end if;
                end if; -- end   if ( seq_type /= last_seq_type) then
              end if; -- end    if (! fault_sequence(0) && col_cnt >= 127) then


          when SM_FAULT =>
              col_cnt <= col_cnt + 2;
              if ( fault_sequence(0) = '0' and col_cnt >= x"7F" ) then
                -- No new fault in lower lanes and almost
                -- reached the 128 columns count, abort fault.
                current_state <= SM_INIT;

              elsif ( col_cnt > 127 ) then
                -- Reached the 128 columns count, abort fault.
                current_state <= SM_INIT;

              elsif fault_sequence(0) = '1' or fault_sequence(1) = '1' then
                -- Clear the column count each time we see a fault,
                -- if fault changes, go no next state.
                col_cnt <= x"00";

                if ( seq_type /= last_seq_type ) then
                  current_state <= SM_NEW_FAULT;
                end if;
              end if;


          when SM_NEW_FAULT =>
              -- Capture new fault type. Start counters.
              col_cnt <= x"00";
              last_seq_type <= seq_type;
              seq_cnt <= '1' & seq_add;
              current_state <= SM_COUNT;

          when others => null;

        end case; -- FSM
      end if; -- Borda de clock
    end if; -- Reset

  end process FSM_PROCESS;




end behav_fault;
