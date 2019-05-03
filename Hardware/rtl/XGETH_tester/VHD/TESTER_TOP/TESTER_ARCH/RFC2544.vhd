library IEEE;
use IEEE.std_logic_1164.all;
--use IEEE.std_logic_arith.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity RFC2544 is
    port
    (

        -- STANDARD INPUTS
        clock                 : in std_logic;                         -- Clock 156.25 MHz
        reset                 : in std_logic;                         -- Reset (Active Low)
        initialize            : in std_logic;                         -- Enable the test (Active High)

        RFC_type              : in std_logic_vector(2 downto 0);      -- Test code
        IDLE_number           : in std_logic_vector(15 downto 0);     -- Number of cycles in idle between packets
        IDLE_count_receiver   : in std_logic_vector(63 downto 0);
        TIMEOUT_number        : in std_logic_vector(15 downto 0);     -- Number of cycles to reach timeout
        PKT_number            : in std_logic_vector(63 downto 0);     -- Number of packets that will be send

        -- FROM Receiver
        PKT_timestamp         : in std_logic_vector(47 downto 0);     -- Timestamp of latency packet
        PKT_timestamp_val     : in std_logic;                         -- Indicates valid timestamp
        PKT_sequence_error    : in std_logic;                         -- Indicates whether the UUT is losing packets
        PKT_sequence_error_flag: in std_logic;

        RESET_done			      : in std_logic;						  -- Indicates the reset test is done

        -- TO Generator and Receiver
        timestamp_base        : out std_logic_vector(47 downto 0);    -- Timestamp base reference for echo generator and receiver

        -- FROM MAC
        PKT_TX_EOP            : in std_logic;                         -- End of PKT by TX
        PKT_RX_EOP            : in std_logic;                         -- End of PKT by RX

        latency               : out std_logic_vector(47 downto 0);    -- Calculated latency from timestamp
        verify_system_rec     : out std_logic;                        -- Indicates that the system recovery test reduced the frame rate
        PKT_rx                : out std_logic_vector(63 downto 0);    -- Number of received packets
        PKT_gen               : out std_logic;                        -- Enable packet generation (Active High)
        --PKT_timestamp_flag    : out std_logic;                        -- Enable timestamp generation (Active High)
        RFC_end               : out std_logic;                        -- Indicates end of the test (Active High)
        RFC_ack               : in std_logic;                         -- Indicates that the uPC acknowledges the end of the test
        --reset_lua             : in std_logic;
        RFC_running            : out std_logic;                         -- Informes the test is running
        check_reduce_frame_rate : in std_logic;
        TX_count                : out std_logic_vector(63 downto 0);
        echo_received_packet    : in std_logic;
        payload_last_size       : in std_logic_vector(7 downto 0);
        IDLE_count_receiver_out : out std_logic_vector(63 downto 0)
    );
end RFC2544;

architecture behavioral of RFC2544 is

    ---------------------------------------------------------------------------------------------------------

    type STATE_TYPE is (S_INIT, S_START, S_WRITE, S_TIMEOUT, S_IDLE_GENERATOR, S_ERROR, S_TRANSMISSION, S_EVALUATE, S_END, S_ACK, S_REDUCE_FRAMERATE);
    signal CURRENT_STATE, NEXT_STATE : STATE_TYPE;

    signal IDLE_count             : integer range 0 to (2**16-1)  := 0;
    signal PKT_count              : std_logic_vector(63 downto 0) := (others=>'0');
    signal time_to_recover        : std_logic_vector(47 downto 0) := (others=>'0');
    signal time_to_recover_aux    : std_logic_vector(47 downto 0) := (others=>'0');
    signal verify_system_rec_int  : std_logic := '0';
    signal TX_count_reg           : std_logic_vector(63 downto 0);

    signal RX_count               : std_logic_vector(63 downto 0);
    signal TIMEOUT_count          : integer range 0 to (2**16-1) := 0;
    signal TIMEOUT_check          : std_logic := '0';

    signal timestamp_cont         : std_logic_vector(47 downto 0) := (others=>'0');

    signal RFC_running_reg        : std_logic;
    signal latency_ready          : std_logic;
    signal maisum                 : std_logic := '1'; --used to max transfer rate with 1 IDLE.
    signal cont                   : std_logic_vector(4 downto 0);
    signal payload_last_size64b   : std_logic_vector(6 downto 0);

    signal  start_tx_begin_delay : std_logic;
