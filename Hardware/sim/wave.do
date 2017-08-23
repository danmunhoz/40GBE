onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group Resets /Top/tb_xgt4/reset_in_pcs
add wave -noupdate -group Resets /Top/tb_xgt4/reset_in
add wave -noupdate -group Resets /Top/tb_xgt4/reset_in_mii_tx
add wave -noupdate -group Resets /Top/tb_xgt4/reset_in_mii_rx
add wave -noupdate /Top/tb_xgt4/clock_in156
add wave -noupdate /Top/tb_xgt4/clock_in161
add wave -noupdate -group From_ECHO_gen /Top/tb_xgt4/echo_gen_inst/current_s
add wave -noupdate -group From_ECHO_gen -radix hexadecimal /Top/tb_xgt4/pkt_tx_data
add wave -noupdate -group From_ECHO_gen /Top/tb_xgt4/inst_wrapper_macpcs/pkt_tx_val
add wave -noupdate -group From_ECHO_gen /Top/tb_xgt4/inst_wrapper_macpcs/pkt_tx_sop
add wave -noupdate -group From_ECHO_gen /Top/tb_xgt4/inst_wrapper_macpcs/pkt_tx_eop
add wave -noupdate -group From_ECHO_gen /Top/tb_xgt4/inst_wrapper_macpcs/INST_xge_mac/pkt_tx_mod
add wave -noupdate -group MII(MAC->PCS) /Top/tb_xgt4/inst_wrapper_macpcs/xgmii_txc
add wave -noupdate -group MII(MAC->PCS) -radix hexadecimal /Top/tb_xgt4/inst_wrapper_macpcs/xgmii_txd
add wave -noupdate -group MII(MAC->PCS) -radix hexadecimal /Top/tb_xgt4/inst_wrapper_macpcs/INST_PCS_core/tx_data_out
add wave -noupdate -group MII(MAC->PCS) -radix binary /Top/tb_xgt4/inst_wrapper_macpcs/INST_PCS_core/tx_header_out
add wave -noupdate -divider REORDER
add wave -noupdate -group {Lane Reorder} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/clock
add wave -noupdate -group {Lane Reorder} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/reset
add wave -noupdate -group {Lane Reorder} -group INPUT -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/lane_0_header_in
add wave -noupdate -group {Lane Reorder} -group INPUT -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/lane_0_data_in
add wave -noupdate -group {Lane Reorder} -group INPUT -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/lane_1_header_in
add wave -noupdate -group {Lane Reorder} -group INPUT -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/lane_1_data_in
add wave -noupdate -group {Lane Reorder} -group INPUT -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/lane_2_header_in
add wave -noupdate -group {Lane Reorder} -group INPUT -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/lane_2_data_in
add wave -noupdate -group {Lane Reorder} -group INPUT -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/lane_3_header_in
add wave -noupdate -group {Lane Reorder} -group INPUT -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/lane_3_data_in
add wave -noupdate -group {Lane Reorder} -childformat {{/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.data_0 -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.data_1 -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.data_2 -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.data_3 -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.header_0 -radix binary} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.header_1 -radix binary} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.header_2 -radix binary} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.header_3 -radix binary} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.logical_lane_0 -radix unsigned} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.logical_lane_1 -radix unsigned} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.logical_lane_2 -radix unsigned} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.logical_lane_3 -radix unsigned}} -subitemconfig {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.data_0 {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.data_1 {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.data_2 {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.data_3 {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.header_0 {-height 16 -radix binary} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.header_1 {-height 16 -radix binary} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.header_2 {-height 16 -radix binary} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.header_3 {-height 16 -radix binary} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.logical_lane_0 {-height 16 -radix unsigned} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.logical_lane_1 {-height 16 -radix unsigned} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.logical_lane_2 {-height 16 -radix unsigned} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew.logical_lane_3 {-height 16 -radix unsigned}} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_skew
add wave -noupdate -group {Lane Reorder} -childformat {{/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.data_0 -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.data_1 -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.data_2 -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.data_3 -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.header_0 -radix binary} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.header_1 -radix binary} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.header_2 -radix binary} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.header_3 -radix binary} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.logical_lane_0 -radix unsigned} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.logical_lane_1 -radix unsigned} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.logical_lane_2 -radix unsigned} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.logical_lane_3 -radix unsigned}} -subitemconfig {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.data_0 {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.data_1 {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.data_2 {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.data_3 {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.header_0 {-height 16 -radix binary} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.header_1 {-height 16 -radix binary} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.header_2 {-height 16 -radix binary} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.header_3 {-height 16 -radix binary} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.logical_lane_0 {-height 16 -radix unsigned} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.logical_lane_1 {-height 16 -radix unsigned} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.logical_lane_2 {-height 16 -radix unsigned} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip.logical_lane_3 {-height 16 -radix unsigned}} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_bip
add wave -noupdate -group {Lane Reorder} -childformat {{/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_xbar.data_0 -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_xbar.data_1 -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_xbar.data_2 -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_xbar.data_3 -radix hexadecimal} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_xbar.header_0 -radix binary} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_xbar.header_1 -radix binary} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_xbar.header_2 -radix binary} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_xbar.header_3 -radix binary}} -subitemconfig {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_xbar.data_0 {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_xbar.data_1 {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_xbar.data_2 {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_xbar.data_3 {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_xbar.header_0 {-height 16 -radix binary} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_xbar.header_1 {-height 16 -radix binary} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_xbar.header_2 {-height 16 -radix binary} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_xbar.header_3 {-height 16 -radix binary}} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/barreira_xbar
add wave -noupdate -group {Lane Reorder} -expand -group OUTPUT -radix binary -childformat {{/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/pcs_0_header_out(1) -radix binary} {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/pcs_0_header_out(0) -radix binary}} -subitemconfig {/Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/pcs_0_header_out(1) {-height 16 -radix binary} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/pcs_0_header_out(0) {-height 16 -radix binary}} /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/pcs_0_header_out
add wave -noupdate -group {Lane Reorder} -expand -group OUTPUT -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/pcs_0_data_out
add wave -noupdate -group {Lane Reorder} -expand -group OUTPUT -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/pcs_1_header_out
add wave -noupdate -group {Lane Reorder} -expand -group OUTPUT -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/pcs_1_data_out
add wave -noupdate -group {Lane Reorder} -expand -group OUTPUT -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/pcs_2_header_out
add wave -noupdate -group {Lane Reorder} -expand -group OUTPUT -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/pcs_2_data_out
add wave -noupdate -group {Lane Reorder} -expand -group OUTPUT -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/pcs_3_header_out
add wave -noupdate -group {Lane Reorder} -expand -group OUTPUT -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/pcs_3_data_out
add wave -noupdate -divider PCSs
add wave -noupdate -group PCS_0 /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/rx_header_valid_in
add wave -noupdate -group PCS_0 /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/rx_data_valid_in
add wave -noupdate -group PCS_0 -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/rx_header_in
add wave -noupdate -group PCS_0 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/rx_data_in
add wave -noupdate -group PCS_0 -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/rx_old_header_in
add wave -noupdate -group PCS_0 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/rx_old_data_in
add wave -noupdate -group PCS_0 /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/rx_data
add wave -noupdate -group PCS_0 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/xgmii_rxc
add wave -noupdate -group PCS_0 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/xgmii_rxd
add wave -noupdate -group desc_o /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RXD_Sync
add wave -noupdate -group desc_o /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rx_old_header_in
add wave -noupdate -group desc_o /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rx_old_data_in
add wave -noupdate -group desc_o /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/DeScr_RXD
add wave -noupdate -group desc_o /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RXD_input
add wave -noupdate -group desc_o /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RX_Sync_header
add wave -noupdate -group desc_o /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/DeScr_wire
add wave -noupdate -group desc_o /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rx_old_block
add wave -noupdate -group desc_o /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rx_old_block_desc
add wave -noupdate -group R_TYPE_Decode_0 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/DeScr_RXD
add wave -noupdate -group R_TYPE_Decode_0 -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/R_TYPE
add wave -noupdate -group R_TYPE_Decode_0 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/rx_data
add wave -noupdate -group R_TYPE_Decode_0 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/rx_control
add wave -noupdate -group R_TYPE_Decode_0 -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/sync_header
add wave -noupdate -group R_TYPE_Decode_0 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/coded_data
add wave -noupdate -group R_TYPE_Decode_0 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/decoded_data
add wave -noupdate -group R_TYPE_Decode_0 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/block_type_dec
add wave -noupdate -group R_TYPE_Decode_0 /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/terminate_out
add wave -noupdate -group R_TYPE_Decode_0 /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/terminate_in
add wave -noupdate -group PCS_1 /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/rx_header_valid_in
add wave -noupdate -group PCS_1 /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/rx_data_valid_in
add wave -noupdate -group PCS_1 -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/rx_header_in
add wave -noupdate -group PCS_1 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/rx_data_in
add wave -noupdate -group PCS_1 -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/rx_old_header_in
add wave -noupdate -group PCS_1 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/rx_old_data_in
add wave -noupdate -group PCS_1 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/xgmii_rxc
add wave -noupdate -group PCS_1 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/xgmii_rxd
add wave -noupdate -group desc_1 /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RXD_Sync
add wave -noupdate -group desc_1 /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rx_old_header_in
add wave -noupdate -group desc_1 /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rx_old_data_in
add wave -noupdate -group desc_1 /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/DeScr_RXD
add wave -noupdate -group desc_1 /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RXD_input
add wave -noupdate -group desc_1 /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RX_Sync_header
add wave -noupdate -group desc_1 /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/DeScr_wire
add wave -noupdate -group desc_1 /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rx_old_block
add wave -noupdate -group desc_1 /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rx_old_block_desc
add wave -noupdate -group R_TYPE_Decode_1 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/DeScr_RXD
add wave -noupdate -group R_TYPE_Decode_1 -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/R_TYPE
add wave -noupdate -group R_TYPE_Decode_1 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/rx_data
add wave -noupdate -group R_TYPE_Decode_1 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/rx_control
add wave -noupdate -group R_TYPE_Decode_1 -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/sync_header
add wave -noupdate -group R_TYPE_Decode_1 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/coded_data
add wave -noupdate -group R_TYPE_Decode_1 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/decoded_data
add wave -noupdate -group R_TYPE_Decode_1 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/block_type_dec
add wave -noupdate -group R_TYPE_Decode_1 /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/terminate_out
add wave -noupdate -group R_TYPE_Decode_1 /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/terminate_in
add wave -noupdate -group PCS_2 /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/rx_header_valid_in
add wave -noupdate -group PCS_2 /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/rx_data_valid_in
add wave -noupdate -group PCS_2 -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/rx_header_in
add wave -noupdate -group PCS_2 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/rx_data_in
add wave -noupdate -group PCS_2 -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/rx_old_header_in
add wave -noupdate -group PCS_2 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/rx_old_data_in
add wave -noupdate -group PCS_2 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/xgmii_rxc
add wave -noupdate -group PCS_2 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/xgmii_rxd
add wave -noupdate -group R_TYPE_2 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/DeScr_RXD
add wave -noupdate -group R_TYPE_2 -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/R_TYPE
add wave -noupdate -group R_TYPE_2 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/rx_data
add wave -noupdate -group R_TYPE_2 /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/rx_control
add wave -noupdate -group R_TYPE_2 -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/sync_header
add wave -noupdate -group R_TYPE_2 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/coded_data
add wave -noupdate -group R_TYPE_2 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/decoded_data
add wave -noupdate -group R_TYPE_2 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/block_type_dec
add wave -noupdate -group R_TYPE_2 /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/terminate_out
add wave -noupdate -group R_TYPE_2 /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/terminate_in
add wave -noupdate -group desc_2 /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RXD_Sync
add wave -noupdate -group desc_2 /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rx_old_header_in
add wave -noupdate -group desc_2 /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rx_old_data_in
add wave -noupdate -group desc_2 /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/DeScr_RXD
add wave -noupdate -group desc_2 /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RXD_input
add wave -noupdate -group desc_2 /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RX_Sync_header
add wave -noupdate -group desc_2 /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/DeScr_wire
add wave -noupdate -group desc_2 /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rx_old_block
add wave -noupdate -group desc_2 /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rx_old_block_desc
add wave -noupdate -group PCS_3 /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/rx_header_valid_in
add wave -noupdate -group PCS_3 /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/rx_data_valid_in
add wave -noupdate -group PCS_3 -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/rx_header_in
add wave -noupdate -group PCS_3 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/rx_data_in
add wave -noupdate -group PCS_3 -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/rx_old_header_in
add wave -noupdate -group PCS_3 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/rx_old_data_in
add wave -noupdate -group PCS_3 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/xgmii_rxc
add wave -noupdate -group PCS_3 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/xgmii_rxd
add wave -noupdate -group R_TYPE_3 -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/Current_state
add wave -noupdate -group R_TYPE_3 -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/Next_state
add wave -noupdate -group R_TYPE_3 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/DeScr_RXD
add wave -noupdate -group R_TYPE_3 -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/R_TYPE
add wave -noupdate -group R_TYPE_3 -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/TYPE
add wave -noupdate -group R_TYPE_3 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/rx_data
add wave -noupdate -group R_TYPE_3 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/rx_control
add wave -noupdate -group R_TYPE_3 -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/sync_header
add wave -noupdate -group R_TYPE_3 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/coded_data
add wave -noupdate -group R_TYPE_3 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/decoded_data
add wave -noupdate -group R_TYPE_3 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/R_TYPE_Decode/block_type_dec
add wave -noupdate -group R_TYPE_3 /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/terminate_in
add wave -noupdate /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DECODER/RX_FSM/terminate_out
add wave -noupdate -group desc_3 /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RXD_Sync
add wave -noupdate -group desc_3 /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rx_old_header_in
add wave -noupdate -group desc_3 /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rx_old_data_in
add wave -noupdate -group desc_3 /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/DeScr_RXD
add wave -noupdate -group desc_3 /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RXD_input
add wave -noupdate -group desc_3 /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/RX_Sync_header
add wave -noupdate -group desc_3 /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/DeScr_wire
add wave -noupdate -group desc_3 /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rx_old_block
add wave -noupdate -group desc_3 /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_DESCRAMBLE/rx_old_block_desc
add wave -noupdate -divider -height 20 {CORE INTERFACE}
add wave -noupdate -expand -group mii_shift_register /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shift_reg/clk
add wave -noupdate -expand -group mii_shift_register /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shift_reg/rst_n
add wave -noupdate -expand -group mii_shift_register /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shift_reg/ctrl
add wave -noupdate -expand -group mii_shift_register /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shift_reg/xgmii_rxc_0
add wave -noupdate -expand -group mii_shift_register /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shift_reg/xgmii_rxd_0
add wave -noupdate -expand -group mii_shift_register /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shift_reg/xgmii_rxc_1
add wave -noupdate -expand -group mii_shift_register /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shift_reg/xgmii_rxd_1
add wave -noupdate -expand -group mii_shift_register /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shift_reg/xgmii_rxc_2
add wave -noupdate -expand -group mii_shift_register /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shift_reg/xgmii_rxd_2
add wave -noupdate -expand -group mii_shift_register /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shift_reg/xgmii_rxc_3
add wave -noupdate -expand -group mii_shift_register /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shift_reg/xgmii_rxd_3
add wave -noupdate -expand -group mii_shift_register /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shift_reg/reg_current_D
add wave -noupdate -expand -group mii_shift_register /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shift_reg/reg_current_Q
add wave -noupdate -expand -group mii_shift_register /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shift_reg/reg_previous_Q
add wave -noupdate -expand -group mii_shift_register /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shift_reg/reg_delay_Q
add wave -noupdate -expand -group mii_shift_register /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shift_reg/out_0
add wave -noupdate -expand -group mii_shift_register /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shift_reg/out_1
add wave -noupdate -divider -height 20 SHIFTER
add wave -noupdate /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/clk
add wave -noupdate /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/rst_n
add wave -noupdate /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_1
add wave -noupdate /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/in_0
add wave -noupdate /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/ctrl_reg_shift
add wave -noupdate /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/shifter/out_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {296383 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 759
configure wave -valuecolwidth 448
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
WaveRestoreZoom {30818 ps} {78516 ps}
