library IEEE;
use IEEE.std_logic_1164.all;
--use IEEE.std_logic_arith.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

library xil_defaultlib;
    use xil_defaultlib.common_pkg.all;

entity xgeth_tester is
    port
    (
        -- Clocks
        clk_156             : in std_logic;
        clk_250             : in std_logic;
        tx_clk_161_13       : in std_logic;
        rx_clk_161_13       : in std_logic;
        clk_xgmii_rx        : in std_logic;
        clk_xgmii_tx        : in std_logic;

        -- Resets
        async_reset_n       : in std_logic;
        reset_tx_n          : in std_logic;
        reset_rx_n          : in std_logic;
        reset_tx_done       : in std_logic;
        reset_rx_done       : in std_logic;

        -- PCS Data Inputs
        rx_header_in        : in std_logic_vector(1 downto 0);
        rx_data_in          : in std_logic_vector(63 downto 0);
        rx_data_valid_in    : in std_logic;
        rx_header_valid_in  : in std_logic;

        -- PCS Data Outputs
        tx_data_out         : out std_logic_vector(63 downto 0);
        tx_header_out       : out std_logic_vector(1 downto 0);
        rxgearboxslip_out   : out std_logic;
        tx_sequence_out     : out std_logic_vector(6 downto 0);
        linkstatus          : out std_logic;
        eth_rx_los          : in std_logic;

        -- uPC interface
        xgeth_waddr         : in std_logic_vector(6 downto 0);
        xgeth_wdata         : in std_logic_vector(31 downto 0);
        xgeth_raddr         : in std_logic_vector(6 downto 0);
        xgeth_rdata         : out std_logic_vector(31 downto 0);
        xgeth_wen           : in std_logic;

        on_frame_sent       : out std_logic;
        on_frame_received   : out std_logic;
        verify_system_rec   : out std_logic
    );
end xgeth_tester;

architecture xgeth_tester of xgeth_tester is

    -- inst_interface_upc <-> RFC2544
    signal PKT_type : std_logic_vector(1 downto 0);
    signal initialize, RFC_end, RFC_ack : std_logic;
    signal RFC_type : std_logic_vector(2 downto 0);
    signal PKT_number, PKT_rx : std_logic_vector(63 downto 0);
    signal IDLE_number: std_logic_vector(15 downto 0);
    signal latency : std_logic_vector(47 downto 0);

    -- inst_interface_upc <-> echo generator
    signal PKT_length : std_logic_vector(15 downto 0);
    signal mac_source, mac_destination : std_logic_vector(47 downto 0);
    signal ip_source, ip_destination : std_logic_vector(31 downto 0);
    signal time_stamp_flag : std_logic;

    -- inst_interface_upc <-> echo receiver
    signal PKT_sequence_in, TIMEOUT_number : std_logic_vector(15 downto 0);
    signal packets_lost :  std_logic_vector(63 downto 0);
    signal pkt_lost_counter :  std_logic_vector(31 downto 0);
    signal reset_test 	: std_logic;

    -- RFC2544 <-> receiver
    signal time_stamp_out : std_logic_vector(47 downto 0);
    signal end_latency, pkt_sequence_error, pkt_sequence_error_flag : std_logic;
    signal RESET_done : std_logic;

    -- Aligner
    signal shifter_to_pcs_rx : std_logic_vector(63 downto 0);

    -- MAC/PCS
    signal seed_A, seed_B   : std_logic_vector(57 downto 0) := (others=>'0');
    signal wb_adr_i         : std_logic_vector(7 downto 0) := (others=>'0');
    signal wb_dat_i         : std_logic_vector(31 downto 0) := (others=>'0');

    -- others
    signal pkt_gen, pkt_gen_arp, pkt_gen_echo : std_logic;

    -- MUX - MAC
    signal pkt_tx_data : std_logic_vector(63 downto 0);
    signal pkt_rx_avail, pkt_tx_val, pkt_tx_sop, pkt_tx_eop : std_logic;
    signal pkt_tx_mod : std_logic_vector(2 downto 0);
    signal select_pkt_generator : std_logic;

    -- echo reset
    signal echo_reset : std_logic;

    -- echo generator
    signal pkt_tx_data_echo : std_logic_vector(63 downto 0);
    signal pkt_tx_val_echo, pkt_tx_sop_echo, pkt_tx_eop_echo, pkt_tx_full_echo : std_logic;
    signal pkt_tx_mod_echo : std_logic_vector(2 downto 0);

  -- echo receiver
    signal pkt_rx_ren, pkt_rx_ren_echo, pkt_rx_eop, pkt_rx_sop, pkt_rx_val, pkt_rx_err, pkt_tx_full, pkt_loopback_ren: std_logic;
    signal pkt_rx_data : std_logic_vector(63 downto 0);
    signal pkt_rx_mod : std_logic_vector(2 downto 0);

    -- arp generator
