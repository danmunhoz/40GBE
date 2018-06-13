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
add wave -noupdate -height 30 -expand -group TX -radix hexadecimal /Top/tx_xgt4/data_out
add wave -noupdate -height 30 -expand -group TX /Top/tx_xgt4/header_out
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
add wave -noupdate -height 30 -expand -group TX -group PCS -group Encode -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_TX_PATH_ENCODE/bypass_66encoder
add wave -noupdate -height 30 -expand -group TX -group PCS -group Encode -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_TX_PATH_ENCODE/clk156
add wave -noupdate -height 30 -expand -group TX -group PCS -group Encode -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_TX_PATH_ENCODE/rstb
add wave -noupdate -height 30 -expand -group TX -group PCS -group Encode -color Gold -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_TX_PATH_ENCODE/txcontrol
add wave -noupdate -height 30 -expand -group TX -group PCS -group Encode -color Gold -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_TX_PATH_ENCODE/txdata
add wave -noupdate -height 30 -expand -group TX -group PCS -group Encode -color Pink -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_TX_PATH_ENCODE/TXD_encoded
add wave -noupdate -height 30 -expand -group TX -group PCS -group Encode -color Pink -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_TX_PATH_ENCODE/txlf
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
add wave -noupdate -height 30 -expand -group TX -group PCS -expand -group FIFO -color Khaki -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_TX_PATH_FIFO/empty
add wave -noupdate -height 30 -expand -group TX -group PCS -expand -group FIFO -color Khaki -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_TX_PATH_FIFO/full
add wave -noupdate -height 30 -expand -group TX -group PCS -group Scramble -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_TX_PATH_SCRAMBLE/tx_jtm_en
add wave -noupdate -height 30 -expand -group TX -group PCS -group Scramble -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_TX_PATH_SCRAMBLE/jtm_dps_0
add wave -noupdate -height 30 -expand -group TX -group PCS -group Scramble -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_TX_PATH_SCRAMBLE/jtm_dps_1
add wave -noupdate -height 30 -expand -group TX -group PCS -group Scramble -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_TX_PATH_SCRAMBLE/bypass_scram
add wave -noupdate -height 30 -expand -group TX -group PCS -group Scramble -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_TX_PATH_SCRAMBLE/clk
add wave -noupdate -height 30 -expand -group TX -group PCS -group Scramble -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_TX_PATH_SCRAMBLE/rst
add wave -noupdate -height 30 -expand -group TX -group PCS -group Scramble -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_TX_PATH_SCRAMBLE/seed_A
add wave -noupdate -height 30 -expand -group TX -group PCS -group Scramble -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_TX_PATH_SCRAMBLE/seed_B
add wave -noupdate -height 30 -expand -group TX -group PCS -group Scramble -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_TX_PATH_SCRAMBLE/TXD_encoded
add wave -noupdate -height 30 -expand -group TX -group PCS -group Scramble -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_TX_PATH_SCRAMBLE/scram_en
add wave -noupdate -height 30 -expand -group TX -group PCS -group Scramble -color Pink -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_TX_PATH_SCRAMBLE/TXD_Scr
add wave -noupdate -height 30 -expand -group TX -group PCS -expand -group tx_sequence_counter -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_txsequence_counter/clk_161_in
add wave -noupdate -height 30 -expand -group TX -group PCS -expand -group tx_sequence_counter -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_txsequence_counter/reset_n_in
add wave -noupdate -height 30 -expand -group TX -group PCS -expand -group tx_sequence_counter -color Pink -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_txsequence_counter/tx_sequence_out
add wave -noupdate -height 30 -expand -group TX -group PCS -expand -group tx_sequence_counter -color Pink -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_txsequence_counter/DATA_PAUSE
add wave -noupdate -height 30 -expand -group TX -group PCS -expand -group tx_sequence_counter -radix hexadecimal /Top/tx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_txsequence_counter/txseq_counter_r
add wave -noupdate -group fiber -expand -group lane_0 -radix hexadecimal /Top/fiber/block_out_0
add wave -noupdate -group fiber -expand -group lane_0 /Top/fiber/header_out_0
add wave -noupdate -group fiber -expand -group lane_0 /Top/fiber/valid_out_0
add wave -noupdate -group fiber -expand -group lane_1 -radix hexadecimal /Top/fiber/block_out_1
add wave -noupdate -group fiber -expand -group lane_1 /Top/fiber/header_out_1
add wave -noupdate -group fiber -expand -group lane_1 /Top/fiber/valid_out_1
add wave -noupdate -group fiber -expand -group lane_2 -radix hexadecimal /Top/fiber/block_out_2
add wave -noupdate -group fiber -expand -group lane_2 /Top/fiber/header_out_2
add wave -noupdate -group fiber -expand -group lane_2 /Top/fiber/valid_out_2
add wave -noupdate -group fiber -expand -group lane_3 -radix hexadecimal /Top/fiber/block_out_3
add wave -noupdate -group fiber -expand -group lane_3 /Top/fiber/header_out_3
add wave -noupdate -group fiber -expand -group lane_3 /Top/fiber/valid_out_3
add wave -noupdate -height 30 -group RX -expand -group reg_old_block -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/pcs_3_header_out
add wave -noupdate -height 30 -group RX -expand -group reg_old_block -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/pcs_3_data_out
add wave -noupdate -height 30 -group RX -expand -group reg_old_block -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/old_header_0
add wave -noupdate -height 30 -group RX -expand -group reg_old_block -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/old_data_0
add wave -noupdate -height 30 -group RX -expand -group RX_MII -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/xgmii_rxc
add wave -noupdate -height 30 -group RX -expand -group RX_MII -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/xgmii_rxd
add wave -noupdate -height 30 -group RX -expand -group RX_MII -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/xgmii_rxc
add wave -noupdate -height 30 -group RX -expand -group RX_MII -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/xgmii_rxd
add wave -noupdate -height 30 -group RX -expand -group RX_MII -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/xgmii_rxc
add wave -noupdate -height 30 -group RX -expand -group RX_MII -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/xgmii_rxd
add wave -noupdate -height 30 -group RX -expand -group RX_MII -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/xgmii_rxc
add wave -noupdate -height 30 -group RX -expand -group RX_MII -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/xgmii_rxd
add wave -noupdate -height 30 -group RX -divider REORDER
add wave -noupdate -height 30 -group RX -group fifo_0 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_0/clk
add wave -noupdate -height 30 -group RX -group fifo_0 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_0/rst_n
add wave -noupdate -height 30 -group RX -group fifo_0 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_0/ren
add wave -noupdate -height 30 -group RX -group fifo_0 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_0/wen
add wave -noupdate -height 30 -group RX -group fifo_0 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_0/data_in
add wave -noupdate -height 30 -group RX -group fifo_0 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_0/almost_f
add wave -noupdate -height 30 -group RX -group fifo_0 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_0/full
add wave -noupdate -height 30 -group RX -group fifo_0 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_0/almost_e
add wave -noupdate -height 30 -group RX -group fifo_0 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_0/empty
add wave -noupdate -height 30 -group RX -group fifo_0 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_0/data_out
add wave -noupdate -height 30 -group RX -group fifo_1 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_1/clk
add wave -noupdate -height 30 -group RX -group fifo_1 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_1/rst_n
add wave -noupdate -height 30 -group RX -group fifo_1 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_1/ren
add wave -noupdate -height 30 -group RX -group fifo_1 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_1/wen
add wave -noupdate -height 30 -group RX -group fifo_1 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_1/data_in
add wave -noupdate -height 30 -group RX -group fifo_1 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_1/almost_f
add wave -noupdate -height 30 -group RX -group fifo_1 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_1/full
add wave -noupdate -height 30 -group RX -group fifo_1 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_1/almost_e
add wave -noupdate -height 30 -group RX -group fifo_1 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_1/empty
add wave -noupdate -height 30 -group RX -group fifo_1 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_1/data_out
add wave -noupdate -height 30 -group RX -group fifo_2 /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_2/clk
add wave -noupdate -height 30 -group RX -group fifo_2 /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_2/rst_n
add wave -noupdate -height 30 -group RX -group fifo_2 /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_2/ren
add wave -noupdate -height 30 -group RX -group fifo_2 /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_2/wen
add wave -noupdate -height 30 -group RX -group fifo_2 /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_2/data_in
add wave -noupdate -height 30 -group RX -group fifo_2 /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_2/almost_f
add wave -noupdate -height 30 -group RX -group fifo_2 /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_2/full
add wave -noupdate -height 30 -group RX -group fifo_2 /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_2/almost_e
add wave -noupdate -height 30 -group RX -group fifo_2 /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_2/empty
add wave -noupdate -height 30 -group RX -group fifo_2 /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_2/data_out
add wave -noupdate -height 30 -group RX -group fifo_3 /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_3/clk
add wave -noupdate -height 30 -group RX -group fifo_3 /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_3/rst_n
add wave -noupdate -height 30 -group RX -group fifo_3 /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_3/ren
add wave -noupdate -height 30 -group RX -group fifo_3 /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_3/wen
add wave -noupdate -height 30 -group RX -group fifo_3 /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_3/data_in
add wave -noupdate -height 30 -group RX -group fifo_3 /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_3/almost_f
add wave -noupdate -height 30 -group RX -group fifo_3 /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_3/full
add wave -noupdate -height 30 -group RX -group fifo_3 /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_3/almost_e
add wave -noupdate -height 30 -group RX -group fifo_3 /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_3/empty
add wave -noupdate -height 30 -group RX -group fifo_3 /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_3/data_out
add wave -noupdate -height 30 -group RX -group {Lane Reorder} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/clock
add wave -noupdate -height 30 -group RX -group {Lane Reorder} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/reset
add wave -noupdate -height 30 -group RX -group {Lane Reorder} -radix binary -childformat {{/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/pcs_0_header_out(1) -radix binary} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/pcs_0_header_out(0) -radix binary}} -subitemconfig {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/pcs_0_header_out(1) {-height 16 -radix binary} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/pcs_0_header_out(0) {-height 16 -radix binary}} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/pcs_0_header_out
add wave -noupdate -height 30 -group RX -group {Lane Reorder} -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/pcs_0_data_out
add wave -noupdate -height 30 -group RX -group {Lane Reorder} -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/pcs_1_header_out
add wave -noupdate -height 30 -group RX -group {Lane Reorder} -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/pcs_1_data_out
add wave -noupdate -height 30 -group RX -group {Lane Reorder} -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/pcs_2_header_out
add wave -noupdate -height 30 -group RX -group {Lane Reorder} -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/pcs_2_data_out
add wave -noupdate -height 30 -group RX -group {Lane Reorder} -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/pcs_3_header_out
add wave -noupdate -height 30 -group RX -group {Lane Reorder} -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/pcs_3_data_out
add wave -noupdate -height 30 -group RX -group {Lane Reorder} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/clock
add wave -noupdate -height 30 -group RX -group {Lane Reorder} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/reset
add wave -noupdate -height 30 -group RX -group {Lane Reorder} -expand -group INPUT -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/lane_0_header_in
add wave -noupdate -height 30 -group RX -group {Lane Reorder} -expand -group INPUT -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/lane_0_data_in
add wave -noupdate -height 30 -group RX -group {Lane Reorder} -expand -group INPUT -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/lane_1_header_in
add wave -noupdate -height 30 -group RX -group {Lane Reorder} -expand -group INPUT -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/lane_1_data_in
add wave -noupdate -height 30 -group RX -group {Lane Reorder} -expand -group INPUT -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/lane_2_header_in
add wave -noupdate -height 30 -group RX -group {Lane Reorder} -expand -group INPUT -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/lane_2_data_in
add wave -noupdate -height 30 -group RX -group {Lane Reorder} -expand -group INPUT -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/lane_3_header_in
add wave -noupdate -height 30 -group RX -group {Lane Reorder} -expand -group INPUT -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/lane_3_data_in
add wave -noupdate -height 30 -group RX -group {Lane Reorder} -expand -group INPUT /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/lane_0_valid_in
add wave -noupdate -height 30 -group RX -group {Lane Reorder} -expand -group INPUT /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/lane_1_valid_in
add wave -noupdate -height 30 -group RX -group {Lane Reorder} -expand -group INPUT /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/lane_2_valid_in
add wave -noupdate -height 30 -group RX -group {Lane Reorder} -expand -group INPUT /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/lane_3_valid_in
add wave -noupdate -height 30 -group RX -group {Lane Reorder} -childformat {{/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.data_0 -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.data_1 -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.data_2 -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.data_3 -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.header_0 -radix binary} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.header_1 -radix binary} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.header_2 -radix binary} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.header_3 -radix binary} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.logical_lane_0 -radix unsigned} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.logical_lane_1 -radix unsigned} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.logical_lane_2 -radix unsigned} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.logical_lane_3 -radix unsigned}} -subitemconfig {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.data_0 {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.data_1 {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.data_2 {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.data_3 {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.header_0 {-height 16 -radix binary} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.header_1 {-height 16 -radix binary} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.header_2 {-height 16 -radix binary} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.header_3 {-height 16 -radix binary} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.logical_lane_0 {-height 16 -radix unsigned} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.logical_lane_1 {-height 16 -radix unsigned} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.logical_lane_2 {-height 16 -radix unsigned} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.logical_lane_3 {-height 16 -radix unsigned}} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew
add wave -noupdate -height 30 -group RX -group {Lane Reorder} -childformat {{/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.data_0 -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.data_1 -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.data_2 -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.data_3 -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.header_0 -radix binary} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.header_1 -radix binary} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.header_2 -radix binary} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.header_3 -radix binary} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.logical_lane_0 -radix unsigned} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.logical_lane_1 -radix unsigned} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.logical_lane_2 -radix unsigned} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.logical_lane_3 -radix unsigned}} -subitemconfig {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.data_0 {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.data_1 {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.data_2 {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.data_3 {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.header_0 {-height 16 -radix binary} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.header_1 {-height 16 -radix binary} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.header_2 {-height 16 -radix binary} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.header_3 {-height 16 -radix binary} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.logical_lane_0 {-height 16 -radix unsigned} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.logical_lane_1 {-height 16 -radix unsigned} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.logical_lane_2 {-height 16 -radix unsigned} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.logical_lane_3 {-height 16 -radix unsigned}} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip
add wave -noupdate -height 30 -group RX -group {Lane Reorder} -childformat {{/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_xbar.data_0 -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_xbar.data_1 -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_xbar.data_2 -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_xbar.data_3 -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_xbar.header_0 -radix binary} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_xbar.header_1 -radix binary} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_xbar.header_2 -radix binary} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_xbar.header_3 -radix binary}} -subitemconfig {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_xbar.data_0 {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_xbar.data_1 {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_xbar.data_2 {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_xbar.data_3 {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_xbar.header_0 {-height 16 -radix binary} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_xbar.header_1 {-height 16 -radix binary} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_xbar.header_2 {-height 16 -radix binary} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_xbar.header_3 {-height 16 -radix binary}} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_xbar
add wave -noupdate -height 30 -group RX -group {Lane Reorder} -expand -group OUTPUT /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/pcs_0_data_out
add wave -noupdate -height 30 -group RX -group {Lane Reorder} -expand -group OUTPUT /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/pcs_1_data_out
add wave -noupdate -height 30 -group RX -group {Lane Reorder} -expand -group OUTPUT /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/pcs_2_data_out
add wave -noupdate -height 30 -group RX -group {Lane Reorder} -expand -group OUTPUT /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/pcs_3_data_out
add wave -noupdate -height 30 -group RX -group {Lane Reorder} -expand -group OUTPUT /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/pcs_0_header_out
add wave -noupdate -height 30 -group RX -group {Lane Reorder} -expand -group OUTPUT /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/pcs_1_header_out
add wave -noupdate -height 30 -group RX -group {Lane Reorder} -expand -group OUTPUT /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/pcs_2_header_out
add wave -noupdate -height 30 -group RX -group {Lane Reorder} -expand -group OUTPUT /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/pcs_3_header_out
add wave -noupdate -height 30 -group RX -divider PCS's
add wave -noupdate -height 30 -group RX -group in_0 -color Magenta -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/pcs_0_valid_out
add wave -noupdate -height 30 -group RX -group in_0 -color Magenta -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/pcs_0_header_out
add wave -noupdate -height 30 -group RX -group in_0 -color Magenta -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/pcs_0_data_out
add wave -noupdate -height 30 -group RX -group in_0 -color Yellow -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/rx_old_header_in
add wave -noupdate -height 30 -group RX -group in_0 -color Yellow -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/rx_old_data_in
add wave -noupdate -height 30 -group RX -group in_1 -color Magenta -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/pcs_1_valid_out
add wave -noupdate -height 30 -group RX -group in_1 -color Magenta -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/pcs_1_header_out
add wave -noupdate -height 30 -group RX -group in_1 -color Magenta -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/pcs_1_data_out
add wave -noupdate -height 30 -group RX -group in_1 -color Yellow -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/rx_old_header_in
add wave -noupdate -height 30 -group RX -group in_1 -color Yellow -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/rx_old_data_in
add wave -noupdate -height 30 -group RX -group in_2 -color Magenta -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/pcs_2_valid_out
add wave -noupdate -height 30 -group RX -group in_2 -color Magenta -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/pcs_2_header_out
add wave -noupdate -height 30 -group RX -group in_2 -color Magenta -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/pcs_2_data_out
add wave -noupdate -height 30 -group RX -group in_2 -color Yellow -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/rx_old_header_in
add wave -noupdate -height 30 -group RX -group in_2 -color Yellow -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/rx_old_data_in
add wave -noupdate -height 30 -group RX -group in_3 -color Magenta -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/pcs_3_valid_out
add wave -noupdate -height 30 -group RX -group in_3 -color Magenta -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/pcs_3_header_out
add wave -noupdate -height 30 -group RX -group in_3 -color Magenta -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/pcs_3_data_out
add wave -noupdate -height 30 -group RX -group in_3 -color Yellow -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/rx_old_header_in
add wave -noupdate -height 30 -group RX -group in_3 -color Yellow -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/rx_old_data_in
add wave -noupdate -height 30 -group RX -group PCS_0 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/Code
add wave -noupdate -height 30 -group RX -group PCS_0 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/rx_data
add wave -noupdate -height 30 -group RX -group PCS_0 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/coded_data
add wave -noupdate -height 30 -group RX -group PCS_0 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/DeScr_RXD_reg
add wave -noupdate -height 30 -group RX -group PCS_0 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/DeScr_RXD
add wave -noupdate -height 30 -group RX -group PCS_0 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/terminate_out
add wave -noupdate -height 30 -group RX -group PCS_0 -group dbg -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/sync_header
add wave -noupdate -height 30 -group RX -group PCS_0 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/block_type_dec_r
add wave -noupdate -height 30 -group RX -group PCS_0 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/R_TYPE
add wave -noupdate -height 30 -group RX -group PCS_0 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/TYPE
add wave -noupdate -height 30 -group RX -group PCS_0 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/Next_state
add wave -noupdate -height 30 -group RX -group PCS_0 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/Current_state
add wave -noupdate -height 30 -group RX -group PCS_0 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/block_type_dec
add wave -noupdate -height 30 -group RX -group PCS_0 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/terminate_in
add wave -noupdate -height 30 -group RX -group PCS_0 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/start_in
add wave -noupdate -height 30 -group RX -group PCS_0 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/start_out
add wave -noupdate -height 30 -group RX -group PCS_0 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/Code
add wave -noupdate -height 30 -group RX -group PCS_0 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/rx_data
add wave -noupdate -height 30 -group RX -group PCS_0 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/coded_data
add wave -noupdate -height 30 -group RX -group PCS_0 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/DeScr_RXD_reg
add wave -noupdate -height 30 -group RX -group PCS_0 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/DeScr_RXD
add wave -noupdate -height 30 -group RX -group PCS_0 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/terminate_out
add wave -noupdate -height 30 -group RX -group PCS_0 -group dbg -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/sync_header
add wave -noupdate -height 30 -group RX -group PCS_0 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/block_type_dec_r
add wave -noupdate -height 30 -group RX -group PCS_0 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/R_TYPE
add wave -noupdate -height 30 -group RX -group PCS_0 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/TYPE
add wave -noupdate -height 30 -group RX -group PCS_0 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/Next_state
add wave -noupdate -height 30 -group RX -group PCS_0 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/Current_state
add wave -noupdate -height 30 -group RX -group PCS_0 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/block_type_dec
add wave -noupdate -height 30 -group RX -group PCS_0 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/terminate_in
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/TIMER_MAX
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/LOCK_INIT
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/INVALID_SH
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/SLIP
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/SLIP_W
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/TEST_SH
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/VALID_SH
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/RESET_BER
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/GOOD_BER
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/S_HI_BER
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/START_TIMER
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/TEST
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/rstb
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_clk161
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_jtm_en
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/clear_ber_count
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_header_in
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_header_valid_in
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/hi_ber
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/blk_lock
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/linkstatus
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/ber_count
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/slip_out
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/sh_valid
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/timer_done
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_sync_ce
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/start_timer
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/sh_cnt
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/sh_invalid_cnt
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/slip
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/timer
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/ber_cnt
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/LOCK_current
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/visual_RESET_BER_current
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/TIMER_MAX
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/LOCK_INIT
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/INVALID_SH
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/SLIP
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/SLIP_W
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/TEST_SH
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/VALID_SH
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/RESET_BER
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/GOOD_BER
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/S_HI_BER
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/START_TIMER
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/TEST
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/rstb
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_clk161
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_jtm_en
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/clear_ber_count
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_header_in
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_header_valid_in
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/hi_ber
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/blk_lock
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/linkstatus
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/ber_count
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/slip_out
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/sh_valid
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/timer_done
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_sync_ce
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/start_timer
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/sh_cnt
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/sh_invalid_cnt
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/slip
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/timer
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/ber_cnt
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/LOCK_current
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_FRAME_SYNC/visual_RESET_BER_current
add wave -noupdate -height 30 -group RX -group PCS_0 -expand -group PCS0_Descramble -divider inputs
add wave -noupdate -height 30 -group RX -group PCS_0 -expand -group PCS0_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/clk
add wave -noupdate -height 30 -group RX -group PCS_0 -expand -group PCS0_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rstb
add wave -noupdate -height 30 -group RX -group PCS_0 -expand -group PCS0_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/write_enable
add wave -noupdate -height 30 -group RX -group PCS_0 -expand -group PCS0_Descramble -color Khaki /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RXD_Sync
add wave -noupdate -height 30 -group RX -group PCS_0 -expand -group PCS0_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/bypass_descram
add wave -noupdate -height 30 -group RX -group PCS_0 -expand -group PCS0_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/clr_jtest_errc
add wave -noupdate -height 30 -group RX -group PCS_0 -expand -group PCS0_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rx_jtm_en
add wave -noupdate -height 30 -group RX -group PCS_0 -expand -group PCS0_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/blk_lock
add wave -noupdate -height 30 -group RX -group PCS_0 -expand -group PCS0_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rx_old_header_in
add wave -noupdate -height 30 -group RX -group PCS_0 -expand -group PCS0_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rx_old_data_in
add wave -noupdate -height 30 -group RX -group PCS_0 -expand -group PCS0_Descramble -divider outputs
add wave -noupdate -height 30 -group RX -group PCS_0 -expand -group PCS0_Descramble -color Yellow -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/DeScr_RXD
add wave -noupdate -height 30 -group RX -group PCS_0 -expand -group PCS0_Descramble -color Yellow -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtest_errc
add wave -noupdate -height 30 -group RX -group PCS_0 -expand -group PCS0_Descramble -divider {sinais internos}
add wave -noupdate -height 30 -group RX -group PCS_0 -expand -group PCS0_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_data
add wave -noupdate -height 30 -group RX -group PCS_0 -expand -group PCS0_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_lock
add wave -noupdate -height 30 -group RX -group PCS_0 -expand -group PCS0_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/blk_ctr
add wave -noupdate -height 30 -group RX -group PCS_0 -expand -group PCS0_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/zero_ctr
add wave -noupdate -height 30 -group RX -group PCS_0 -expand -group PCS0_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/ones_ctr
add wave -noupdate -height 30 -group RX -group PCS_0 -expand -group PCS0_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/LF_ctr
add wave -noupdate -height 30 -group RX -group PCS_0 -expand -group PCS0_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/LF_bar_ctr
add wave -noupdate -height 30 -group RX -group PCS_0 -expand -group PCS0_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RXD_input
add wave -noupdate -height 30 -group RX -group PCS_0 -expand -group PCS0_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RX_Sync_header
add wave -noupdate -height 30 -group RX -group PCS_0 -expand -group PCS0_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/DeScr_wire_reg
add wave -noupdate -height 30 -group RX -group PCS_0 -expand -group PCS0_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_d_neq_0
add wave -noupdate -height 30 -group RX -group PCS_0 -expand -group PCS0_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_d_neq_1
add wave -noupdate -height 30 -group RX -group PCS_0 -expand -group PCS0_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_d_neq_lf
add wave -noupdate -height 30 -group RX -group PCS_0 -expand -group PCS0_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_d_neq_lfb
add wave -noupdate -height 30 -group RX -group PCS_0 -expand -group PCS0_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_err_bit
add wave -noupdate -height 30 -group RX -group PCS_0 -expand -group PCS0_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rx_old_block
add wave -noupdate -height 30 -group RX -group PCS_0 -expand -group PCS0_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RXD_hdr_sync
add wave -noupdate -height 30 -group RX -group PCS_0 -expand -group PCS0_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RXD_hdr_sync_reg
add wave -noupdate -height 30 -group RX -group PCS_0 -expand -group PCS0_FIFO -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/rclk
add wave -noupdate -height 30 -group RX -group PCS_0 -expand -group PCS0_FIFO -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/wclk
add wave -noupdate -height 30 -group RX -group PCS_0 -expand -group PCS0_FIFO -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/rst
add wave -noupdate -height 30 -group RX -group PCS_0 -expand -group PCS0_FIFO -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/readen
add wave -noupdate -height 30 -group RX -group PCS_0 -expand -group PCS0_FIFO -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/writen
add wave -noupdate -height 30 -group RX -group PCS_0 -expand -group PCS0_FIFO -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/writedata
add wave -noupdate -height 30 -group RX -group PCS_0 -expand -group PCS0_FIFO -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/spill
add wave -noupdate -height 30 -group RX -group PCS_0 -expand -group PCS0_FIFO -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/readdata
add wave -noupdate -height 30 -group RX -group PCS_0 -expand -group PCS0_FIFO -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/almostempty
add wave -noupdate -height 30 -group RX -group PCS_0 -expand -group PCS0_FIFO -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/almostfull
add wave -noupdate -height 30 -group RX -group PCS_0 -expand -group PCS0_FIFO -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/empty
add wave -noupdate -height 30 -group RX -group PCS_0 -expand -group PCS0_FIFO -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/full
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Decoder -group R_TYPE_DECOD -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/rstb156
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Decoder -group R_TYPE_DECOD -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/clk156
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Decoder -group R_TYPE_DECOD -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/DeScr_RXD
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Decoder -group R_TYPE_DECOD -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/R_TYPE
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Decoder -group R_TYPE_DECOD -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/rx_data
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Decoder -group R_TYPE_DECOD -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/rx_control
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/clk156
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/rstb156
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/DeScr_RXD
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/clear_errblk
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/hi_ber
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/blk_lock
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/bypass_66decoder
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/rx_data
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/rx_control
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/R_TYPE
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/lpbk
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/terminate_in
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/start_in
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/rxlf
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/rxcontrol
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/rxdata
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/errd_blks
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/terminate_out
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/start_out
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Decoder -divider inputs
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/DeScr_RXD
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/blk_lock
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/bypass_66decoder
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/lpbk
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/clear_errblk
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/clk156
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/hi_ber
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/rstb156
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/terminate_in
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/start_in
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Decoder -divider outputs
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/rxlf
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/errd_blks
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/rxcontrol
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/rxdata
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/terminate_out
add wave -noupdate -height 30 -group RX -group PCS_0 -group PCS0_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/start_out
add wave -noupdate -height 30 -group RX -group PCS_0 -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/xgmii_rxc
add wave -noupdate -height 30 -group RX -group PCS_0 -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/xgmii_rxd
add wave -noupdate -height 30 -group RX -group PCS_0 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/start_in
add wave -noupdate -height 30 -group RX -group PCS_0 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/start_out
add wave -noupdate -height 30 -group RX -group PCS_0 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/terminate_in
add wave -noupdate -height 30 -group RX -group PCS_0 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/terminate_out
add wave -noupdate -height 30 -group RX -group PCS_1 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/terminate_in
add wave -noupdate -height 30 -group RX -group PCS_1 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/terminate_out
add wave -noupdate -height 30 -group RX -group PCS_1 -group dbg -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/sync_header
add wave -noupdate -height 30 -group RX -group PCS_1 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/block_type_dec_r
add wave -noupdate -height 30 -group RX -group PCS_1 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE
add wave -noupdate -height 30 -group RX -group PCS_1 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/TYPE
add wave -noupdate -height 30 -group RX -group PCS_1 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/Next_state
add wave -noupdate -height 30 -group RX -group PCS_1 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/Current_state
add wave -noupdate -height 30 -group RX -group PCS_1 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/DeScr_RXD
add wave -noupdate -height 30 -group RX -group PCS_1 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/block_type_dec
add wave -noupdate -height 30 -group RX -group PCS_1 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/terminate_in
add wave -noupdate -height 30 -group RX -group PCS_1 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/terminate_out
add wave -noupdate -height 30 -group RX -group PCS_1 -group dbg -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/sync_header
add wave -noupdate -height 30 -group RX -group PCS_1 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/block_type_dec_r
add wave -noupdate -height 30 -group RX -group PCS_1 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE
add wave -noupdate -height 30 -group RX -group PCS_1 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/TYPE
add wave -noupdate -height 30 -group RX -group PCS_1 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/Next_state
add wave -noupdate -height 30 -group RX -group PCS_1 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/Current_state
add wave -noupdate -height 30 -group RX -group PCS_1 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/DeScr_RXD
add wave -noupdate -height 30 -group RX -group PCS_1 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/block_type_dec
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/TIMER_MAX
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/LOCK_INIT
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/INVALID_SH
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/SLIP
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/SLIP_W
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/TEST_SH
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/VALID_SH
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/RESET_BER
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/GOOD_BER
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/S_HI_BER
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/START_TIMER
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/TEST
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/rstb
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_clk161
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_jtm_en
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/clear_ber_count
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_header_in
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_header_valid_in
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/hi_ber
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/blk_lock
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/linkstatus
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/ber_count
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/slip_out
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/sh_valid
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/timer_done
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_sync_ce
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/start_timer
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/sh_cnt
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/sh_invalid_cnt
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/slip
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/timer
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/ber_cnt
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/LOCK_current
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/visual_RESET_BER_current
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/TIMER_MAX
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/LOCK_INIT
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/INVALID_SH
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/SLIP
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/SLIP_W
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/TEST_SH
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/VALID_SH
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/RESET_BER
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/GOOD_BER
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/S_HI_BER
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/START_TIMER
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/TEST
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/rstb
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_clk161
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_jtm_en
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/clear_ber_count
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_header_in
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_header_valid_in
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/hi_ber
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/blk_lock
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/linkstatus
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/ber_count
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/slip_out
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/sh_valid
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/timer_done
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_sync_ce
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/start_timer
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/sh_cnt
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/sh_invalid_cnt
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/slip
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/timer
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/ber_cnt
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/LOCK_current
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_FRAME_SYNC/visual_RESET_BER_current
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Descramble -divider inputs
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Descramble -color Khaki /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/write_enable
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RXD_Sync
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Descramble -color Khaki /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/bypass_descram
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Descramble -color Khaki /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/clr_jtest_errc
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Descramble -color Khaki /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rx_jtm_en
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Descramble -color Khaki /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/clk
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Descramble -color Khaki /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rstb
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Descramble -color Khaki /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/blk_lock
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Descramble -color Khaki /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rx_old_header_in
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Descramble -divider outputs
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Descramble -color Khaki /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rx_old_data_in
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Descramble -color Yellow /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtest_errc
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Descramble -divider {sinais internos}
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Descramble /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_data
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Descramble /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_lock
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Descramble /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/blk_ctr
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Descramble /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/zero_ctr
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Descramble /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/ones_ctr
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Descramble /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/LF_ctr
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Descramble /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/LF_bar_ctr
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Descramble /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RXD_input
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Descramble /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RX_Sync_header
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Descramble /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/DeScr_wire_reg
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Descramble /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_d_neq_0
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Descramble /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_d_neq_1
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Descramble /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_d_neq_lf
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Descramble /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_d_neq_lfb
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Descramble /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_err_bit
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Descramble /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rx_old_block
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Descramble /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RXD_hdr_sync
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Descramble /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RXD_hdr_sync_reg
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/rclk
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/wclk
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/rst
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/readen
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/writen
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/writedata
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/spill
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/readdata
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/almostempty
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/almostfull
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/empty
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/full
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Decoder -group R_TYPE_DECOD -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/rstb156
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Decoder -group R_TYPE_DECOD -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/clk156
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Decoder -group R_TYPE_DECOD -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/DeScr_RXD
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Decoder -group R_TYPE_DECOD -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/R_TYPE
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Decoder -group R_TYPE_DECOD -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/rx_data
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Decoder -group R_TYPE_DECOD -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/rx_control
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/clk156
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/rstb156
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/DeScr_RXD
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/clear_errblk
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/hi_ber
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/blk_lock
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/bypass_66decoder
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/rx_data
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/rx_control
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/R_TYPE
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/lpbk
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/terminate_in
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/start_in
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/rxlf
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/rxcontrol
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/rxdata
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/errd_blks
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/terminate_out
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/start_out
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Decoder -divider inputs
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/DeScr_RXD
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/blk_lock
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/bypass_66decoder
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/lpbk
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/clear_errblk
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/clk156
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/hi_ber
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/rstb156
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/terminate_in
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/start_in
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Decoder -divider outputs
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/rxlf
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/errd_blks
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/rxcontrol
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/rxdata
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/terminate_out
add wave -noupdate -height 30 -group RX -group PCS_1 -group PCS1_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/start_out
add wave -noupdate -height 30 -group RX -group PCS_1 -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/xgmii_rxc
add wave -noupdate -height 30 -group RX -group PCS_1 -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/xgmii_rxd
add wave -noupdate -height 30 -group RX -group PCS_1 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/start_in
add wave -noupdate -height 30 -group RX -group PCS_1 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/start_out
add wave -noupdate -height 30 -group RX -group PCS_1 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/terminate_in
add wave -noupdate -height 30 -group RX -group PCS_1 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/terminate_out
add wave -noupdate -height 30 -group RX -group PCS_2 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/terminate_in
add wave -noupdate -height 30 -group RX -group PCS_2 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/DeScr_RXD
add wave -noupdate -height 30 -group RX -group PCS_2 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/terminate_out
add wave -noupdate -height 30 -group RX -group PCS_2 -group dbg -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/sync_header
add wave -noupdate -height 30 -group RX -group PCS_2 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/block_type_dec_r
add wave -noupdate -height 30 -group RX -group PCS_2 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/TYPE
add wave -noupdate -height 30 -group RX -group PCS_2 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE
add wave -noupdate -height 30 -group RX -group PCS_2 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/Next_state
add wave -noupdate -height 30 -group RX -group PCS_2 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/Current_state
add wave -noupdate -height 30 -group RX -group PCS_2 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/DeScr_RXD
add wave -noupdate -height 30 -group RX -group PCS_2 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/block_type_dec
add wave -noupdate -height 30 -group RX -group PCS_2 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/terminate_in
add wave -noupdate -height 30 -group RX -group PCS_2 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/DeScr_RXD
add wave -noupdate -height 30 -group RX -group PCS_2 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/terminate_out
add wave -noupdate -height 30 -group RX -group PCS_2 -group dbg -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/sync_header
add wave -noupdate -height 30 -group RX -group PCS_2 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/block_type_dec_r
add wave -noupdate -height 30 -group RX -group PCS_2 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/TYPE
add wave -noupdate -height 30 -group RX -group PCS_2 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE
add wave -noupdate -height 30 -group RX -group PCS_2 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/Next_state
add wave -noupdate -height 30 -group RX -group PCS_2 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/Current_state
add wave -noupdate -height 30 -group RX -group PCS_2 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/DeScr_RXD
add wave -noupdate -height 30 -group RX -group PCS_2 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/block_type_dec
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/TIMER_MAX
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/LOCK_INIT
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/INVALID_SH
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/SLIP
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/SLIP_W
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/TEST_SH
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/VALID_SH
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/RESET_BER
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/GOOD_BER
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/S_HI_BER
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/START_TIMER
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/TEST
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/rstb
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_clk161
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_jtm_en
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/clear_ber_count
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_header_in
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_header_valid_in
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/hi_ber
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/blk_lock
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/linkstatus
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/ber_count
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/slip_out
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/sh_valid
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/timer_done
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_sync_ce
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/start_timer
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/sh_cnt
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/sh_invalid_cnt
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/slip
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/timer
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/ber_cnt
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/LOCK_current
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/visual_RESET_BER_current
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/TIMER_MAX
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/LOCK_INIT
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/INVALID_SH
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/SLIP
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/SLIP_W
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/TEST_SH
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/VALID_SH
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/RESET_BER
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/GOOD_BER
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/S_HI_BER
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/START_TIMER
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/TEST
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/rstb
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_clk161
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_jtm_en
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/clear_ber_count
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_header_in
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_header_valid_in
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/hi_ber
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/blk_lock
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/linkstatus
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/ber_count
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/slip_out
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/sh_valid
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/timer_done
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_sync_ce
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/start_timer
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/sh_cnt
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/sh_invalid_cnt
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/slip
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/timer
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/ber_cnt
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/LOCK_current
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_FRAME_SYNC/visual_RESET_BER_current
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Descramble -divider inputs
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/write_enable
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RXD_Sync
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/bypass_descram
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/clr_jtest_errc
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rx_jtm_en
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/clk
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rstb
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/blk_lock
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rx_old_header_in
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rx_old_data_in
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Descramble -divider outputs
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Descramble -color Yellow -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/DeScr_RXD
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Descramble -color Yellow -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtest_errc
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Descramble -divider {sinais internos}
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_data
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_lock
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/blk_ctr
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/zero_ctr
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/ones_ctr
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/LF_ctr
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/LF_bar_ctr
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RXD_input
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RX_Sync_header
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/DeScr_wire
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/DeScr_wire_reg
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_d_neq_0
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_d_neq_1
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_d_neq_lf
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_d_neq_lfb
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_err_bit
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rx_old_block
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rx_old_block_desc
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RXD_data_sync
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RXD_hdr_sync
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RXD_hdr_sync_reg
add wave -noupdate -height 30 -group RX -group PCS_2 -expand -group PCS2_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/rclk
add wave -noupdate -height 30 -group RX -group PCS_2 -expand -group PCS2_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/wclk
add wave -noupdate -height 30 -group RX -group PCS_2 -expand -group PCS2_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/rst
add wave -noupdate -height 30 -group RX -group PCS_2 -expand -group PCS2_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/readen
add wave -noupdate -height 30 -group RX -group PCS_2 -expand -group PCS2_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/writen
add wave -noupdate -height 30 -group RX -group PCS_2 -expand -group PCS2_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/writedata
add wave -noupdate -height 30 -group RX -group PCS_2 -expand -group PCS2_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/spill
add wave -noupdate -height 30 -group RX -group PCS_2 -expand -group PCS2_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/readdata
add wave -noupdate -height 30 -group RX -group PCS_2 -expand -group PCS2_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/almostempty
add wave -noupdate -height 30 -group RX -group PCS_2 -expand -group PCS2_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/almostfull
add wave -noupdate -height 30 -group RX -group PCS_2 -expand -group PCS2_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/empty
add wave -noupdate -height 30 -group RX -group PCS_2 -expand -group PCS2_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/full
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Decoder -group R_TYPE_DECODE -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/rstb156
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Decoder -group R_TYPE_DECODE -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/clk156
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Decoder -group R_TYPE_DECODE -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/DeScr_RXD
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Decoder -group R_TYPE_DECODE -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/R_TYPE
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Decoder -group R_TYPE_DECODE -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/rx_data
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Decoder -group R_TYPE_DECODE -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/rx_control
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/clk156
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/rstb156
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/DeScr_RXD
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/clear_errblk
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/hi_ber
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/blk_lock
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/bypass_66decoder
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/rx_data
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/rx_control
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/R_TYPE
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/lpbk
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/terminate_in
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/start_in
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/rxlf
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/rxcontrol
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/rxdata
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/errd_blks
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/terminate_out
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Decoder -group RX_FSM /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/start_out
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Decoder -divider inputs
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/DeScr_RXD
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/blk_lock
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/bypass_66decoder
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/lpbk
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/clear_errblk
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/clk156
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/hi_ber
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/rstb156
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/terminate_in
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/start_in
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Decoder -divider outputs
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/rxlf
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/errd_blks
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/rxcontrol
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/rxdata
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/terminate_out
add wave -noupdate -height 30 -group RX -group PCS_2 -group PCS2_Decoder /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/start_out
add wave -noupdate -height 30 -group RX -group PCS_2 -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/xgmii_rxc
add wave -noupdate -height 30 -group RX -group PCS_2 -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/xgmii_rxd
add wave -noupdate -height 30 -group RX -group PCS_2 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/start_in
add wave -noupdate -height 30 -group RX -group PCS_2 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/start_out
add wave -noupdate -height 30 -group RX -group PCS_2 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/terminate_in
add wave -noupdate -height 30 -group RX -group PCS_2 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/terminate_out
add wave -noupdate -height 30 -group RX -group PCS_3 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/terminate_in
add wave -noupdate -height 30 -group RX -group PCS_3 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/terminate_out
add wave -noupdate -height 30 -group RX -group PCS_3 -group dbg -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/sync_header
add wave -noupdate -height 30 -group RX -group PCS_3 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/block_type_dec_r
add wave -noupdate -height 30 -group RX -group PCS_3 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE
add wave -noupdate -height 30 -group RX -group PCS_3 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/TYPE
add wave -noupdate -height 30 -group RX -group PCS_3 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/Next_state
add wave -noupdate -height 30 -group RX -group PCS_3 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/Current_state
add wave -noupdate -height 30 -group RX -group PCS_3 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/DeScr_RXD
add wave -noupdate -height 30 -group RX -group PCS_3 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/block_type_dec
add wave -noupdate -height 30 -group RX -group PCS_3 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/terminate_in
add wave -noupdate -height 30 -group RX -group PCS_3 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/terminate_out
add wave -noupdate -height 30 -group RX -group PCS_3 -group dbg -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/sync_header
add wave -noupdate -height 30 -group RX -group PCS_3 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/block_type_dec_r
add wave -noupdate -height 30 -group RX -group PCS_3 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE
add wave -noupdate -height 30 -group RX -group PCS_3 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/TYPE
add wave -noupdate -height 30 -group RX -group PCS_3 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/Next_state
add wave -noupdate -height 30 -group RX -group PCS_3 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/Current_state
add wave -noupdate -height 30 -group RX -group PCS_3 -group dbg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/DeScr_RXD
add wave -noupdate -height 30 -group RX -group PCS_3 -group dbg /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/block_type_dec
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/TIMER_MAX
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/LOCK_INIT
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/INVALID_SH
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/SLIP
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/SLIP_W
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/TEST_SH
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/VALID_SH
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/RESET_BER
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/GOOD_BER
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/S_HI_BER
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/START_TIMER
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/TEST
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/rstb
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_clk161
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_jtm_en
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/clear_ber_count
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_header_in
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_header_valid_in
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/hi_ber
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/blk_lock
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/linkstatus
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/ber_count
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/slip_out
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/sh_valid
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/timer_done
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_sync_ce
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/start_timer
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/sh_cnt
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/sh_invalid_cnt
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/slip
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/timer
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/ber_cnt
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/LOCK_current
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/visual_RESET_BER_current
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/TIMER_MAX
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/LOCK_INIT
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/INVALID_SH
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/SLIP
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/SLIP_W
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/TEST_SH
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/VALID_SH
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/RESET_BER
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/GOOD_BER
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/S_HI_BER
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/START_TIMER
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/TEST
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/rstb
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_clk161
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_jtm_en
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/clear_ber_count
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_header_in
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_header_valid_in
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/hi_ber
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/blk_lock
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/linkstatus
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/ber_count
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/slip_out
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/sh_valid
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/timer_done
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/rx_sync_ce
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/start_timer
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/sh_cnt
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/sh_invalid_cnt
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/slip
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/timer
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/ber_cnt
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/LOCK_current
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_frame_sync /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_FRAME_SYNC/visual_RESET_BER_current
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Descramble -divider inputs
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/write_enable
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RXD_Sync
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/bypass_descram
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/clr_jtest_errc
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rx_jtm_en
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/clk
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rstb
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/blk_lock
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rx_old_header_in
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Descramble -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rx_old_data_in
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Descramble -divider outputs
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Descramble -color Yellow -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/DeScr_RXD
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Descramble -color Yellow -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtest_errc
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Descramble -divider {sinais internos}
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_data
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_lock
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/blk_ctr
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/zero_ctr
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/ones_ctr
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/LF_ctr
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/LF_bar_ctr
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RXD_input
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RX_Sync_header
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/DeScr_wire
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/DeScr_wire_reg
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_d_neq_0
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_d_neq_1
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_d_neq_lf
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_d_neq_lfb
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/jtm_err_bit
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rx_old_block
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rx_old_block_desc
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RXD_data_sync
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RXD_hdr_sync
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Descramble -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RXD_hdr_sync_reg
add wave -noupdate -height 30 -group RX -group PCS_3 -expand -group PCS3_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/rclk
add wave -noupdate -height 30 -group RX -group PCS_3 -expand -group PCS3_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/wclk
add wave -noupdate -height 30 -group RX -group PCS_3 -expand -group PCS3_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/rst
add wave -noupdate -height 30 -group RX -group PCS_3 -expand -group PCS3_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/readen
add wave -noupdate -height 30 -group RX -group PCS_3 -expand -group PCS3_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/writen
add wave -noupdate -height 30 -group RX -group PCS_3 -expand -group PCS3_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/writedata
add wave -noupdate -height 30 -group RX -group PCS_3 -expand -group PCS3_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/spill
add wave -noupdate -height 30 -group RX -group PCS_3 -expand -group PCS3_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/readdata
add wave -noupdate -height 30 -group RX -group PCS_3 -expand -group PCS3_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/almostempty
add wave -noupdate -height 30 -group RX -group PCS_3 -expand -group PCS3_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/almostfull
add wave -noupdate -height 30 -group RX -group PCS_3 -expand -group PCS3_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/empty
add wave -noupdate -height 30 -group RX -group PCS_3 -expand -group PCS3_FIFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/full
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Decoder -group R_TYPE_DECOD -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/rstb156
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Decoder -group R_TYPE_DECOD -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/clk156
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Decoder -group R_TYPE_DECOD -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/DeScr_RXD
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Decoder -group R_TYPE_DECOD -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/R_TYPE
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Decoder -group R_TYPE_DECOD -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/rx_data
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Decoder -group R_TYPE_DECOD -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/rx_control
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/clk156
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/rstb156
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/DeScr_RXD
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/clear_errblk
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/hi_ber
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/blk_lock
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/bypass_66decoder
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/rx_data
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/rx_control
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/R_TYPE
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/lpbk
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/terminate_in
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/start_in
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/rxlf
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/rxcontrol
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/rxdata
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/errd_blks
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/terminate_out
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Decoder -group RX_FSM -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/start_out
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Decoder -divider inputs
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/DeScr_RXD
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/blk_lock
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/bypass_66decoder
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/lpbk
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/clear_errblk
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/clk156
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/hi_ber
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/rstb156
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/terminate_in
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/start_in
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Decoder -divider outputs
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/rxlf
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/errd_blks
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/rxcontrol
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/rxdata
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/terminate_out
add wave -noupdate -height 30 -group RX -group PCS_3 -group PCS3_Decoder -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/start_out
add wave -noupdate -height 30 -group RX -group PCS_3 -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/xgmii_rxc
add wave -noupdate -height 30 -group RX -group PCS_3 -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/xgmii_rxd
add wave -noupdate -height 30 -group RX -group PCS_3 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/start_in
add wave -noupdate -height 30 -group RX -group PCS_3 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/start_out
add wave -noupdate -height 30 -group RX -group PCS_3 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/terminate_in
add wave -noupdate -height 30 -group RX -group PCS_3 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/terminate_out
add wave -noupdate -height 30 -group RX -divider REORDER
add wave -noupdate -height 30 -group RX -group shuffle /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/shuffle_lanes/in_0
add wave -noupdate -height 30 -group RX -group shuffle /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/shuffle_lanes/in_1
add wave -noupdate -height 30 -group RX -group shuffle /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/shuffle_lanes/in_2
add wave -noupdate -height 30 -group RX -group shuffle /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/shuffle_lanes/in_3
add wave -noupdate -height 30 -group RX -group shuffle -radix unsigned /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/shuffle_lanes/lane_0
add wave -noupdate -height 30 -group RX -group shuffle -radix unsigned /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/shuffle_lanes/lane_1
add wave -noupdate -height 30 -group RX -group shuffle -radix unsigned /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/shuffle_lanes/lane_2
add wave -noupdate -height 30 -group RX -group shuffle -radix unsigned /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/shuffle_lanes/lane_3
add wave -noupdate -height 30 -group RX -group shuffle /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/shuffle_lanes/out_0
add wave -noupdate -height 30 -group RX -group shuffle /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/shuffle_lanes/out_1
add wave -noupdate -height 30 -group RX -group shuffle /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/shuffle_lanes/out_2
add wave -noupdate -height 30 -group RX -group shuffle /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/shuffle_lanes/out_3
add wave -noupdate -height 30 -group RX -divider -height 20 {CORE INTERFACE}
add wave -noupdate -height 30 -group RX -group Controller -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/xgmii_rxc_0
add wave -noupdate -height 30 -group RX -group Controller -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/xgmii_rxd_0
add wave -noupdate -height 30 -group RX -group Controller -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/xgmii_rxc_1
add wave -noupdate -height 30 -group RX -group Controller -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/xgmii_rxd_1
add wave -noupdate -height 30 -group RX -group Controller -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/xgmii_rxc_2
add wave -noupdate -height 30 -group RX -group Controller -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/xgmii_rxd_2
add wave -noupdate -height 30 -group RX -group Controller -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/xgmii_rxc_3
add wave -noupdate -height 30 -group RX -group Controller -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/xgmii_rxd_3
add wave -noupdate -height 30 -group RX -group Controller -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/shift_out
add wave -noupdate -height 30 -group RX -group Controller -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/shift_out_int
add wave -noupdate -height 30 -group RX -group Controller -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/shift_out_reg
add wave -noupdate -height 30 -group RX -group Controller -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/shift_eop
add wave -noupdate -height 30 -group RX -group Controller -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/shift_eop_reg
add wave -noupdate -height 30 -group RX -group Controller -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/shift_out_reg_reg
add wave -noupdate -height 30 -group RX -group Controller -color Gold /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/is_sop
add wave -noupdate -height 30 -group RX -group Controller -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/is_sop_int
add wave -noupdate -height 30 -group RX -group Controller -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/is_sop_reg
add wave -noupdate -height 30 -group RX -group Controller -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/is_sop_reg_reg
add wave -noupdate -height 30 -group RX -group Controller -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/sop_location
add wave -noupdate -height 30 -group RX -group Controller -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/eop_location
add wave -noupdate -height 30 -group RX -group Controller -color Gold -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/ctrl_delay
add wave -noupdate -height 30 -group RX -group Controller -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/ctrl_delay_int
add wave -noupdate -height 30 -group RX -group Controller -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/ctrl_delay_reg
add wave -noupdate -height 30 -group RX -group Controller -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/ctrl_delay_reg_reg
add wave -noupdate -height 30 -group RX -group Controller -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/ctrl_delay_reg_reg_reg
add wave -noupdate -height 30 -group RX -group Controller -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/eop_location_calc
add wave -noupdate -height 30 -group RX -group Controller -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/eop_location_calc_reg
add wave -noupdate -height 30 -group RX -group Controller -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/eop_location_calc_reg_reg
add wave -noupdate -height 30 -group RX -group Controller -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/eop_location_calc_reg_reg_reg
add wave -noupdate -height 30 -group RX -group Controller -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/eop_location_out
add wave -noupdate -height 30 -group RX -group Controller -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/shift_calc
add wave -noupdate -height 30 -group RX -group Controller /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/wen_fifo_reg
add wave -noupdate -height 30 -group RX -group Controller /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/sop_eop_same_cycle
add wave -noupdate -height 30 -group RX -group Controller /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/sop7_eop_same_cycle
add wave -noupdate -height 30 -group RX -group Controller /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/sop7_eop_same_cycle_reg
add wave -noupdate -height 30 -group RX -group Controller /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/sop_eop_same_cycle_reg
add wave -noupdate -height 30 -group RX -group Controller /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/controller/sop_eop_same_cycle_reg_reg
add wave -noupdate -height 30 -group RX -group Shift_reg -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shift_reg/xgmii_rxd_0
add wave -noupdate -height 30 -group RX -group Shift_reg -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shift_reg/xgmii_rxd_1
add wave -noupdate -height 30 -group RX -group Shift_reg -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shift_reg/xgmii_rxd_2
add wave -noupdate -height 30 -group RX -group Shift_reg -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shift_reg/xgmii_rxd_3
add wave -noupdate -height 30 -group RX -group Shift_reg -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shift_reg/reg_current_Q
add wave -noupdate -height 30 -group RX -group Shift_reg -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shift_reg/reg_previous_Q
add wave -noupdate -height 30 -group RX -group Shift_reg -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shift_reg/reg_delay_Q
add wave -noupdate -height 30 -group RX -group Shift_reg -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shift_reg/ctrl
add wave -noupdate -height 30 -group RX -group Shift_reg -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shift_reg/out_0
add wave -noupdate -height 30 -group RX -group Shift_reg -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shift_reg/out_1
add wave -noupdate -height 30 -group RX -group Shifter -radix hexadecimal -childformat {{/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(255) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(254) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(253) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(252) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(251) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(250) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(249) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(248) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(247) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(246) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(245) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(244) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(243) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(242) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(241) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(240) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(239) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(238) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(237) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(236) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(235) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(234) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(233) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(232) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(231) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(230) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(229) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(228) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(227) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(226) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(225) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(224) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(223) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(222) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(221) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(220) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(219) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(218) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(217) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(216) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(215) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(214) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(213) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(212) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(211) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(210) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(209) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(208) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(207) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(206) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(205) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(204) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(203) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(202) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(201) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(200) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(199) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(198) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(197) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(196) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(195) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(194) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(193) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(192) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(191) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(190) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(189) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(188) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(187) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(186) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(185) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(184) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(183) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(182) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(181) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(180) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(179) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(178) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(177) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(176) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(175) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(174) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(173) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(172) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(171) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(170) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(169) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(168) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(167) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(166) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(165) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(164) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(163) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(162) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(161) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(160) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(159) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(158) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(157) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(156) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(155) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(154) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(153) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(152) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(151) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(150) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(149) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(148) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(147) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(146) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(145) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(144) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(143) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(142) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(141) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(140) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(139) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(138) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(137) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(136) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(135) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(134) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(133) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(132) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(131) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(130) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(129) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(128) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(127) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(126) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(125) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(124) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(123) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(122) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(121) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(120) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(119) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(118) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(117) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(116) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(115) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(114) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(113) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(112) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(111) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(110) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(109) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(108) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(107) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(106) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(105) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(104) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(103) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(102) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(101) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(100) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(99) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(98) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(97) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(96) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(95) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(94) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(93) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(92) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(91) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(90) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(89) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(88) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(87) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(86) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(85) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(84) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(83) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(82) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(81) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(80) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(79) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(78) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(77) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(76) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(75) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(74) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(73) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(72) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(71) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(70) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(69) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(68) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(67) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(66) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(65) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(64) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(63) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(62) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(61) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(60) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(59) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(58) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(57) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(56) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(55) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(54) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(53) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(52) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(51) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(50) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(49) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(48) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(47) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(46) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(45) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(44) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(43) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(42) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(41) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(40) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(39) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(38) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(37) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(36) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(35) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(34) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(33) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(32) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(31) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(30) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(29) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(28) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(27) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(26) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(25) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(24) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(23) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(22) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(21) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(20) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(19) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(18) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(17) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(16) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(15) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(14) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(13) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(12) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(11) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(10) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(9) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(8) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(7) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(6) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(5) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(4) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(3) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(2) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(1) -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(0) -radix hexadecimal}} -subitemconfig {/Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(255) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(254) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(253) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(252) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(251) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(250) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(249) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(248) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(247) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(246) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(245) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(244) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(243) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(242) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(241) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(240) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(239) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(238) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(237) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(236) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(235) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(234) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(233) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(232) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(231) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(230) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(229) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(228) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(227) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(226) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(225) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(224) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(223) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(222) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(221) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(220) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(219) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(218) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(217) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(216) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(215) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(214) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(213) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(212) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(211) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(210) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(209) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(208) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(207) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(206) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(205) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(204) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(203) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(202) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(201) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(200) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(199) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(198) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(197) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(196) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(195) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(194) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(193) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(192) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(191) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(190) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(189) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(188) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(187) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(186) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(185) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(184) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(183) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(182) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(181) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(180) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(179) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(178) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(177) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(176) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(175) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(174) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(173) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(172) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(171) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(170) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(169) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(168) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(167) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(166) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(165) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(164) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(163) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(162) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(161) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(160) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(159) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(158) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(157) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(156) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(155) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(154) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(153) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(152) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(151) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(150) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(149) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(148) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(147) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(146) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(145) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(144) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(143) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(142) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(141) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(140) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(139) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(138) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(137) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(136) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(135) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(134) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(133) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(132) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(131) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(130) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(129) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(128) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(127) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(126) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(125) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(124) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(123) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(122) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(121) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(120) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(119) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(118) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(117) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(116) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(115) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(114) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(113) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(112) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(111) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(110) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(109) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(108) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(107) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(106) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(105) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(104) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(103) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(102) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(101) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(100) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(99) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(98) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(97) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(96) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(95) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(94) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(93) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(92) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(91) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(90) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(89) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(88) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(87) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(86) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(85) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(84) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(83) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(82) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(81) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(80) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(79) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(78) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(77) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(76) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(75) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(74) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(73) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(72) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(71) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(70) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(69) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(68) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(67) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(66) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(65) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(64) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(63) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(62) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(61) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(60) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(59) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(58) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(57) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(56) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(55) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(54) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(53) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(52) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(51) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(50) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(49) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(48) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(47) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(46) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(45) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(44) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(43) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(42) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(41) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(40) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(39) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(38) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(37) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(36) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(35) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(34) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(33) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(32) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(31) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(30) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(29) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(28) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(27) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(26) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(25) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(24) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(23) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(22) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(21) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(20) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(19) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(18) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(17) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(16) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(15) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(14) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(13) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(12) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(11) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(10) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(9) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(8) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(7) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(6) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(5) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(4) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(3) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(2) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(1) {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0(0) {-height 16 -radix hexadecimal}} /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0
add wave -noupdate -height 30 -group RX -group Shifter -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_1
add wave -noupdate -height 30 -group RX -group Shifter -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/ctrl_reg_shift
add wave -noupdate -height 30 -group RX -color Gold -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/data_out
add wave -noupdate -height 30 -group RX -group fifo_BRAM /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/rst_n
add wave -noupdate -height 30 -group RX -group fifo_BRAM /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/clk_w
add wave -noupdate -height 30 -group RX -group fifo_BRAM /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/clk_r
add wave -noupdate -height 30 -group RX -group fifo_BRAM -color Magenta /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/wen
add wave -noupdate -height 30 -group RX -group fifo_BRAM -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/data_in
add wave -noupdate -height 30 -group RX -group fifo_BRAM /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/is_sop_in
add wave -noupdate -height 30 -group RX -group fifo_BRAM /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/eop_addr_in
add wave -noupdate -height 30 -group RX -group fifo_BRAM -color Magenta /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/ren
add wave -noupdate -height 30 -group RX -group fifo_BRAM -color Khaki /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/empty
add wave -noupdate -height 30 -group RX -group fifo_BRAM -color Khaki /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/full
add wave -noupdate -height 30 -group RX -group fifo_BRAM /Top/rx_xgt4/mac_val
add wave -noupdate -height 30 -group RX -group fifo_BRAM -color Gold -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/data_out
add wave -noupdate -height 30 -group RX -group fifo_BRAM -color Gold -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/is_sop_out
add wave -noupdate -height 30 -group RX -group fifo_BRAM -color Gold -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/eop_addr_out
add wave -noupdate -height 30 -group RX -group fifo_BRAM -divider dbug
add wave -noupdate -group dgp_BRAM /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/clk_w
add wave -noupdate -group dgp_BRAM /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/clk_r
add wave -noupdate -group dgp_BRAM -color Cyan -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/rr
add wave -noupdate -group dgp_BRAM -color Magenta -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/ren_int_l
add wave -noupdate -group dgp_BRAM -color Magenta -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/ren_int_h
add wave -noupdate -group dgp_BRAM -radix unsigned /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/r_ptr_l
add wave -noupdate -group dgp_BRAM -radix unsigned /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/r_ptr_h
add wave -noupdate -group dgp_BRAM -expand -group low_0 -color Cyan /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/FIFO_inst_l_0/WREN
add wave -noupdate -group dgp_BRAM -expand -group low_0 -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/mem_low_in_0_reg
add wave -noupdate -group dgp_BRAM -expand -group low_0 -color Green -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/mem_low_in_0
add wave -noupdate -group dgp_BRAM -expand -group low_0 /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/FIFO_inst_l_0/FULL
add wave -noupdate -group dgp_BRAM -expand -group low_0 /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/FIFO_inst_l_0/EMPTY
add wave -noupdate -group dgp_BRAM -expand -group low_0 -color Khaki -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/FIFO_inst_l_0/ALMOSTEMPTY
add wave -noupdate -group dgp_BRAM -expand -group low_0 -color Khaki -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/FIFO_inst_l_0/ALMOSTFULL
add wave -noupdate -group dgp_BRAM -expand -group low_0 -color Yellow /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/FIFO_inst_l_0/RDEN
add wave -noupdate -group dgp_BRAM -expand -group low_0 -color Yellow -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/FIFO_inst_l_0/DO
add wave -noupdate -group dgp_BRAM -expand -group low_1 -color Cyan /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/FIFO_inst_l_1/WREN
add wave -noupdate -group dgp_BRAM -expand -group low_1 -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/r_low_in_1
add wave -noupdate -group dgp_BRAM -expand -group low_1 -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/low_in_1
add wave -noupdate -group dgp_BRAM -expand -group low_1 -color Green -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/mem_low_in_1
add wave -noupdate -group dgp_BRAM -expand -group low_1 -color {Spring Green} -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/mem_low_in_1_reg
add wave -noupdate -group dgp_BRAM -expand -group low_1 /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/FIFO_inst_l_1/FULL
add wave -noupdate -group dgp_BRAM -expand -group low_1 /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/FIFO_inst_l_1/EMPTY
add wave -noupdate -group dgp_BRAM -expand -group low_1 -color Khaki -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/FIFO_inst_l_1/ALMOSTEMPTY
add wave -noupdate -group dgp_BRAM -expand -group low_1 -color Khaki -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/FIFO_inst_l_1/ALMOSTFULL
add wave -noupdate -group dgp_BRAM -expand -group low_1 -color Yellow /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/FIFO_inst_l_1/RDEN
add wave -noupdate -group dgp_BRAM -expand -group low_1 -color Yellow -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/DO_L_1
add wave -noupdate -group dgp_BRAM -expand -group low_1 -color Green -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/FIFO_inst_l_1/DO
add wave -noupdate -group dgp_BRAM -expand -group high_0 -color Cyan /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/FIFO_inst_h_0/WREN
add wave -noupdate -group dgp_BRAM -expand -group high_0 -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/mem_high_in_0_reg
add wave -noupdate -group dgp_BRAM -expand -group high_0 -color Green -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/mem_high_in_0
add wave -noupdate -group dgp_BRAM -expand -group high_0 /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/FIFO_inst_h_0/FULL
add wave -noupdate -group dgp_BRAM -expand -group high_0 /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/FIFO_inst_h_0/EMPTY
add wave -noupdate -group dgp_BRAM -expand -group high_0 -color Khaki -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/FIFO_inst_h_0/ALMOSTEMPTY
add wave -noupdate -group dgp_BRAM -expand -group high_0 -color Khaki -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/FIFO_inst_h_0/ALMOSTFULL
add wave -noupdate -group dgp_BRAM -expand -group high_0 -color Yellow /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/FIFO_inst_h_0/RDEN
add wave -noupdate -group dgp_BRAM -expand -group high_0 -color Yellow -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/FIFO_inst_h_0/DO
add wave -noupdate -group dgp_BRAM -expand -group high_1 -color Cyan /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/FIFO_inst_h_1/WREN
add wave -noupdate -group dgp_BRAM -expand -group high_1 -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/r_high_in_1
add wave -noupdate -group dgp_BRAM -expand -group high_1 -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/high_in_1
add wave -noupdate -group dgp_BRAM -expand -group high_1 -color {Spring Green} -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/mem_high_in_1
add wave -noupdate -group dgp_BRAM -expand -group high_1 -color {Spring Green} -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/mem_high_in_1_reg
add wave -noupdate -group dgp_BRAM -expand -group high_1 /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/FIFO_inst_h_1/FULL
add wave -noupdate -group dgp_BRAM -expand -group high_1 /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/FIFO_inst_h_1/EMPTY
add wave -noupdate -group dgp_BRAM -expand -group high_1 -color Khaki -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/FIFO_inst_h_1/ALMOSTEMPTY
add wave -noupdate -group dgp_BRAM -expand -group high_1 -color Khaki -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/FIFO_inst_h_1/ALMOSTFULL
add wave -noupdate -group dgp_BRAM -expand -group high_1 -color Yellow /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/FIFO_inst_h_1/RDEN
add wave -noupdate -group dgp_BRAM -expand -group high_1 -color Yellow -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/DO_H_1
add wave -noupdate -group dgp_BRAM -expand -group high_1 -color Green -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/FIFO_inst_h_1/DO
add wave -noupdate -group dgp_BRAM -color Pink -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/almost_f
add wave -noupdate -group dgp_BRAM -color Pink -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/almost_e
add wave -noupdate -group dgp_BRAM -color Pink -radix binary /Top/rx_xgt4/pause_read
add wave -noupdate -divider {MAC RX}
add wave -noupdate -group CRC /Top/rx_xgt4/inst_wrapper_macpcs/INST_crc_rx/ps_crc
add wave -noupdate -group CRC -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_crc_rx/eop_reg
add wave -noupdate -group CRC -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_crc_rx/d64_reg
add wave -noupdate -group CRC -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_crc_rx/input_reg
add wave -noupdate -group CRC /Top/rx_xgt4/inst_wrapper_macpcs/INST_crc_rx/crc_ok
add wave -noupdate -group CRC -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_crc_rx/crc_value
add wave -noupdate -group CRC -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_crc_rx/crc_final
add wave -noupdate -group CRC -radix unsigned /Top/rx_xgt4/inst_wrapper_macpcs/INST_crc_rx/d8_bytes
add wave -noupdate -group CRC /Top/rx_xgt4/inst_wrapper_macpcs/INST_crc_rx/crc_done
add wave -noupdate -group CRC -radix unsigned /Top/rx_xgt4/inst_wrapper_macpcs/INST_crc_rx/frame_len
add wave -noupdate -group CRC -radix unsigned /Top/rx_xgt4/inst_wrapper_macpcs/INST_crc_rx/byte_counter
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
add wave -noupdate -divider APP_TX
add wave -noupdate -expand -group app_tx /Top/app_tx/reset_in
add wave -noupdate -expand -group app_tx /Top/app_tx/clock_in
add wave -noupdate -expand -group app_tx -radix hexadecimal /Top/app_tx/data
add wave -noupdate -expand -group app_tx -radix binary /Top/app_tx/mod
add wave -noupdate -expand -group app_tx -radix binary /Top/app_tx/sop
add wave -noupdate -expand -group app_tx /Top/app_tx/eop
add wave -noupdate -expand -group app_tx /Top/app_tx/val
add wave -noupdate -expand -group app_tx -radix unsigned /Top/app_tx/counter
add wave -noupdate -divider MAC_TX
add wave -noupdate -group mac_tx_path -expand -group IN /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/clk_156
add wave -noupdate -group mac_tx_path -expand -group IN /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/rst_n
add wave -noupdate -group mac_tx_path -expand -group IN -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/data_in
add wave -noupdate -group mac_tx_path -expand -group IN /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/sop_in
add wave -noupdate -group mac_tx_path -expand -group IN /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/eop_in
add wave -noupdate -group mac_tx_path -expand -group IN /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/mod_in
add wave -noupdate -group mac_tx_path -expand -group IN /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/val_in
add wave -noupdate -group mac_tx_path -group OUT /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/mii_data_0
add wave -noupdate -group mac_tx_path -group OUT /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/mii_ctrl_0
add wave -noupdate -group mac_tx_path -group OUT /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/mii_data_1
add wave -noupdate -group mac_tx_path -group OUT /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/mii_ctrl_1
add wave -noupdate -group mac_tx_path -group OUT /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/mii_data_2
add wave -noupdate -group mac_tx_path -group OUT /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/mii_ctrl_2
add wave -noupdate -group mac_tx_path -group OUT /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/mii_data_3
add wave -noupdate -group mac_tx_path -group OUT /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/mii_ctrl_3
add wave -noupdate -divider PAYLOAD_IN
add wave -noupdate -group payload_in -expand -group IN_fifo -color Cyan /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/payload_in/clk
add wave -noupdate -group payload_in -expand -group IN_fifo -color Cyan /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/payload_in/rst
add wave -noupdate -group payload_in -expand -group IN_fifo -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/payload_in/data_in
add wave -noupdate -group payload_in -expand -group IN_fifo -color Cyan -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/payload_in/eop_in
add wave -noupdate -group payload_in -expand -group IN_fifo -color Cyan -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/payload_in/sop_in
add wave -noupdate -group payload_in -expand -group IN_fifo -color Cyan /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/payload_in/val_in
add wave -noupdate -group payload_in -expand -group IN_fifo -color Cyan /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/payload_in/wen
add wave -noupdate -group payload_in -expand -group OUT -color Gold /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/payload_in/ren
add wave -noupdate -group payload_in -expand -group OUT -color Gold -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/payload_in/data_out
add wave -noupdate -group payload_in -expand -group OUT -color Gold -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/payload_in/eop_out
add wave -noupdate -group payload_in -expand -group OUT -color Gold -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/payload_in/sop_out
add wave -noupdate -group payload_in -expand -group OUT -color Gold /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/payload_in/val_out
add wave -noupdate -group payload_in -expand -group OUT -color Gold /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/payload_in/almost_e
add wave -noupdate -group payload_in -expand -group OUT -color Gold /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/payload_in/almost_f
add wave -noupdate -group payload_in -expand -group OUT -color Gold /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/payload_in/full
add wave -noupdate -group payload_in -expand -group OUT -color Gold /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/payload_in/empty
add wave -noupdate -divider Frame
add wave -noupdate -group frame_builder -expand -group INPUTS -color Cyan /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame/rst
add wave -noupdate -group frame_builder -expand -group INPUTS -color Cyan /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame/clk
add wave -noupdate -group frame_builder -expand -group INPUTS -color Cyan /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame/almost_f
add wave -noupdate -group frame_builder -expand -group INPUTS -color Cyan /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame/almost_e
add wave -noupdate -group frame_builder -expand -group INPUTS -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame/data_in
add wave -noupdate -group frame_builder -expand -group INPUTS -color Cyan -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame/eop_in
add wave -noupdate -group frame_builder -expand -group INPUTS -color Cyan -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame/sop_in
add wave -noupdate -group frame_builder -expand -group INPUTS -color Cyan /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame/val_in
add wave -noupdate -group frame_builder -expand -group OUTPUTS -color Gold -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame/frame_out
add wave -noupdate -group frame_builder -expand -group OUTPUTS -color Gold -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame/eop_out
add wave -noupdate -group frame_builder -expand -group OUTPUTS -color Gold -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame/sop_out
add wave -noupdate -group frame_builder -expand -group OUTPUTS /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame/val_out
add wave -noupdate -group frame_builder -expand -group regs /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame/use_frame_next
add wave -noupdate -group frame_builder -expand -group regs -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame/frame_int
add wave -noupdate -group frame_builder -expand -group regs -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame/frame_int_next
add wave -noupdate -group frame_builder -expand -group regs /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame/ps_frame
add wave -noupdate -group frame_builder -expand -group regs -color Magenta /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame/ps_crc
add wave -noupdate -group frame_builder -expand -group regs -divider <NULL>
add wave -noupdate -group frame_builder -expand -group regs -color Magenta -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame/crc_final
add wave -noupdate -group frame_builder -expand -group regs -color Magenta -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame/crc_reg
add wave -noupdate -group frame_builder -expand -group regs -divider <NULL>
add wave -noupdate -group frame_builder -expand -group regs -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame/data_in_reg
add wave -noupdate -group frame_builder -expand -group regs -divider <NULL>
add wave -noupdate -group frame_builder -expand -group regs -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame/data_0
add wave -noupdate -group frame_builder -expand -group regs -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame/data_1
add wave -noupdate -group frame_builder -expand -group regs -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame/data_2
add wave -noupdate -group frame_builder -expand -group regs -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame/data_3
add wave -noupdate -group frame_builder -expand -group regs -divider <NULL>
add wave -noupdate -group frame_builder -expand -group regs -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame/data_0_o
add wave -noupdate -group frame_builder -expand -group regs -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame/data_1_o
add wave -noupdate -group frame_builder -expand -group regs -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame/data_2_o
add wave -noupdate -group frame_builder -expand -group regs -color Khaki -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame/data_3_o
add wave -noupdate -group frame_builder -expand -group regs -divider <NULL>
add wave -noupdate -group frame_builder -expand -group regs -radix binary -childformat {{/Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame/sop_reg_in(1) -radix binary} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame/sop_reg_in(0) -radix binary}} -subitemconfig {/Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame/sop_reg_in(1) {-height 16 -radix binary} /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame/sop_reg_in(0) {-height 16 -radix binary}} /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame/sop_reg_in
add wave -noupdate -group frame_builder -expand -group regs -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame/eop_int
add wave -noupdate -group frame_builder -expand -group regs -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame/eop_int_reg
add wave -noupdate -group frame_builder -expand -group regs -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame/eop_reg_in
add wave -noupdate -group frame_builder -expand -group regs -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame/eop_reg_reg_in
add wave -noupdate -group frame_builder -expand -group regs /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame/frame_shift
add wave -noupdate -group frame_builder -expand -group regs /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame/val_reg_in
add wave -noupdate -divider {FIFO 2}
add wave -noupdate -expand -group frame_out -expand -group INPUTS_ -color Cyan /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame_out/clk
add wave -noupdate -expand -group frame_out -expand -group INPUTS_ -color Cyan /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame_out/rst
add wave -noupdate -expand -group frame_out -expand -group INPUTS_ -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame_out/data_in
add wave -noupdate -expand -group frame_out -expand -group INPUTS_ -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame_out/eop_in
add wave -noupdate -expand -group frame_out -expand -group INPUTS_ -color Cyan -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame_out/sop_in
add wave -noupdate -expand -group frame_out -expand -group INPUTS_ -color Cyan /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame_out/val_in
add wave -noupdate -expand -group frame_out -expand -group INPUTS_ /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame_out/wen
add wave -noupdate -expand -group frame_out -expand -group OUTPUTS -color Magenta /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame_out/ren
add wave -noupdate -expand -group frame_out -expand -group OUTPUTS /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame_out/almost_e
add wave -noupdate -expand -group frame_out -expand -group OUTPUTS /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame_out/empty
add wave -noupdate -expand -group frame_out -expand -group OUTPUTS /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame_out/almost_f
add wave -noupdate -expand -group frame_out -expand -group OUTPUTS /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame_out/full
add wave -noupdate -expand -group frame_out -expand -group OUTPUTS -color Gold -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame_out/data_out
add wave -noupdate -expand -group frame_out -expand -group OUTPUTS -color Gold -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame_out/eop_out
add wave -noupdate -expand -group frame_out -expand -group OUTPUTS -color Gold -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame_out/sop_out
add wave -noupdate -expand -group frame_out -expand -group OUTPUTS -color Gold -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame_out/val_out
add wave -noupdate -divider MII
add wave -noupdate -expand -group mii_if -group IN -color Coral /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/mii/clk
add wave -noupdate -expand -group mii_if -group IN -color Coral /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/mii/rst
add wave -noupdate -expand -group mii_if -group IN -color Coral -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/mii/data_in
add wave -noupdate -expand -group mii_if -group IN -color Coral -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/mii/eop_in
add wave -noupdate -expand -group mii_if -group IN -color Coral -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/mii/sop_in
add wave -noupdate -expand -group mii_if -group IN -color Coral /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/mii/val_in
add wave -noupdate -expand -group mii_if -group IN /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/mii/almost_e
add wave -noupdate -expand -group mii_if -group IN /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/mii/almost_f
add wave -noupdate -expand -group mii_if -group IN /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/mii/empty
add wave -noupdate -expand -group mii_if -group IN /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/mii/full
add wave -noupdate -expand -group mii_if -group SIGNALS -color Magenta /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/mii/ps_mii
add wave -noupdate -expand -group mii_if -group SIGNALS /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/mii/ren_int
add wave -noupdate -expand -group mii_if -group SIGNALS -color {Orange Red} -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/mii/shift
add wave -noupdate -expand -group mii_if -group SIGNALS -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/mii/data_0_o
add wave -noupdate -expand -group mii_if -group SIGNALS -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/mii/data_1_o
add wave -noupdate -expand -group mii_if -group SIGNALS -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/mii/data_2_o
add wave -noupdate -expand -group mii_if -group SIGNALS -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/mii/data_3_o
add wave -noupdate -expand -group mii_if -group SIGNALS -color {Orange Red} -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/mii/eop_in_o
add wave -noupdate -expand -group mii_if -group SIGNALS -color {Orange Red} -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/mii/sop_in_o
add wave -noupdate -expand -group mii_if -group SIGNALS -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/mii/data_0_o_o
add wave -noupdate -expand -group mii_if -group SIGNALS -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/mii/data_1_o_o
add wave -noupdate -expand -group mii_if -group SIGNALS -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/mii/data_2_o_o
add wave -noupdate -expand -group mii_if -group SIGNALS -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/mii/data_3_o_o
add wave -noupdate -expand -group mii_if -expand -group OUT -color Gold /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/mii/ren_out
add wave -noupdate -expand -group mii_if -expand -group OUT -color Gold -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/mii/mii_data_0
add wave -noupdate -expand -group mii_if -expand -group OUT -color Gold -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/mii/mii_ctrl_0
add wave -noupdate -expand -group mii_if -expand -group OUT -color Gold -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/mii/mii_data_1
add wave -noupdate -expand -group mii_if -expand -group OUT -color Gold -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/mii/mii_ctrl_1
add wave -noupdate -expand -group mii_if -expand -group OUT -color Gold -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/mii/mii_data_2
add wave -noupdate -expand -group mii_if -expand -group OUT -color Gold -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/mii/mii_ctrl_2
add wave -noupdate -expand -group mii_if -expand -group OUT -color Gold -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/mii/mii_data_3
add wave -noupdate -expand -group mii_if -expand -group OUT -color Gold -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/mii/mii_ctrl_3
add wave -noupdate -divider PCS_TX
add wave -noupdate -expand -group PCS_0 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/xgmii_txc
add wave -noupdate -expand -group PCS_0 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/xgmii_txd
add wave -noupdate -expand -group PCS_0 -expand -group Encode_FSM_0 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_tx_path/INST_TX_PATH_ENCODE/TX_FSM/T_TYPE
add wave -noupdate -expand -group PCS_0 -expand -group Encode_FSM_0 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_tx_path/INST_TX_PATH_ENCODE/TX_FSM/TXD_encoded
add wave -noupdate -expand -group PCS_0 -expand -group Encode_FSM_0 -color Magenta -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_tx_path/INST_TX_PATH_ENCODE/TX_FSM/Current_state
add wave -noupdate -expand -group PCS_0 -expand -group Encode_FSM_0 -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_tx_path/INST_TX_PATH_ENCODE/TX_FSM/TYPE
add wave -noupdate -expand -group PCS_0 /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_tx_path/INST_TX_PATH_ENCODE/TX_FSM/terminate_out
add wave -noupdate -expand -group PCS_0 /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_tx_path/INST_TX_PATH_ENCODE/TX_FSM/start_out
add wave -noupdate -expand -group PCS_1 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/xgmii_txc
add wave -noupdate -expand -group PCS_1 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/xgmii_txd
add wave -noupdate -expand -group PCS_1 -expand -group Encode_FSM_1 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_tx_path/INST_TX_PATH_ENCODE/TX_FSM/T_TYPE
add wave -noupdate -expand -group PCS_1 -expand -group Encode_FSM_1 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_tx_path/INST_TX_PATH_ENCODE/TX_FSM/TXD_encoded
add wave -noupdate -expand -group PCS_1 -expand -group Encode_FSM_1 -color Magenta -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_tx_path/INST_TX_PATH_ENCODE/TX_FSM/Current_state
add wave -noupdate -expand -group PCS_1 -expand -group Encode_FSM_1 -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_tx_path/INST_TX_PATH_ENCODE/TX_FSM/TYPE
add wave -noupdate -expand -group PCS_1 /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_tx_path/INST_TX_PATH_ENCODE/TX_FSM/terminate_out
add wave -noupdate -expand -group PCS_1 /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_tx_path/INST_TX_PATH_ENCODE/TX_FSM/start_out
add wave -noupdate -expand -group PCS_2 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/xgmii_txc
add wave -noupdate -expand -group PCS_2 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/xgmii_txd
add wave -noupdate -expand -group PCS_2 -expand -group Encode_FSM_2 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_tx_path/INST_TX_PATH_ENCODE/TX_FSM/T_TYPE
add wave -noupdate -expand -group PCS_2 -expand -group Encode_FSM_2 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_tx_path/INST_TX_PATH_ENCODE/TX_FSM/TXD_encoded
add wave -noupdate -expand -group PCS_2 -expand -group Encode_FSM_2 -color Magenta -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_tx_path/INST_TX_PATH_ENCODE/TX_FSM/Current_state
add wave -noupdate -expand -group PCS_2 -expand -group Encode_FSM_2 -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_tx_path/INST_TX_PATH_ENCODE/TX_FSM/TYPE
add wave -noupdate -expand -group PCS_2 /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_tx_path/INST_TX_PATH_ENCODE/TX_FSM/terminate_out
add wave -noupdate -expand -group PCS_2 /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_tx_path/INST_TX_PATH_ENCODE/TX_FSM/start_out
add wave -noupdate -expand -group PCS_3 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/xgmii_txc
add wave -noupdate -expand -group PCS_3 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/xgmii_txd
add wave -noupdate -expand -group PCS_3 -expand -group Encode_FSM_3 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_tx_path/INST_TX_PATH_ENCODE/TX_FSM/T_TYPE
add wave -noupdate -expand -group PCS_3 -expand -group Encode_FSM_3 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_tx_path/INST_TX_PATH_ENCODE/TX_FSM/TXD_encoded
add wave -noupdate -expand -group PCS_3 -expand -group Encode_FSM_3 -color Magenta -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_tx_path/INST_TX_PATH_ENCODE/TX_FSM/Current_state
add wave -noupdate -expand -group PCS_3 -expand -group Encode_FSM_3 -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_tx_path/INST_TX_PATH_ENCODE/TX_FSM/TYPE
add wave -noupdate -expand -group PCS_3 /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_tx_path/INST_TX_PATH_ENCODE/TX_FSM/terminate_out
add wave -noupdate -expand -group PCS_3 /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_tx_path/INST_TX_PATH_ENCODE/TX_FSM/start_out
add wave -noupdate -group PLOT_FIFOs /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/payload_in/FIFO_L0/WRCOUNT
add wave -noupdate -group PLOT_FIFOs /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/payload_in/FIFO_L0/RDCOUNT
add wave -noupdate -group PLOT_FIFOs /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/payload_in/FIFO_L1/WRCOUNT
add wave -noupdate -group PLOT_FIFOs /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/payload_in/FIFO_L1/RDCOUNT
add wave -noupdate -group PLOT_FIFOs /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/payload_in/FIFO_H0/WRCOUNT
add wave -noupdate -group PLOT_FIFOs /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/payload_in/FIFO_H0/RDCOUNT
add wave -noupdate -group PLOT_FIFOs /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/payload_in/FIFO_H1/WRCOUNT
add wave -noupdate -group PLOT_FIFOs /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/payload_in/FIFO_H1/RDCOUNT
add wave -noupdate -group PLOT_FIFOs /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame_out/FIFO_L0/WRCOUNT
add wave -noupdate -group PLOT_FIFOs /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame_out/FIFO_L0/RDCOUNT
add wave -noupdate -group PLOT_FIFOs /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame_out/FIFO_L1/WRCOUNT
add wave -noupdate -group PLOT_FIFOs /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame_out/FIFO_L1/RDCOUNT
add wave -noupdate -group PLOT_FIFOs /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame_out/FIFO_H0/WRCOUNT
add wave -noupdate -group PLOT_FIFOs /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame_out/FIFO_H0/RDCOUNT
add wave -noupdate -group PLOT_FIFOs /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame_out/FIFO_H1/WRCOUNT
add wave -noupdate -group PLOT_FIFOs /Top/rx_xgt4/inst_wrapper_macpcs/INST_mac_tx_path/frame_out/FIFO_H1/RDCOUNT
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 5} {2454400 ps} 1} {{Cursor 2} {438400 ps} 0}
quietly wave cursor active 2
configure wave -namecolwidth 180
configure wave -valuecolwidth 185
configure wave -justifyvalue left
configure wave -signalnamewidth 1
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
WaveRestoreZoom {430484 ps} {484717 ps}
bookmark add wave bookmark45 {{770754 ps} {811500 ps}} 13
bookmark add wave bookmark46 {{780000 ps} {800000 ps}} 8
bookmark add wave bookmark47 {{0 ps} {42010 ps}} 0
bookmark add wave bookmark48 {{201305 ps} {266263 ps}} 7
bookmark add wave bookmark49 {{728057 ps} {794311 ps}} 6
bookmark add wave bookmark50 {{1931987 ps} {1965959 ps}} 9
