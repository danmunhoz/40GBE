onerror {resume}
quietly virtual function -install /glbl -env /glbl { 907643} virtual_000001
quietly WaveActivateNextPane {} 0
add wave -noupdate -group GEN_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/clock
add wave -noupdate -group GEN_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/reset
add wave -noupdate -group GEN_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/start
add wave -noupdate -group GEN_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/lfsr_seed
add wave -noupdate -group GEN_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/valid_seed
add wave -noupdate -group GEN_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/lfsr_polynomial
add wave -noupdate -group GEN_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/mac_source
add wave -noupdate -group GEN_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/mac_destination
add wave -noupdate -group GEN_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/ip_source
add wave -noupdate -group GEN_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/ip_destination
add wave -noupdate -group GEN_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/packet_length
add wave -noupdate -group GEN_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/timestamp_base
add wave -noupdate -group GEN_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/time_stamp_flag
add wave -noupdate -group GEN_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/pkt_tx_full
add wave -noupdate -group GEN_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/pkt_tx_data
add wave -noupdate -group GEN_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/pkt_tx_val
add wave -noupdate -group GEN_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/pkt_tx_sop
add wave -noupdate -group GEN_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/pkt_tx_eop
add wave -noupdate -group GEN_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/pkt_tx_mod
add wave -noupdate -group GEN_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/payload_type
add wave -noupdate -group GEN_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/payload_cycles
add wave -noupdate -group GEN_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/current_s
add wave -noupdate -group GEN_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/next_s
add wave -noupdate -group GEN_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/MAC
add wave -noupdate -group GEN_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/IP
add wave -noupdate -group GEN_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/EOH_SOF
add wave -noupdate -group GEN_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/HEADER
add wave -noupdate -group GEN_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/PAYLOAD
add wave -noupdate -group GEN_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/PAYLOAD_PKT
add wave -noupdate -group GEN_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/PAYLOAD_LAST
add wave -noupdate -group GEN_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/IDLE_VALUE
add wave -noupdate -group GEN_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/UPD_INFO
add wave -noupdate -group GEN_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/ALL_ONE
add wave -noupdate -group GEN_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/ALL_ZERO
add wave -noupdate -group GEN_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/PKT_COUNTER
add wave -noupdate -group GEN_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/ID_COUNTER_H
add wave -noupdate -group GEN_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/ID_COUNTER_L
add wave -noupdate -group GEN_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/SEED
add wave -noupdate -group GEN_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/RANDOM
add wave -noupdate -group GEN_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/start_lfsr
add wave -noupdate -group GEN_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/preset_lfsr
add wave -noupdate -group GEN_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/count
add wave -noupdate -group GEN_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/pkt_tx_data_N
add wave -noupdate -group GEN_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/pkt_tx_data_buffer
add wave -noupdate -group GEN_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/pkt_tx_mod_reg
add wave -noupdate -group GEN_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/pkt_tx_eop_reg
add wave -noupdate -group GEN_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/last_pkt
add wave -noupdate -group GEN_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/time_stamp
add wave -noupdate -group GEN_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/it_payload
add wave -noupdate -group GEN_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/it_mod
add wave -noupdate -group GEN_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/ip_checksum
add wave -noupdate -group GEN_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/aux_checksum
add wave -noupdate -group GEN_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/ip_message_length
add wave -noupdate -group GEN_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/udp_message_length
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/clock
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/reset
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/start
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/lfsr_seed
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/valid_seed
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/lfsr_polynomial
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/mac_source
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/mac_destination
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/ip_source
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/ip_destination
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/packet_length
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/timestamp_base
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/time_stamp_flag
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/pkt_tx_full
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/pkt_tx_data
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/pkt_tx_val
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/pkt_tx_sop
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/pkt_tx_eop
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/pkt_tx_mod
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/payload_type
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/payload_cycles
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/current_s
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/next_s
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/MAC
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/IP
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/EOH_SOF
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/HEADER
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/PAYLOAD
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/PAYLOAD_PKT
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/PAYLOAD_LAST
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/IDLE_VALUE
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/UPD_INFO
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/ALL_ONE
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/ALL_ZERO
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/PKT_COUNTER
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/ID_COUNTER_H
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/ID_COUNTER_L
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/SEED
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/RANDOM
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/start_lfsr
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/preset_lfsr
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/count
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/pkt_tx_data_N
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/pkt_tx_data_buffer
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/pkt_tx_mod_reg
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/pkt_tx_eop_reg
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/last_pkt
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/time_stamp
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/it_payload
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/it_mod
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/ip_checksum
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/aux_checksum
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/ip_message_length
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/udp_message_length
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/clk_312
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/reset
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/lfsr_seed
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/lfsr_polynomial
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/valid_seed
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/timestamp_base
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/mac_source
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/mac_source_rx
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/mac_destination
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/ip_source
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/ip_destination
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/time_stamp_out
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/received_packet
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/end_latency
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/packets_lost
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/RESET_done
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/pkt_rx_ren
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/pkt_rx_avail
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/pkt_rx_eop
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/pkt_rx_sop
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/pkt_rx_val
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/pkt_rx_err
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/pkt_rx_data
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/pkt_rx_mod
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/payload_type
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/verify_system_rec
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/reset_test
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/pkt_sequence_in
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/pkt_sequence_error_flag
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/pkt_sequence_error
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/count_error
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/IDLE_count
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/current_s
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/next_s
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/lfsr_state
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/recovery_state
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/pkt_rx_data_buffer
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/pkt_rx_data_nbits
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/pkt_rx_data_N
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/pkt_sequence_error_flag_aux
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/reg_mac_source
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/reg_mac_destination
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/reg_ip_source
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/reg_ip_destination
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/reg_ethernet_type
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/reg_ip_protocol
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/reg_ip_message_length
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/ip_high
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/ip_pkt_type
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/udp_pkt_type
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/time_stamp_generator
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/time_stamp_receiver
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/time_stamp_ready
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/received_packet_wire
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/id_pkt_tester
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/id_sequence_counter
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/id_current_pkg_number
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/lost_pkt_flag
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/not_lost_pkt_test
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/lost_counter
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/lost_pkt_tester
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/IDLE_count_reg
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/RANDOM
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/lfsr_bert
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/start
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/lfsr_start
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/lfsr_start_delay
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/lfsr_resync_ON
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/lfsr_fsm_begin
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/lfsr_test_begin
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/lfsr_load_seed
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/delay_B0
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/delay_B1
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/delay_B2
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/lfsr_resync_SIGNAL
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/lfsr_resync_RANDOM
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/lfsr_counter
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/const_test_begin
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/bert_target_lfsr
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/bert_xor
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/bert_cycle_wrong
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/bert_n_flipped_b
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/bert_count_flip
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/bert_test_begin
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/ALL_ONE
add wave -noupdate -group REC_0 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/ALL_ZERO
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/clk_312
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/reset
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/lfsr_seed
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/lfsr_polynomial
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/valid_seed
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/timestamp_base
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/mac_source
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/mac_source_rx
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/mac_destination
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/ip_source
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/ip_destination
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/time_stamp_out
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/received_packet
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/end_latency
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/packets_lost
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/RESET_done
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/pkt_rx_ren
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/pkt_rx_avail
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/pkt_rx_eop
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/pkt_rx_sop
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/pkt_rx_val
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/pkt_rx_err
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/pkt_rx_data
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/pkt_rx_mod
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/payload_type
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/verify_system_rec
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/reset_test
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/pkt_sequence_in
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/pkt_sequence_error_flag
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/pkt_sequence_error
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/count_error
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/IDLE_count
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/current_s
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/next_s
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/lfsr_state
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/recovery_state
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/pkt_rx_data_buffer
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/pkt_rx_data_nbits
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/pkt_rx_data_N
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/pkt_sequence_error_flag_aux
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/reg_mac_source
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/reg_mac_destination
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/reg_ip_source
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/reg_ip_destination
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/reg_ethernet_type
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/reg_ip_protocol
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/reg_ip_message_length
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/ip_high
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/ip_pkt_type
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/udp_pkt_type
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/time_stamp_generator
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/time_stamp_receiver
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/time_stamp_ready
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/received_packet_wire
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/id_pkt_tester
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/id_sequence_counter
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/id_current_pkg_number
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/lost_pkt_flag
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/not_lost_pkt_test
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/lost_counter
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/lost_pkt_tester
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/IDLE_count_reg
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/RANDOM
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/lfsr_bert
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/start
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/lfsr_start
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/lfsr_start_delay
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/lfsr_resync_ON
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/lfsr_fsm_begin
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/lfsr_test_begin
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/lfsr_load_seed
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/delay_B0
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/delay_B1
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/delay_B2
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/lfsr_resync_SIGNAL
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/lfsr_resync_RANDOM
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/lfsr_counter
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/const_test_begin
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/bert_target_lfsr
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/bert_xor
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/bert_cycle_wrong
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/bert_n_flipped_b
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/bert_count_flip
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/bert_test_begin
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/ALL_ONE
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/ALL_ZERO
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/clk_156
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/clk_312
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/clk_312_n
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/rst_n
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/loop_select
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/mac_source
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/rec_mac_source_rx
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/rec_mac_destination_rx
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/rec_ip_source_rx
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/rec_ip_destination_rx
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/pkt_tx_data
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/pkt_tx_val
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/pkt_tx_sop
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/pkt_tx_eop
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/pkt_tx_mod
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/start
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/lfsr_seed
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/valid_seed
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/lfsr_polynomial
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/mac_destination
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/ip_source
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/ip_destination
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/packet_length
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/timestamp_base
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/time_stamp_flag
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/pkt_tx_full
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/payload_type
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/payload_cycles
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/pkt_rx_avail_in
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/pkt_rx_eop_in
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/pkt_rx_sop_in
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/pkt_rx_val_in
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/pkt_rx_err_in
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/pkt_rx_data_in
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/pkt_rx_mod_in
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/mac_filter
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/mac_source_out
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/mac_destination_out
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/ip_source_out
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/ip_destination_out
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/lb_pkt_start
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/lb_pkt_tx_eop
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/lb_pkt_tx_sop
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/lb_pkt_tx_val
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/lb_pkt_tx_data
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/lb_pkt_tx_mod
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/lb_mac_destination
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/lb_mac_source
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/lb_ip_destination
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/lb_ip_source
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/gen_pkt_tx_data
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/gen_pkt_tx_val
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/gen_pkt_tx_sop
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/gen_pkt_tx_eop
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/gen_pkt_tx_mod
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/build_s
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/parity_stop_156
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/parity_start_156
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/data_rebuild
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/data_ctrl_out
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/rebuild_s_156
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/rebuild_s_312
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/rebuild_s_312_n
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/rebuild_start_h
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/rebuild_stop_h
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/rebuild_ctrl_in
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/rebuild_ctrl_in_reg_156
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/rebuild_ctrl_in_reg_312
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/rebuild_ctrl_in_reg_312_n
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/rebuild_ctrl_312_delay
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/rebuild_ctrl_312_n_delay
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/rebuild_data_in_reg_156
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/rebuild_data_in_reg_312
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/rebuild_data_in_reg_312_n
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/rebuild_data_312_delay
add wave -noupdate -group PKT_MNGR_0 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/rebuild_data_312_n_delay
add wave -noupdate -expand -group TB /tb_4xgth/RDEN_FIFO_PCS40
add wave -noupdate -expand -group TB /tb_4xgth/async_reset_n
add wave -noupdate -expand -group TB /tb_4xgth/clk_156
add wave -noupdate -expand -group TB /tb_4xgth/clk_312
add wave -noupdate -expand -group TB /tb_4xgth/clk_312_n
add wave -noupdate -expand -group TB /tb_4xgth/clk_250
add wave -noupdate -expand -group TB /tb_4xgth/eth_rx_los
add wave -noupdate -expand -group TB /tb_4xgth/index
add wave -noupdate -expand -group TB /tb_4xgth/linkstatus
add wave -noupdate -expand -group TB /tb_4xgth/on_frame_received
add wave -noupdate -expand -group TB /tb_4xgth/on_frame_sent
add wave -noupdate -expand -group TB /tb_4xgth/pkt_rx_avail_in
add wave -noupdate -expand -group TB /tb_4xgth/reset_rx_n
add wave -noupdate -expand -group TB /tb_4xgth/reset_tx_n
add wave -noupdate -expand -group TB /tb_4xgth/rst_n
add wave -noupdate -expand -group TB /tb_4xgth/rx_clk161
add wave -noupdate -expand -group TB /tb_4xgth/start_fifo
add wave -noupdate -expand -group TB /tb_4xgth/start_fifo_rd
add wave -noupdate -expand -group TB /tb_4xgth/start_tx_begin
add wave -noupdate -expand -group TB /tb_4xgth/tx_clk161
add wave -noupdate -expand -group TB /tb_4xgth/tx_data_0
add wave -noupdate -expand -group TB /tb_4xgth/tx_data_1
add wave -noupdate -expand -group TB /tb_4xgth/tx_data_2
add wave -noupdate -expand -group TB /tb_4xgth/tx_data_3
add wave -noupdate -expand -group TB /tb_4xgth/tx_header_0
add wave -noupdate -expand -group TB /tb_4xgth/tx_header_1
add wave -noupdate -expand -group TB /tb_4xgth/tx_header_2
add wave -noupdate -expand -group TB /tb_4xgth/tx_header_3
add wave -noupdate -expand -group TB /tb_4xgth/tx_valid_0
add wave -noupdate -expand -group TB /tb_4xgth/tx_valid_1
add wave -noupdate -expand -group TB /tb_4xgth/tx_valid_2
add wave -noupdate -expand -group TB /tb_4xgth/tx_valid_3
add wave -noupdate -expand -group TB /tb_4xgth/xgeth_rdata
add wave -noupdate -expand -group TB /tb_4xgth/xgeth_waddr
add wave -noupdate -expand -group TB /tb_4xgth/xgeth_wdata
add wave -noupdate -expand -group TB /tb_4xgth/xgeth_wen
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/clk_156
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/clk_250
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/reset
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/xgeth_rdata
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/xgeth_raddr
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/PKT_rx
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/packets_lost
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/latency
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/RFC_end
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/RFC_ack
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/initialize
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/reset_test
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/lfsr_seed
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/lfsr_polynomial
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/valid_seed
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/PKT_number
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/mac_source
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/mac_destination
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/PKT_sequence_in
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/ip_source
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/ip_destination
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/IDLE_number
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/PKT_length
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/TIMEOUT_number
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/RFC_type
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/PKT_type
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/mac_source_rx
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/mac_destination_rx
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/ip_source_rx
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/ip_destination_rx
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/TX_count
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/IDLE_count_receiver_out
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/RFC_running
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/linkstatus
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/eth_rx_los
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/check_reduce_frame_rate
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/time_stamp_flag
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/soft_reset
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/cont_error
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/payload_cycles
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/loopback_filter
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/payload_type
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/CURRENT_STATE
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/NEXT_STATE
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/PKT_number_value
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/RFC_type_250
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/RFC_type_156
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/STATUS_reg_250
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/STATUS_reg_156
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/STATUS_reg_250_out
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/STATUS_reg_156_out
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/test_end
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/time_stamp_flag_reg
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/check_reduce_frame_rate_reg
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/xgeth_wen
add wave -noupdate -expand -group UPC -radix hexadecimal /tb_4xgth/TESTER_0/inst_interface_upc/xgeth_wdata
add wave -noupdate -expand -group UPC -radix hexadecimal /tb_4xgth/TESTER_0/inst_interface_upc/xgeth_waddr
add wave -noupdate -expand -group UPC -radix hexadecimal /tb_4xgth/TESTER_0/inst_interface_upc/wen
add wave -noupdate -expand -group UPC -radix hexadecimal -childformat {{/tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(0) -radix hexadecimal} {/tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(1) -radix hexadecimal} {/tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(2) -radix hexadecimal} {/tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(3) -radix hexadecimal} {/tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(4) -radix hexadecimal} {/tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(5) -radix hexadecimal} {/tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(6) -radix hexadecimal} {/tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(7) -radix hexadecimal} {/tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(8) -radix hexadecimal} {/tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(9) -radix hexadecimal} {/tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(10) -radix hexadecimal} {/tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(11) -radix hexadecimal} {/tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(12) -radix hexadecimal} {/tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(13) -radix hexadecimal} {/tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(14) -radix hexadecimal} {/tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(15) -radix hexadecimal} {/tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(16) -radix hexadecimal} {/tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(17) -radix hexadecimal} {/tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(18) -radix hexadecimal} {/tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(19) -radix hexadecimal} {/tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(20) -radix hexadecimal} {/tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(21) -radix hexadecimal} {/tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(22) -radix hexadecimal} {/tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(23) -radix hexadecimal} {/tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(24) -radix hexadecimal} {/tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(25) -radix hexadecimal} {/tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(26) -radix hexadecimal} {/tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(27) -radix hexadecimal}} -expand -subitemconfig {/tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(0) {-height 16 -radix hexadecimal} /tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(1) {-height 16 -radix hexadecimal} /tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(2) {-height 16 -radix hexadecimal} /tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(3) {-height 16 -radix hexadecimal} /tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(4) {-height 16 -radix hexadecimal} /tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(5) {-height 16 -radix hexadecimal} /tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(6) {-height 16 -radix hexadecimal} /tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(7) {-height 16 -radix hexadecimal} /tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(8) {-height 16 -radix hexadecimal} /tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(9) {-height 16 -radix hexadecimal} /tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(10) {-height 16 -radix hexadecimal} /tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(11) {-height 16 -radix hexadecimal} /tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(12) {-height 16 -radix hexadecimal} /tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(13) {-height 16 -radix hexadecimal} /tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(14) {-height 16 -radix hexadecimal} /tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(15) {-height 16 -radix hexadecimal} /tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(16) {-height 16 -radix hexadecimal} /tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(17) {-height 16 -radix hexadecimal} /tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(18) {-height 16 -radix hexadecimal} /tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(19) {-height 16 -radix hexadecimal} /tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(20) {-height 16 -radix hexadecimal} /tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(21) {-height 16 -radix hexadecimal} /tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(22) {-height 16 -radix hexadecimal} /tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(23) {-height 16 -radix hexadecimal} /tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(24) {-height 16 -radix hexadecimal} /tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(25) {-height 16 -radix hexadecimal} /tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(26) {-height 16 -radix hexadecimal} /tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out(27) {-height 16 -radix hexadecimal}} /tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/crossClock_buffer_250_in
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/crossClock_buffer_156_in
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/crossClock_buffer_250_out
add wave -noupdate -expand -group UPC /tb_4xgth/TESTER_0/inst_interface_upc/crossClock_buffer_156_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{inicio do pkt no rx} {366601643200 ps} 1} {{Cursor 5} {1600 ps} 0}
quietly wave cursor active 2
configure wave -namecolwidth 252
configure wave -valuecolwidth 279
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
WaveRestoreZoom {0 ps} {61608 ps}
bookmark add wave bookmark5 {{770754 ps} {811500 ps}} 13
bookmark add wave bookmark6 {{780000 ps} {800000 ps}} 8
bookmark add wave bookmark7 {{0 ps} {42010 ps}} 0
bookmark add wave bookmark8 {{201305 ps} {266263 ps}} 7
bookmark add wave bookmark9 {{728057 ps} {794311 ps}} 6
bookmark add wave bookmark10 {{1931987 ps} {1965959 ps}} 9
