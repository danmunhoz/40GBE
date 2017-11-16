onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider REORDER
add wave -noupdate -expand -group {LANE REORDER} -group debug {/Top/area_timing_wrapper/inst_wrapper_macpcs/INST_lane_reorder/\barreira_bip[logical_lane_0] }
add wave -noupdate -expand -group {LANE REORDER} -group debug {/Top/area_timing_wrapper/inst_wrapper_macpcs/INST_lane_reorder/\barreira_bip[logical_lane_1] }
add wave -noupdate -expand -group {LANE REORDER} -group debug {/Top/area_timing_wrapper/inst_wrapper_macpcs/INST_lane_reorder/\barreira_bip[logical_lane_2] }
add wave -noupdate -expand -group {LANE REORDER} -group debug {/Top/area_timing_wrapper/inst_wrapper_macpcs/INST_lane_reorder/\barreira_bip[logical_lane_3] }
add wave -noupdate -expand -group {LANE REORDER} -group debug {/Top/area_timing_wrapper/inst_wrapper_macpcs/INST_lane_reorder/\barreira_bip[read_from_fifos] }
add wave -noupdate -expand -group {LANE REORDER} -group debug /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_lane_reorder/is_sync_0_int
add wave -noupdate -expand -group {LANE REORDER} -group debug /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_lane_reorder/is_sync_1_int
add wave -noupdate -expand -group {LANE REORDER} -group debug /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_lane_reorder/is_sync_2_int
add wave -noupdate -expand -group {LANE REORDER} -group debug /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_lane_reorder/is_sync_3_int
add wave -noupdate -expand -group {LANE REORDER} -group debug /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_lane_reorder/logical_lane_0_int
add wave -noupdate -expand -group {LANE REORDER} -group debug /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_lane_reorder/logical_lane_1_int
add wave -noupdate -expand -group {LANE REORDER} -group debug /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_lane_reorder/logical_lane_2_int
add wave -noupdate -expand -group {LANE REORDER} -group debug /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_lane_reorder/logical_lane_3_int
add wave -noupdate -expand -group {LANE REORDER} -group debug /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_lane_reorder/reg_bip_read_lanes_i_1_n_0
add wave -noupdate -expand -group {LANE REORDER} -group debug /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_lane_reorder/reg_xbar_wen_0_i_1_n_0
add wave -noupdate -expand -group {LANE REORDER} -group debug /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_lane_reorder/reg_xbar_wen_1_i_1_n_0
add wave -noupdate -expand -group {LANE REORDER} -group debug /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_lane_reorder/reg_xbar_wen_2_i_1_n_0
add wave -noupdate -expand -group {LANE REORDER} -group debug /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_lane_reorder/reg_xbar_wen_3_i_1_n_0
add wave -noupdate -expand -group {LANE REORDER} -radix binary /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_lane_reorder/clock
add wave -noupdate -expand -group {LANE REORDER} -radix binary /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_lane_reorder/reset
add wave -noupdate -expand -group {LANE REORDER} -radix binary /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_lane_reorder/pcs_0_header_out
add wave -noupdate -expand -group {LANE REORDER} -radix hexadecimal /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_lane_reorder/pcs_0_data_out
add wave -noupdate -expand -group {LANE REORDER} -radix binary /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_lane_reorder/pcs_1_header_out
add wave -noupdate -expand -group {LANE REORDER} -radix hexadecimal /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_lane_reorder/pcs_1_data_out
add wave -noupdate -expand -group {LANE REORDER} -radix binary /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_lane_reorder/pcs_2_header_out
add wave -noupdate -expand -group {LANE REORDER} -radix hexadecimal /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_lane_reorder/pcs_2_data_out
add wave -noupdate -expand -group {LANE REORDER} -radix binary /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_lane_reorder/pcs_3_header_out
add wave -noupdate -expand -group {LANE REORDER} -radix hexadecimal /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_lane_reorder/pcs_3_data_out
add wave -noupdate -divider PCSs
add wave -noupdate -expand -group PCS_0 -group PCS_0 /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_0_PCS_core/clk156
add wave -noupdate -expand -group PCS_0 -group PCS_0 /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_0_PCS_core/tx_clk161
add wave -noupdate -expand -group PCS_0 -group PCS_0 /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_0_PCS_core/rx_clk161
add wave -noupdate -expand -group PCS_0 -group PCS_0 /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_0_PCS_core/reset_tx_n
add wave -noupdate -expand -group PCS_0 -group PCS_0 /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_0_PCS_core/reset_rx_n
add wave -noupdate -expand -group PCS_0 -group PCS_0 /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_0_PCS_core/xgmii_txc
add wave -noupdate -expand -group PCS_0 -group PCS_0 /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_0_PCS_core/xgmii_txd
add wave -noupdate -expand -group PCS_0 -group PCS_0 /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_0_PCS_core/rx_header_valid_in
add wave -noupdate -expand -group PCS_0 -group PCS_0 /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_0_PCS_core/rx_header_in
add wave -noupdate -expand -group PCS_0 -group PCS_0 /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_0_PCS_core/rx_data_valid_in
add wave -noupdate -expand -group PCS_0 -group PCS_0 /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_0_PCS_core/rx_data_in
add wave -noupdate -expand -group PCS_0 -group PCS_0 /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_0_PCS_core/rx_old_data_in
add wave -noupdate -expand -group PCS_0 -group PCS_0 /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_0_PCS_core/jtest_errc
add wave -noupdate -expand -group PCS_0 -group PCS_0 /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_0_PCS_core/ber_cnt
add wave -noupdate -expand -group PCS_0 -group PCS_0 /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_0_PCS_core/hi_ber
add wave -noupdate -expand -group PCS_0 -group PCS_0 /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_0_PCS_core/blk_lock
add wave -noupdate -expand -group PCS_0 -group PCS_0 /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_0_PCS_core/rxlf
add wave -noupdate -expand -group PCS_0 -group PCS_0 /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_0_PCS_core/txlf
add wave -noupdate -expand -group PCS_0 -group PCS_0 /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_0_PCS_core/errd_blks
add wave -noupdate -expand -group PCS_0 -group PCS_0 /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_0_PCS_core/start_fifo
add wave -noupdate -expand -group PCS_0 /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_0_PCS_core/xgmii_rxc
add wave -noupdate -expand -group PCS_0 /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_0_PCS_core/xgmii_rxd
add wave -noupdate -expand -group PCS_1 -group PCS_1 /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_1_PCS_core/clk156
add wave -noupdate -expand -group PCS_1 -group PCS_1 /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_1_PCS_core/rx_clk161
add wave -noupdate -expand -group PCS_1 -group PCS_1 /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_1_PCS_core/reset_rx_n
add wave -noupdate -expand -group PCS_1 -group PCS_1 /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_1_PCS_core/rx_header_in
add wave -noupdate -expand -group PCS_1 -group PCS_1 /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_1_PCS_core/rx_data_valid_in
add wave -noupdate -expand -group PCS_1 -group PCS_1 /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_1_PCS_core/rx_data_in
add wave -noupdate -expand -group PCS_1 -group PCS_1 /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_1_PCS_core/rx_old_data_in
add wave -noupdate -expand -group PCS_1 -group PCS_1 /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_1_PCS_core/start_fifo
add wave -noupdate -expand -group PCS_1 /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_1_PCS_core/xgmii_rxc
add wave -noupdate -expand -group PCS_1 /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_1_PCS_core/xgmii_rxd
add wave -noupdate -expand -group PCS_2 -group PCS_2 /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_2_PCS_core/clk156
add wave -noupdate -expand -group PCS_2 -group PCS_2 /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_2_PCS_core/rx_clk161
add wave -noupdate -expand -group PCS_2 -group PCS_2 /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_2_PCS_core/reset_rx_n
add wave -noupdate -expand -group PCS_2 -group PCS_2 /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_2_PCS_core/rx_header_in
add wave -noupdate -expand -group PCS_2 -group PCS_2 /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_2_PCS_core/rx_data_valid_in
add wave -noupdate -expand -group PCS_2 -group PCS_2 /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_2_PCS_core/rx_data_in
add wave -noupdate -expand -group PCS_2 -group PCS_2 /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_2_PCS_core/rx_old_data_in
add wave -noupdate -expand -group PCS_2 -group PCS_2 /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_2_PCS_core/start_fifo
add wave -noupdate -expand -group PCS_2 /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_2_PCS_core/xgmii_rxc
add wave -noupdate -expand -group PCS_2 /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_2_PCS_core/xgmii_rxd
add wave -noupdate -expand -group PCS_3 -group PCS_3 /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_3_PCS_core/clk156
add wave -noupdate -expand -group PCS_3 -group PCS_3 /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_3_PCS_core/rx_clk161
add wave -noupdate -expand -group PCS_3 -group PCS_3 /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_3_PCS_core/reset_rx_n
add wave -noupdate -expand -group PCS_3 -group PCS_3 /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_3_PCS_core/rx_header_in
add wave -noupdate -expand -group PCS_3 -group PCS_3 /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_3_PCS_core/rx_data_valid_in
add wave -noupdate -expand -group PCS_3 -group PCS_3 /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_3_PCS_core/rx_data_in
add wave -noupdate -expand -group PCS_3 -group PCS_3 /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_3_PCS_core/rx_old_data_in
add wave -noupdate -expand -group PCS_3 -group PCS_3 /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_3_PCS_core/start_fifo
add wave -noupdate -expand -group PCS_3 /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_3_PCS_core/xgmii_rxc
add wave -noupdate -expand -group PCS_3 /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_3_PCS_core/xgmii_rxd
add wave -noupdate -divider -height 20 {CORE INTERFACE}
add wave -noupdate -group controller /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/controller/clk
add wave -noupdate -group controller /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/controller/rst_n
add wave -noupdate -group controller /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/controller/xgmii_rxc_0
add wave -noupdate -group controller /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/controller/xgmii_rxd_0
add wave -noupdate -group controller /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/controller/xgmii_rxc_1
add wave -noupdate -group controller /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/controller/xgmii_rxd_1
add wave -noupdate -group controller /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/controller/xgmii_rxc_2
add wave -noupdate -group controller /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/controller/xgmii_rxd_2
add wave -noupdate -group controller /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/controller/xgmii_rxc_3
add wave -noupdate -group controller /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/controller/xgmii_rxd_3
add wave -noupdate -group controller /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/controller/ctrl_delay
add wave -noupdate -group controller /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/controller/shift_out
add wave -noupdate -group controller /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/controller/is_sop
add wave -noupdate -group controller /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/controller/eop_location_out
add wave -noupdate -group controller /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/controller/wen_fifo
add wave -noupdate -group controller /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/controller/ctrl_delay_reg
add wave -noupdate -group controller /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/controller/eop_location_calc_reg
add wave -noupdate -group controller /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/controller/eop_location_calc_reg_reg__0
add wave -noupdate -group controller /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/controller/eop_location_reg
add wave -noupdate -group controller /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/controller/eop_location_reg_reg__0
add wave -noupdate -group controller /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/controller/shift_calc
add wave -noupdate -group controller /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/controller/shift_out_int
add wave -noupdate -group controller /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/controller/shift_out_reg
add wave -noupdate -group controller /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/controller/sop_location
add wave -noupdate -group controller /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/controller/sop_location_reg
add wave -noupdate -group shift_reg /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/shift_reg/clk
add wave -noupdate -group shift_reg /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/shift_reg/rst_n
add wave -noupdate -group shift_reg /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/shift_reg/xgmii_rxd_0
add wave -noupdate -group shift_reg /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/shift_reg/xgmii_rxd_1
add wave -noupdate -group shift_reg /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/shift_reg/xgmii_rxd_2
add wave -noupdate -group shift_reg /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/shift_reg/xgmii_rxd_3
add wave -noupdate -group shift_reg /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/shift_reg/ctrl
add wave -noupdate -group shift_reg /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/shift_reg/out_0
add wave -noupdate -group shift_reg /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/shift_reg/out_1
add wave -noupdate -group shift_reg -expand -group r_current /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/shift_reg/reg_current/ck
add wave -noupdate -group shift_reg -expand -group r_current /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/shift_reg/reg_current/rst
add wave -noupdate -group shift_reg -expand -group r_current /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/shift_reg/reg_current/ce
add wave -noupdate -group shift_reg -expand -group r_current /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/shift_reg/reg_current/D
add wave -noupdate -group shift_reg -expand -group r_current /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/shift_reg/reg_current/Q
add wave -noupdate -group shift_reg -expand -group r_previous /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/shift_reg/reg_previous/ck
add wave -noupdate -group shift_reg -expand -group r_previous /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/shift_reg/reg_previous/rst
add wave -noupdate -group shift_reg -expand -group r_previous /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/shift_reg/reg_previous/ce
add wave -noupdate -group shift_reg -expand -group r_previous /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/shift_reg/reg_previous/D
add wave -noupdate -group shift_reg -expand -group r_previous /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/shift_reg/reg_previous/Q
add wave -noupdate -group shift_reg -expand -group r_delay /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/shift_reg/reg_delay/ck
add wave -noupdate -group shift_reg -expand -group r_delay /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/shift_reg/reg_delay/rst
add wave -noupdate -group shift_reg -expand -group r_delay /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/shift_reg/reg_delay/ce
add wave -noupdate -group shift_reg -expand -group r_delay /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/shift_reg/reg_delay/D
add wave -noupdate -group shift_reg -expand -group r_delay /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/shift_reg/reg_delay/Q
add wave -noupdate -group shifter /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/shifter/in_1
add wave -noupdate -group shifter /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/shifter/in_0
add wave -noupdate -group shifter /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/shifter/ctrl_reg_shift
add wave -noupdate -group shifter /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/shifter/data_out
add wave -noupdate -expand -group fifo_b /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/fifo_b/clk_w
add wave -noupdate -expand -group fifo_b /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/fifo_b/clk_r
add wave -noupdate -expand -group fifo_b /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/fifo_b/rst_n
add wave -noupdate -expand -group fifo_b /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/fifo_b/data_in
add wave -noupdate -expand -group fifo_b /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/fifo_b/data_out
add wave -noupdate -expand -group fifo_b /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/fifo_b/is_sop_in
add wave -noupdate -expand -group fifo_b /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/fifo_b/eop_addr_in
add wave -noupdate -expand -group fifo_b /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/fifo_b/is_sop_out
add wave -noupdate -expand -group fifo_b /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/fifo_b/eop_addr_out
add wave -noupdate -expand -group fifo_b /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/fifo_b/wen
add wave -noupdate -expand -group fifo_b /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/fifo_b/ren
add wave -noupdate -expand -group fifo_b /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/fifo_b/empty
add wave -noupdate -expand -group fifo_b /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/fifo_b/full
add wave -noupdate -expand -group fifo_b /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_core_interface/fifo_b/DO
add wave -noupdate -expand -group fifo_violated /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/almostempty_ff1
add wave -noupdate -expand -group fifo_violated /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/almostempty_ff1_i_1_n_0
add wave -noupdate -expand -group fifo_violated /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/almostempty_ff2
add wave -noupdate -expand -group fifo_violated /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/almostempty_ff2_i_1_n_0
add wave -noupdate -expand -group fifo_violated /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/readdata
add wave -noupdate -expand -group fifo_violated /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/rclk
add wave -noupdate -expand -group fifo_violated /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/wclk
add wave -noupdate -expand -group fifo_violated /Top/area_timing_wrapper/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/writedata
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {251387 ps} 0} {{Cursor 2} {1492852 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 839
configure wave -valuecolwidth 217
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
WaveRestoreZoom {260349 ps} {265127 ps}
