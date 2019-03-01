onerror {resume}
quietly virtual function -install /glbl -env /glbl { 907643} virtual_000001
quietly WaveActivateNextPane {} 0
add wave -noupdate /Top/tx_xgt4/echo_gen_inst/ip_source_reg
add wave -noupdate /Top/tx_xgt4/echo_gen_inst/ip_destination_reg
add wave -noupdate /Top/tx_xgt4/echo_gen_inst/ip_checksum
add wave -noupdate /Top/tx_xgt4/echo_gen_inst/ip_message_length
add wave -noupdate /Top/tx_xgt4/echo_gen_inst/udp_message_length
add wave -noupdate /Top/tx_xgt4/echo_gen_inst/mac_source_reg
add wave -noupdate /Top/tx_xgt4/echo_gen_inst/mac_destination_reg
add wave -noupdate /Top/tx_xgt4/echo_gen_inst/packet_length_reg
add wave -noupdate -expand -group LOOP_BACK /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/clk_156
add wave -noupdate -expand -group LOOP_BACK /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/reset
add wave -noupdate -expand -group LOOP_BACK -expand -group lb_in /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/parity
add wave -noupdate -expand -group LOOP_BACK -expand -group lb_in /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/pkt_rx_data
add wave -noupdate -expand -group LOOP_BACK -expand -group lb_in -color Magenta /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/current_s
add wave -noupdate -expand -group LOOP_BACK -expand -group lb_in -color Magenta /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/next_s
add wave -noupdate -expand -group LOOP_BACK -expand -group lb_in -color Cyan /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/pkt_rx_data_N
add wave -noupdate -expand -group LOOP_BACK -expand -group lb_in /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/mac_source
add wave -noupdate -expand -group LOOP_BACK -expand -group lb_in /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/pkt_rx_avail
add wave -noupdate -expand -group LOOP_BACK -expand -group lb_in /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/pkt_rx_eop
add wave -noupdate -expand -group LOOP_BACK -expand -group lb_in /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/pkt_rx_sop
add wave -noupdate -expand -group LOOP_BACK -expand -group lb_in /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/pkt_rx_val
add wave -noupdate -expand -group LOOP_BACK -expand -group lb_in /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/pkt_rx_err
add wave -noupdate -expand -group LOOP_BACK -expand -group lb_in /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/pkt_rx_mod
add wave -noupdate -expand -group LOOP_BACK -expand -group lb_in /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/mac_filter
add wave -noupdate -expand -group LOOP_BACK -group lb_out /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/lb_pkt_tx_eop
add wave -noupdate -expand -group LOOP_BACK -group lb_out /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/lb_pkt_tx_sop
add wave -noupdate -expand -group LOOP_BACK -group lb_out /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/lb_pkt_tx_val
add wave -noupdate -expand -group LOOP_BACK -group lb_out /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/lb_pkt_tx_data
add wave -noupdate -expand -group LOOP_BACK -group lb_out /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/lb_pkt_tx_mod
add wave -noupdate -expand -group LOOP_BACK -group lb_out /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/lb_mac_destination
add wave -noupdate -expand -group LOOP_BACK -group lb_out /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/lb_mac_source
add wave -noupdate -expand -group LOOP_BACK -group lb_out /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/lb_ip_destination
add wave -noupdate -expand -group LOOP_BACK -group lb_out /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/lb_ip_source
add wave -noupdate -expand -group LOOP_BACK -expand -group wire /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/wire_mac_source
add wave -noupdate -expand -group LOOP_BACK -expand -group wire /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/wire_mac_destination
add wave -noupdate -expand -group LOOP_BACK -expand -group wire /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/wire_ip_source
add wave -noupdate -expand -group LOOP_BACK -expand -group wire /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/wire_ethernet_type
add wave -noupdate -expand -group LOOP_BACK -expand -group wire /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/wire_ip_protocol
add wave -noupdate -expand -group LOOP_BACK -expand -group wire /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/wire_ip_message_length
add wave -noupdate -expand -group LOOP_BACK /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/wire_ip_checksum
add wave -noupdate -expand -group LOOP_BACK /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/ip_destination_reg
add wave -noupdate -expand -group LOOP_BACK /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/ip_high
add wave -noupdate -expand -group LOOP_BACK /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/time_stamp_generator
add wave -noupdate -expand -group LOOP_BACK /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/lb_mac_source_reg
add wave -noupdate -expand -group LOOP_BACK /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/lb_mac_destination_reg
add wave -noupdate -expand -group LOOP_BACK /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/lb_ip_message_length
add wave -noupdate -expand -group LOOP_BACK /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/lb_ip_source_reg
add wave -noupdate -expand -group LOOP_BACK /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/lb_ip_destination_reg
add wave -noupdate -expand -group LOOP_BACK /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/lb_ip_checksum
add wave -noupdate -expand -group LOOP_BACK /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/lb_udp_message_length
add wave -noupdate -expand -group LOOP_BACK /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/pkt_rebuilt
add wave -noupdate -expand -group LOOP_BACK /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/mod_rebuilt
add wave -noupdate -expand -group LOOP_BACK /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/HEADER2
add wave -noupdate -expand -group LOOP_BACK /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/HEADER
add wave -noupdate -expand -group LOOP_BACK /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/IP
add wave -noupdate -expand -group LOOP_BACK /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/MAC
add wave -noupdate -expand -group LOOP_BACK /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/PAYLOAD
add wave -noupdate -expand -group LOOP_BACK /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loopback_inst/IDLE_VALUE
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/clock
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/reset
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/start
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/lfsr_seed
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/valid_seed
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/lfsr_polynomial
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/mac_source
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/mac_destination
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/ip_source
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/ip_destination
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/packet_length
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/timestamp_base
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/time_stamp_flag
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/pkt_tx_full
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/pkt_tx_data
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/pkt_tx_val
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/pkt_tx_sop
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/pkt_tx_eop
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/pkt_tx_mod
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/payload_type
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/payload_cycles
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/current_s
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/next_s
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/MAC
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/IP
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/EOH_SOF
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/HEADER
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/PAYLOAD
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/PAYLOAD_PKT
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/PAYLOAD_LAST
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/IDLE_VALUE
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/UPD_INFO
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/ALL_ONE
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/ALL_ZERO
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/PKT_COUNTER
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/ID_COUNTER_H
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/ID_COUNTER_L
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/SEED
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/RANDOM
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/start_lfsr
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/preset_lfsr
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/count
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/pkt_tx_data_N
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/pkt_tx_data_buffer
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/pkt_tx_mod_reg
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/pkt_tx_eop_reg
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/last_pkt
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/time_stamp
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/it_payload
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/it_mod
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/ip_checksum
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/aux_checksum
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/ip_message_length
add wave -noupdate -group GEN /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/echo_gen_inst/udp_message_length
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/clk_156
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/clk_312
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/rst_n
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/loop_select
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/data_high
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/data_rebuild
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/turn
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/parity
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/mac_source
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/pkt_tx_data
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/pkt_tx_val
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/pkt_tx_sop
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/pkt_tx_eop
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/pkt_tx_mod
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/rec_mac_source_rx
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/rec_mac_destination_rx
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/rec_ip_source_rx
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/rec_ip_destination_rx
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/start
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/lfsr_seed
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/valid_seed
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/lfsr_polynomial
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/mac_destination
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/ip_source
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/ip_destination
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/packet_length
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/timestamp_base
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/time_stamp_flag
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/pkt_tx_full
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/payload_type
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/payload_cycles
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/pkt_rx_avail_in
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/pkt_rx_eop_in
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/pkt_rx_sop_in
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/pkt_rx_val_in
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/pkt_rx_err_in
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/pkt_rx_data_in
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/pkt_rx_mod_in
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/mac_filter
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/mac_source_out
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/mac_destination_out
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/ip_source_out
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/ip_destination_out
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/lb_pkt_tx_eop
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/lb_pkt_tx_sop
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/lb_pkt_tx_val
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/lb_pkt_tx_data
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/lb_pkt_tx_mod
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/lb_mac_destination
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/lb_mac_source
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/lb_ip_destination
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/lb_ip_source
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/gen_pkt_tx_data
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/gen_pkt_tx_val
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/gen_pkt_tx_sop
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/gen_pkt_tx_eop
add wave -noupdate -expand -group PKT_CREATION /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/gen_pkt_tx_mod
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/clk_312
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/reset
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/lfsr_seed
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/lfsr_polynomial
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/valid_seed
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/timestamp_base
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/mac_source
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/mac_source_rx
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/mac_destination
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/ip_source
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/ip_destination
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/time_stamp_out
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/received_packet
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/end_latency
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/packets_lost
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/RESET_done
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/pkt_rx_ren
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/pkt_rx_avail
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/pkt_rx_eop
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/pkt_rx_sop
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/pkt_rx_val
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/pkt_rx_err
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/pkt_rx_data
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/pkt_rx_mod
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/payload_type
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/verify_system_rec
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/reset_test
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/pkt_sequence_in
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/pkt_sequence_error_flag
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/pkt_sequence_error
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/count_error
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/IDLE_count
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/current_s
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/next_s
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/lfsr_state
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/recovery_state
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/pkt_rx_data_buffer
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/pkt_rx_data_nbits
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/pkt_rx_data_N
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/pkt_sequence_error_flag_aux
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/reg_mac_source
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/reg_mac_destination
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/reg_ip_source
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/reg_ip_destination
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/reg_ethernet_type
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/reg_ip_protocol
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/reg_ip_message_length
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/ip_low
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/ip_high
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/ip_pkt_type
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/udp_pkt_type
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/time_stamp_generator
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/time_stamp_receiver
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/time_stamp_ready
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/received_packet_wire
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/id_pkt_tester
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/id_sequence_counter
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/id_checker_reg
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/lost_pkt_flag
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/not_lost_pkt_test
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/lost_counter
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/lost_pkt_tester
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/IDLE_count_reg
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/pkt_zeros
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/pkt_ones
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/RANDOM
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/lfsr_bert
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/start
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/lfsr_start
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/lfsr_start_delay
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/lfsr_resync_ON
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/lfsr_fsm_begin
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/lfsr_test_begin
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/lfsr_load_seed
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/delay_B0
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/delay_B1
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/delay_B2
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/lfsr_resync_SIGNAL
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/lfsr_resync_RANDOM
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/lfsr_counter
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/const_test_begin
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/bert_target_lfsr
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/bert_xor
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/bert_cycle_wrong
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/bert_n_flipped_b
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/bert_count_flip
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/bert_test_begin
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/ALL_ONE
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/ALL_ZERO
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/recovery_n_flipped_b
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/recovery_cycle_wrong
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/recovery_ON
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/recovery_start_pkt
add wave -noupdate -group REC /Top/rx_xgt4/inst_wrapper_macpcs/INST_echo_receiver_128_v2/recovery_stop_pkt
add wave -noupdate /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/data_rebuild
add wave -noupdate /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/data_fifo_out
add wave -noupdate /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/data_high
add wave -noupdate /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/mem_low_out_0
add wave -noupdate /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/mem_low_out_1
add wave -noupdate /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/mem_low_in_1_reg
add wave -noupdate /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/mem_low_in_0_reg
add wave -noupdate /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/FIFO_inst_l_0/DI
add wave -noupdate /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/FIFO_inst_l_1/DI
add wave -noupdate /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/FIFO_inst_l_0/DO
add wave -noupdate /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/FIFO_inst_l_1/DO
add wave -noupdate /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/FIFO_inst_l_1/WREN
add wave -noupdate /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/FIFO_inst_l_1/RDEN
add wave -noupdate /Top/rx_xgt4/inst_wrapper_macpcs/INST_pkt_generator/FIFO_inst_l_0/RST
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{bip rx} {3286075 ps} 1} {{bip tx} {3217811 ps} 1} {{Cursor 3} {45934400 ps} 1} {{Cursor 4} {5334005 ps} 0}
quietly wave cursor active 4
configure wave -namecolwidth 191
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
WaveRestoreZoom {5321782 ps} {5352142 ps}
bookmark add wave bookmark5 {{770754 ps} {811500 ps}} 13
bookmark add wave bookmark6 {{780000 ps} {800000 ps}} 8
bookmark add wave bookmark7 {{0 ps} {42010 ps}} 0
bookmark add wave bookmark8 {{201305 ps} {266263 ps}} 7
bookmark add wave bookmark9 {{728057 ps} {794311 ps}} 6
bookmark add wave bookmark10 {{1931987 ps} {1965959 ps}} 9
