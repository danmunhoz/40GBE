--////////////////////////////////////////////////////////////////////////
--////                                                                ////
--//// File name "interface_upc_xgeth.vhd                             ////
--////                                                                ////
--//// This file is part of "Testset X40G" project                    ////
--////                                                                ////
--//// Author(s):                                                     ////
--//// - Matheus Lemes Ferronato                                      ////
--//// - Gabriel Susin                                                ////
--////                                                                ////
--////////////////////////////////////////////////////////////////////////

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

  		xgeth_waddr				      : in std_logic_vector(6 downto 0);
  		xgeth_raddr				      : in std_logic_vector(6 downto 0);
  		xgeth_wdata				      : in std_logic_vector(31 downto 0);
  		xgeth_wen				        : in std_logic;
  		xgeth_rdata				      : out std_logic_vector(31 downto 0);

  		RFC_end					        : in std_logic;
  		PKT_rx					        : in std_logic_vector(63 downto 0);
  		latency					        : in std_logic_vector(47 downto 0);
  		packets_lost			      : in std_logic_vector(63 downto 0);
  		RFC_ack					        : out std_logic;

  		initialize				      : out std_logic;
  		reset_test				      : out std_logic;

  		lfsr_seed				        : out std_logic_vector(63 downto 0);
  		lfsr_polynomial			    : out std_logic_vector(1 downto 0);
  		valid_seed				      : out std_logic;

  		PKT_type            	  : out std_logic;
  		RFC_type		    		    : out std_logic_vector(2 downto 0);
  		IDLE_number		  		    : out std_logic_vector(15 downto 0);
  		PKT_length			  	    : out std_logic_vector(15 downto 0);
  		PKT_number			  	    : out std_logic_vector(63 downto 0);
  		TIMEOUT_number			    : out std_logic_vector(15 downto 0);
  		PKT_sequence_in			    : out std_logic_vector(31 downto 0);
  		mac_source			  	    : out std_logic_vector(47 downto 0);
  		mac_destination			    : out std_logic_vector(47 downto 0);
  		ip_source				        : out std_logic_vector(31 downto 0);
  		ip_destination			    : out std_logic_vector(31 downto 0);

	    mac_source_rx           : in std_logic_vector(47 downto 0);
	    mac_destination_rx      : in std_logic_vector(47 downto 0);
	    ip_source_rx            : in std_logic_vector(31 downto 0);
	    ip_destination_rx       : in std_logic_vector(31 downto 0);

  		soft_reset    	    		: out std_logic;
  		RFC_running 		      	: in std_logic;
  		time_stamp_flag		    	: out std_logic;
  		check_reduce_frame_rate	: out std_logic;
  		TX_count                : in std_logic_vector(63 downto 0);
  		linkstatus              : in std_logic;
  		eth_rx_los              : in std_logic;
  		IDLE_count_receiver_out : in std_logic_vector(63 downto 0);

	    cont_error              : in std_logic_vector(63 downto 0);
	    payload_type            : out std_logic_vector(1 downto 0);
	  	payload_cycles          : out std_logic_vector(31 downto 0);
		  loopback_filter         : out std_logic_vector(2 downto 0)

	);
end interface_upc_xgeth;