begin

  ---------------------------------------------------------------------------------------
  -- FSM implementation
  ---------------------------------------------------------------------------------------

--DEBUG STUFF
  timestamp_base <= x"000000000001";
  verify_system_rec <= '0';
  start_tx_begin_delay <= '0','1' after 5000 ns;
  start_gen : process
  begin
      wait until start_tx_begin_delay = '1';
      while 1 = 1 loop
        PKT_gen <= '0';
      wait for 135 ns;
        PKT_gen <= '1';
      wait until pkt_tx_eop = '0';
        PKT_gen <= '0';
      end loop;
  end process;

    --
    -- payload_last_size64b <= payload_last_size(6 downto 0);
    -- PKT_gen                 <= '1' when NEXT_STATE = S_START else '0';
    -- RFC_end                 <= '1' when CURRENT_STATE = S_END else '0';
    -- TIMEOUT_check           <= '1' when (PKT_number = RX_count and RFC_type =  0) else '0';
    -- verify_system_rec       <= verify_system_rec_int;
    -- PKT_rx <= RX_count;
    -- timestamp_base <= timestamp_cont;
    -- TX_count <= TX_count_reg;
    -- RFC_running  <= '0' when NEXT_STATE = S_INIT else '1';
    --
    -- next_updater: process (initialize, RFC_type, CURRENT_STATE, check_reduce_frame_rate, PKT_count, IDLE_count, TIMEOUT_count, PKT_TX_EOP, TIMEOUT_check, RFC_ack, verify_system_rec_int, latency_ready, PKT_sequence_error, RESET_done)
    -- begin
    --     NEXT_STATE <= CURRENT_STATE;
    --     case CURRENT_STATE is -- inicial state
    --         when S_INIT => -- initiates test
    --             if(initialize = '1') then NEXT_STATE <= S_START; end if;
    --         when S_START =>
    --             NEXT_STATE <= S_EVALUATE;
    --         when S_EVALUATE =>
    --             if (RFC_type = 0 and PKT_count = 1) or (RFC_type = 1 and latency_ready='1') or
    --                (RFC_type = 2 and verify_system_rec_int = '1' and PKT_sequence_error = '0') or
    --                (RFC_type = 4 and RESET_done = '1')  then
    --                 NEXT_STATE <= S_TIMEOUT;
    --             elsif (RFC_type = 2 and check_reduce_frame_rate = '1' and verify_system_rec_int = '0') then
    --                  NEXT_STATE <= S_REDUCE_FRAMERATE;
    --             else NEXT_STATE <= S_TRANSMISSION;
    --             end if;
    --       when S_TRANSMISSION => -- trasmits packet
    --           if(PKT_TX_EOP = '1') then NEXT_STATE <= S_IDLE_GENERATOR;
    --           else NEXT_STATE <= CURRENT_STATE; end if;
    --         when S_IDLE_GENERATOR => -- generate idle cycles
    --             if(IDLE_count < 2) then NEXT_STATE <= S_START;
    --             else NEXT_STATE <= CURRENT_STATE; end if;
    --         when S_TIMEOUT => -- timeout state. hold until all packet are received or timeout_count = TIMEOUT_number (input)
    --             if(TIMEOUT_count = 1 or TIMEOUT_check = '1') then NEXT_STATE <= S_END;-- if occured a timeout or all packets were received, go to write state
    --             else NEXT_STATE <= CURRENT_STATE;
    --             end if;
    --         when S_REDUCE_FRAMERATE =>
    --             if(PKT_TX_EOP = '1') then NEXT_STATE <= S_IDLE_GENERATOR;
    --             else NEXT_STATE <= CURRENT_STATE;
    --             end if;
    --         when S_END =>
    --           if(RFC_ack = '1') then NEXT_STATE <= S_INIT;
    --           else NEXT_STATE <= CURRENT_STATE;
    --         end if;
    --         when others => -- ERROR! Something is wrong!
    --             NEXT_STATE <= S_INIT;
    --     end case;
    -- end process;
    --
    --
    --
    --   current_updater: process(clock,reset)
    --   begin
    --
    --       if(reset = '0') then
    --           PKT_count <= (others=> '0');
    --           TIMEOUT_count <= 0;
    --           IDLE_count            <= 0;
    --           latency               <= (others=>'0');
    --           verify_system_rec_int <= '0';
    --           latency_ready         <= '0';
    --           timestamp_cont <= (others=>'0');
    --           time_to_recover <= (others => '0');
    --           time_to_recover_aux <= (others => '0');
    --           IDLE_count_receiver_out <= (others=>'0');
    --           maisum <= '0';
    --           RX_count <= (others=>'0');
    --           TX_count_reg <= (others=>'0');
    --           cont <= (others=>'0');
    --
    --       elsif rising_edge(clock) then
    --          -- RFC_end <= '0';
    --           timestamp_cont <= timestamp_cont + '1';
    --
    --           case CURRENT_STATE is
    --               when S_INIT =>
    --                   PKT_count             <= PKT_number;
    --                   TIMEOUT_count         <= to_integer(unsigned(TIMEOUT_number));
    --                   verify_system_rec_int <= '0';
    --                   IDLE_count            <= to_integer(unsigned(IDLE_number));
    --                   timestamp_cont <= (others=>'0');
    --
    --               when S_TIMEOUT =>
    --                   if(TIMEOUT_check = '1' or TIMEOUT_count = 1) then
    --                       IDLE_count_receiver_out <= IDLE_count_receiver;
    --                       TIMEOUT_count <= TIMEOUT_count;
    --                   else
    --                       TIMEOUT_count <= TIMEOUT_count - 1;
    --                       IDLE_count_receiver_out <= (others=>'0');
    --                   end if;
    --
    --               when S_IDLE_GENERATOR =>
    --                   if payload_last_size64b = 0 then
    --                       if IDLE_count = 1 and IDLE_number = 1 then
    --                           IDLE_count <= 2;
    --                       elsif IDLE_count = 1 then
    --                           IDLE_count <= to_integer(unsigned(IDLE_number));
    --                       else
    --                           IDLE_count <= IDLE_count - 1;
    --                       end if;
    --                   elsif payload_last_size64b = 8 then
    --                       if IDLE_count = 1 then
    --                           if cont < 7 then
    --                              cont <= cont + '1';
    --                              IDLE_count <= to_integer(unsigned(IDLE_number));
    --                           else
    --                               if IDLE_number = 1 then
    --                                   IDLE_count <= 2;
    --                               else
    --                                   IDLE_count <= to_integer(unsigned(IDLE_number));
    --                               end if;
    --                              cont <= (others=>'0');
    --                           end if;
    --                       else
    --                           IDLE_count <= IDLE_count - 1;
    --                       end if;
    --                   elsif payload_last_size64b = 16 then
    --                       if IDLE_count = 1 then
    --                           if cont < 3 then
    --                              cont <= cont + '1';
    --                              IDLE_count <= to_integer(unsigned(IDLE_number));
    --                           else
    --                               if IDLE_number = 1 then
    --                                   IDLE_count <= 2;
    --                               else
    --                                   IDLE_count <= to_integer(unsigned(IDLE_number));
    --                               end if;
    --                              cont <= (others=>'0');
    --                           end if;
    --                       else
    --                           IDLE_count <= IDLE_count - 1;
    --                       end if;
    --                   elsif payload_last_size64b = 24 then
    --                       if IDLE_count = 1 then
    --                           if cont < 7 then
    --                              cont <= cont + '1';
    --                              IDLE_count <= to_integer(unsigned(IDLE_number));
    --                           else
    --                               if IDLE_number = 1 then
    --                                   IDLE_count <= 4;
    --                               else
    --                                   IDLE_count <= to_integer(unsigned(IDLE_number));
    --                               end if;
    --                              cont <= (others=>'0');
    --                           end if;
    --                       else
    --                           IDLE_count <= IDLE_count - 1;
    --                       end if;
    --                   elsif payload_last_size64b = 32 then
    --                       if IDLE_count = 1 and IDLE_number = 1 then
    --                           if(maisum = '1') then
    --                              maisum <= '0';
    --                              IDLE_count <= to_integer(unsigned(IDLE_number) + 1);
    --                           else
    --                              maisum <= '1';
    --                              IDLE_count <= to_integer(unsigned(IDLE_number));
    --                           end if;
    --                       elsif IDLE_count = 1 then
    --                           IDLE_count <= to_integer(unsigned(IDLE_number));
    --                       else
    --                           IDLE_count <= IDLE_count - 1;
    --                       end if;
    --                   elsif payload_last_size64b = 40 then
    --                       if IDLE_count <= 1 then
    --                           if cont < 7 then
    --                               cont <= cont + '1';
    --                               if IDLE_number = 1 then
    --                                   IDLE_count <= 1;
    --                               else
    --                                   IDLE_count <= to_integer(unsigned(IDLE_number));
    --                               end if;
    --                           else
    --                               if IDLE_number = 1 then
    --                                   IDLE_count <= 6;
    --                               else
    --                                   IDLE_count <= to_integer(unsigned(IDLE_number));
    --                               end if;
    --                               cont <= (others=>'0');
    --                           end if;
    --                       else
    --                           IDLE_count <= IDLE_count - 1;
    --                       end if;
    --                   elsif payload_last_size64b = 48 then
    --                       if IDLE_count = 1 then
    --                           if cont < 3 then
    --                               cont <= cont + '1';
    --                               if IDLE_number = 1 then
    --                                   IDLE_count <= 2;
    --                               else
    --                                   IDLE_count <= to_integer(unsigned(IDLE_number));
    --                               end if;
    --                           else
    --                               IDLE_count <= to_integer(unsigned(IDLE_number));
    --                               cont <= (others=>'0');
    --                           end if;
    --                       else
    --                           IDLE_count <= IDLE_count - 1;
    --                       end if;
    --                   elsif payload_last_size64b = 56 then
    --                       if IDLE_count = 1 then
    --                           if cont < 7 then
    --                               cont <= cont + '1';
    --                               if IDLE_number = 1 then
    --                                   IDLE_count <= 2;
    --                               else
    --                                   IDLE_count <= to_integer(unsigned(IDLE_number));
    --                               end if;
    --                           else
    --                               IDLE_count <= to_integer(unsigned(IDLE_number));
    --                               cont <= (others=>'0');
    --                           end if;
    --                       else
    --                           IDLE_count <= IDLE_count - 1;
    --                       end if;
    --                   end if;
    --               when S_TRANSMISSION =>
    --                   null;
    --               when S_REDUCE_FRAMERATE =>
    --                   verify_system_rec_int <= '1';
    --
    --               when S_END =>
    --                  -- RFC_end <= '1';
    --
    --
    --               when others =>
    --                   null;
    --           end case;
    --
    --           if(PKT_TX_EOP = '1') then
    --                TX_count_reg <= TX_count_reg + 1;
    --                if RFC_type = 0  then
    --                   if(PKT_count = 1) then
    --                       PKT_count <= PKT_number;
    --                   else
    --                       PKT_count <= PKT_count - 1;
    --                   end if;
    --                end if ;
    --           end if;
    --
    --            if(echo_received_packet = '1') then
    --               RX_count <= RX_count + 1;
    --            end if;
    --
    --            if initialize = '1' then
    --                RX_count <= (others=>'0');
    --                TX_count_reg <= (others=>'0');
    --            end if ;
    --
    --            if((verify_system_rec_int = '1') and (PKT_sequence_error = '0')) then
    --                latency <= time_to_recover_aux;
    --            elsif(PKT_timestamp_val = '1') then
    --                latency <= PKT_timestamp;
    --                latency_ready <= '1';
    --            end if;
    --            if(verify_system_rec_int = '0') then
    --                 time_to_recover     <= (others=>'0');
    --                 time_to_recover_aux <= (others=>'0');
    --            elsif((verify_system_rec_int = '1') and (PKT_sequence_error = '1')) then
    --                 time_to_recover <= time_to_recover + '1';
    --            end if;
    --            if((verify_system_rec_int = '1') and (PKT_sequence_error = '1') and (PKT_sequence_error_flag = '1')) then
    --                 time_to_recover_aux <= time_to_recover;
    --            end if;
    --       end if;
    --   end process;

end behavioral;