--    signal pkt_tx_data_arp : std_logic_vector(63 downto 0);
--    signal pkt_tx_val_arp, pkt_tx_sop_arp, pkt_tx_eop_arp, pkt_tx_full_arp : std_logic;
--    signal pkt_tx_mod_arp : std_logic_vector(2 downto 0);

    -- Timestamp base reference
    signal timestamp_base   : std_logic_vector(47 downto 0);
    signal test_end : std_logic;
    signal soft_reset : std_logic;
    signal reset : std_logic;
    signal RFC_running : std_logic;
    signal check_reduce_frame_rate : std_logic;
    signal TX_count : std_logic_vector(63 downto 0);
    signal echo_received_packet: std_logic;
    signal linkstatus_reg: std_logic;
    signal reset_sync: std_logic;
    signal IDLE_count_receiver, IDLE_count_receiver_out: std_logic_vector(63 downto 0);

    -- loopback signals

    signal lb_pkt_rx_data, lb_pkt_tx_data: std_logic_vector(63 downto 0);
    signal lb_mac_source, mac_source_rx, mac_source_rx_echo : std_logic_vector(47 downto 0);
    signal lb_mac_destination, mac_destination_rx, mac_destination_rx_echo : std_logic_vector(47 downto 0);
    signal lb_ip_message_length : std_logic_vector(15 downto 0);
    signal lb_ip_source, ip_source_rx, ip_source_rx_echo : std_logic_vector(31 downto 0);
    signal lb_ip_destination, ip_destination_rx, ip_destination_rx_echo : std_logic_vector(31 downto 0);
    signal lb_ip_checksum : std_logic_vector(15 downto 0);
    signal lb_udp_message_length : std_logic_vector(15 downto 0);
    signal lb_pkt_rx_mod, lb_pkt_tx_mod: std_logic_vector(2 downto 0);
    signal it_header : std_logic_vector(2 downto 0);
    signal in_eop : std_logic;
    signal lb_pkt_tx_sop, lb_pkt_tx_eop, lb_pkt_tx_val, receiving_payload: std_logic;

    signal cont_error: std_logic_vector(63 downto 0);
    signal lfsr_seed: std_logic_vector(63 downto 0);
    signal lfsr_polynomial : std_logic_vector(1 downto 0);

    signal payload_type : std_logic_vector(2 downto 0);
    signal valid_seed : std_logic;


    signal payload_cycles        : std_logic_vector(31 downto 0);
    signal payload_last_size     : std_logic_vector(6 downto 0);

    signal loopback_filter      : std_logic_vector(2 downto 0);

    signal last_id		 : std_logic_vector(15 downto 0);
    signal current_id 	 : std_logic_vector(15 downto 0);

    component wrapper_macpcs_rx port(
    --  component wrapper_macpcs port(

        -- Clocks
        clk_156             : in  std_logic;
        tx_clk_161_13       : in  std_logic;
        rx_clk_161_13       : in  std_logic;
        clk_xgmii_rx        : in  std_logic;
        clk_xgmii_tx        : in  std_logic;

        -- Resets
        async_reset_n       : in  std_logic;
        reset_tx_n          : in std_logic;
        reset_rx_n          : in std_logic;
        reset_tx_done       : in std_logic;
        reset_rx_done       : in std_logic;
        -- PCS Inputs
        rx_jtm_en           : in  std_logic;
        bypass_descram      : in  std_logic;
        bypass_scram        : in  std_logic;
        bypass_66decoder    : in  std_logic;
        bypass_66encoder    : in  std_logic;
        clear_errblk        : in  std_logic;
        clear_ber_cnt       : in  std_logic;
        tx_jtm_en           : in  std_logic;
        jtm_dps_0           : in  std_logic;
        jtm_dps_1           : in  std_logic;
        seed_A              : in  std_logic_vector(57 downto 0);
        seed_B              : in  std_logic_vector(57 downto 0);

        -- rx_header_valid_in  : in  std_logic;
        -- rx_header_in        : in  std_logic_vector(1 downto 0);
        -- rx_data_valid_in    : in  std_logic;
        -- rx_data_in          : in  std_logic_vector(63 downto 0);

        rx_lane_0_header_valid_in : in std_logic;
        rx_lane_0_header_in       : in std_logic_vector(1 downto 0);
        rx_lane_0_data_in         : in std_logic_vector(63 downto 0);
        rx_lane_0_data_valid_in   : in std_logic;
        rx_lane_1_header_valid_in : in std_logic;
        rx_lane_1_header_in       : in std_logic_vector(1 downto 0);
        rx_lane_1_data_in         : in std_logic_vector(63 downto 0);
        rx_lane_1_data_valid_in   : in std_logic;
        rx_lane_2_header_valid_in : in std_logic;
        rx_lane_2_header_in       : in std_logic_vector(1 downto 0);
        rx_lane_2_data_in         : in std_logic_vector(63 downto 0);
        rx_lane_2_data_valid_in   : in std_logic;
        rx_lane_3_header_valid_in : in std_logic;
        rx_lane_3_header_in       : in std_logic_vector(1 downto 0);
        rx_lane_3_data_in         : in std_logic_vector(63 downto 0);
        rx_lane_3_data_valid_in   : in std_logic;

        -- PCS Outputs
        hi_ber              : out  std_logic;
        blk_lock            : out  std_logic;
        linkstatus          : out  std_logic;
        rx_fifo_spill       : out  std_logic;
        tx_fifo_spill       : out  std_logic;
        rxlf                : out  std_logic;
        txlf                : out  std_logic;
        ber_cnt             : out  std_logic_vector(5 downto 0);
        errd_blks           : out  std_logic_vector(7 downto 0);
        jtest_errc          : out  std_logic_vector(15 downto 0);

        tx_data_out         : out  std_logic_vector(63 downto 0);
        tx_header_out       : out  std_logic_vector(1 downto 0);
        rxgearboxslip_out   : out  std_logic;
        tx_sequence_out     : out  std_logic_vector(6 downto 0);

        -- MAC Inputs
        pkt_rx_ren          : in  std_logic;
        pkt_tx_data         : in  std_logic_vector(63 downto 0);
        pkt_tx_eop          : in  std_logic;
        pkt_tx_mod          : in  std_logic_vector(2 downto 0);
        pkt_tx_sop          : in  std_logic;
        pkt_tx_val          : in  std_logic;
            -- Wishbone (MAC)
        wb_adr_i            : in  std_logic_vector(7 downto 0);
        wb_clk_i            : in  std_logic;
        wb_cyc_i            : in  std_logic;
        wb_dat_i            : in  std_logic_vector(31 downto 0);
        wb_stb_i            : in  std_logic;
        wb_we_i             : in  std_logic;

        -- XMAC Outputs
        pkt_rx_avail        : out  std_logic;
        pkt_rx_data         : out  std_logic_vector(63 downto 0);
        pkt_rx_eop          : out  std_logic;
        pkt_rx_err          : out  std_logic;
        pkt_rx_mod          : out  std_logic_vector(2 downto 0);
        pkt_rx_sop          : out  std_logic;
        pkt_rx_val          : out  std_logic;
        pkt_tx_full         : out  std_logic;
            -- Wishbone (MAC)
        wb_ack_o            : out  std_logic;
        wb_dat_o            : out  std_logic_vector(31 downto 0);
        wb_int_o            : out  std_logic
        );
    end component;

begin

    -- inst_wrapper_macpcs : wrapper_macpcs port map(
    inst_wrapper_macpcs : wrapper_macpcs_rx port map(
        -- Inputs

        -- Clocks
        clk_156             => clk_156,
        tx_clk_161_13       => tx_clk_161_13,
        rx_clk_161_13       => rx_clk_161_13,
        clk_xgmii_rx        => clk_xgmii_rx,
        clk_xgmii_tx        => clk_xgmii_tx,

        -- Resets
        async_reset_n       => async_reset_n,
        reset_tx_n          => reset_tx_n,
        reset_rx_n          => reset_rx_n,
        reset_tx_done       => reset_tx_done,
        reset_rx_done       => reset_rx_done,

        -- PCS Inputs
        rx_jtm_en           => '0',
        bypass_descram      => '0',
        bypass_scram        => '0',
        bypass_66decoder    => '0',
        bypass_66encoder    => '0',
        clear_errblk        => '0',
        clear_ber_cnt       => '0',
        tx_jtm_en           => '0',
        jtm_dps_0           => '0',
        jtm_dps_1           => '0',
        seed_A              => seed_A,
        seed_B              => seed_B,

        -- rx_header_valid_in  => rx_header_valid_in,
        -- rx_header_in        => rx_header_in,
        -- rx_data_valid_in    => rx_data_valid_in,
        -- rx_data_in          => rx_data_in,

        rx_lane_0_header_valid_in  => rx_header_valid_in,
        rx_lane_0_header_in        => rx_header_in,
        rx_lane_0_data_in          => rx_data_in,
        rx_lane_0_data_valid_in    => rx_data_valid_in,

        rx_lane_1_header_valid_in => '0',
        rx_lane_1_header_in       => "00",
        rx_lane_1_data_in         => (others=>'0'),
        rx_lane_1_data_valid_in   => '0',
        rx_lane_2_header_valid_in => '0',
        rx_lane_2_header_in       => "00",
        rx_lane_2_data_in         => (others=>'0'),
        rx_lane_2_data_valid_in   => '0',
        rx_lane_3_header_valid_in => '0',
        rx_lane_3_header_in       => "00",
        rx_lane_3_data_in         => (others=>'0'),
        rx_lane_3_data_valid_in   => '0',

        -- PCS Outputs
        hi_ber              => open,
        blk_lock            => open,
        linkstatus          => linkstatus_reg,
        rx_fifo_spill       => open,
        tx_fifo_spill       => open,
        rxlf                => open,
        txlf                => open,
        ber_cnt             => open,
        errd_blks           => open,
        jtest_errc          => open,

        tx_data_out        => tx_data_out,
        tx_header_out      => tx_header_out,
        rxgearboxslip_out  => rxgearboxslip_out,
        tx_sequence_out    => tx_sequence_out,

        -- Wishbone Inputs (MAC)
        wb_adr_i            => wb_adr_i,
        wb_clk_i            => '0',
        wb_cyc_i            => '0',
        wb_dat_i            => wb_dat_i,
        wb_stb_i            => '0',
        wb_we_i             => '0',

        -- MAC
        pkt_rx_data     => pkt_rx_data,
        pkt_rx_avail    => pkt_rx_avail,
        pkt_rx_eop      => pkt_rx_eop,
        pkt_rx_err      => pkt_rx_err,
        pkt_rx_mod      => pkt_rx_mod,
        pkt_rx_sop      => pkt_rx_sop,
        pkt_rx_val      => pkt_rx_val,
        pkt_tx_full     => pkt_tx_full,

        -- MAC Outputs

        pkt_rx_ren      => pkt_rx_ren,
        pkt_tx_data     => pkt_tx_data,
        pkt_tx_eop      => pkt_tx_eop,
        pkt_tx_mod      => pkt_tx_mod,
        pkt_tx_sop      => pkt_tx_sop,
        pkt_tx_val      => pkt_tx_val,

        -- Wishbone Outputs (MAC)
        wb_ack_o            => open,
        wb_dat_o            => open,
        wb_int_o            => open
    );

    inst_interface_upc : entity work.interface_upc_xgeth port map(
        clk_156                   => clk_156,
        clk_250                 => clk_250,
        reset                   => async_reset_n,

        xgeth_waddr             => xgeth_waddr,
        xgeth_raddr             => xgeth_raddr,
        xgeth_wdata             => xgeth_wdata,
        xgeth_wen               => xgeth_wen,

        xgeth_rdata             => xgeth_rdata,

        RFC_end                 => RFC_end,
        PKT_rx                  => PKT_rx,
        latency                 => latency,
        packets_lost			=> packets_lost,
        pkt_lost_counter    	=> pkt_lost_counter,
        RFC_ack                 => RFC_ack,
        reset_test				=> reset_test,

        initialize              => initialize,

        lfsr_seed               => lfsr_seed,
        lfsr_polynomial         => lfsr_polynomial,
        valid_seed              => valid_seed,

        PKT_type                => PKT_type,
        RFC_type                => RFC_type,
        IDLE_number             => IDLE_number,
        PKT_length              => PKT_length,
        PKT_number              => PKT_number,
        TIMEOUT_number          => TIMEOUT_number,
        PKT_sequence_in         => PKT_sequence_in,
        mac_source              => mac_source,
        mac_destination         => mac_destination,
        ip_source               => ip_source,
        ip_destination          => ip_destination,
        soft_reset              => soft_reset,
        RFC_running             => RFC_running,
        timestamp_flag          => time_stamp_flag,
        check_reduce_frame_rate => check_reduce_frame_rate,
        TX_count                => TX_count,
        linkstatus              => linkstatus_reg,
        eth_rx_los              => eth_rx_los,
        IDLE_count_receiver_out => IDLE_count_receiver_out,
        mac_source_rx           => mac_source_rx,
        mac_destination_rx      => mac_destination_rx,
        ip_source_rx            => ip_source_rx,
        ip_destination_rx       => ip_destination_rx,
        cont_error              => cont_error,
        payload_type            => payload_type,
        payload_cycles          => payload_cycles,
        payload_last_size       => payload_last_size,
        --last_id					=> last_id,
        --current_id          	=> current_id,
        loopback_filter         => loopback_filter
    );

    echo_gen_inst : entity work.echo_generator port map (
        clock               => clk_156,
        reset         => reset,

        -- Control Signals
        start               => pkt_gen,
        time_stamp_flag     => time_stamp_flag,
        --LFSR settings
        lfsr_seed           => lfsr_seed,
        lfsr_polynomial     => lfsr_polynomial,
        valid_seed          => valid_seed,

        -- Settings
        mac_source          => mac_source,
        mac_destination     => mac_destination,
        ip_source           => ip_source,
        ip_destination      => ip_destination,
        packet_length       => PKT_length,
        timestamp_base      => timestamp_base,

        -- TX mac interface
        pkt_tx_full         => pkt_tx_full,
        pkt_tx_data         => pkt_tx_data_echo,
        pkt_tx_val          => pkt_tx_val_echo,
        pkt_tx_sop          => pkt_tx_sop_echo,
        pkt_tx_eop          => pkt_tx_eop_echo,
        pkt_tx_mod          => pkt_tx_mod_echo,
        payload_type        => payload_type,
        payload_cycles      => payload_cycles
        --payload_last_size   => payload_last_size,
        --pkt_lost_counter    => pkt_lost_counter
    );

    echo_rec_inst : entity work.echo_receiver port map(
        clock               => clk_156,
        reset               => reset,

        --LFSR settings
        lfsr_seed           => lfsr_seed,
        lfsr_polynomial     => lfsr_polynomial,
        valid_seed          => valid_seed,

        -- Packet Info
        mac_source          => mac_source,
        mac_source_rx       => mac_source_rx_echo,
        mac_destination     => mac_destination_rx_echo,
        ip_source           => ip_source_rx_echo,
        ip_destination      => ip_destination_rx_echo,
        time_stamp_out      => time_stamp_out,
        received_packet     => echo_received_packet,
        end_latency         => end_latency,
        timestamp_base      => timestamp_base,
        RESET_done			=> RESET_done,
        reset_test			=> reset_test,
        -- RX mac interface
       -- start               => pkt_gen_echo,
        pkt_rx_ren          => pkt_rx_ren_echo,
        pkt_rx_avail        => pkt_rx_avail,
        pkt_rx_eop          => pkt_rx_eop,
        pkt_rx_sop          => pkt_rx_sop,
        pkt_rx_val          => pkt_rx_val,
        pkt_rx_err          => pkt_rx_err,
        pkt_rx_data         => pkt_rx_data,
        pkt_rx_mod          => pkt_rx_mod,

		packets_lost		=> packets_lost,
        IDLE_count          => IDLE_count_receiver,
        verify_system_rec   => check_reduce_frame_rate,
        pkt_sequence_in     => PKT_sequence_in,
        pkt_sequence_error_flag  => pkt_sequence_error_flag,
        pkt_sequence_error  => pkt_sequence_error,
        cont_error          => cont_error,
		--last_id				=> last_id,
        --current_id          => current_id,
        payload_type        => payload_type
    );

    trafic_gen_inst : entity work.rfc2544 port map (
        -- STANDARD INPUTSapp_eop[4]
        clock               => clk_156,
        reset               => reset,
        initialize          => initialize,

        RFC_type            => RFC_type,

        IDLE_number         => IDLE_number,
        TIMEOUT_number      => TIMEOUT_number,
        PKT_number          => PKT_number,

        -- FROM Receiver
        PKT_timestamp       => time_stamplinkstatus_reg_out,
        PKT_timestamp_val   => end_latency,
        PKT_sequence_error_flag  => pkt_sequence_error_flag,
        PKT_sequence_error  => pkt_sequence_error,
        RESET_done			=> RESET_done,


        -- TO echo generator and receiver
        timestamp_base      => timestamp_base,

        -- FROM MAC
        PKT_TX_EOP          => PKT_TX_EOP,
        PKT_RX_EOP          => PKT_RX_EOP,

        IDLE_count_receiver => IDLE_count_receiver,
        latency             => latency,
        verify_system_rec   => verify_system_rec,
        PKT_rx              => PKT_rx,
        PKT_gen             => pkt_gen,
        --PKT_timestamp_flag  => time_stamp_flag,
        RFC_end             => RFC_end,
        RFC_ack             => RFC_ack,
        RFC_running         => RFC_running,
        check_reduce_frame_rate => check_reduce_frame_rate,
        TX_count            => TX_count,
        echo_received_packet => echo_received_packet,
        IDLE_count_receiver_out => IDLE_count_receiver_out,

        payload_last_size   => payload_last_size
    );

    loopback_inst : entity work.loopback_old port map (
        -- STANDARD INPUTS
        clock               => clk_156,
        reset               => reset,linkstatus_reg

        mac_source          => mac_source,

        pkt_rx_avail        => pkt_rx_avail,
        pkt_rx_eop          => pkt_rx_eop,
        pkt_rx_sop          => pkt_rx_sop,
        pkt_rx_val          => pkt_rx_val,
        pkt_rx_err          => pkt_rx_err,
        pkt_rx_data         => pkt_rx_data,
        pkt_rx_mod          => pkt_rx_mod,

        pkt_loopback_ren    => pkt_loopback_ren,
        lb_pkt_tx_eop       => lb_pkt_tx_eop,
        lb_pkt_tx_sop       => lb_pkt_tx_sop,
        lb_pkt_tx_val       => lb_pkt_tx_val,
        lb_pkt_tx_data      => lb_pkt_tx_data,
        lb_pkt_tx_mod       => lb_pkt_tx_mod,

        lb_mac_destination  => lb_mac_destination,
        lb_mac_source       => lb_mac_source,
        lb_ip_destination   => lb_ip_destination,
        lb_ip_source        => lb_ip_source,

        mac_filter          => loopback_filter
    );

    on_frame_sent <= RFC_running;
    on_frame_received <= pkt_rx_avail;
    reset <= async_reset_n and soft_reset;
    linkstatus <= linkstatus_reg;

    mac_source_rx       <= lb_mac_source when PKT_type = "10" else mac_source_rx_echo;
    mac_destination_rx  <= lb_mac_destination when PKT_type = "10" else mac_destination_rx_echo;
    ip_source_rx        <= lb_ip_source when PKT_type = "10" else ip_source_rx_echo;
    ip_destination_rx   <= lb_ip_destination when PKT_type = "10" else ip_destination_rx_echo;
        ---------------------------------------------------------
        -- MUX to select ECHO or LOOPBACK  -> MAC bus
        ---------------------------------------------------------

    pkt_tx_data   <= lb_pkt_tx_data when PKT_type = "10" else
                 pkt_tx_data_echo;

    pkt_tx_val    <= lb_pkt_tx_val when PKT_type = "10" else
                pkt_tx_val_echo;

    pkt_tx_sop    <= lb_pkt_tx_sop when PKT_type = "10" else
                pkt_tx_sop_echo;

    pkt_tx_eop    <= lb_pkt_tx_eop when PKT_type = "10" else
                pkt_tx_eop_echo;

    pkt_tx_mod    <= lb_pkt_tx_mod when PKT_type = "10" elseecho_generator_256
                pkt_tx_mod_echo;

    pkt_rx_ren    <= pkt_loopback_ren when PKT_type = "10" else
                pkt_rx_ren_echo;

end xgeth_tester;