architecture behavioral of interface_upc_xgeth is
attribute mark_debug : string;

	type STATE_TYPE is (S_INIT, S_START_TEST, S_LOOPBACK, S_END, S_EXECUTING_LATENCY, S_EXECUTING_SYSREC, S_RESET, S_EXECUTING_TEST_RESET);
  signal CURRENT_STATE, NEXT_STATE : STATE_TYPE;

  signal raddr 					             : std_logic_vector(6 downto 0) 	:= (others=>'0');

  signal STATUS_reg_250              : std_logic_vector(1 downto 0) := (others=>'0');
  signal STATUS_reg_156			         : std_logic_vector(1 downto 0) := (others=>'0');
  signal STATUS_reg_250_out          : std_logic_vector(1 downto 0) := (others=>'0');
  signal STATUS_reg_156_out          : std_logic_vector(1 downto 0) := (others=>'0');

  signal RFC_type_250, RFC_type_156  : std_logic_vector(2 downto 0) 	:= (others=>'0');
	signal IDLE_number_reg			       : std_logic_vector(15 downto 0) := (others=>'0');
	signal PKT_length_reg			         : std_logic_vector(15 downto 0)	:= (others=>'0');
	signal PKT_number_reg			         : std_logic_vector(63 downto 0) := (others=>'0');
	signal TIMEOUT_number_reg		       : std_logic_vector(15 downto 0) := (others=>'0');
	signal PKT_sequence_in_reg		     : std_logic_vector(31 downto 0) := (others=>'0');
	signal mac_source_reg			         : std_logic_vector(47 downto 0) := (others=>'0');
	signal mac_destination_reg		     : std_logic_vector(47 downto 0) := (others=>'0');
	signal ip_source_reg		    	     : std_logic_vector(31 downto 0) := (others=>'0');
	signal ip_destination_reg		       : std_logic_vector(31 downto 0) := (others=>'0');

	signal PKT_rx_INT 				         : std_logic_vector(63 downto 0) := (others=>'0');
  signal latency_INT                 : std_logic_vector(47 downto 0) := (others=>'0');
  signal payload_cycles_reg          : std_logic_vector(31 downto 0) := (others=>'0');
  signal payload_last_size_reg       : std_logic_vector(6 downto 0) := (others=>'0');
	signal loopback_filter_reg 		     : std_logic_vector(2 downto 0) := (others=>'0');

	signal linkstatus_reg			         : std_logic;
	signal timestamp_flag_reg			     : std_logic;
	signal check_reduce_frame_rate_reg : std_logic;
	signal test_end                    : std_logic;
	signal cont_reset                  : std_logic_vector(1 downto 0);

	signal debug_rfc_end               : std_logic;

  signal ce                          : std_logic;
  signal wen                         : std_logic_vector(63 downto 0);
  type regnbits_out is array (0 to 63) of std_logic_vector(31 downto 0);
  signal registers_q_out: regnbits_out;

    component CrossClockDomain port(
        clkA: in std_logic;
        clkB: in std_logic;
        SignalIn_clkA : in std_logic;
        SignalOut_clkB : out std_logic
    );
    end component;

