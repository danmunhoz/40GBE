onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/clk_312
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/reset
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/lfsr_seed
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/lfsr_polynomial
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/valid_seed
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/timestamp_base
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/mac_source
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/mac_source_rx
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/mac_destination
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/ip_source
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/ip_destination
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/time_stamp_out
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/received_packet
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/end_latency
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/packets_lost
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/RESET_done
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/pkt_rx_ren
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/pkt_rx_avail
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/pkt_rx_eop
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/pkt_rx_sop
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/pkt_rx_val
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/pkt_rx_err
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/pkt_rx_data
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/pkt_rx_mod
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/payload_type
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/verify_system_rec
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/reset_test
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/pkt_sequence_in
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/pkt_sequence_error_flag
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/pkt_sequence_error
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/count_error
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/IDLE_count
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/current_s
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/next_s
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/lfsr_state
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/recovery_state
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/pkt_rx_data_buffer
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/pkt_rx_data_nbits
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/pkt_rx_data_N
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/pkt_sequence_error_flag_aux
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/reg_mac_source
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/reg_mac_destination
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/reg_ip_source
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/reg_ip_destination
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/reg_ethernet_type
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/reg_ip_protocol
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/reg_ip_message_length
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/ip_high
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/ip_pkt_type
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/udp_pkt_type
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/time_stamp_generator
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/time_stamp_receiver
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/time_stamp_ready
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/received_packet_wire
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/id_pkt_tester
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/id_sequence_counter
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/id_current_pkg_number
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/lost_pkt_flag
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/not_lost_pkt_test
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/lost_counter
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/lost_pkt_tester
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/IDLE_count_reg
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/RANDOM
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/lfsr_bert
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/start
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/lfsr_start
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/lfsr_start_delay
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/lfsr_resync_ON
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/lfsr_fsm_begin
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/lfsr_test_begin
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/lfsr_load_seed
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/delay_B0
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/delay_B1
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/delay_B2
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/lfsr_resync_SIGNAL
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/lfsr_resync_RANDOM
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/lfsr_counter
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/const_test_begin
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/bert_target_lfsr
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/bert_xor
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/bert_cycle_wrong
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/bert_n_flipped_b
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/bert_count_flip
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/bert_test_begin
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/ALL_ONE
add wave -noupdate -expand -group REC /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/ALL_ZERO
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {25841 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 121
configure wave -valuecolwidth 461
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {43955 ps}
