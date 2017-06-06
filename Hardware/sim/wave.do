onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group Resets /Top/tb_xgt4/reset_in_pcs
add wave -noupdate -expand -group Resets /Top/tb_xgt4/reset_in
add wave -noupdate -expand -group Resets /Top/tb_xgt4/reset_in_mii_tx
add wave -noupdate -expand -group Resets /Top/tb_xgt4/reset_in_mii_rx
add wave -noupdate /Top/tb_xgt4/clock_in156
add wave -noupdate /Top/tb_xgt4/clock_in161
add wave -noupdate -expand -group From_ECHO_gen /Top/tb_xgt4/echo_gen_inst/current_s
add wave -noupdate -expand -group From_ECHO_gen -radix hexadecimal /Top/tb_xgt4/pkt_tx_data
add wave -noupdate -expand -group From_ECHO_gen /Top/tb_xgt4/inst_wrapper_macpcs/pkt_tx_val
add wave -noupdate -expand -group From_ECHO_gen /Top/tb_xgt4/inst_wrapper_macpcs/pkt_tx_sop
add wave -noupdate -expand -group From_ECHO_gen /Top/tb_xgt4/inst_wrapper_macpcs/pkt_tx_eop
add wave -noupdate -expand -group From_ECHO_gen /Top/tb_xgt4/inst_wrapper_macpcs/INST_xge_mac/pkt_tx_mod
add wave -noupdate -expand -group MII(MAC->PCS) /Top/tb_xgt4/inst_wrapper_macpcs/xgmii_txc
add wave -noupdate -expand -group MII(MAC->PCS) -radix hexadecimal /Top/tb_xgt4/inst_wrapper_macpcs/xgmii_txd
add wave -noupdate /Top/tb_xgt4/start_fifo
add wave -noupdate -radix binary /Top/tb_xgt4/inst_wrapper_macpcs/INST_PCS_core/tx_header_out
add wave -noupdate -radix hexadecimal /Top/tb_xgt4/inst_wrapper_macpcs/INST_PCS_core/tx_data_out
add wave -noupdate -divider fiber
add wave -noupdate -expand -group FIBER -radix binary /Top/fiber/header_out_0
add wave -noupdate -expand -group FIBER -radix hexadecimal /Top/fiber/block_out_0
add wave -noupdate -expand -group FIBER -radix binary /Top/fiber/header_out_1
add wave -noupdate -expand -group FIBER -radix hexadecimal /Top/fiber/block_out_1
add wave -noupdate -expand -group FIBER -radix binary /Top/fiber/header_out_2
add wave -noupdate -expand -group FIBER -radix hexadecimal /Top/fiber/block_out_2
add wave -noupdate -expand -group FIBER -radix binary /Top/fiber/header_out_3
add wave -noupdate -expand -group FIBER -radix hexadecimal /Top/fiber/block_out_3
add wave -noupdate -divider REORDER
add wave -noupdate -expand -group LANE_REORDER -radix binary /Top/rx_xgt4/inst_lane_reorder/logical_lane_0_int
add wave -noupdate -expand -group LANE_REORDER -radix binary /Top/rx_xgt4/inst_lane_reorder/lane_0_header_in
add wave -noupdate -expand -group LANE_REORDER -radix hexadecimal /Top/rx_xgt4/inst_lane_reorder/lane_0_data_in
add wave -noupdate -expand -group LANE_REORDER -radix binary /Top/rx_xgt4/inst_lane_reorder/logical_lane_1_int
add wave -noupdate -expand -group LANE_REORDER -radix binary /Top/rx_xgt4/inst_lane_reorder/lane_1_header_in
add wave -noupdate -expand -group LANE_REORDER -radix hexadecimal /Top/rx_xgt4/inst_lane_reorder/lane_1_data_in
add wave -noupdate -expand -group LANE_REORDER -radix binary /Top/rx_xgt4/inst_lane_reorder/logical_lane_2_int
add wave -noupdate -expand -group LANE_REORDER -radix binary /Top/rx_xgt4/inst_lane_reorder/lane_2_header_in
add wave -noupdate -expand -group LANE_REORDER -radix hexadecimal /Top/rx_xgt4/inst_lane_reorder/lane_2_data_in
add wave -noupdate -expand -group LANE_REORDER -radix binary /Top/rx_xgt4/inst_lane_reorder/logical_lane_3_int
add wave -noupdate -expand -group LANE_REORDER -radix binary /Top/rx_xgt4/inst_lane_reorder/lane_3_header_in
add wave -noupdate -expand -group LANE_REORDER -radix hexadecimal /Top/rx_xgt4/inst_lane_reorder/lane_3_data_in
add wave -noupdate -expand -group LANE_REORDER /Top/rx_xgt4/inst_lane_reorder/barreira_skew
add wave -noupdate -expand -group LANE_REORDER /Top/rx_xgt4/inst_lane_reorder/sync_ok_0
add wave -noupdate -expand -group LANE_REORDER /Top/rx_xgt4/inst_lane_reorder/sync_ok_1
add wave -noupdate -expand -group LANE_REORDER /Top/rx_xgt4/inst_lane_reorder/sync_ok_2
add wave -noupdate -expand -group LANE_REORDER /Top/rx_xgt4/inst_lane_reorder/sync_ok_3
add wave -noupdate -expand -group LANE_REORDER /Top/rx_xgt4/inst_lane_reorder/pcs_0_header_out
add wave -noupdate -expand -group LANE_REORDER /Top/rx_xgt4/inst_lane_reorder/pcs_0_data_out
add wave -noupdate -expand -group LANE_REORDER /Top/rx_xgt4/inst_lane_reorder/pcs_1_header_out
add wave -noupdate -expand -group LANE_REORDER /Top/rx_xgt4/inst_lane_reorder/pcs_1_data_out
add wave -noupdate -expand -group LANE_REORDER /Top/rx_xgt4/inst_lane_reorder/pcs_2_header_out
add wave -noupdate -expand -group LANE_REORDER /Top/rx_xgt4/inst_lane_reorder/pcs_2_data_out
add wave -noupdate -expand -group LANE_REORDER /Top/rx_xgt4/inst_lane_reorder/pcs_3_header_out
add wave -noupdate -expand -group LANE_REORDER /Top/rx_xgt4/inst_lane_reorder/pcs_3_data_out
add wave -noupdate -expand -group LANE_0 -radix hexadecimal /Top/rx_xgt4/inst_lane_reorder/lane_0/data_in
add wave -noupdate -expand -group LANE_0 -radix binary /Top/rx_xgt4/inst_lane_reorder/lane_0/header_in
add wave -noupdate -expand -group LANE_0 -radix binary /Top/rx_xgt4/inst_lane_reorder/lane_0/logical_lane
add wave -noupdate -expand -group LANE_0 -radix binary /Top/rx_xgt4/inst_lane_reorder/lane_0/logical_lane_int
add wave -noupdate -expand -group LANE_0 /Top/rx_xgt4/inst_lane_reorder/lane_0/sync_ok
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {120900 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 452
configure wave -valuecolwidth 144
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
WaveRestoreZoom {740826 ps} {803115 ps}
