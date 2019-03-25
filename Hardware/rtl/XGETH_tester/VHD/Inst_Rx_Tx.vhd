--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
----------------------------------RECEIVER---------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

entity Rx_40Gb is
  port (
    clk_156           : in std_logic; -- Clock 156.25 MHz
    clk_312           : in std_logic; -- Clock 312 MHz
    clk_312_n         : in std_logic;
    rst_n             : in std_logic; -- Reset (Active Hi

    -- DOS GURI
    rx_header_valid_in  : in std_logic;
    rx_header_in        : in std_logic_vector(1 downto 0);
    rx_data_in          : in std_logic_vector(63 downto 0);
    rx_data_valid_in    : in std_logic
  );
end Rx_40Gb;

architecture arch_Rx_40Gb of Rx_40Gb is
------------------------------------------------------------------------
-------------------------STD INPUTS-------------------------------------
 -- signal clk_156                : std_logic; -- Clock 156.25 MHz
 -- signal clk_312                : std_logic; -- Clock 312 MHz
 -- signal clk_312_n              : std_logic;
 -- signal rst_n                  : std_logic; -- Reset (Active Hi
---------------------pkt_creation_mngr----------------------------------
-------------------------INPUTS-----------------------------------------

signal loop_select            : std_logic;
signal mac_source             : std_logic_vector(47 downto 0);
signal rec_mac_source_rx      : std_logic_vector(47 downto 0);
signal rec_mac_destination_rx : std_logic_vector(47 downto 0);
signal rec_ip_source_rx       : std_logic_vector(31 downto 0);
signal rec_ip_destination_rx  : std_logic_vector(31 downto 0);
signal start                  : std_logic;  -- Enable the pack
signal lfsr_seed              : std_logic_vector(255 downto 0);
signal valid_seed             : std_logic;
signal lfsr_polynomial        : std_logic_vector(1 downto 0);


signal mac_destination        : std_logic_vector(47 downto 0);
signal ip_source              : std_logic_vector(31 downto 0);
signal ip_destination         : std_logic_vector(31 downto 0);
signal packet_length          : std_logic_vector(15 downto 0);
signal timestamp_base         : std_logic_vector(47 downto 0);
signal time_stamp_flag        : std_logic; -- If the timestamp
signal pkt_tx_full            : std_logic;
signal wen                    : std_logic;
signal ren                    : std_logic;

signal payload_type           : std_logic_vector(1 downto 0);

signal payload_cycles         : std_logic_vector(31 downto 0);

signal pkt_rx_avail_in       : std_logic;
signal pkt_rx_eop_in         : std_logic;
signal pkt_rx_sop_in         : std_logic;
signal pkt_rx_val_in         : std_logic;
signal pkt_rx_err_in         : std_logic;
signal pkt_rx_data_in        : std_logic_vector(127 downto 0);
signal pkt_rx_mod_in         : std_logic_vector(3 downto 0);


signal mac_filter            : std_logic_vector(2 downto 0);
------------------------------------------------------------------------
-------------------------OUTPUTS-----------------------------------
signal mngr_pkt_tx_data_out       :std_logic_vector (255 downto 0);
signal mngr_pkt_tx_val_out        :std_logic;
signal mngr_pkt_tx_sop_out        :std_logic_vector (1 downto 0);
signal mngr_pkt_tx_eop_out        :std_logic;
signal mngr_pkt_tx_mod_out        :std_logic_vector (4 downto 0);
signal mngr_mac_source_out        :std_logic_vector (47 downto 0);
signal mngr_mac_destination_out   :std_logic_vector (47 downto 0);
signal mngr_ip_source_out         :std_logic_vector (31 downto 0);
signal mngr_ip_destination_out    :std_logic_vector (31 downto 0);
signal mac_source_out        :std_logic_vector (47 downto 0);
signal mac_destination_out   :std_logic_vector (47 downto 0);
signal ip_source_out         :std_logic_vector (31 downto 0);
signal ip_destination_out    :std_logic_vector (31 downto 0);
------------------------------------------------------------------------
------------------------------------------------------------------------
------------------------ECHO RECEIVER-----------------------------------
---------------------------INPUTS-------------------------------------


--signal rec_lfsr_seed                : std_logic_vector(127 downto 0);
--signal rec_lfsr_polynomial          : std_logic_vector(1 downto 0);
--signal rec_valid_seed               : std_logic;

--signal timestamp_base           : std_logic_vector(47 downto 0);
--signal mac_source               : std_logic_vector(47 downto 0);

signal pkt_rx_avail             : std_logic;
signal pkt_rx_eop               : std_logic;
--signal pkt_rx_sop               : std_logic;
--signal pkt_rx_val               : std_logic;
--signal pkt_rx_err               : std_logic;
signal pkt_rx_data              : std_logic_vector(127 downto 0);
--signal pkt_rx_mod               : std_logic_vector(3 downto 0);
--signal payload_type             : std_logic_vector(1 downto 0);

signal verify_system_rec        : std_logic;
signal reset_test               : std_logic;       -- activates res
signal pkt_sequence_in          : std_logic_vector(31 downto 0);
------------------------------------------------------------------------
-------------------------OUTPUTS----------------------------------------
signal rec_pkt_sequence_error_flag_out  : std_logic; -- to RFC254|
signal rec_pkt_sequence_error_out       : std_logic;                -- '0'
signal rec_count_error_out              : std_logic_vector(127 downto 0);
signal rec_IDLE_count_out               : std_logic_vector(127 downto 0);
signal rec_mac_source_rx_out            : std_logic_vector(47 downto 0);
signal rec_mac_destination_out          : std_logic_vector(47 downto 0);
signal rec_ip_source_out                : std_logic_vector(31 downto 0);
signal rec_ip_destination_out           : std_logic_vector(31 downto 0);
signal rec_time_stamp_out_out           : std_logic_vector(47 downto 0);
signal rec_received_packet_out          : std_logic;
signal rec_end_latency_out              : std_logic;
signal rec_packets_lost_out             : std_logic_vector(127 downto 0);
signal rec_RESET_done_out               : std_logic; -- to RFC254|
signal rec_pkt_rx_ren_out               : std_logic;
------------------------------------------------------------------------
------------------------------------------------------------------------
-----------------------WRAPPER---------------------------------------

--signal clk_156              : std_logic;
signal tx_clk_161_13        : std_logic;
signal rx_clk_161_13        : std_logic;
signal clk_xgmii_rx         : std_logic;
signal clk_xgmii_tx         : std_logic;

signal async_reset_n        : std_logic;
signal reset_tx_n           : std_logic;
signal reset_rx_n           : std_logic;
signal reset_tx_done        : std_logic;
signal reset_rx_done        : std_logic;


signal rx_jtm_en            : std_logic;
signal bypass_descram       : std_logic;
signal bypass_scram         : std_logic;
signal bypass_66decoder     : std_logic;
signal bypass_66encoder     : std_logic;
signal clear_errblk         : std_logic;
signal clear_ber_cnt        : std_logic;
signal tx_jtm_en            : std_logic;
signal jtm_dps_0            : std_logic;
signal jtm_dps_1            : std_logic;
signal seed_A               : std_logic_vector (57 downto 0);
signal seed_B               : std_logic_vector (57 downto 0);



signal rx_lane_0_header_valid_in  : std_logic;
signal rx_lane_0_header_in        : std_logic_vector (1 downto 0);
signal rx_lane_0_data_valid_in    : std_logic;
signal rx_lane_0_data_in          : std_logic_vector(63 downto 0);

signal rx_lane_1_header_valid_in  : std_logic;
signal rx_lane_1_header_in        : std_logic_vector (1 downto 0);
signal rx_lane_1_data_valid_in    : std_logic;
signal rx_lane_1_data_in          : std_logic_vector(63 downto 0);

signal rx_lane_2_header_valid_in  : std_logic;
signal rx_lane_2_header_in        : std_logic_vector(1 downto 0);
signal rx_lane_2_data_valid_in    : std_logic;
signal rx_lane_2_data_in          : std_logic_vector (63 downto 0);

signal rx_lane_3_header_valid_in  : std_logic;
signal rx_lane_3_header_in        : std_logic_vector(1 downto 0);
signal rx_lane_3_data_valid_in    : std_logic;
signal rx_lane_3_data_in          : std_logic_vector(63 downto 0);

-- signal rx_header_valid_in   : std_logic;
-- signal rx_header_in         : std_logic_vector(1 downto 0);
-- signal rx_data_valid_in     : std_logic;
-- signal rx_data_in           : std_logic_vector (63 downto 0);

signal start_fifo           : std_logic;
signal start_fifo_rd        : std_logic;

signal pkt_rx_ren           : std_logic;
--signal pkt_tx_data          : std_logic_vector (63 downto 0);
--signal pkt_tx_eop           : std_logic;
--signal pkt_tx_mod           : std_logic_vector (2 downto 0);
--signal pkt_tx_sop           : std_logic;
--signal pkt_tx_val           : std_logic;

signal wb_adr_i             : std_logic_vector (7 downto 0);
signal wb_clk_i             : std_logic;
signal wb_cyc_i             : std_logic;
signal wb_dat_i             : std_logic_vector (31 downto 0);
signal wb_stb_i             : std_logic;
signal wb_we_i              : std_logic;

---------------------------OUTPUTS-------------------------------------

--signal  pkt_rx_avail        : std_logic;
--signal  pkt_rx_data         : std_logic_vector(63 downto 0);
--signal  pkt_rx_eop          : std_logic;
signal  pkt_rx_err          : std_logic;
signal  pkt_rx_mod          : std_logic_vector (2 downto 0);
signal  pkt_rx_sop          : std_logic;
signal  pkt_rx_val          : std_logic;
--signal  pkt_tx_full         : std_logic;

signal wb_ack_o             : std_logic;
signal wb_dat_o             : std_logic_vector (31 downto 0);
signal wb_int_o             : std_logic;

signal dump_xgmii_txc       : std_logic_vector (7 downto 0);
signal dump_xgmii_txd       : std_logic_vector (63 downto 0);

signal hi_ber               : std_logic;
signal blk_lock             : std_logic;
signal linkstatus           : std_logic;
signal rx_fifo_spill        : std_logic;
signal tx_fifo_spill        : std_logic;
signal rxlf                 : std_logic;
signal txlf                 : std_logic;
signal ber_cnt              : std_logic_vector (5 downto 0);
signal errd_blks            : std_logic_vector (7 downto 0);
signal jtest_errc           : std_logic_vector (15 downto 0);

signal tx_data_out          : std_logic_vector (63 downto 0);
signal tx_header_out        : std_logic_vector (1 downto 0);
signal rxgearboxslip_out    : std_logic;
signal tx_sequence_out      : std_logic_vector (6 downto 0);

signal mac_eop              : std_logic_vector (4 downto 0);
signal mac_sop              : std_logic;
signal mac_val              : std_logic;
signal mac_data             : std_logic_vector (127 downto 0);
signal empty_fifo           : std_logic;
signal full_fifo            : std_logic;
signal fifo_almost_f        : std_logic;
signal fifo_almost_e        : std_logic;

-- outputs to RECEIVER
signal rx_eop_out           : std_logic_vector (4 downto 0);
signal rx_sop_out           : std_logic;
signal rx_val_out           : std_logic;
signal rx_data_out          : std_logic_vector (127 downto 0);
signal rx_crc_ok_out        : std_logic;
signal rx_avail_out         : std_logic;

signal pkt_tx_data : std_logic_vector (255 downto 0);
signal pkt_tx_eop  : std_logic;
signal pkt_tx_mod  : std_logic_vector (4 downto 0);
signal pkt_tx_sop  : std_logic_vector (1 downto 0);
signal pkt_tx_val  : std_logic;
signal pkt_tx_ren  : std_logic;


------------------------------------------------------------------------
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
    --GEN

    pkt_rx_ren          : in std_logic;
    pkt_tx_data         : in std_logic_vector(255 downto 0);
    pkt_tx_eop          : in std_logic;
    pkt_tx_mod          : in std_logic_vector(4 downto 0);
    pkt_tx_sop          : in std_logic_vector(1 downto 0);
    pkt_tx_val          : in std_logic;

    -- -- PCS Inputs
    -- rx_jtm_en           : in  std_logic;
    -- bypass_descram      : in  std_logic;
    -- bypass_scram        : in  std_logic;
    -- bypass_66decoder    : in  std_logic;
    -- bypass_66encoder    : in  std_logic;
    -- clear_errblk        : in  std_logic;
    -- clear_ber_cnt       : in  std_logic;
    -- tx_jtm_en           : in  std_logic;
    -- jtm_dps_0           : in  std_logic;
    -- jtm_dps_1           : in  std_logic;
    -- seed_A              : in  std_logic_vector(57 downto 0);
    -- seed_B              : in  std_logic_vector(57 downto 0);

    rx_header_valid_in  : in std_logic;
    rx_header_in        : in std_logic_vector(1 downto 0);
    rx_data_in          : in std_logic_vector(63 downto 0);
    rx_data_valid_in    : in std_logic;

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

    -- -- MAC Inputs
    -- pkt_rx_ren          : in  std_logic;
    -- pkt_tx_data         : in  std_logic_vector(63 downto 0);
    -- pkt_tx_eop          : in  std_logic;
    -- pkt_tx_mod          : in  std_logic_vector(2 downto 0);
    -- pkt_tx_sop          : in  std_logic;
    -- pkt_tx_val          : in  std_logic;
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
    wb_int_o            : out  std_logic;

    mac_eop             : out std_logic_vector (4 downto 0);
    mac_sop             : out std_logic;
    mac_val             : out std_logic;
    mac_data            : out std_logic_vector (127 downto 0);
    empty_fifo          : out std_logic;
    full_fifo           : out std_logic;
    fifo_almost_f       : out std_logic;
    fifo_almost_e       : out std_logic;

    rx_eop_out          : out std_logic_vector (4 downto 0);
    rx_sop_out          : out std_logic;
    rx_val_out          : out std_logic;
    rx_data_out         : out std_logic_vector (127 downto 0);
    rx_crc_ok_out       : out std_logic;
    rx_avail_out        : out std_logic
    );
end component;


begin

TB_pkt_creation_mngr : entity work.pkt_creation_mngr
  port map (
            ----INPUTs
            clk_156 => clk_156,
            clk_312 => clk_312,
            rst_n   => rst_n,

            --FROM INTERFACE
            loop_select => loop_select,
            mac_source  => mac_source,

            --FROM REC
            rec_mac_source_rx       => rec_mac_source_rx,
            rec_mac_destination_rx  => rec_mac_destination_rx,
            rec_ip_source_rx        => rec_ip_source_rx,
            rec_ip_destination_rx   => rec_ip_destination_rx,

            --GEN PORTS
              -- Control Signals
            start             => start,

              --LFSR Initialization
            lfsr_seed         => lfsr_seed,
            valid_seed        => valid_seed,
            lfsr_polynomial   => lfsr_polynomial,

              -- Settings
            mac_destination   => mac_destination,
            ip_source         => ip_source,
            ip_destination    => ip_destination,
            packet_length     => packet_length,

            timestamp_base    => timestamp_base,
            time_stamp_flag   => time_stamp_flag,

            -- TX mac interface
            pkt_tx_full       => pkt_tx_full,
            wen               => wen,
            ren               => ren,
            payload_type      => payload_type,
            payload_cycles    => payload_cycles,

            --LOOPBACK PORTS
            -- When asserted, the packet transfer will begin on next cycle. Should remain asserted until EOP.
            pkt_rx_avail_in    => pkt_rx_avail_in,
            pkt_rx_eop_in      => pkt_rx_eop_in,
            pkt_rx_sop_in      => pkt_rx_sop_in,
            pkt_rx_val_in      => pkt_rx_val_in,
            pkt_rx_err_in      => pkt_rx_err_in,
            pkt_rx_data_in     => pkt_rx_data_in,
            pkt_rx_mod_in      => pkt_rx_mod_in,
            mac_filter         => mac_filter,


          ---OUTPUT
           pkt_tx_data         =>  mngr_pkt_tx_data_out,
           pkt_tx_val          =>  mngr_pkt_tx_val_out,
           pkt_tx_sop          =>  mngr_pkt_tx_sop_out,
           pkt_tx_eop          =>  mngr_pkt_tx_eop_out,
           pkt_tx_mod          =>  mngr_pkt_tx_mod_out,
           mac_source_out      =>  mngr_mac_source_out,
           mac_destination_out =>  mngr_mac_destination_out,
           ip_source_out       =>  mngr_ip_source_out,
           ip_destination_out  =>  mngr_ip_destination_out
  );

  TB_echo_receiver : entity work.echo_receiver
    port map (
        clk_312  => clk_312,
        reset    => rst_n,              -- Reset (Active High)
        ----INPUTS
        --LFSR Initialization
        lfsr_seed               => lfsr_seed,
        lfsr_polynomial         => lfsr_polynomial,
        valid_seed              => valid_seed,
        -------------------------------------------------------------------------------
        -- Packet Info
        -------------------------------------------------------------------------------
        timestamp_base          => timestamp_base,
        mac_source              => mac_source,
                -------------------------------------------------------------------------------
        -- RX mac interface
        -------------------------------------------------------------------------------
        -- Should only be asserted when a packet is available in the receive FIFO.
        -- When asserted, the packet transfer will begin on next cycle. Should remain asserted until EOP.

        pkt_rx_avail            => pkt_rx_avail,               -- Asserted when a packet is available in for reading in receive FIFO
        pkt_rx_eop              => pkt_rx_eop,                 -- Receive data is the first word of the packet
        pkt_rx_sop              => pkt_rx_sop,                 -- Receive data is the last word of the packet
        pkt_rx_val              => pkt_rx_val,                 -- Indicates that valid data is present on the bus
        pkt_rx_err              => pkt_rx_err,                 -- Current packet is bad and should be discarded
        pkt_rx_data             => pkt_rx_data,                -- Receive data
        pkt_rx_mod              => pkt_rx_mod,                 -- Indicates valid bytes during last word -- added 0 in all pkt_rx_mod most val bit position
        payload_type            => payload_type,
        verify_system_rec       => verify_system_rec,
        reset_test              => reset_test,                  -- activates reset test
        pkt_sequence_in         => pkt_sequence_in,            -- number of packets to define if recovery is completed

        --- OUTPUT
        pkt_rx_ren              => rec_pkt_rx_ren_out,
        mac_source_rx           => rec_mac_source_rx_out,
        mac_destination         => rec_mac_destination_out,
        ip_source               => rec_ip_source_out,
        ip_destination          => rec_ip_destination_out,
        time_stamp_out          => rec_time_stamp_out_out,
        received_packet         => rec_received_packet_out,
        end_latency             => rec_end_latency_out,
        packets_lost            => rec_packets_lost_out,
        RESET_done              => rec_RESET_done_out,      -- to RFC254|
        pkt_sequence_error_flag => rec_pkt_sequence_error_flag_out,   -- to RFC254|
        pkt_sequence_error      => rec_pkt_sequence_error_out,   -- '0' if sequence is ok, '1' if error in sequence and not recovered -- to RFC254|
        count_error             => rec_count_error_out,
        IDLE_count              => rec_IDLE_count_out

  );
  inst_TB_wrapper : wrapper_macpcs_rx
   port map (
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

       rx_lane_0_header_valid_in  => '0',
       rx_lane_0_header_in        => "00",
       rx_lane_0_data_in          => (others=>'0'),
       rx_lane_0_data_valid_in    => '0',

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
       --linkstatus          => linkstatus_reg,
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
       wb_int_o            => open,

       -- outputs to CRC
       mac_eop             => mac_eop,
       mac_sop             => mac_sop,
       mac_val             => mac_val,
       mac_data            => mac_data,
       empty_fifo          => empty_fifo,
       full_fifo           => full_fifo,
       fifo_almost_f       => fifo_almost_f,
       fifo_almost_e       => fifo_almost_e,

       -- outputs to RECEIVER
       rx_eop_out          => rx_eop_out,
       rx_sop_out          => rx_sop_out,
       rx_val_out          => rx_val_out,
       rx_data_out         => rx_data_out,
       rx_crc_ok_out       => rx_crc_ok_out,
       rx_avail_out        => rx_avail_out

  );
end arch_Rx_40Gb;
