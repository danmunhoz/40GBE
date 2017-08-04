onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group Resets /Top/tb_xgt4/reset_in_pcs
add wave -noupdate -expand -group Resets /Top/tb_xgt4/reset_in
add wave -noupdate -expand -group Resets /Top/tb_xgt4/reset_in_mii_tx
add wave -noupdate -expand -group Resets /Top/tb_xgt4/reset_in_mii_rx
add wave -noupdate /Top/tb_xgt4/clock_in156
add wave -noupdate /Top/tb_xgt4/clock_in161
add wave -noupdate -divider {PCS TX (rx path)}
add wave -noupdate /Top/tb_xgt4/start_fifo
add wave -noupdate -divider PCSs
add wave -noupdate -expand -group PCS_0 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/xgmii_rxc
add wave -noupdate -expand -group PCS_0 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/xgmii_rxd
add wave -noupdate -expand -group PCS_1 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/xgmii_rxc
add wave -noupdate -expand -group PCS_1 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/xgmii_rxd
add wave -noupdate -expand -group PCS_2 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/xgmii_rxc
add wave -noupdate -expand -group PCS_2 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/xgmii_rxd
add wave -noupdate -expand -group PCS_3 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/xgmii_rxc
add wave -noupdate -expand -group PCS_3 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/xgmii_rxd
add wave -noupdate -divider {MAC - RX_ENQEUEs}
add wave -noupdate /Top/rx_xgt4/inst_wrapper_macpcs/INST_xge_mac/clk_xgmii_rx
add wave -noupdate /Top/rx_xgt4/inst_wrapper_macpcs/INST_xge_mac/reset_xgmii_rx_n
add wave -noupdate -expand -group rx_eq_0 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_xge_mac/rx_eq0/xgmii_rxd
add wave -noupdate -expand -group rx_eq_0 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_xge_mac/rx_eq0/xgmii_rxc
add wave -noupdate -expand -group rx_eq_0 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_xge_mac/rx_eq0/rxdfifo_wdata
add wave -noupdate -expand -group rx_eq_0 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_xge_mac/rx_eq0/rxdfifo_wstatus
add wave -noupdate -expand -group rx_eq_0 /Top/rx_xgt4/inst_wrapper_macpcs/INST_xge_mac/rx_eq0/rxdfifo_wen
add wave -noupdate -expand -group rx_eq_1 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_xge_mac/rx_eq1/xgmii_rxd
add wave -noupdate -expand -group rx_eq_1 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_xge_mac/rx_eq1/xgmii_rxc
add wave -noupdate -expand -group rx_eq_1 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_xge_mac/rx_eq1/rxdfifo_wdata
add wave -noupdate -expand -group rx_eq_1 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_xge_mac/rx_eq1/rxdfifo_wstatus
add wave -noupdate -expand -group rx_eq_1 /Top/rx_xgt4/inst_wrapper_macpcs/INST_xge_mac/rx_eq1/rxdfifo_wen
add wave -noupdate -expand -group rx_eq_2 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_xge_mac/rx_eq2/xgmii_rxd
add wave -noupdate -expand -group rx_eq_2 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_xge_mac/rx_eq2/xgmii_rxc
add wave -noupdate -expand -group rx_eq_2 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_xge_mac/rx_eq2/rxdfifo_wdata
add wave -noupdate -expand -group rx_eq_2 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_xge_mac/rx_eq2/rxdfifo_wstatus
add wave -noupdate -expand -group rx_eq_2 /Top/rx_xgt4/inst_wrapper_macpcs/INST_xge_mac/rx_eq2/rxdfifo_wen
add wave -noupdate -expand -group rx_eq_3 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_xge_mac/rx_eq3/xgmii_rxd
add wave -noupdate -expand -group rx_eq_3 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_xge_mac/rx_eq3/xgmii_rxc
add wave -noupdate -expand -group rx_eq_3 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_xge_mac/rx_eq3/rxdfifo_wdata
add wave -noupdate -expand -group rx_eq_3 -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_xge_mac/rx_eq3/rxdfifo_wstatus
add wave -noupdate -expand -group rx_eq_3 /Top/rx_xgt4/inst_wrapper_macpcs/INST_xge_mac/rx_eq3/rxdfifo_wen
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {361541 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 872
configure wave -valuecolwidth 148
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
WaveRestoreZoom {399188 ps} {460218 ps}
