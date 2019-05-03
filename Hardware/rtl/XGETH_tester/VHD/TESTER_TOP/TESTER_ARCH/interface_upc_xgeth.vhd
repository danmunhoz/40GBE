--////////////////////////////////////////////////////////////////////////////////
--////                                                                        ////
--//// File name "interface_upc_xgeth.vhd                                     ////
--////                                                                        ////
--//// This file is part of "Tester X40G" project                             ////
--//// This is a legacy architecture from 10gb project refactured for 40GB    ////
--//// regbank arch added                                                     ////
--//// Author(s):                                                             ////
--//// - Matheus Lemes Ferronato                                              ////
--//// - Gabriel Susin                                                        ////
--////                                                                        ////
--///////////////////////////////////////////////////////////////////////////////

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- CrossClock
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity CrossClock_nbits is
           generic( FF_NUMBER : integer := 3;
                    DATA_SIZE : integer := 128);
           port (
              rst_n   : in std_logic;
              clk_A   : in std_logic;
              clk_B   : in std_logic;
              dataIN  : in std_logic_vector (DATA_SIZE-1 downto 0);
              dataOUT : out std_logic_vector (DATA_SIZE-1 downto 0)
         );
end CrossClock_nbits;


architecture arch_CrossClock of CrossClock_nbits is
  type ff_array is array (0 to FF_NUMBER-1) of std_logic_vector (DATA_SIZE-1 downto 0);
  signal flipflop : ff_array;

begin

