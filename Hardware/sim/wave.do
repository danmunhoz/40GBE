onerror {resume}
quietly virtual function -install /glbl -env /glbl { 907643} virtual_000001
quietly WaveActivateNextPane {} 0
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/rst_n
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/clk_156
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/clk_312
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/clk_312_n
add wave -noupdate -group PKT_GEN -color Cyan -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/pkt_rx_data_in
add wave -noupdate -group PKT_GEN -color Orange -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/data_concat
add wave -noupdate -group PKT_GEN -color {Medium Spring Green} -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/data_rebuild
add wave -noupdate -group PKT_GEN -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/test_tbd_data_ctrl_out
add wave -noupdate -group PKT_GEN -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/data_ctrl_in
add wave -noupdate -group PKT_GEN -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/data_ctrl_out
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/parity
add wave -noupdate -group PKT_GEN -color {Medium Violet Red} /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/pkt_rx_val_in
add wave -noupdate -group PKT_GEN -color {Medium Violet Red} /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/pkt_rx_avail_in
add wave -noupdate -group PKT_GEN -color White /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/pkt_rx_sop_in
add wave -noupdate -group PKT_GEN -color Gold /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/pkt_rx_eop_in
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loop_select
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/mac_source
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/pkt_tx_data
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/pkt_tx_val
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/pkt_tx_sop
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/pkt_tx_eop
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/pkt_tx_mod
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/rec_mac_source_rx
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/rec_mac_destination_rx
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/rec_ip_source_rx
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/rec_ip_destination_rx
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/start
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/lfsr_seed
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/valid_seed
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/lfsr_polynomial
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/mac_destination
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/ip_source
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/ip_destination
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/packet_length
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/timestamp_base
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/time_stamp_flag
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/pkt_tx_full
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/wen
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/ren
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/payload_type
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/payload_cycles
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/pkt_rx_avail_in
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/pkt_rx_eop_in
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/pkt_rx_sop_in
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/pkt_rx_val_in
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/pkt_rx_err_in
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/pkt_rx_mod_in
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/mac_filter
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/mac_source_out
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/mac_destination_out
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/ip_source_out
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/ip_destination_out
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/parity
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/lb_pkt_tx_eop
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/lb_pkt_tx_sop
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/lb_pkt_tx_val
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/lb_pkt_tx_data
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/lb_pkt_tx_mod
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/lb_mac_destination
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/lb_mac_source
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/lb_ip_destination
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/lb_ip_source
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/gen_pkt_tx_data
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/gen_pkt_tx_val
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/gen_pkt_tx_sop
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/gen_pkt_tx_eop
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/gen_pkt_tx_mod
add wave -noupdate -group PKT_GEN -color {Pale Green} /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/pkt_rx_avail_in
add wave -noupdate -group PKT_GEN -color Goldenrod /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/pkt_rx_sop_in
add wave -noupdate -group PKT_GEN -color White /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/pkt_rx_eop_in
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/clk_156
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/clk_312
add wave -noupdate -group PKT_GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/pkt_rx_data_in
add wave -noupdate -group PKT_GEN -color White /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/data_rebuild
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/clock
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/reset
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/start
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/lfsr_seed
add wave -noupdate -group GEN -color {Medium Violet Red} /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/pkt_tx_data_N
add wave -noupdate -group GEN -color {Medium Violet Red} /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/pkt_tx_data_buffer
add wave -noupdate -group GEN -color Yellow /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/pkt_tx_data
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/current_s
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/next_s
add wave -noupdate -group GEN -color {Medium Blue} /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/pkt_tx_val
add wave -noupdate -group GEN -color White -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/pkt_tx_sop
add wave -noupdate -group GEN -color Gray75 /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/pkt_tx_eop
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/pkt_tx_mod_reg
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/pkt_tx_eop_reg
add wave -noupdate -group GEN -color {Medium Blue} -radix binary /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/pkt_tx_mod
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/last_pkt
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/payload_type
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/payload_cycles
add wave -noupdate -group GEN -group MAC_IP_INFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/valid_seed
add wave -noupdate -group GEN -group MAC_IP_INFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/lfsr_polynomial
add wave -noupdate -group GEN -group MAC_IP_INFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/mac_source
add wave -noupdate -group GEN -group MAC_IP_INFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/mac_destination
add wave -noupdate -group GEN -group MAC_IP_INFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/ip_source
add wave -noupdate -group GEN -group MAC_IP_INFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/ip_destination
add wave -noupdate -group GEN -group MAC_IP_INFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/packet_length
add wave -noupdate -group GEN -group MAC_IP_INFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/timestamp_base
add wave -noupdate -group GEN -group MAC_IP_INFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/time_stamp_flag
add wave -noupdate -group GEN -group MAC_IP_INFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/ip_checksum
add wave -noupdate -group GEN -group MAC_IP_INFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/aux_checksum
add wave -noupdate -group GEN -group MAC_IP_INFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/ip_message_length
add wave -noupdate -group GEN -group MAC_IP_INFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/udp_message_length
add wave -noupdate -group GEN -group MAC_IP_INFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/pkt_tx_full
add wave -noupdate -group GEN -group MAC_IP_INFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/time_stamp
add wave -noupdate -group GEN -group CABECALHO /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/MAC
add wave -noupdate -group GEN -group CABECALHO /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/IP
add wave -noupdate -group GEN -group CABECALHO /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/EOH_SOF
add wave -noupdate -group GEN -group CABECALHO /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/HEADER
add wave -noupdate -group GEN -group CABECALHO /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/PAYLOAD
add wave -noupdate -group GEN -group CABECALHO /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/PAYLOAD_PKT
add wave -noupdate -group GEN -group CABECALHO /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/PAYLOAD_LAST
add wave -noupdate -group GEN -group CABECALHO /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/IDLE_VALUE
add wave -noupdate -group GEN -group CABECALHO /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/UPD_INFO
add wave -noupdate -group GEN -group CABECALHO /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/ALL_ONE
add wave -noupdate -group GEN -group CABECALHO /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/ALL_ZERO
add wave -noupdate -group GEN -group CABECALHO /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/PKT_COUNTER
add wave -noupdate -group GEN -group CABECALHO /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/ID_COUNTER_H
add wave -noupdate -group GEN -group CABECALHO /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/ID_COUNTER_L
add wave -noupdate -group GEN -group LFSR /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/SEED
add wave -noupdate -group GEN -group LFSR /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/RANDOM
add wave -noupdate -group GEN -group LFSR /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/start_lfsr
add wave -noupdate -group GEN -group LFSR /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/preset_lfsr
add wave -noupdate -group GEN -group LFSR /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/count
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/it_payload
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/it_mod
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/clk_312
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/reset
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/lfsr_seed
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/lfsr_polynomial
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/valid_seed
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/timestamp_base
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/mac_source
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/mac_source_rx
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/mac_destination
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/ip_source
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/ip_destination
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/time_stamp_out
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/received_packet
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/end_latency
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/packets_lost
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/RESET_done
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/pkt_rx_ren
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/pkt_rx_avail
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/pkt_rx_eop
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/pkt_rx_sop
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/pkt_rx_val
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/pkt_rx_err
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/pkt_rx_data
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/pkt_rx_mod
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/payload_type
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/verify_system_rec
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/reset_test
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/pkt_sequence_in
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/pkt_sequence_error_flag
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/pkt_sequence_error
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/count_error
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/IDLE_count
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/current_s
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/next_s
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/lfsr_state
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/recovery_state
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/pkt_rx_data_buffer
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/pkt_rx_data_nbits
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/pkt_rx_data_N
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/pkt_sequence_error_flag_aux
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/reg_mac_source
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/reg_mac_destination
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/reg_ip_source
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/reg_ip_destination
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/reg_ethernet_type
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/reg_ip_protocol
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/reg_ip_message_length
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/ip_low
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/ip_high
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/ip_pkt_type
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/udp_pkt_type
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/time_stamp_generator
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/time_stamp_receiver
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/time_stamp_ready
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/received_packet_wire
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/id_pkt_tester
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/id_sequence_counter
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/id_checker_reg
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/lost_pkt_flag
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/not_lost_pkt_test
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/lost_counter
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/lost_pkt_tester
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/IDLE_count_reg
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/pkt_zeros
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/pkt_ones
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/RANDOM
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/lfsr_bert
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/start
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/lfsr_start
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/lfsr_start_delay
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/lfsr_resync_ON
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/lfsr_fsm_begin
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/lfsr_test_begin
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/lfsr_load_seed
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/delay_B0
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/delay_B1
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/delay_B2
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/lfsr_resync_SIGNAL
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/lfsr_resync_RANDOM
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/lfsr_counter
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/const_test_begin
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/bert_target_lfsr
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/bert_xor
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/bert_cycle_wrong
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/bert_n_flipped_b
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/bert_count_flip
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/bert_test_begin
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/ALL_ONE
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/ALL_ZERO
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/recovery_n_flipped_b
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/recovery_cycle_wrong
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/recovery_ON
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/recovery_start_pkt
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver/recovery_stop_pkt
add wave -noupdate -group LOOPBACK /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/clk_156
add wave -noupdate -group LOOPBACK -color Cyan /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/current_s
add wave -noupdate -group LOOPBACK -color Magenta /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/next_s
add wave -noupdate -group LOOPBACK -color {Medium Spring Green} /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/pkt_rx_data_in
add wave -noupdate -group LOOPBACK -color Khaki /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/pkt_rx_data_N
add wave -noupdate -group LOOPBACK -color Khaki /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/pkt_rx_data_buffer
add wave -noupdate -group LOOPBACK -color Yellow /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/pkt_rebuilt
add wave -noupdate -group LOOPBACK -color Gold /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/pkt_tx_data_out
add wave -noupdate -group LOOPBACK /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/pkt_rx_avail_in
add wave -noupdate -group LOOPBACK -color White /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/pkt_rx_sop_in
add wave -noupdate -group LOOPBACK -color Gray75 /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/pkt_rx_eop_in
add wave -noupdate -group LOOPBACK /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/pkt_rx_err_in
add wave -noupdate -group LOOPBACK /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/pkt_rx_mod_in
add wave -noupdate -group LOOPBACK /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/pkt_rx_val_in
add wave -noupdate -group LOOPBACK -color White -radix hexadecimal /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/pkt_tx_sop_out
add wave -noupdate -group LOOPBACK -color Gray75 /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/pkt_tx_eop_out
add wave -noupdate -group LOOPBACK /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/pkt_tx_mod_out
add wave -noupdate -group LOOPBACK /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/pkt_tx_val_out
add wave -noupdate -group LOOPBACK -group CABECALHO /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/EOH_SOF
add wave -noupdate -group LOOPBACK -group CABECALHO /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/HEADER_H
add wave -noupdate -group LOOPBACK -group CABECALHO /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/HEADER_L
add wave -noupdate -group LOOPBACK -group CABECALHO /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/IDLE_VALUE
add wave -noupdate -group LOOPBACK -group CABECALHO /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/IP
add wave -noupdate -group LOOPBACK -group CABECALHO /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/MAC
add wave -noupdate -group LOOPBACK -group CABECALHO /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/PAYLOAD
add wave -noupdate -group LOOPBACK -group CABECALHO /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/ip_message_length_reg
add wave -noupdate -group LOOPBACK -group CABECALHO /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/udp_message_length_reg
add wave -noupdate -group LOOPBACK -group MAC_IP_INFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/mac_source_in
add wave -noupdate -group LOOPBACK -group MAC_IP_INFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/mac_destination_reg
add wave -noupdate -group LOOPBACK -group MAC_IP_INFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/mac_source_reg
add wave -noupdate -group LOOPBACK -group MAC_IP_INFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/ethernet_type_reg
add wave -noupdate -group LOOPBACK -group MAC_IP_INFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/ip_message_length_reg
add wave -noupdate -group LOOPBACK -group MAC_IP_INFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/ip_protocol_reg
add wave -noupdate -group LOOPBACK -group MAC_IP_INFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/ip_source_reg
add wave -noupdate -group LOOPBACK -group MAC_IP_INFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/ip_destination_reg
add wave -noupdate -group LOOPBACK -group MAC_IP_INFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/ip_checksum_reg
add wave -noupdate -group LOOPBACK -group MAC_IP_INFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/mac_filter_in
add wave -noupdate -group LOOPBACK -group MAC_IP_INFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/parity
add wave -noupdate -group LOOPBACK -group MAC_IP_INFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/ip_destination_wire
add wave -noupdate -group LOOPBACK -group MAC_IP_INFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/ip_high
add wave -noupdate -group LOOPBACK -group MAC_IP_INFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/mac_destination_out
add wave -noupdate -group LOOPBACK -group MAC_IP_INFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/mac_source_out
add wave -noupdate -group LOOPBACK -group MAC_IP_INFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/ip_destination_out
add wave -noupdate -group LOOPBACK -group MAC_IP_INFO /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/ip_source_out
add wave -noupdate -group LOOPBACK /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/reset
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 4} {12642445 ps} 0} {{Cursor 5} {47996800 ps} 0}
quietly wave cursor active 2
configure wave -namecolwidth 257
configure wave -valuecolwidth 122
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
WaveRestoreZoom {47975487 ps} {48027381 ps}
bookmark add wave bookmark5 {{770754 ps} {811500 ps}} 13
bookmark add wave bookmark6 {{780000 ps} {800000 ps}} 8
bookmark add wave bookmark7 {{0 ps} {42010 ps}} 0
bookmark add wave bookmark8 {{201305 ps} {266263 ps}} 7
bookmark add wave bookmark9 {{728057 ps} {794311 ps}} 6
bookmark add wave bookmark10 {{1931987 ps} {1965959 ps}} 9
