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
add wave -noupdate -group FIBER -radix binary /Top/fiber/header_out_0
add wave -noupdate -group FIBER -radix hexadecimal /Top/fiber/block_out_0
add wave -noupdate -group FIBER -radix binary /Top/fiber/header_out_1
add wave -noupdate -group FIBER -radix hexadecimal /Top/fiber/block_out_1
add wave -noupdate -group FIBER -radix binary /Top/fiber/header_out_2
add wave -noupdate -group FIBER -radix hexadecimal /Top/fiber/block_out_2
add wave -noupdate -group FIBER -radix binary /Top/fiber/header_out_3
add wave -noupdate -group FIBER -radix hexadecimal /Top/fiber/block_out_3
add wave -noupdate -divider REORDER
add wave -noupdate -expand -group LANE_REORDER -expand -group FIRST_STAGE -radix unsigned /Top/rx_xgt4/inst_lane_reorder/logical_lane_0/logical_lane_reg
add wave -noupdate -expand -group LANE_REORDER -expand -group FIRST_STAGE -radix binary /Top/rx_xgt4/inst_lane_reorder/logical_lane_0_int
add wave -noupdate -expand -group LANE_REORDER -expand -group FIRST_STAGE -radix binary /Top/rx_xgt4/inst_lane_reorder/lane_0_header_in
add wave -noupdate -expand -group LANE_REORDER -expand -group FIRST_STAGE -radix hexadecimal /Top/rx_xgt4/inst_lane_reorder/lane_0_data_in
add wave -noupdate -expand -group LANE_REORDER -expand -group FIRST_STAGE -radix unsigned /Top/rx_xgt4/inst_lane_reorder/logical_lane_1/logical_lane_reg
add wave -noupdate -expand -group LANE_REORDER -expand -group FIRST_STAGE -radix binary /Top/rx_xgt4/inst_lane_reorder/logical_lane_1_int
add wave -noupdate -expand -group LANE_REORDER -expand -group FIRST_STAGE -radix binary /Top/rx_xgt4/inst_lane_reorder/lane_1_header_in
add wave -noupdate -expand -group LANE_REORDER -expand -group FIRST_STAGE -radix hexadecimal /Top/rx_xgt4/inst_lane_reorder/lane_1_data_in
add wave -noupdate -expand -group LANE_REORDER -expand -group FIRST_STAGE -radix unsigned /Top/rx_xgt4/inst_lane_reorder/logical_lane_2/logical_lane_reg
add wave -noupdate -expand -group LANE_REORDER -expand -group FIRST_STAGE -radix binary /Top/rx_xgt4/inst_lane_reorder/logical_lane_2_int
add wave -noupdate -expand -group LANE_REORDER -expand -group FIRST_STAGE -radix binary /Top/rx_xgt4/inst_lane_reorder/lane_2_header_in
add wave -noupdate -expand -group LANE_REORDER -expand -group FIRST_STAGE -radix hexadecimal /Top/rx_xgt4/inst_lane_reorder/lane_2_data_in
add wave -noupdate -expand -group LANE_REORDER -expand -group FIRST_STAGE -radix unsigned /Top/rx_xgt4/inst_lane_reorder/logical_lane_3/logical_lane_reg
add wave -noupdate -expand -group LANE_REORDER -expand -group FIRST_STAGE -radix binary /Top/rx_xgt4/inst_lane_reorder/logical_lane_3_int
add wave -noupdate -expand -group LANE_REORDER -expand -group FIRST_STAGE -radix binary /Top/rx_xgt4/inst_lane_reorder/lane_3_header_in
add wave -noupdate -expand -group LANE_REORDER -expand -group FIRST_STAGE -radix hexadecimal /Top/rx_xgt4/inst_lane_reorder/lane_3_data_in
add wave -noupdate -expand -group LANE_REORDER -expand -group FIRST_STAGE -childformat {{/Top/rx_xgt4/inst_lane_reorder/barreira_skew.data_0 -radix hexadecimal} {/Top/rx_xgt4/inst_lane_reorder/barreira_skew.data_1 -radix hexadecimal} {/Top/rx_xgt4/inst_lane_reorder/barreira_skew.data_2 -radix hexadecimal} {/Top/rx_xgt4/inst_lane_reorder/barreira_skew.data_3 -radix hexadecimal} {/Top/rx_xgt4/inst_lane_reorder/barreira_skew.header_0 -radix binary} {/Top/rx_xgt4/inst_lane_reorder/barreira_skew.header_1 -radix binary} {/Top/rx_xgt4/inst_lane_reorder/barreira_skew.header_2 -radix binary} {/Top/rx_xgt4/inst_lane_reorder/barreira_skew.header_3 -radix binary} {/Top/rx_xgt4/inst_lane_reorder/barreira_skew.logical_lane_0 -radix decimal} {/Top/rx_xgt4/inst_lane_reorder/barreira_skew.logical_lane_1 -radix decimal} {/Top/rx_xgt4/inst_lane_reorder/barreira_skew.logical_lane_2 -radix decimal} {/Top/rx_xgt4/inst_lane_reorder/barreira_skew.logical_lane_3 -radix decimal}} -subitemconfig {/Top/rx_xgt4/inst_lane_reorder/barreira_skew.data_0 {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_lane_reorder/barreira_skew.data_1 {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_lane_reorder/barreira_skew.data_2 {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_lane_reorder/barreira_skew.data_3 {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_lane_reorder/barreira_skew.header_0 {-height 16 -radix binary} /Top/rx_xgt4/inst_lane_reorder/barreira_skew.header_1 {-height 16 -radix binary} /Top/rx_xgt4/inst_lane_reorder/barreira_skew.header_2 {-height 16 -radix binary} /Top/rx_xgt4/inst_lane_reorder/barreira_skew.header_3 {-height 16 -radix binary} /Top/rx_xgt4/inst_lane_reorder/barreira_skew.logical_lane_0 {-height 16 -radix decimal} /Top/rx_xgt4/inst_lane_reorder/barreira_skew.logical_lane_1 {-height 16 -radix decimal} /Top/rx_xgt4/inst_lane_reorder/barreira_skew.logical_lane_2 {-height 16 -radix decimal} /Top/rx_xgt4/inst_lane_reorder/barreira_skew.logical_lane_3 {-height 16 -radix decimal}} /Top/rx_xgt4/inst_lane_reorder/barreira_skew
add wave -noupdate -expand -group LANE_REORDER -expand -group SECOND_STAGE -childformat {{/Top/rx_xgt4/inst_lane_reorder/barreira_bip.data_0 -radix hexadecimal} {/Top/rx_xgt4/inst_lane_reorder/barreira_bip.data_1 -radix hexadecimal} {/Top/rx_xgt4/inst_lane_reorder/barreira_bip.data_2 -radix hexadecimal} {/Top/rx_xgt4/inst_lane_reorder/barreira_bip.data_3 -radix hexadecimal} {/Top/rx_xgt4/inst_lane_reorder/barreira_bip.header_0 -radix binary} {/Top/rx_xgt4/inst_lane_reorder/barreira_bip.header_1 -radix binary} {/Top/rx_xgt4/inst_lane_reorder/barreira_bip.header_2 -radix binary} {/Top/rx_xgt4/inst_lane_reorder/barreira_bip.header_3 -radix binary} {/Top/rx_xgt4/inst_lane_reorder/barreira_bip.logical_lane_0 -radix unsigned} {/Top/rx_xgt4/inst_lane_reorder/barreira_bip.logical_lane_1 -radix unsigned} {/Top/rx_xgt4/inst_lane_reorder/barreira_bip.logical_lane_2 -radix unsigned} {/Top/rx_xgt4/inst_lane_reorder/barreira_bip.logical_lane_3 -radix unsigned}} -subitemconfig {/Top/rx_xgt4/inst_lane_reorder/barreira_bip.data_0 {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_lane_reorder/barreira_bip.data_1 {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_lane_reorder/barreira_bip.data_2 {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_lane_reorder/barreira_bip.data_3 {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_lane_reorder/barreira_bip.header_0 {-height 16 -radix binary} /Top/rx_xgt4/inst_lane_reorder/barreira_bip.header_1 {-height 16 -radix binary} /Top/rx_xgt4/inst_lane_reorder/barreira_bip.header_2 {-height 16 -radix binary} /Top/rx_xgt4/inst_lane_reorder/barreira_bip.header_3 {-height 16 -radix binary} /Top/rx_xgt4/inst_lane_reorder/barreira_bip.logical_lane_0 {-height 16 -radix unsigned} /Top/rx_xgt4/inst_lane_reorder/barreira_bip.logical_lane_1 {-height 16 -radix unsigned} /Top/rx_xgt4/inst_lane_reorder/barreira_bip.logical_lane_2 {-height 16 -radix unsigned} /Top/rx_xgt4/inst_lane_reorder/barreira_bip.logical_lane_3 {-height 16 -radix unsigned}} /Top/rx_xgt4/inst_lane_reorder/barreira_bip
add wave -noupdate -expand -group LANE_REORDER -expand -group SECOND_STAGE /Top/rx_xgt4/inst_lane_reorder/enable_lane_0
add wave -noupdate -expand -group LANE_REORDER -expand -group SECOND_STAGE /Top/rx_xgt4/inst_lane_reorder/enable_lane_1
add wave -noupdate -expand -group LANE_REORDER -expand -group SECOND_STAGE /Top/rx_xgt4/inst_lane_reorder/enable_lane_2
add wave -noupdate -expand -group LANE_REORDER -expand -group SECOND_STAGE /Top/rx_xgt4/inst_lane_reorder/enable_lane_3
add wave -noupdate -expand -group LANE_REORDER -group THIRD_STAGE -childformat {{/Top/rx_xgt4/inst_lane_reorder/barreira_xbar.data_0 -radix hexadecimal} {/Top/rx_xgt4/inst_lane_reorder/barreira_xbar.data_1 -radix hexadecimal} {/Top/rx_xgt4/inst_lane_reorder/barreira_xbar.data_2 -radix hexadecimal} {/Top/rx_xgt4/inst_lane_reorder/barreira_xbar.data_3 -radix hexadecimal} {/Top/rx_xgt4/inst_lane_reorder/barreira_xbar.header_0 -radix binary} {/Top/rx_xgt4/inst_lane_reorder/barreira_xbar.header_1 -radix binary} {/Top/rx_xgt4/inst_lane_reorder/barreira_xbar.header_2 -radix binary} {/Top/rx_xgt4/inst_lane_reorder/barreira_xbar.header_3 -radix binary}} -expand -subitemconfig {/Top/rx_xgt4/inst_lane_reorder/barreira_xbar.data_0 {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_lane_reorder/barreira_xbar.data_1 {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_lane_reorder/barreira_xbar.data_2 {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_lane_reorder/barreira_xbar.data_3 {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_lane_reorder/barreira_xbar.header_0 {-height 16 -radix binary} /Top/rx_xgt4/inst_lane_reorder/barreira_xbar.header_1 {-height 16 -radix binary} /Top/rx_xgt4/inst_lane_reorder/barreira_xbar.header_2 {-height 16 -radix binary} /Top/rx_xgt4/inst_lane_reorder/barreira_xbar.header_3 {-height 16 -radix binary}} /Top/rx_xgt4/inst_lane_reorder/barreira_xbar
add wave -noupdate -expand -group LANE_REORDER -group FORTH_STAGE -radix hexadecimal /Top/rx_xgt4/inst_lane_reorder/fifo_in_0
add wave -noupdate -expand -group LANE_REORDER -group FORTH_STAGE -radix hexadecimal /Top/rx_xgt4/inst_lane_reorder/fifo_in_1
add wave -noupdate -expand -group LANE_REORDER -group FORTH_STAGE -radix hexadecimal /Top/rx_xgt4/inst_lane_reorder/fifo_in_2
add wave -noupdate -expand -group LANE_REORDER -group FORTH_STAGE -radix hexadecimal /Top/rx_xgt4/inst_lane_reorder/fifo_in_3
add wave -noupdate -expand -group LANE_REORDER -group FORTH_STAGE -radix hexadecimal /Top/rx_xgt4/inst_lane_reorder/fifo_out_0
add wave -noupdate -expand -group LANE_REORDER -group FORTH_STAGE -radix hexadecimal /Top/rx_xgt4/inst_lane_reorder/fifo_out_1
add wave -noupdate -expand -group LANE_REORDER -group FORTH_STAGE -radix hexadecimal /Top/rx_xgt4/inst_lane_reorder/fifo_out_2
add wave -noupdate -expand -group LANE_REORDER -group FORTH_STAGE -radix hexadecimal /Top/rx_xgt4/inst_lane_reorder/fifo_out_3
add wave -noupdate -expand -group LANE_REORDER -expand -group OUTPUTS -radix hexadecimal /Top/rx_xgt4/inst_lane_reorder/pcs_0_data_out
add wave -noupdate -expand -group LANE_REORDER -expand -group OUTPUTS -radix hexadecimal /Top/rx_xgt4/inst_lane_reorder/pcs_1_data_out
add wave -noupdate -expand -group LANE_REORDER -expand -group OUTPUTS -radix hexadecimal /Top/rx_xgt4/inst_lane_reorder/pcs_2_data_out
add wave -noupdate -expand -group LANE_REORDER -expand -group OUTPUTS -radix hexadecimal /Top/rx_xgt4/inst_lane_reorder/pcs_3_data_out
add wave -noupdate -expand -group LANE_REORDER -expand -group OUTPUTS -radix binary /Top/rx_xgt4/inst_lane_reorder/pcs_0_header_out
add wave -noupdate -expand -group LANE_REORDER -expand -group OUTPUTS -radix binary /Top/rx_xgt4/inst_lane_reorder/pcs_1_header_out
add wave -noupdate -expand -group LANE_REORDER -expand -group OUTPUTS -radix binary /Top/rx_xgt4/inst_lane_reorder/pcs_2_header_out
add wave -noupdate -expand -group LANE_REORDER -expand -group OUTPUTS -radix binary /Top/rx_xgt4/inst_lane_reorder/pcs_3_header_out
add wave -noupdate -expand -group bip_0 /Top/rx_xgt4/inst_lane_reorder/bip_calculator_0/clk
add wave -noupdate -expand -group bip_0 /Top/rx_xgt4/inst_lane_reorder/bip_calculator_0/data_in
add wave -noupdate -expand -group bip_0 /Top/rx_xgt4/inst_lane_reorder/bip_calculator_0/header_in
add wave -noupdate -expand -group bip_0 /Top/rx_xgt4/inst_lane_reorder/bip_calculator_0/is_sync
add wave -noupdate -expand -group bip_0 /Top/rx_xgt4/inst_lane_reorder/bip_calculator_0/bip_ok
add wave -noupdate -expand -group bip_0 /Top/rx_xgt4/inst_lane_reorder/bip_calculator_0/bip_old
add wave -noupdate -expand -group bip_0 /Top/rx_xgt4/inst_lane_reorder/bip_calculator_0/bip
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {749509 ps} 0}
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
WaveRestoreZoom {0 ps} {62289 ps}