dataOUT <= flipflop(FF_NUMBER-1);

  crossFlipFlops : process(clk_A,clk_B, rst_n)
    begin
      if(rst_n = '0') Then
        for i in 0 to FF_NUMBER-1 loop
          flipflop(i) <= (others=> '0');
        end loop;
      else
        if(clk_A'event and clk_A = '1') Then
          flipflop(0) <= dataIN;
        end if;
        if(clk_B'event and clk_B = '1') Then
          for i in 1 to FF_NUMBER-1 loop
            flipflop(i) <= flipflop(i-1);
          end loop;
        end if;
      end if;
  end process crossFlipFlops;
  end arch_CrossClock;

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Regs
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


library IEEE;
use IEEE.std_logic_1164.all;

entity generic_registers is
           generic( INIT_VALUE : STD_LOGIC_VECTOR(31 downto 0) := (others=>'0') );
           port(  ck, rst, ce, wen : in std_logic;
                  D : in  STD_LOGIC_VECTOR (31 downto 0);
                  Q : out STD_LOGIC_VECTOR (31 downto 0)
               );
end generic_registers;

architecture arch_generic_registers of generic_registers is
begin

  process(ck, rst)
  begin
       if rst = '0' then
              Q <= INIT_VALUE(31 downto 0);
       elsif ck'event and ck = '1' then
           if (ce and wen) = '1' then
              Q <= D;
           end if;
       end if;
  end process;

end arch_generic_registers;


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity interface_upc_xgeth is
  	port
  	(
  		clk_156					        : in std_logic;
  		clk_250                 : in std_logic;
  		reset					          : in std_logic;

      xgeth_wdata				      : in std_logic_vector(31 downto 0);
      xgeth_rdata				      : out std_logic_vector(31 downto 0);
      xgeth_waddr				      : in std_logic_vector(6 downto 0);
      xgeth_raddr				      : in std_logic_vector(6 downto 0);
      xgeth_wen				        : in std_logic;

      PKT_rx					        : in std_logic_vector(63 downto 0);
      packets_lost			      : in std_logic_vector(63 downto 0);
      latency					        : in std_logic_vector(47 downto 0);
  		RFC_end					        : in std_logic;
  		RFC_ack					        : out std_logic;
  		initialize				      : out std_logic;
  		reset_test				      : out std_logic;

  		lfsr_seed				        : out std_logic_vector(255 downto 0);
  		lfsr_polynomial			    : out std_logic_vector(1 downto 0);
  		valid_seed				      : out std_logic;

      PKT_number			  	    : out std_logic_vector(63 downto 0);
      mac_source			  	    : out std_logic_vector(47 downto 0);
      mac_destination			    : out std_logic_vector(47 downto 0);
      PKT_sequence_in			    : out std_logic_vector(31 downto 0);
      ip_source				        : out std_logic_vector(31 downto 0);
      ip_destination			    : out std_logic_vector(31 downto 0);
      IDLE_number		  		    : out std_logic_vector(15 downto 0);
      PKT_length			  	    : out std_logic_vector(15 downto 0);
      TIMEOUT_number			    : out std_logic_vector(15 downto 0);
      RFC_type		    		    : out std_logic_vector(2 downto 0);
  		PKT_type            	  : out std_logic;

	    mac_source_rx           : in std_logic_vector(47 downto 0);
	    mac_destination_rx      : in std_logic_vector(47 downto 0);
	    ip_source_rx            : in std_logic_vector(31 downto 0);
	    ip_destination_rx       : in std_logic_vector(31 downto 0);

      TX_count                : in std_logic_vector(63 downto 0);
      IDLE_count_receiver_out : in std_logic_vector(63 downto 0);
      RFC_running 		      	: in std_logic;
      linkstatus              : in std_logic;
      eth_rx_los              : in std_logic;
  		check_reduce_frame_rate	: out std_logic;
      time_stamp_flag		    	: out std_logic;
      soft_reset    	    		: out std_logic;

	    cont_error              : in std_logic_vector(63 downto 0);
      payload_cycles          : out std_logic_vector(31 downto 0);
      payload_last_size       : out std_logic_vector(7 downto 0);
      loopback_filter         : out std_logic_vector(2 downto 0);
	    payload_type            : out std_logic_vector(1 downto 0)

	);
end interface_upc_xgeth;

architecture behavioral of interface_upc_xgeth is
attribute mark_debug : string;

	type STATE_TYPE is (S_INIT, S_START_TEST, S_LOOPBACK, S_END, S_EXECUTING_LATENCY, S_EXECUTING_SYSREC, S_RESET, S_EXECUTING_TEST_RESET);
  signal CURRENT_STATE, NEXT_STATE : STATE_TYPE;

  signal PKT_number_value  	         : std_logic_vector(63 downto 0);
  signal wen                         : std_logic_vector(63 downto 0);
  signal RFC_type_250                : std_logic_vector(2 downto 0);
  signal RFC_type_156                : std_logic_vector(2 downto 0);
  signal STATUS_reg_250              : std_logic_vector(1 downto 0);
  signal STATUS_reg_156			         : std_logic_vector(1 downto 0);
  signal STATUS_reg_250_out          : std_logic_vector(1 downto 0);
  signal STATUS_reg_156_out          : std_logic_vector(1 downto 0);
  signal test_end                    : std_logic;
  signal time_stamp_flag_reg         : std_logic;
  signal check_reduce_frame_rate_reg : std_logic;

  type regnbits_out is array (0 to 28) of std_logic_vector(31 downto 0);
  signal registers_q_out: regnbits_out;

  signal crossClock_buffer_250_in    : std_logic_vector(4 downto 0);
  signal crossClock_buffer_156_in    : std_logic_vector(4 downto 0);
  signal crossClock_buffer_250_out    : std_logic_vector(4 downto 0);
  signal crossClock_buffer_156_out    : std_logic_vector(4 downto 0);


  component CrossClockDomain port(
      clkA: in std_logic;
      clkB: in std_logic;
      SignalIn_clkA : in std_logic;
      SignalOut_clkB : out std_logic
  );
  end component;

begin

  ---------------------------------------------------------------------------------------
    -- Register Bank
   ---------------------------------------------------------------------------------------

  reg_bank: for i in 0 to 28 generate
        registers: entity work.generic_registers port map(ck=>clk_250, rst=>reset, ce=>xgeth_wen, wen=>wen(i), D=>xgeth_wdata, Q=>registers_q_out(i));
  end generate reg_bank;

   decoder: process(xgeth_waddr)
   begin
     wen <= (others => '0');
      for i in 0 to 28 loop
        if i = to_integer(unsigned(xgeth_waddr)) then
          wen(i) <= '1';
        else
          wen(i) <= '0';
        end if;
      end loop;
   end process;

   xgeth_rdata <= registers_q_out(to_integer(unsigned(xgeth_raddr)));

   	---------------------------------------------------------------------------------------
     	-- FSM implementation
     ---------------------------------------------------------------------------------------

   	next_updater: process(CURRENT_STATE, STATUS_reg_156, RFC_end, RFC_type_156, test_end, RFC_running, time_stamp_flag_reg, check_reduce_frame_rate_reg)
   	begin
   		valid_seed <= '0';
   		NEXT_STATE <= CURRENT_STATE;
   		case CURRENT_STATE is
   			when S_INIT =>
   				if(RFC_end = '1') then
   					NEXT_STATE <= S_END;
   				elsif(STATUS_reg_156 = 3) then
   					NEXT_STATE <= S_RESET;	-- comando de reset vindo do software
          elsif(STATUS_reg_156 = 1) then
            if(RFC_type_156 = 3) then
   					  NEXT_STATE <= S_LOOPBACK;
   				  elsif(test_end = '0' and RFC_running = '0') then
   					  NEXT_STATE <= S_START_TEST;
            end if;
          elsif(STATUS_reg_156 = 2) then
            if(RFC_type_156 = 1 and time_stamp_flag_reg = '0') then -- envia timestamp
   					  NEXT_STATE <= S_EXECUTING_LATENCY;
   				  elsif(RFC_type_156 = 2 and check_reduce_frame_rate_reg = '0') then
   					NEXT_STATE <= S_EXECUTING_SYSREC;
            end if;
   				end if;
   			when S_START_TEST =>
   				valid_seed <= '1';
   				NEXT_STATE <= S_INIT;
   			when S_EXECUTING_LATENCY => NEXT_STATE <= S_INIT;
   			when S_EXECUTING_SYSREC => NEXT_STATE <= S_INIT;
   			when S_EXECUTING_TEST_RESET => NEXT_STATE <= S_INIT;
   			when S_RESET =>
   				if(STATUS_reg_156 = 0) then
   					NEXT_STATE <= S_INIT;
   				end if;
   			when S_LOOPBACK => NEXT_STATE <= S_INIT;
   			when S_END => NEXT_STATE <= S_INIT;
   		end case;
   end process;

  current_updater: process(clk_156,reset)
	begin
		if(reset = '0') then
      CURRENT_STATE               <= S_INIT;
			PKT_type				            <= '0';
			check_reduce_frame_rate_reg <= '0';
			time_stamp_flag_reg		      <= '0';
			STATUS_reg_156_out          <= "00";
			test_end 			              <= '0';
		elsif rising_edge(clk_156) then
      CURRENT_STATE <= NEXT_STATE;
			case CURRENT_STATE is
				when S_INIT =>
				    null;
				when S_START_TEST =>
					PKT_type	<= '0';
          test_end <= '1';
					STATUS_reg_156_out <= "01";
				when S_LOOPBACK =>
					PKT_type	<= '1';
					test_end <= '1';
					STATUS_reg_156_out <= "01";
				when S_EXECUTING_LATENCY =>
					time_stamp_flag_reg <= '1';
					STATUS_reg_156_out <= "01";
				when S_EXECUTING_SYSREC =>
					check_reduce_frame_rate_reg <= '1';
					STATUS_reg_156_out <= "01";
				when S_EXECUTING_TEST_RESET =>
					STATUS_reg_156_out <= "01";
				when S_END =>
						STATUS_reg_156_out <= "00";
						test_end <= '1';
				when S_RESET =>
					STATUS_reg_156_out			    <= "00";
          test_end 			              <= '0';
          PKT_type                    <= '0';
          check_reduce_frame_rate_reg <= '0';
          time_stamp_flag_reg         <= '0';
				when others =>
					null;
			end case;
		end if;
	end process;


	---------------------------------------------------------------------------------------
  	-- registers
  ---------------------------------------------------------------------------------------
  PKT_number <= TX_count when RFC_type_156 = 1 or RFC_type_156 = 2 or RFC_type_156 = 3 else PKT_number_value;
  soft_reset <= '0' when CURRENT_STATE = S_RESET else '1';
  initialize <= '1' when CURRENT_STATE = S_START_TEST else '0';
  RFC_ack    <= '1' when CURRENT_STATE = S_END else '0';
  RFC_type 	 <= RFC_type_156;

	STATUS_reg_250(1 downto 0)          <= registers_q_out(0)(1 downto 0);
	RFC_type_250(2 downto 0)            <= registers_q_out(1)(2 downto 0);
	PKT_length(15 downto 0)             <= registers_q_out(2)(15 downto 0);
	IDLE_number(15 downto 0)            <= registers_q_out(3)(15 downto 0);
	PKT_number_value(31 downto 0)       <= registers_q_out(4);
	PKT_number_value(63 downto 32)      <= registers_q_out(5);
	payload_type               			    <= registers_q_out(6)(1 downto 0);
	mac_source(47 downto 16)            <= registers_q_out(7);
	mac_source(15 downto 0)             <= registers_q_out(8)(15 downto 0);
	mac_destination(47 downto 16)       <= registers_q_out(9);
	mac_destination(15 downto 0)        <= registers_q_out(10)(15 downto 0);
	ip_source(31 downto 0)   		        <= registers_q_out(11)(31 downto 0);
	ip_destination(31 downto 0)   	    <= registers_q_out(12);
	TIMEOUT_number(15 downto 0)       	<= registers_q_out(13)(15 downto 0);
	PKT_sequence_in                   	<= registers_q_out(14);
  seed : for i in 1 to 8 generate
    lfsr_seed(((i* 32)-1) downto ((i-1 )* 32)) <= registers_q_out(15+(i-1))(31 downto 0);
  end generate;
  lfsr_polynomial(1 downto 0)			    <= registers_q_out(24)(1 downto 0);
  payload_cycles(31 downto 0)         <= registers_q_out(25);
  loopback_filter                     <= registers_q_out(26)(2 downto 0);
  reset_test						              <= registers_q_out(27)(0);
  payload_last_size(7 downto 0)       <= registers_q_out(28)(7 downto 0);

  time_stamp_flag                     <= time_stamp_flag_reg;
  check_reduce_frame_rate             <= check_reduce_frame_rate_reg;


  	---------------------------------------------------------------------------------------
    	-- CrossClock
    ---------------------------------------------------------------------------------------

    crossClock_buffer_250_in(0)  <= STATUS_reg_250(0);
    crossClock_buffer_250_in(1)  <= STATUS_reg_250(1);
    crossClock_buffer_250_in(2)  <= RFC_type_250(0);
    crossClock_buffer_250_in(3)  <= RFC_type_250(1);
    crossClock_buffer_250_in(4)  <= RFC_type_250(2);

    crossClock_buffer_156_in(0) <= STATUS_reg_156_out(0);
    crossClock_buffer_156_in(1) <= STATUS_reg_156_out(1);
    crossClock_buffer_156_in(4 downto 2) <= (others => '0');

    STATUS_reg_156(0) <= crossClock_buffer_156_out(0);
    STATUS_reg_156(1) <= crossClock_buffer_156_out(1);
    RFC_type_156(0) <= crossClock_buffer_156_out(2);
    RFC_type_156(1) <= crossClock_buffer_156_out(3);
    RFC_type_156(2) <= crossClock_buffer_156_out(4);

    STATUS_reg_250_out(0) <= crossClock_buffer_250_out(0);
    STATUS_reg_250_out(1) <= crossClock_buffer_250_out(1);

    clock_250_in : entity work.CrossClock_nbits
      generic map (FF_NUMBER => 3,
                   DATA_SIZE => 5)
      port map(
          rst_n          => reset,
          clk_A          => clk_250,
          clk_B          => clk_156,
          DATAIN         => crossClock_buffer_250_in,
          DATAOUT        => crossClock_buffer_156_out
      );

      clock_156_in : entity work.CrossClock_nbits
        generic map (FF_NUMBER => 3,
                     DATA_SIZE => 5)
        port map(
            rst_n          => reset,
            clk_A          => clk_156,
            clk_B          => clk_250,
            DATAIN         => crossClock_buffer_156_in,
            DATAOUT        => crossClock_buffer_250_out
        );

end behavioral;