begin



  reg_bank: for i in 0 to 63 generate
        registers: entity work.generic_registers port map(ck=>clk_250, rst=>reset, ce=>ce, wen=>wen(i), D=>xgeth_wdata, Q=>registers_q_out(i));
  end generate reg_bank;

   decoder: process(xgeth_waddr)
   begin
     wen <= (others => '0');
      for i in 0 to 63 loop
        if i = to_integer(unsigned(xgeth_waddr)) then
          wen(i) <= '1';
        else
          wen(i) <= '0';
        end if;
      end loop;
   end process;

   xgeth_rdata <= registers_q_out(to_integer(unsigned(xgeth_raddr)));



   lfsr_polynomial <= "00";
   mac_source			 <= x"00AA11BB22CC";
   mac_destination <= x"AA00BB11CC22";
   ip_source			 <= x"0ABCDE01";
   ip_destination	 <= x"0ABCDE02";
   PKT_length      <= x"05EE";
   payload_type    <= "00";
   payload_cycles  <= x"0000002E";
   time_stamp_flag <= '0';
   soft_reset      <= '1';
   loopback_filter <= "001";
   PKT_type        <= '0';
   check_reduce_frame_rate <= '1';
   reset_test     <= '1';
   pkt_sequence_in <= (others => '0');
  --
	-- debug_rfc_end <= RFC_end;
	-- timestamp_flag <= timestamp_flag_reg;
  --
  -- PKT_number <= TX_count when RFC_type_156 = 1 or RFC_type_156 = 2 or RFC_type_156 = 3 else PKT_number_reg;
  --
  -- check_reduce_frame_rate <= check_reduce_frame_rate_reg;
  --
	-- soft_reset 			<= '0' when CURRENT_STATE = S_RESET else '1';
	-- initialize	     	<= '1' when CURRENT_STATE = S_START_TEST else '0';
	-- RFC_ack			    <= '1' when CURRENT_STATE = S_END else '0';
	-- raddr 			    <= xgeth_raddr(6 downto 0);
  --
	-- RFC_type 			<= RFC_type_156;
	-- PKT_length 			<= PKT_length_reg;
	-- IDLE_number 		<= IDLE_number_reg;
	-- mac_source 			<= mac_source_reg;
	-- mac_destination 	<= mac_destination_reg;
	-- ip_source 			<= ip_source_reg;
	-- ip_destination 		<= ip_destination_reg;
	-- TIMEOUT_number 		<= TIMEOUT_number_reg;
	-- PKT_sequence_in 	<= PKT_sequence_in_reg;
  --
	-- latency_INT <= latency;
	-- PKT_rx_INT <= PKT_rx;
	-- linkstatus_reg <= linkstatus;
  --
  -- payload_cycles <= payload_cycles_reg;
  -- loopback_filter <= loopback_filter_reg;
	---------------------------------------------------------------------------------------
  	-- FSM implementation
  	---------------------------------------------------------------------------------------

	-- FSM process
	FSM_PROC: process (clk_156, reset)
	begin
	    if (reset = '0') then
	    	CURRENT_STATE <= S_INIT;
	    elsif rising_edge(clk_156) then
	    	CURRENT_STATE <= NEXT_STATE;
	    end if;

	end process;

	FSM_LOGIC: process(CURRENT_STATE, STATUS_reg_156, RFC_end, RFC_type_156, test_end, RFC_running, timestamp_flag_reg, check_reduce_frame_rate_reg)
	begin
		valid_seed <= '0';
		NEXT_STATE <= CURRENT_STATE;
		case CURRENT_STATE is
			when S_INIT =>
				if(RFC_end = '1') then
					NEXT_STATE <= S_END;

				elsif(STATUS_reg_156 = 3) then
					NEXT_STATE <= S_RESET;	-- comando de reset vindo do software

				elsif(STATUS_reg_156 = 1 and RFC_type_156 = 3) then
					NEXT_STATE <= S_LOOPBACK;

				elsif(STATUS_reg_156 = 1 and test_end = '0' and RFC_running = '0') then
					NEXT_STATE <= S_START_TEST;

				elsif(STATUS_reg_156 = 2 and RFC_type_156 = 1 and timestamp_flag_reg = '0') then -- envia timestamp
					NEXT_STATE <= S_EXECUTING_LATENCY;

				elsif(STATUS_reg_156 = 2 and RFC_type_156 = 2 and check_reduce_frame_rate_reg = '0') then
					NEXT_STATE <= S_EXECUTING_SYSREC;

				--elsif(STATUS_reg_156 = 2 and RFC_type_156 = 3) then
				--	NEXT_STATE <= S_EXECUTING_TEST_RESET;

				else
					NEXT_STATE <= S_INIT;
				end if;

			when S_START_TEST =>
				valid_seed <= '1';
				NEXT_STATE <= S_INIT;

			when S_EXECUTING_LATENCY =>
				NEXT_STATE <= S_INIT;

			when S_EXECUTING_SYSREC =>
				NEXT_STATE <= S_INIT;

			when S_EXECUTING_TEST_RESET =>
				NEXT_STATE <= S_INIT;

			when S_RESET =>
				if(STATUS_reg_156 = 0) then
					NEXT_STATE <= S_INIT;
				end if;

			when S_LOOPBACK =>
				NEXT_STATE <= S_INIT;

			when others =>
				NEXT_STATE <= S_INIT;
		end case;
	end process;

  --
	-- STATUS_reg_250(1 downto 0)          <= registers(0)(1 downto 0);
	-- RFC_type_250(2 downto 0)            <= registers(1)(2 downto 0);
	-- PKT_length_reg(15 downto 0)          <= registers(2)(15 downto 0);
	-- IDLE_number_reg(15 downto 0)        <= registers(3)(15 downto 0);
	-- PKT_number_reg(31 downto 0)         <= registers(4)(31 downto 0);
	-- PKT_number_reg(63 downto 32)        <= registers(5)(31 downto 0);
	-- payload_type(2 downto 0)  			<= registers(6)(2 downto 0);
	-- mac_source_reg(31 downto 0)         <= registers(7)(31 downto 0);
	-- mac_source_reg(47 downto 32)        <= registers(8)(15 downto 0);
	-- mac_destination_reg(31 downto 0)    <= registers(9)(31 downto 0);
	-- mac_destination_reg(47 downto 32)   <= registers(10)(15 downto 0);
	-- ip_source_reg(31 downto 0)   		<= registers(11)(31 downto 0);
	-- ip_destination_reg(31 downto 0)   	<= registers(12)(31 downto 0);
	-- TIMEOUT_number_reg(15 downto 0)   	<= registers(13)(15 downto 0);
	-- PKT_sequence_in_reg(15 downto 0)   	<= registers(14)(15 downto 0);
	-- lfsr_seed(31 downto 0)       	<= registers(33)(31 downto 0);
	-- lfsr_seed(63 downto 32)         <= registers(34)(31 downto 0);
  -- lfsr_polynomial(1 downto 0)			<= registers(35)(1 downto 0);
  -- payload_cycles_reg(31 downto 0)       <= registers(36)(31 downto 0);
  -- payload_last_size_reg(6 downto 0)       <= registers(37)(6 downto 0);
  -- loopback_filter_reg(2 downto 0)     <= registers(38)(2 downto 0);
  -- reset_test						  <= registers(39)(0);

  -- 	registers(15)(31 downto 0)			<=	PKT_rx_INT(31 downto 0);
	-- registers(16)(31 downto 0)			<=	PKT_rx_INT(63 downto 32);
	-- registers(17)(31 downto 0)			<=  TX_count(31 downto 0);
	-- registers(18)(31 downto 0)			<=	TX_count(63 downto 32);
	-- registers(19)(31 downto 0)			<=	latency_INT(31 downto 0);
	-- registers(20)(31 downto 0)			<=	"0000000000000000" & latency_INT(47 downto 32);
	-- registers(21)(31 downto 0)			<=	IDLE_count_receiver_out(31 downto 0);
	-- registers(22)(31 downto 0)			<=	IDLE_count_receiver_out(63 downto 32);
	-- registers(23)(31 downto 0)			<=	"000000000000000000000000000000" & eth_rx_los & linkstatus_reg;
	-- registers(24)(31 downto 0)      <=  "000000000000000000000000000000" & STATUS_reg_250_out;
	-- registers(25)(31 downto 0)      <=  mac_source_rx(31 downto 0);
	-- registers(26)(15 downto 0)      <=  mac_source_rx(47 downto 32);
	-- registers(27)(31 downto 0)      <=  mac_destination_rx(31 downto 0);
	-- registers(28)(15 downto 0)      <=  mac_destination_rx(47 downto 32);
	-- registers(29)(31 downto 0)      <=  ip_source_rx(31 downto 0);
	-- registers(30)(31 downto 0)      <=  ip_destination_rx(31 downto 0);
	-- registers(31)(31 downto 0)      <=  cont_error(31 downto 0);
	-- registers(32)(31 downto 0)      <=  cont_error(63 downto 32);
	-- registers(40)(31 downto 0)      <=  packets_lost(31 downto 0);
	-- registers(41)(31 downto 0)      <=  packets_lost(63 downto 32);
	--registers(42)(15 downto 0)      <=  last_id;
	--registers(43)(15 downto 0)      <=  current_id;

	REGISTRADORES: process(clk_156,reset)
	begin
		if(reset = '0') then
			PKT_type				<= '0';
			check_reduce_frame_rate_reg <= '0';
			timestamp_flag_reg		<= '0';
			STATUS_reg_156_out <= "00";
			test_end 			<= '0';

		-- Escrita no registrador Status Register
		elsif rising_edge(clk_156) then
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
					timestamp_flag_reg <= '1';
					STATUS_reg_156_out <= "01";

				when S_EXECUTING_SYSREC =>
					check_reduce_frame_rate_reg <= '1';
					STATUS_reg_156_out <= "01";

				when S_EXECUTING_TEST_RESET =>
					STATUS_reg_156_out <= "01";

				when S_END =>
					--if (RFC_end = '0') then
						STATUS_reg_156_out <= "00";
						test_end <= '1';
					--end if;

				when S_RESET =>
					STATUS_reg_156_out			<= "00";
                    test_end 			        <= '0';
                    PKT_type                    <= '0';
                    check_reduce_frame_rate_reg <= '0';
                    timestamp_flag_reg          <= '0';
				when others =>
					null;
			end case;
		end if;
	end process;

    inst_CCD_STATUSreg_in_0 : CrossClockDomain port map(
        clkA           => clk_250,
        clkB           => clk_156,
        SignalIn_clkA  => STATUS_reg_250(0),
        SignalOut_clkB => STATUS_reg_156(0)
    );

    inst_CCD_STATUSreg_in_1 : CrossClockDomain port map(
        clkA           => clk_250,
        clkB           => clk_156,
        SignalIn_clkA  => STATUS_reg_250(1),
        SignalOut_clkB => STATUS_reg_156(1)
    );

    inst_CCD_STATUSreg_out_0 : CrossClockDomain port map(
        clkA           => clk_156,
        clkB           => clk_250,
        SignalIn_clkA  => STATUS_reg_156_out(0),
        SignalOut_clkB => STATUS_reg_250_out(0)
    );


    inst_CCD_STATUSreg_out_1 : CrossClockDomain port map(
        clkA           => clk_156,
        clkB           => clk_250,
        SignalIn_clkA  => STATUS_reg_156_out(1),
        SignalOut_clkB => STATUS_reg_250_out(1)
    );

    inst_CDC_RFC_type_0 : CrossClockDomain port map(
        clkA           => clk_250,
        clkB           => clk_156,
        SignalIn_clkA  => RFC_type_250(0),
        SignalOut_clkB => RFC_type_156(0)
    );

    inst_CDC_RFC_type_1 : CrossClockDomain port map(
        clkA           => clk_250,
        clkB           => clk_156,
        SignalIn_clkA  => RFC_type_250(1),
        SignalOut_clkB => RFC_type_156(1)
    );

    inst_CDC_RFC_type_2 : CrossClockDomain port map(
        clkA           => clk_250,
        clkB           => clk_156,
        SignalIn_clkA  => RFC_type_250(2),
        SignalOut_clkB => RFC_type_156(2)
    );

end behavioral;
