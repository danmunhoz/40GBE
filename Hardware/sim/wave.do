onerror {resume}
quietly virtual function -install /glbl -env /glbl { 907643} virtual_000001
quietly WaveActivateNextPane {} 0
add wave -noupdate /Top/tx_xgt4/clock_in156
add wave -noupdate /Top/tx_xgt4/clock_in161
add wave -noupdate -group Resets /Top/tx_xgt4/reset_in_pcs
add wave -noupdate -group Resets /Top/tx_xgt4/reset_in
add wave -noupdate -group Resets /Top/tx_xgt4/reset_in_mii_tx
add wave -noupdate -group Resets /Top/tx_xgt4/reset_in_mii_rx
add wave -noupdate -group Resets /Top/tx_xgt4/reset_in_pcs
add wave -noupdate -group Resets /Top/tx_xgt4/reset_in
add wave -noupdate -group Resets /Top/tx_xgt4/reset_in_mii_tx
add wave -noupdate -group Resets /Top/tx_xgt4/reset_in_mii_rx
add wave -noupdate -height 30 -expand -group TX -color Gold -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/xgmii_txc
add wave -noupdate -height 30 -expand -group TX -color Gold -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/xgmii_txd
add wave -noupdate -height 30 -expand -group TX -group ECHO_GEN /Top/tx_xgt4/echo_gen_inst/clock
add wave -noupdate -height 30 -expand -group TX -group ECHO_GEN /Top/tx_xgt4/echo_gen_inst/ip_destination
add wave -noupdate -height 30 -expand -group TX -group ECHO_GEN /Top/tx_xgt4/echo_gen_inst/ip_source
add wave -noupdate -height 30 -expand -group TX -group ECHO_GEN /Top/tx_xgt4/echo_gen_inst/lfsr_polynomial
add wave -noupdate -height 30 -expand -group TX -group ECHO_GEN /Top/tx_xgt4/echo_gen_inst/lfsr_seed
add wave -noupdate -height 30 -expand -group TX -group ECHO_GEN /Top/tx_xgt4/echo_gen_inst/mac_destination
add wave -noupdate -height 30 -expand -group TX -group ECHO_GEN /Top/tx_xgt4/echo_gen_inst/mac_source
add wave -noupdate -height 30 -expand -group TX -group ECHO_GEN /Top/tx_xgt4/echo_gen_inst/packet_length
add wave -noupdate -height 30 -expand -group TX -group ECHO_GEN /Top/tx_xgt4/echo_gen_inst/payload_cycles
add wave -noupdate -height 30 -expand -group TX -group ECHO_GEN /Top/tx_xgt4/echo_gen_inst/payload_last_size
add wave -noupdate -height 30 -expand -group TX -group ECHO_GEN /Top/tx_xgt4/echo_gen_inst/payload_type
add wave -noupdate -height 30 -expand -group TX -group ECHO_GEN /Top/tx_xgt4/echo_gen_inst/pkt_tx_full
add wave -noupdate -height 30 -expand -group TX -group ECHO_GEN /Top/tx_xgt4/echo_gen_inst/reset
add wave -noupdate -height 30 -expand -group TX -group ECHO_GEN /Top/tx_xgt4/echo_gen_inst/start
add wave -noupdate -height 30 -expand -group TX -group ECHO_GEN /Top/tx_xgt4/echo_gen_inst/time_stamp_flag
add wave -noupdate -height 30 -expand -group TX -group ECHO_GEN /Top/tx_xgt4/echo_gen_inst/timestamp_base
add wave -noupdate -height 30 -expand -group TX -group ECHO_GEN /Top/tx_xgt4/echo_gen_inst/valid_seed
add wave -noupdate -height 30 -expand -group TX -group ECHO_GEN -divider outputs
add wave -noupdate -height 30 -expand -group TX -group ECHO_GEN /Top/tx_xgt4/echo_gen_inst/pkt_lost_counter
add wave -noupdate -height 30 -expand -group TX -group ECHO_GEN /Top/tx_xgt4/echo_gen_inst/pkt_tx_data
add wave -noupdate -height 30 -expand -group TX -group ECHO_GEN /Top/tx_xgt4/echo_gen_inst/pkt_tx_eop
add wave -noupdate -height 30 -expand -group TX -group ECHO_GEN /Top/tx_xgt4/echo_gen_inst/pkt_tx_mod
add wave -noupdate -height 30 -expand -group TX -group ECHO_GEN /Top/tx_xgt4/echo_gen_inst/pkt_tx_sop
add wave -noupdate -height 30 -expand -group TX -group ECHO_GEN /Top/tx_xgt4/echo_gen_inst/pkt_tx_val
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group XGE_MAC /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/clk_156m25
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group XGE_MAC /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/clk_xgmii_rx
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group XGE_MAC /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/clk_xgmii_tx
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group XGE_MAC /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/pkt_rx_ren
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group XGE_MAC /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/pkt_tx_data
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group XGE_MAC /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/pkt_tx_eop
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group XGE_MAC /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/pkt_tx_mod
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group XGE_MAC /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/pkt_tx_sop
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group XGE_MAC /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/pkt_tx_val
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group XGE_MAC /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/reset_156m25_n
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group XGE_MAC /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/reset_xgmii_rx_n
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group XGE_MAC /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/reset_xgmii_tx_n
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group XGE_MAC /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/wb_adr_i
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group XGE_MAC /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/wb_clk_i
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group XGE_MAC /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/wb_cyc_i
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group XGE_MAC /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/wb_dat_i
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group XGE_MAC /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/wb_rst_i
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group XGE_MAC /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/wb_stb_i
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group XGE_MAC /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/wb_we_i
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group XGE_MAC /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/xgmii_rxc
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group XGE_MAC /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/xgmii_rxd
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group XGE_MAC -divider outputs
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group XGE_MAC /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/pkt_rx_avail
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group XGE_MAC /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/pkt_rx_data
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group XGE_MAC /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/pkt_rx_eop
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group XGE_MAC /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/pkt_rx_err
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group XGE_MAC /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/pkt_rx_mod
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group XGE_MAC /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/pkt_rx_sop
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group XGE_MAC /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/pkt_rx_val
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group XGE_MAC /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/pkt_tx_full
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group XGE_MAC /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/wb_ack_o
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group XGE_MAC /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/wb_dat_o
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group XGE_MAC /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/wb_int_o
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group XGE_MAC /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/xgmii_txc
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group XGE_MAC /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/xgmii_txd
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group tx_data_fifo /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/tx_data_fifo0/clk_156m25
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group tx_data_fifo /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/tx_data_fifo0/clk_xgmii_tx
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group tx_data_fifo /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/tx_data_fifo0/reset_156m25_n
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group tx_data_fifo /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/tx_data_fifo0/reset_xgmii_tx_n
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group tx_data_fifo /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/tx_data_fifo0/txdfifo_ren
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group tx_data_fifo /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/tx_data_fifo0/txdfifo_wdata
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group tx_data_fifo /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/tx_data_fifo0/txdfifo_wen
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group tx_data_fifo /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/tx_data_fifo0/txdfifo_wstatus
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group tx_data_fifo -divider out
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group tx_data_fifo /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/tx_data_fifo0/txdfifo_ralmost_empty
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group tx_data_fifo /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/tx_data_fifo0/txdfifo_rdata
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group tx_data_fifo /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/tx_data_fifo0/txdfifo_rempty
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group tx_data_fifo /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/tx_data_fifo0/txdfifo_rstatus
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group tx_data_fifo /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/tx_data_fifo0/txdfifo_walmost_full
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group tx_data_fifo /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/tx_data_fifo0/txdfifo_wfull
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group tx_hold_fifo /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/tx_hold_fifo0/clk_xgmii_tx
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group tx_hold_fifo /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/tx_hold_fifo0/reset_xgmii_tx_n
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group tx_hold_fifo /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/tx_hold_fifo0/txhfifo_ren
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group tx_hold_fifo /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/tx_hold_fifo0/txhfifo_wdata
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group tx_hold_fifo /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/tx_hold_fifo0/txhfifo_wen
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group tx_hold_fifo /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/tx_hold_fifo0/txhfifo_wstatus
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group tx_hold_fifo -divider out
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group tx_hold_fifo /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/tx_hold_fifo0/txhfifo_ralmost_empty
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group tx_hold_fifo /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/tx_hold_fifo0/txhfifo_rdata
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group tx_hold_fifo /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/tx_hold_fifo0/txhfifo_rempty
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group tx_hold_fifo /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/tx_hold_fifo0/txhfifo_rstatus
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group tx_hold_fifo /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/tx_hold_fifo0/txhfifo_walmost_full
add wave -noupdate -height 30 -expand -group TX -group MAC -expand -group tx_hold_fifo /Top/tx_xgt4/inst_wrapper_macpcs/INST_xge_mac/tx_hold_fifo0/txhfifo_wfull
add wave -noupdate -height 30 -expand -group TX -group PCS -expand -group Encode -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_TX_PATH_ENCODE/bypass_66encoder
add wave -noupdate -height 30 -expand -group TX -group PCS -expand -group Encode -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_TX_PATH_ENCODE/clk156
add wave -noupdate -height 30 -expand -group TX -group PCS -expand -group Encode -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_TX_PATH_ENCODE/rstb
add wave -noupdate -height 30 -expand -group TX -group PCS -expand -group Encode -color Gold -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_TX_PATH_ENCODE/txcontrol
add wave -noupdate -height 30 -expand -group TX -group PCS -expand -group Encode -color Gold -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_TX_PATH_ENCODE/txdata
add wave -noupdate -height 30 -expand -group TX -group PCS -expand -group Encode -color Pink -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_TX_PATH_ENCODE/TXD_encoded
add wave -noupdate -height 30 -expand -group TX -group PCS -expand -group Encode -color Pink -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_TX_PATH_ENCODE/txlf
add wave -noupdate -height 30 -expand -group TX -group PCS -expand -group FIFO -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_TX_PATH_FIFO/FIFO_FULL
add wave -noupdate -height 30 -expand -group TX -group PCS -expand -group FIFO -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_TX_PATH_FIFO/rclk
add wave -noupdate -height 30 -expand -group TX -group PCS -expand -group FIFO -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_TX_PATH_FIFO/wclk
add wave -noupdate -height 30 -expand -group TX -group PCS -expand -group FIFO -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_TX_PATH_FIFO/rst
add wave -noupdate -height 30 -expand -group TX -group PCS -expand -group FIFO -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/start_fifo_rd
add wave -noupdate -height 30 -expand -group TX -group PCS -expand -group FIFO -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_TX_PATH_FIFO/readen
add wave -noupdate -height 30 -expand -group TX -group PCS -expand -group FIFO -color Pink -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_TX_PATH_FIFO/readdata
add wave -noupdate -height 30 -expand -group TX -group PCS -expand -group FIFO -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/start_fifo
add wave -noupdate -height 30 -expand -group TX -group PCS -expand -group FIFO -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_TX_PATH_FIFO/writen
add wave -noupdate -height 30 -expand -group TX -group PCS -expand -group FIFO -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_TX_PATH_FIFO/writedata
add wave -noupdate -height 30 -expand -group TX -group PCS -expand -group FIFO -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_TX_PATH_FIFO/spill
add wave -noupdate -height 30 -expand -group TX -group PCS -expand -group FIFO -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_TX_PATH_FIFO/almostempty
add wave -noupdate -height 30 -expand -group TX -group PCS -expand -group FIFO -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_TX_PATH_FIFO/almostfull
add wave -noupdate -height 30 -expand -group TX -group PCS -expand -group FIFO -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_TX_PATH_FIFO/empty
add wave -noupdate -height 30 -expand -group TX -group PCS -expand -group FIFO -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_TX_PATH_FIFO/full
add wave -noupdate -height 30 -expand -group TX -group PCS -expand -group Scramble -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_TX_PATH_SCRAMBLE/tx_jtm_en
add wave -noupdate -height 30 -expand -group TX -group PCS -expand -group Scramble -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_TX_PATH_SCRAMBLE/jtm_dps_0
add wave -noupdate -height 30 -expand -group TX -group PCS -expand -group Scramble -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_TX_PATH_SCRAMBLE/jtm_dps_1
add wave -noupdate -height 30 -expand -group TX -group PCS -expand -group Scramble -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_TX_PATH_SCRAMBLE/bypass_scram
add wave -noupdate -height 30 -expand -group TX -group PCS -expand -group Scramble -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_TX_PATH_SCRAMBLE/clk
add wave -noupdate -height 30 -expand -group TX -group PCS -expand -group Scramble -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_TX_PATH_SCRAMBLE/rst
add wave -noupdate -height 30 -expand -group TX -group PCS -expand -group Scramble -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_TX_PATH_SCRAMBLE/seed_A
add wave -noupdate -height 30 -expand -group TX -group PCS -expand -group Scramble -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_TX_PATH_SCRAMBLE/seed_B
add wave -noupdate -height 30 -expand -group TX -group PCS -expand -group Scramble -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_TX_PATH_SCRAMBLE/TXD_encoded
add wave -noupdate -height 30 -expand -group TX -group PCS -expand -group Scramble -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_TX_PATH_SCRAMBLE/scram_en
add wave -noupdate -height 30 -expand -group TX -group PCS -expand -group Scramble -color Pink -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_TX_PATH_SCRAMBLE/TXD_Scr
add wave -noupdate -height 30 -expand -group TX -group PCS -expand -group tx_sequence_counter -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_txsequence_counter/clk_161_in
add wave -noupdate -height 30 -expand -group TX -group PCS -expand -group tx_sequence_counter -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_txsequence_counter/reset_n_in
add wave -noupdate -height 30 -expand -group TX -group PCS -expand -group tx_sequence_counter -color Pink -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_txsequence_counter/tx_sequence_out
add wave -noupdate -height 30 -expand -group TX -group PCS -expand -group tx_sequence_counter -color Pink -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_txsequence_counter/DATA_PAUSE
add wave -noupdate -height 30 -expand -group TX -group PCS -expand -group tx_sequence_counter -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_txsequence_counter/txseq_counter_r
add wave -noupdate -height 30 -expand -group RX -expand -group RX_MII -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/xgmii_rxc
add wave -noupdate -height 30 -expand -group RX -expand -group RX_MII -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/xgmii_rxd
add wave -noupdate -height 30 -expand -group RX -expand -group RX_MII -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/xgmii_rxc
add wave -noupdate -height 30 -expand -group RX -expand -group RX_MII -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/xgmii_rxd
add wave -noupdate -height 30 -expand -group RX -expand -group RX_MII -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/xgmii_rxc
add wave -noupdate -height 30 -expand -group RX -expand -group RX_MII -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/xgmii_rxd
add wave -noupdate -height 30 -expand -group RX -expand -group RX_MII -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/xgmii_rxc
add wave -noupdate -height 30 -expand -group RX -expand -group RX_MII -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/xgmii_rxd
add wave -noupdate -height 30 -expand -group RX -divider REORDER
add wave -noupdate -height 30 -expand -group RX -group fifo_0 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_0/clk
add wave -noupdate -height 30 -expand -group RX -group fifo_0 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_0/rst_n
add wave -noupdate -height 30 -expand -group RX -group fifo_0 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_0/ren
add wave -noupdate -height 30 -expand -group RX -group fifo_0 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_0/wen
add wave -noupdate -height 30 -expand -group RX -group fifo_0 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_0/data_in
add wave -noupdate -height 30 -expand -group RX -group fifo_0 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_0/almost_f
add wave -noupdate -height 30 -expand -group RX -group fifo_0 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_0/full
add wave -noupdate -height 30 -expand -group RX -group fifo_0 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_0/almost_e
add wave -noupdate -height 30 -expand -group RX -group fifo_0 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_0/empty
add wave -noupdate -height 30 -expand -group RX -group fifo_0 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_0/data_out
add wave -noupdate -height 30 -expand -group RX -group fifo_1 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_1/clk
add wave -noupdate -height 30 -expand -group RX -group fifo_1 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_1/rst_n
add wave -noupdate -height 30 -expand -group RX -group fifo_1 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_1/ren
add wave -noupdate -height 30 -expand -group RX -group fifo_1 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_1/wen
add wave -noupdate -height 30 -expand -group RX -group fifo_1 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_1/data_in
add wave -noupdate -height 30 -expand -group RX -group fifo_1 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_1/almost_f
add wave -noupdate -height 30 -expand -group RX -group fifo_1 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_1/full
add wave -noupdate -height 30 -expand -group RX -group fifo_1 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_1/almost_e
add wave -noupdate -height 30 -expand -group RX -group fifo_1 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_1/empty
add wave -noupdate -height 30 -expand -group RX -group fifo_1 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_1/data_out
add wave -noupdate -height 30 -expand -group RX -group fifo_2 /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_2/clk
add wave -noupdate -height 30 -expand -group RX -group fifo_2 /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_2/rst_n
add wave -noupdate -height 30 -expand -group RX -group fifo_2 /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_2/ren
add wave -noupdate -height 30 -expand -group RX -group fifo_2 /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_2/wen
add wave -noupdate -height 30 -expand -group RX -group fifo_2 /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_2/data_in
add wave -noupdate -height 30 -expand -group RX -group fifo_2 /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_2/almost_f
add wave -noupdate -height 30 -expand -group RX -group fifo_2 /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_2/full
add wave -noupdate -height 30 -expand -group RX -group fifo_2 /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_2/almost_e
add wave -noupdate -height 30 -expand -group RX -group fifo_2 /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_2/empty
add wave -noupdate -height 30 -expand -group RX -group fifo_2 /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_2/data_out
add wave -noupdate -height 30 -expand -group RX -group fifo_3 /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_3/clk
add wave -noupdate -height 30 -expand -group RX -group fifo_3 /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_3/rst_n
add wave -noupdate -height 30 -expand -group RX -group fifo_3 /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_3/ren
add wave -noupdate -height 30 -expand -group RX -group fifo_3 /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_3/wen
add wave -noupdate -height 30 -expand -group RX -group fifo_3 /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_3/data_in
add wave -noupdate -height 30 -expand -group RX -group fifo_3 /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_3/almost_f
add wave -noupdate -height 30 -expand -group RX -group fifo_3 /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_3/full
add wave -noupdate -height 30 -expand -group RX -group fifo_3 /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_3/almost_e
add wave -noupdate -height 30 -expand -group RX -group fifo_3 /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_3/empty
add wave -noupdate -height 30 -expand -group RX -group fifo_3 /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_3/data_out
add wave -noupdate -height 30 -expand -group RX -group {Lane Reorder} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/clock
add wave -noupdate -height 30 -expand -group RX -group {Lane Reorder} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/reset
add wave -noupdate -height 30 -expand -group RX -group {Lane Reorder} -radix binary -childformat {{/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/pcs_0_header_out(1) -radix binary} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/pcs_0_header_out(0) -radix binary}} -subitemconfig {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/pcs_0_header_out(1) {-height 16 -radix binary} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/pcs_0_header_out(0) {-height 16 -radix binary}} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/pcs_0_header_out
add wave -noupdate -height 30 -expand -group RX -group {Lane Reorder} -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/pcs_0_data_out
add wave -noupdate -height 30 -expand -group RX -group {Lane Reorder} -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/pcs_1_header_out
add wave -noupdate -height 30 -expand -group RX -group {Lane Reorder} -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/pcs_1_data_out
add wave -noupdate -height 30 -expand -group RX -group {Lane Reorder} -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/pcs_2_header_out
add wave -noupdate -height 30 -expand -group RX -group {Lane Reorder} -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/pcs_2_data_out
add wave -noupdate -height 30 -expand -group RX -group {Lane Reorder} -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/pcs_3_header_out
add wave -noupdate -height 30 -expand -group RX -group {Lane Reorder} -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/pcs_3_data_out
add wave -noupdate -height 30 -expand -group RX -group {Lane Reorder} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/clock
add wave -noupdate -height 30 -expand -group RX -group {Lane Reorder} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/reset
add wave -noupdate -height 30 -expand -group RX -group {Lane Reorder} -group INPUT -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/lane_0_header_in
add wave -noupdate -height 30 -expand -group RX -group {Lane Reorder} -group INPUT -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/lane_0_data_in
add wave -noupdate -height 30 -expand -group RX -group {Lane Reorder} -group INPUT -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/lane_1_header_in
add wave -noupdate -height 30 -expand -group RX -group {Lane Reorder} -group INPUT -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/lane_1_data_in
add wave -noupdate -height 30 -expand -group RX -group {Lane Reorder} -group INPUT -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/lane_2_header_in
add wave -noupdate -height 30 -expand -group RX -group {Lane Reorder} -group INPUT -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/lane_2_data_in
add wave -noupdate -height 30 -expand -group RX -group {Lane Reorder} -group INPUT -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/lane_3_header_in
add wave -noupdate -height 30 -expand -group RX -group {Lane Reorder} -group INPUT -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/lane_3_data_in
add wave -noupdate -height 30 -expand -group RX -group {Lane Reorder} -childformat {{/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.data_0 -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.data_1 -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.data_2 -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.data_3 -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.header_0 -radix binary} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.header_1 -radix binary} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.header_2 -radix binary} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.header_3 -radix binary} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.logical_lane_0 -radix unsigned} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.logical_lane_1 -radix unsigned} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.logical_lane_2 -radix unsigned} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.logical_lane_3 -radix unsigned}} -subitemconfig {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.data_0 {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.data_1 {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.data_2 {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.data_3 {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.header_0 {-height 16 -radix binary} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.header_1 {-height 16 -radix binary} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.header_2 {-height 16 -radix binary} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.header_3 {-height 16 -radix binary} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.logical_lane_0 {-height 16 -radix unsigned} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.logical_lane_1 {-height 16 -radix unsigned} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.logical_lane_2 {-height 16 -radix unsigned} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.logical_lane_3 {-height 16 -radix unsigned}} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew
add wave -noupdate -height 30 -expand -group RX -group {Lane Reorder} -childformat {{/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.data_0 -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.data_1 -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.data_2 -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.data_3 -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.header_0 -radix binary} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.header_1 -radix binary} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.header_2 -radix binary} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.header_3 -radix binary} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.logical_lane_0 -radix unsigned} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.logical_lane_1 -radix unsigned} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.logical_lane_2 -radix unsigned} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.logical_lane_3 -radix unsigned}} -subitemconfig {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.data_0 {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.data_1 {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.data_2 {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.data_3 {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.header_0 {-height 16 -radix binary} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.header_1 {-height 16 -radix binary} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.header_2 {-height 16 -radix binary} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.header_3 {-height 16 -radix binary} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.logical_lane_0 {-height 16 -radix unsigned} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.logical_lane_1 {-height 16 -radix unsigned} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.logical_lane_2 {-height 16 -radix unsigned} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.logical_lane_3 {-height 16 -radix unsigned}} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip
add wave -noupdate -height 30 -expand -group RX -group {Lane Reorder} -childformat {{/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_xbar.data_0 -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_xbar.data_1 -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_xbar.data_2 -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_xbar.data_3 -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_xbar.header_0 -radix binary} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_xbar.header_1 -radix binary} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_xbar.header_2 -radix binary} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_xbar.header_3 -radix binary}} -subitemconfig {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_xbar.data_0 {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_xbar.data_1 {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_xbar.data_2 {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_xbar.data_3 {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_xbar.header_0 {-height 16 -radix binary} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_xbar.header_1 {-height 16 -radix binary} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_xbar.header_2 {-height 16 -radix binary} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_xbar.header_3 {-height 16 -radix binary}} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_xbar
add wave -noupdate -height 30 -expand -group RX -group {Lane Reorder} -group OUTPUT /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/pcs_0_data_out
add wave -noupdate -height 30 -expand -group RX -group {Lane Reorder} -group OUTPUT /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/pcs_1_data_out
add wave -noupdate -height 30 -expand -group RX -group {Lane Reorder} -group OUTPUT /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/pcs_2_data_out
add wave -noupdate -height 30 -expand -group RX -group {Lane Reorder} -group OUTPUT /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/pcs_3_data_out
add wave -noupdate -height 30 -expand -group RX -group {Lane Reorder} -group OUTPUT /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/pcs_0_header_out
add wave -noupdate -height 30 -expand -group RX -group {Lane Reorder} -group OUTPUT /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/pcs_1_header_out
add wave -noupdate -height 30 -expand -group RX -group {Lane Reorder} -group OUTPUT /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/pcs_2_header_out
add wave -noupdate -height 30 -expand -group RX -group {Lane Reorder} -group OUTPUT /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/pcs_3_header_out
add wave -noupdate -height 30 -expand -group RX -divider PCS's
add wave -noupdate -height 30 -expand -group RX -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RXD_Sync
add wave -noupdate -height 30 -expand -group RX -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RXD_Sync
add wave -noupdate -height 30 -expand -group RX -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RXD_Sync
add wave -noupdate -height 30 -expand -group RX -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RXD_Sync
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/Code
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/rx_data
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/coded_data
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/DeScr_RXD_reg
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/DeScr_RXD
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/terminate_out
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group dbg -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/sync_header
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/block_type_dec_r
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/R_TYPE
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/TYPE
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/Next_state
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/Current_state
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/block_type_dec
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/terminate_in
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/start_in
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/start_out
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/Code
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/rx_data
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/coded_data
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/DeScr_RXD_reg
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/DeScr_RXD
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/terminate_out
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group dbg -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/sync_header
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/block_type_dec_r
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/R_TYPE
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/TYPE
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/Next_state
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/Current_state
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/block_type_dec
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/terminate_in
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/TIMER_MAX
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/LOCK_INIT
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/INVALID_SH
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/SLIP
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/SLIP_W
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/TEST_SH
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/VALID_SH
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/RESET_BER
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/GOOD_BER
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/S_HI_BER
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/START_TIMER
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/TEST
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/rstb
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_clk161
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_jtm_en
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/clear_ber_count
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_header_in
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_header_valid_in
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/hi_ber
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/blk_lock
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/linkstatus
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/ber_count
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/slip_out
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/sh_valid
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/timer_done
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_sync_ce
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/start_timer
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/sh_cnt
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/sh_invalid_cnt
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/slip
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/timer
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/ber_cnt
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/LOCK_current
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/visual_RESET_BER_current
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/TIMER_MAX
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/LOCK_INIT
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/INVALID_SH
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/SLIP
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/SLIP_W
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/TEST_SH
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/VALID_SH
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/RESET_BER
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/GOOD_BER
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/S_HI_BER
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/START_TIMER
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/TEST
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/rstb
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_clk161
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_jtm_en
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/clear_ber_count
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_header_in
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_header_valid_in
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/hi_ber
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/blk_lock
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/linkstatus
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/ber_count
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/slip_out
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/sh_valid
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/timer_done
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_sync_ce
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/start_timer
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/sh_cnt
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/sh_invalid_cnt
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/slip
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/timer
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/ber_cnt
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/LOCK_current
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/visual_RESET_BER_current
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Descramble -divider inputs
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/clk
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rstb
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/write_enable
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Descramble -color Khaki /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RXD_Sync
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/bypass_descram
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/clr_jtest_errc
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rx_jtm_en
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/blk_lock
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rx_old_header_in
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rx_old_data_in
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Descramble -divider outputs
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Descramble -color Yellow -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/DeScr_RXD
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Descramble -color Yellow -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtest_errc
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Descramble -color Yellow -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/is_reg_current_equal
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Descramble -divider {sinais internos}
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_data
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_lock
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/blk_ctr
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/zero_ctr
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/ones_ctr
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/LF_ctr
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/LF_bar_ctr
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RXD_input
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RX_Sync_header
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/DeScr_wire_reg
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_d_neq_0
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_d_neq_1
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_d_neq_lf
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_d_neq_lfb
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_err_bit
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rx_old_block
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RXD_hdr_sync
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RXD_hdr_sync_reg
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/rclk
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/wclk
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/rst
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/readen
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/writen
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/writedata
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/spill
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/readdata
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/almostempty
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/almostfull
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/empty
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/full
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Decoder -group R_TYPE_DECOD -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/rstb156
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Decoder -group R_TYPE_DECOD -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/clk156
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Decoder -group R_TYPE_DECOD -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/DeScr_RXD
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Decoder -group R_TYPE_DECOD -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/R_TYPE
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Decoder -group R_TYPE_DECOD -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/rx_data
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Decoder -group R_TYPE_DECOD -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/rx_control
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/clk156
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/rstb156
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/DeScr_RXD
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/clear_errblk
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/hi_ber
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/blk_lock
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/bypass_66decoder
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/rx_data
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/rx_control
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/R_TYPE
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/lpbk
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/terminate_in
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/start_in
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/rxlf
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/rxcontrol
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/rxdata
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/errd_blks
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/terminate_out
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/start_out
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Decoder -divider inputs
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/DeScr_RXD
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/blk_lock
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/bypass_66decoder
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/lpbk
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/clear_errblk
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/clk156
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/hi_ber
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/rstb156
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/terminate_in
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/start_in
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Decoder -divider outputs
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/rxlf
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/errd_blks
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/rxcontrol
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/rxdata
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/terminate_out
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -group PCS0_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/start_out
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/xgmii_rxc
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/xgmii_rxd
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/start_in
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/start_out
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/terminate_in
add wave -noupdate -height 30 -expand -group RX -group PCS_0 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/terminate_out
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/terminate_in
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/terminate_out
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group dbg -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/sync_header
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/block_type_dec_r
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/TYPE
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/Next_state
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/Current_state
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/DeScr_RXD
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/block_type_dec
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/terminate_in
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/terminate_out
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group dbg -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/sync_header
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/block_type_dec_r
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/TYPE
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/Next_state
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/Current_state
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/DeScr_RXD
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/block_type_dec
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/TIMER_MAX
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/LOCK_INIT
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/INVALID_SH
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/SLIP
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/SLIP_W
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/TEST_SH
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/VALID_SH
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/RESET_BER
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/GOOD_BER
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/S_HI_BER
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/START_TIMER
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/TEST
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/rstb
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_clk161
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_jtm_en
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/clear_ber_count
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_header_in
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_header_valid_in
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/hi_ber
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/blk_lock
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/linkstatus
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/ber_count
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/slip_out
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/sh_valid
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/timer_done
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_sync_ce
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/start_timer
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/sh_cnt
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/sh_invalid_cnt
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/slip
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/timer
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/ber_cnt
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/LOCK_current
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/visual_RESET_BER_current
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/TIMER_MAX
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/LOCK_INIT
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/INVALID_SH
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/SLIP
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/SLIP_W
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/TEST_SH
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/VALID_SH
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/RESET_BER
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/GOOD_BER
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/S_HI_BER
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/START_TIMER
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/TEST
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/rstb
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_clk161
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_jtm_en
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/clear_ber_count
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_header_in
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_header_valid_in
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/hi_ber
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/blk_lock
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/linkstatus
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/ber_count
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/slip_out
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/sh_valid
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/timer_done
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_sync_ce
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/start_timer
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/sh_cnt
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/sh_invalid_cnt
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/slip
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/timer
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/ber_cnt
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/LOCK_current
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/visual_RESET_BER_current
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Descramble -divider inputs
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Descramble -color Khaki /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/write_enable
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RXD_Sync
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Descramble -color Khaki /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/bypass_descram
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Descramble -color Khaki /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/clr_jtest_errc
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Descramble -color Khaki /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rx_jtm_en
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Descramble -color Khaki /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/clk
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Descramble -color Khaki /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rstb
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Descramble -color Khaki /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/blk_lock
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Descramble -color Khaki /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rx_old_header_in
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Descramble -divider outputs
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Descramble -color Khaki /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rx_old_data_in
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Descramble -color Yellow /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtest_errc
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Descramble -color Yellow /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/is_reg_current_equal
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Descramble -divider {sinais internos}
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Descramble /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_data
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Descramble /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_lock
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Descramble /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/blk_ctr
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Descramble /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/zero_ctr
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Descramble /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/ones_ctr
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Descramble /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/LF_ctr
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Descramble /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/LF_bar_ctr
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Descramble /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RXD_input
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Descramble /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RX_Sync_header
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Descramble /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/DeScr_wire_reg
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Descramble /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_d_neq_0
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Descramble /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_d_neq_1
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Descramble /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_d_neq_lf
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Descramble /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_d_neq_lfb
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Descramble /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_err_bit
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Descramble /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rx_old_block
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Descramble /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RXD_hdr_sync
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Descramble /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RXD_hdr_sync_reg
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/rclk
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/wclk
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/rst
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/readen
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/writen
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/writedata
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/spill
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/readdata
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/almostempty
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/almostfull
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/empty
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/full
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Decoder -group R_TYPE_DECOD -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/rstb156
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Decoder -group R_TYPE_DECOD -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/clk156
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Decoder -group R_TYPE_DECOD -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/DeScr_RXD
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Decoder -group R_TYPE_DECOD -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/R_TYPE
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Decoder -group R_TYPE_DECOD -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/rx_data
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Decoder -group R_TYPE_DECOD -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/rx_control
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/clk156
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/rstb156
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/DeScr_RXD
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/clear_errblk
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/hi_ber
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/blk_lock
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/bypass_66decoder
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/rx_data
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/rx_control
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/R_TYPE
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/lpbk
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/terminate_in
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/start_in
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/rxlf
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/rxcontrol
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/rxdata
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/errd_blks
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/terminate_out
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/start_out
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Decoder -divider inputs
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/DeScr_RXD
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/blk_lock
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/bypass_66decoder
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/lpbk
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/clear_errblk
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/clk156
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/hi_ber
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/rstb156
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/terminate_in
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/start_in
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Decoder -divider outputs
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/rxlf
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/errd_blks
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/rxcontrol
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/rxdata
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/terminate_out
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -group PCS1_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/start_out
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/xgmii_rxc
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/xgmii_rxd
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/start_in
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/start_out
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/terminate_in
add wave -noupdate -height 30 -expand -group RX -group PCS_1 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/terminate_out
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/terminate_in
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/DeScr_RXD
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/terminate_out
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group dbg -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/sync_header
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/block_type_dec_r
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/TYPE
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/Next_state
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/Current_state
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/DeScr_RXD
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/block_type_dec
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/terminate_in
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/DeScr_RXD
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/terminate_out
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group dbg -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/sync_header
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/block_type_dec_r
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/TYPE
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/Next_state
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/Current_state
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/DeScr_RXD
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/block_type_dec
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/TIMER_MAX
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/LOCK_INIT
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/INVALID_SH
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/SLIP
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/SLIP_W
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/TEST_SH
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/VALID_SH
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/RESET_BER
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/GOOD_BER
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/S_HI_BER
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/START_TIMER
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/TEST
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/rstb
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_clk161
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_jtm_en
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/clear_ber_count
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_header_in
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_header_valid_in
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/hi_ber
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/blk_lock
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/linkstatus
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/ber_count
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/slip_out
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/sh_valid
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/timer_done
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_sync_ce
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/start_timer
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/sh_cnt
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/sh_invalid_cnt
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/slip
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/timer
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/ber_cnt
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/LOCK_current
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/visual_RESET_BER_current
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/TIMER_MAX
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/LOCK_INIT
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/INVALID_SH
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/SLIP
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/SLIP_W
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/TEST_SH
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/VALID_SH
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/RESET_BER
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/GOOD_BER
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/S_HI_BER
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/START_TIMER
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/TEST
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/rstb
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_clk161
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_jtm_en
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/clear_ber_count
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_header_in
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_header_valid_in
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/hi_ber
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/blk_lock
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/linkstatus
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/ber_count
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/slip_out
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/sh_valid
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/timer_done
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_sync_ce
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/start_timer
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/sh_cnt
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/sh_invalid_cnt
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/slip
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/timer
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/ber_cnt
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/LOCK_current
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/visual_RESET_BER_current
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Descramble -divider inputs
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/write_enable
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RXD_Sync
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/bypass_descram
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/clr_jtest_errc
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rx_jtm_en
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/clk
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rstb
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/blk_lock
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rx_old_header_in
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rx_old_data_in
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Descramble -divider outputs
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Descramble -color Yellow -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/DeScr_RXD
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Descramble -color Yellow -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtest_errc
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Descramble -color Yellow -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/is_reg_current_equal
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Descramble -divider {sinais internos}
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_data
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_lock
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/blk_ctr
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/zero_ctr
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/ones_ctr
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/LF_ctr
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/LF_bar_ctr
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RXD_input
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RX_Sync_header
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/DeScr_wire
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/DeScr_wire_reg
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_d_neq_0
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_d_neq_1
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_d_neq_lf
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_d_neq_lfb
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_err_bit
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rx_old_block
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rx_old_block_desc
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RXD_data_sync
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RXD_hdr_sync
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RXD_hdr_sync_reg
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/rclk
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/wclk
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/rst
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/readen
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/writen
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/writedata
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/spill
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/readdata
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/almostempty
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/almostfull
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/empty
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/full
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Decoder -group R_TYPE_DECODE -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/rstb156
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Decoder -group R_TYPE_DECODE -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/clk156
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Decoder -group R_TYPE_DECODE -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/DeScr_RXD
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Decoder -group R_TYPE_DECODE -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/R_TYPE
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Decoder -group R_TYPE_DECODE -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/rx_data
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Decoder -group R_TYPE_DECODE -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/rx_control
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/clk156
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/rstb156
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/DeScr_RXD
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/clear_errblk
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/hi_ber
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/blk_lock
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/bypass_66decoder
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/rx_data
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/rx_control
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/R_TYPE
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/lpbk
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/terminate_in
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/start_in
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/rxlf
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/rxcontrol
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/rxdata
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/errd_blks
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/terminate_out
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/start_out
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Decoder -divider inputs
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/DeScr_RXD
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/blk_lock
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/bypass_66decoder
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/lpbk
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/clear_errblk
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/clk156
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/hi_ber
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/rstb156
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/terminate_in
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/start_in
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Decoder -divider outputs
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/rxlf
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/errd_blks
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/rxcontrol
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/rxdata
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/terminate_out
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -group PCS2_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/start_out
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/xgmii_rxc
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/xgmii_rxd
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/start_in
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/start_out
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/terminate_in
add wave -noupdate -height 30 -expand -group RX -group PCS_2 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/terminate_out
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/terminate_in
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/terminate_out
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group dbg -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/sync_header
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/block_type_dec_r
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/TYPE
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/Next_state
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/Current_state
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/DeScr_RXD
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/block_type_dec
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/terminate_in
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/terminate_out
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group dbg -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/sync_header
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/block_type_dec_r
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/TYPE
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/Next_state
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/Current_state
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/DeScr_RXD
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/block_type_dec
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/TIMER_MAX
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/LOCK_INIT
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/INVALID_SH
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/SLIP
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/SLIP_W
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/TEST_SH
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/VALID_SH
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/RESET_BER
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/GOOD_BER
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/S_HI_BER
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/START_TIMER
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/TEST
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/rstb
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_clk161
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_jtm_en
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/clear_ber_count
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_header_in
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_header_valid_in
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/hi_ber
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/blk_lock
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/linkstatus
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/ber_count
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/slip_out
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/sh_valid
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/timer_done
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_sync_ce
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/start_timer
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/sh_cnt
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/sh_invalid_cnt
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/slip
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/timer
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/ber_cnt
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/LOCK_current
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/visual_RESET_BER_current
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/TIMER_MAX
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/LOCK_INIT
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/INVALID_SH
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/SLIP
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/SLIP_W
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/TEST_SH
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/VALID_SH
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/RESET_BER
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/GOOD_BER
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/S_HI_BER
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/START_TIMER
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/TEST
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/rstb
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_clk161
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_jtm_en
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/clear_ber_count
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_header_in
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_header_valid_in
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/hi_ber
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/blk_lock
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/linkstatus
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/ber_count
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/slip_out
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/sh_valid
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/timer_done
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_sync_ce
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/start_timer
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/sh_cnt
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/sh_invalid_cnt
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/slip
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/timer
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/ber_cnt
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/LOCK_current
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/visual_RESET_BER_current
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Descramble -divider inputs
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/write_enable
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RXD_Sync
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/bypass_descram
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/clr_jtest_errc
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rx_jtm_en
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/clk
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rstb
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/blk_lock
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rx_old_header_in
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rx_old_data_in
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Descramble -divider outputs
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Descramble -color Yellow -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/DeScr_RXD
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Descramble -color Yellow -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtest_errc
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Descramble -color Yellow -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/is_reg_current_equal
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Descramble -divider {sinais internos}
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_data
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_lock
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/blk_ctr
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/zero_ctr
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/ones_ctr
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/LF_ctr
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/LF_bar_ctr
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RXD_input
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RX_Sync_header
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/DeScr_wire
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/DeScr_wire_reg
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_d_neq_0
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_d_neq_1
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_d_neq_lf
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_d_neq_lfb
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_err_bit
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rx_old_block
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rx_old_block_desc
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RXD_data_sync
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RXD_hdr_sync
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RXD_hdr_sync_reg
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/rclk
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/wclk
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/rst
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/readen
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/writen
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/writedata
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/spill
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/readdata
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/almostempty
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/almostfull
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/empty
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/full
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Decoder -group R_TYPE_DECOD -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/rstb156
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Decoder -group R_TYPE_DECOD -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/clk156
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Decoder -group R_TYPE_DECOD -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/DeScr_RXD
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Decoder -group R_TYPE_DECOD -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/R_TYPE
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Decoder -group R_TYPE_DECOD -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/rx_data
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Decoder -group R_TYPE_DECOD -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/rx_control
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/clk156
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/rstb156
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/DeScr_RXD
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/clear_errblk
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/hi_ber
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/blk_lock
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/bypass_66decoder
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/rx_data
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/rx_control
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/R_TYPE
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/lpbk
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/terminate_in
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/start_in
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/rxlf
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/rxcontrol
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/rxdata
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/errd_blks
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/terminate_out
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/start_out
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Decoder -divider inputs
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/DeScr_RXD
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/blk_lock
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/bypass_66decoder
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/lpbk
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/clear_errblk
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/clk156
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/hi_ber
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/rstb156
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/terminate_in
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/start_in
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Decoder -divider outputs
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/rxlf
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/errd_blks
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/rxcontrol
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/rxdata
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/terminate_out
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -group PCS3_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/start_out
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/xgmii_rxc
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/xgmii_rxd
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/start_in
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/start_out
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/terminate_in
add wave -noupdate -height 30 -expand -group RX -group PCS_3 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/terminate_out
add wave -noupdate -height 30 -expand -group RX -divider REORDER
add wave -noupdate -height 30 -expand -group RX -group shuffle /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/shuffle_lanes/in_0
add wave -noupdate -height 30 -expand -group RX -group shuffle /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/shuffle_lanes/in_1
add wave -noupdate -height 30 -expand -group RX -group shuffle /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/shuffle_lanes/in_2
add wave -noupdate -height 30 -expand -group RX -group shuffle /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/shuffle_lanes/in_3
add wave -noupdate -height 30 -expand -group RX -group shuffle -radix unsigned /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/shuffle_lanes/lane_0
add wave -noupdate -height 30 -expand -group RX -group shuffle -radix unsigned /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/shuffle_lanes/lane_1
add wave -noupdate -height 30 -expand -group RX -group shuffle -radix unsigned /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/shuffle_lanes/lane_2
add wave -noupdate -height 30 -expand -group RX -group shuffle -radix unsigned /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/shuffle_lanes/lane_3
add wave -noupdate -height 30 -expand -group RX -group shuffle /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/shuffle_lanes/out_0
add wave -noupdate -height 30 -expand -group RX -group shuffle /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/shuffle_lanes/out_1
add wave -noupdate -height 30 -expand -group RX -group shuffle /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/shuffle_lanes/out_2
add wave -noupdate -height 30 -expand -group RX -group shuffle /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/shuffle_lanes/out_3
add wave -noupdate -height 30 -expand -group RX -divider -height 20 {CORE INTERFACE}
add wave -noupdate -height 30 -expand -group RX -group Controller -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/xgmii_rxc_0
add wave -noupdate -height 30 -expand -group RX -group Controller -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/xgmii_rxd_0
add wave -noupdate -height 30 -expand -group RX -group Controller -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/xgmii_rxc_1
add wave -noupdate -height 30 -expand -group RX -group Controller -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/xgmii_rxd_1
add wave -noupdate -height 30 -expand -group RX -group Controller -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/xgmii_rxc_2
add wave -noupdate -height 30 -expand -group RX -group Controller -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/xgmii_rxd_2
add wave -noupdate -height 30 -expand -group RX -group Controller -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/xgmii_rxc_3
add wave -noupdate -height 30 -expand -group RX -group Controller -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/xgmii_rxd_3
add wave -noupdate -height 30 -expand -group RX -group Controller -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/ctrl_delay
add wave -noupdate -height 30 -expand -group RX -group Controller -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/shift_out
add wave -noupdate -height 30 -expand -group RX -group Controller -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/shift_out_int
add wave -noupdate -height 30 -expand -group RX -group Controller -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/shift_out_reg
add wave -noupdate -height 30 -expand -group RX -group Controller -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/shift_eop
add wave -noupdate -height 30 -expand -group RX -group Controller -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/shift_eop_reg
add wave -noupdate -height 30 -expand -group RX -group Controller -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/shift_out_reg_reg
add wave -noupdate -height 30 -expand -group RX -group Controller -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/sop_location
add wave -noupdate -height 30 -expand -group RX -group Controller -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/eop_location
add wave -noupdate -height 30 -expand -group RX -group Controller -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/eop_location_calc
add wave -noupdate -height 30 -expand -group RX -group Controller /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/ctrl_delay_int
add wave -noupdate -height 30 -expand -group RX -group Controller /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/ctrl_delay_reg
add wave -noupdate -height 30 -expand -group RX -group Controller /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/eop_location_out
add wave -noupdate -height 30 -expand -group RX -group Controller /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/eop_location_calc_reg
add wave -noupdate -height 30 -expand -group RX -group Controller /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/eop_location_calc_reg_reg
add wave -noupdate -height 30 -expand -group RX -group Controller /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/eop_location_calc_reg_reg_reg
add wave -noupdate -height 30 -expand -group RX -group Controller -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/shift_calc
add wave -noupdate -height 30 -expand -group RX -group Controller /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/wen_fifo_reg
add wave -noupdate -height 30 -expand -group RX -group Controller /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/sop_eop_same_cycle
add wave -noupdate -height 30 -expand -group RX -group Controller /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/sop7_eop_same_cycle
add wave -noupdate -height 30 -expand -group RX -group Controller /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/sop7_eop_same_cycle_reg
add wave -noupdate -height 30 -expand -group RX -group Controller /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/sop_eop_same_cycle_reg
add wave -noupdate -height 30 -expand -group RX -group Controller /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/sop_eop_same_cycle_reg_reg
add wave -noupdate -height 30 -expand -group RX -group Shift_reg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shift_reg/xgmii_rxd_0
add wave -noupdate -height 30 -expand -group RX -group Shift_reg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shift_reg/xgmii_rxd_1
add wave -noupdate -height 30 -expand -group RX -group Shift_reg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shift_reg/xgmii_rxd_2
add wave -noupdate -height 30 -expand -group RX -group Shift_reg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shift_reg/xgmii_rxd_3
add wave -noupdate -height 30 -expand -group RX -group Shift_reg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shift_reg/ctrl
add wave -noupdate -height 30 -expand -group RX -group Shift_reg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shift_reg/out_0
add wave -noupdate -height 30 -expand -group RX -group Shift_reg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shift_reg/out_1
add wave -noupdate -height 30 -expand -group RX -group Shifter -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0
add wave -noupdate -height 30 -expand -group RX -group Shifter -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_1
add wave -noupdate -height 30 -expand -group RX -group Shifter -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/ctrl_reg_shift
add wave -noupdate -height 30 -expand -group RX -group fifo_BRAM /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/rst_n
add wave -noupdate -height 30 -expand -group RX -group fifo_BRAM /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/clk_w
add wave -noupdate -height 30 -expand -group RX -group fifo_BRAM /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/wen
add wave -noupdate -height 30 -expand -group RX -group fifo_BRAM -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/data_in
add wave -noupdate -height 30 -expand -group RX -group fifo_BRAM /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/is_sop_in
add wave -noupdate -height 30 -expand -group RX -group fifo_BRAM /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/eop_addr_in
add wave -noupdate -height 30 -expand -group RX -group fifo_BRAM /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/clk_r
add wave -noupdate -height 30 -expand -group RX -group fifo_BRAM /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/ren
add wave -noupdate -height 30 -expand -group RX -group fifo_BRAM /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/empty
add wave -noupdate -height 30 -expand -group RX -group fifo_BRAM /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/full
add wave -noupdate -height 30 -expand -group RX -group fifo_BRAM -color Gold -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/data_out
add wave -noupdate -height 30 -expand -group RX -group fifo_BRAM -color Gold -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/is_sop_out
add wave -noupdate -height 30 -expand -group RX -group fifo_BRAM -color Gold -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/eop_addr_out
add wave -noupdate -height 30 -expand -group RX -group fifo_BRAM -divider dbug
add wave -noupdate -height 30 -expand -group RX -group fifo_BRAM -expand -group low_0 /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/FIFO_inst_l_0/WREN
add wave -noupdate -height 30 -expand -group RX -group fifo_BRAM -expand -group low_0 /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/FIFO_inst_l_0/RDEN
add wave -noupdate -height 30 -expand -group RX -group fifo_BRAM -expand -group low_0 -color {Slate Blue} -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/mem_low_in_0
add wave -noupdate -height 30 -expand -group RX -group fifo_BRAM -expand -group low_0 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/mem_low_in_0_reg
add wave -noupdate -height 30 -expand -group RX -group fifo_BRAM -expand -group low_0 /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/FIFO_inst_l_0/FULL
add wave -noupdate -height 30 -expand -group RX -group fifo_BRAM -expand -group low_0 /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/FIFO_inst_l_0/EMPTY
add wave -noupdate -height 30 -expand -group RX -group fifo_BRAM -expand -group low_0 /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/FIFO_inst_l_0/DO
add wave -noupdate -height 30 -expand -group RX -group fifo_BRAM -expand -group low_1 /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/FIFO_inst_l_1/WREN
add wave -noupdate -height 30 -expand -group RX -group fifo_BRAM -expand -group low_1 /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/FIFO_inst_l_1/RDEN
add wave -noupdate -height 30 -expand -group RX -group fifo_BRAM -expand -group low_1 -color {Slate Blue} -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/mem_low_in_1
add wave -noupdate -height 30 -expand -group RX -group fifo_BRAM -expand -group low_1 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/mem_low_in_1_reg
add wave -noupdate -height 30 -expand -group RX -group fifo_BRAM -expand -group low_1 /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/FIFO_inst_l_1/FULL
add wave -noupdate -height 30 -expand -group RX -group fifo_BRAM -expand -group low_1 /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/FIFO_inst_l_1/EMPTY
add wave -noupdate -height 30 -expand -group RX -group fifo_BRAM -expand -group low_1 /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/FIFO_inst_l_1/DO
add wave -noupdate -height 30 -expand -group RX -group fifo_BRAM -expand -group high_0 /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/FIFO_inst_h_0/WREN
add wave -noupdate -height 30 -expand -group RX -group fifo_BRAM -expand -group high_0 /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/FIFO_inst_h_0/RDEN
add wave -noupdate -height 30 -expand -group RX -group fifo_BRAM -expand -group high_0 -color {Slate Blue} -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/mem_high_in_0
add wave -noupdate -height 30 -expand -group RX -group fifo_BRAM -expand -group high_0 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/mem_high_in_0_reg
add wave -noupdate -height 30 -expand -group RX -group fifo_BRAM -expand -group high_0 /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/FIFO_inst_h_0/FULL
add wave -noupdate -height 30 -expand -group RX -group fifo_BRAM -expand -group high_0 /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/FIFO_inst_h_0/EMPTY
add wave -noupdate -height 30 -expand -group RX -group fifo_BRAM -expand -group high_0 /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/FIFO_inst_h_0/DO
add wave -noupdate -height 30 -expand -group RX -group fifo_BRAM -expand -group high_1 /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/FIFO_inst_h_1/WREN
add wave -noupdate -height 30 -expand -group RX -group fifo_BRAM -expand -group high_1 /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/FIFO_inst_h_1/RDEN
add wave -noupdate -height 30 -expand -group RX -group fifo_BRAM -expand -group high_1 -color {Slate Blue} -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/mem_high_in_1
add wave -noupdate -height 30 -expand -group RX -group fifo_BRAM -expand -group high_1 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/mem_high_in_1_reg
add wave -noupdate -height 30 -expand -group RX -group fifo_BRAM -expand -group high_1 /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/FIFO_inst_h_1/FULL
add wave -noupdate -height 30 -expand -group RX -group fifo_BRAM -expand -group high_1 /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/FIFO_inst_h_1/EMPTY
add wave -noupdate -height 30 -expand -group RX -group fifo_BRAM -expand -group high_1 /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/FIFO_inst_h_1/DO
add wave -noupdate -divider {MAC RX}
add wave -noupdate -expand -group CRC /Top/rx_xgt4/inst_wrapper_macpcs/INST_crc_rx/ps_crc
add wave -noupdate -expand -group CRC -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_crc_rx/eop_reg
add wave -noupdate -expand -group CRC -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_crc_rx/d64_reg
add wave -noupdate -expand -group CRC -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_crc_rx/input_reg
add wave -noupdate -expand -group CRC /Top/rx_xgt4/inst_wrapper_macpcs/INST_crc_rx/crc_ok
add wave -noupdate -expand -group CRC -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_crc_rx/crc_value
add wave -noupdate -expand -group CRC -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_crc_rx/crc_final
add wave -noupdate -expand -group CRC -radix unsigned /Top/rx_xgt4/inst_wrapper_macpcs/INST_crc_rx/d8_bytes
add wave -noupdate -expand -group CRC /Top/rx_xgt4/inst_wrapper_macpcs/INST_crc_rx/crc_done
add wave -noupdate -expand -group CRC -radix unsigned /Top/rx_xgt4/inst_wrapper_macpcs/INST_crc_rx/frame_len
add wave -noupdate -expand -group CRC -radix unsigned /Top/rx_xgt4/inst_wrapper_macpcs/INST_crc_rx/byte_counter
add wave -noupdate -divider {PLOT PYTHON}
add wave -noupdate -group {SINAIS PARA LISTA} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_0/w_ptr
add wave -noupdate -group {SINAIS PARA LISTA} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_0/r_ptr
add wave -noupdate -group {SINAIS PARA LISTA} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_1/w_ptr
add wave -noupdate -group {SINAIS PARA LISTA} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_1/r_ptr
add wave -noupdate -group {SINAIS PARA LISTA} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_2/w_ptr
add wave -noupdate -group {SINAIS PARA LISTA} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_2/r_ptr
add wave -noupdate -group {SINAIS PARA LISTA} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_3/w_ptr
add wave -noupdate -group {SINAIS PARA LISTA} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_3/r_ptr
add wave -noupdate -group {SINAIS PARA LISTA} /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_TX_PATH_FIFO/wr_count
add wave -noupdate -group {SINAIS PARA LISTA} /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_TX_PATH_FIFO/rd_count
add wave -noupdate -group {SINAIS PARA LISTA} /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/wr_count
add wave -noupdate -group {SINAIS PARA LISTA} /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/rd_count
add wave -noupdate -group {SINAIS PARA LISTA} /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/wr_count
add wave -noupdate -group {SINAIS PARA LISTA} /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/rd_count
add wave -noupdate -group {SINAIS PARA LISTA} /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/wr_count
add wave -noupdate -group {SINAIS PARA LISTA} /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/rd_count
add wave -noupdate -group {SINAIS PARA LISTA} /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/wr_count
add wave -noupdate -group {SINAIS PARA LISTA} /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/rd_count
add wave -noupdate -group {SINAIS PARA LISTA} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/w_ptr
add wave -noupdate -group {SINAIS PARA LISTA} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/r_ptr_h
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{falta blobo 07 no PCS0} {2038400 ps} 1} {{pkt 42 codificado em erro} {10550400 ps} 1} {{entrada em data_in (pkt_id=43)} {3024000 ps} 1} {{Cursor 4} {3140800 ps} 0}
quietly wave cursor active 4
configure wave -namecolwidth 653
configure wave -valuecolwidth 159
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {3121485 ps} {3156043 ps}
bookmark add wave bookmark105 {{770754 ps} {811500 ps}} 13
bookmark add wave bookmark106 {{780000 ps} {800000 ps}} 8
bookmark add wave bookmark107 {{0 ps} {42010 ps}} 0
bookmark add wave bookmark108 {{201305 ps} {266263 ps}} 7
bookmark add wave bookmark109 {{728057 ps} {794311 ps}} 6
bookmark add wave bookmark110 {{1931987 ps} {1965959 ps}} 9
