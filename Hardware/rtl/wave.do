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
add wave -noupdate -divider RX
add wave -noupdate /Top/rx_xgt4/start_fifo
add wave -noupdate /Top/rx_xgt4/inst_wrapper_macpcs/async_reset_n
add wave -noupdate /Top/rx_xgt4/inst_wrapper_macpcs/reset_tx_n
add wave -noupdate /Top/rx_xgt4/inst_wrapper_macpcs/reset_rx_n
add wave -noupdate /Top/rx_xgt4/inst_wrapper_macpcs/reset_tx_done
add wave -noupdate /Top/rx_xgt4/inst_wrapper_macpcs/reset_rx_done
add wave -noupdate -expand -group {PCS IN (int. externa)} /Top/rx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_rx_path/rx_header_valid_in
add wave -noupdate -expand -group {PCS IN (int. externa)} /Top/rx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_rx_path/rx_data_valid_in
add wave -noupdate -expand -group {PCS IN (int. externa)} -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_rx_path/rx_header_in
add wave -noupdate -expand -group {PCS IN (int. externa)} -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_rx_path/rx_data_in
add wave -noupdate -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/xgmii_rxc
add wave -noupdate -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/xgmii_rxd
add wave -noupdate /Top/rx_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_rx_path/rxlf
add wave -noupdate /Top/rx_xgt4/inst_wrapper_macpcs/INST_PCS_core/rx_fifo_spill
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {387200 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 810
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
WaveRestoreZoom {206084 ps} {295819 ps}
