onerror {resume}
quietly virtual function -install /glbl -env /glbl { 907643} virtual_000001
quietly WaveActivateNextPane {} 0
add wave -noupdate -group 40TB /tb_40gb/clk_156
add wave -noupdate -group 40TB /tb_40gb/tx_clk161
add wave -noupdate -group 40TB /tb_40gb/clk_312
add wave -noupdate -group 40TB /tb_40gb/clk_312_n
add wave -noupdate -group 40TB /tb_40gb/rst_n
add wave -noupdate -group 40TB /tb_40gb/async_reset_n
add wave -noupdate -group 40TB /tb_40gb/reset_tx_n
add wave -noupdate -group 40TB /tb_40gb/reset_rx_n
add wave -noupdate -group 40TB /tb_40gb/loop_select
add wave -noupdate -group 40TB /tb_40gb/mac_source
add wave -noupdate -group 40TB /tb_40gb/rec_mac_source_rx
add wave -noupdate -group 40TB /tb_40gb/rec_mac_destination_rx
add wave -noupdate -group 40TB /tb_40gb/rec_ip_source_rx
add wave -noupdate -group 40TB /tb_40gb/rec_ip_destination_rx
add wave -noupdate -group 40TB /tb_40gb/start_tx_begin_delay
add wave -noupdate -group 40TB /tb_40gb/start_tx_begin
add wave -noupdate -group 40TB /tb_40gb/contador_teste
add wave -noupdate -group 40TB /tb_40gb/pkt_tx_eop
add wave -noupdate -group 40TB /tb_40gb/start
add wave -noupdate -group 40TB /tb_40gb/lfsr_seed
add wave -noupdate -group 40TB /tb_40gb/valid_seed
add wave -noupdate -group 40TB /tb_40gb/lfsr_polynomial
add wave -noupdate -group 40TB /tb_40gb/mac_destination
add wave -noupdate -group 40TB /tb_40gb/ip_source
add wave -noupdate -group 40TB /tb_40gb/ip_destination
add wave -noupdate -group 40TB /tb_40gb/packet_length
add wave -noupdate -group 40TB /tb_40gb/timestamp_base
add wave -noupdate -group 40TB /tb_40gb/time_stamp_flag
add wave -noupdate -group 40TB /tb_40gb/pkt_tx_full
add wave -noupdate -group 40TB /tb_40gb/payload_type
add wave -noupdate -group 40TB /tb_40gb/payload_cycles
add wave -noupdate -group 40TB /tb_40gb/pkt_rx_avail_in
add wave -noupdate -group 40TB /tb_40gb/pkt_rx_eop_in
add wave -noupdate -group 40TB /tb_40gb/pkt_rx_sop_in
add wave -noupdate -group 40TB /tb_40gb/pkt_rx_val_in
add wave -noupdate -group 40TB /tb_40gb/pkt_rx_err_in
add wave -noupdate -group 40TB /tb_40gb/pkt_rx_data_in
add wave -noupdate -group 40TB /tb_40gb/pkt_rx_mod_in
add wave -noupdate -group 40TB /tb_40gb/mac_filter
add wave -noupdate -group 40TB /tb_40gb/bypass_scram
add wave -noupdate -group 40TB /tb_40gb/bypass_66encoder
add wave -noupdate -group 40TB /tb_40gb/tx_jtm_en
add wave -noupdate -group 40TB /tb_40gb/jtm_dps_0
add wave -noupdate -group 40TB /tb_40gb/jtm_dps_1
add wave -noupdate -group 40TB /tb_40gb/seed_A
add wave -noupdate -group 40TB /tb_40gb/seed_B
add wave -noupdate -group 40TB /tb_40gb/start_fifo
add wave -noupdate -group 40TB /tb_40gb/start_fifo_rd
add wave -noupdate -group 40TB /tb_40gb/tx_fifo_spill
add wave -noupdate -group 40TB /tb_40gb/fill_pcs_tx
add wave -noupdate -group 40TB /tb_40gb/tx_data_out_0
add wave -noupdate -group 40TB /tb_40gb/tx_data_out_1
add wave -noupdate -group 40TB /tb_40gb/tx_data_out_2
add wave -noupdate -group 40TB /tb_40gb/tx_data_out_3
add wave -noupdate -group 40TB /tb_40gb/tx_header_out_0
add wave -noupdate -group 40TB /tb_40gb/tx_header_out_1
add wave -noupdate -group 40TB /tb_40gb/tx_header_out_2
add wave -noupdate -group 40TB /tb_40gb/tx_header_out_3
add wave -noupdate -group 40TB /tb_40gb/tx_valid_out_0
add wave -noupdate -group 40TB /tb_40gb/tx_valid_out_1
add wave -noupdate -group 40TB /tb_40gb/tx_valid_out_2
add wave -noupdate -group 40TB /tb_40gb/tx_valid_out_3
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/clk_156
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/tx_clk161
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/clk_312
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/clk_312_n
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/rst_n
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/async_reset_n
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/reset_tx_n
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/reset_rx_n
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/loop_select
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/mac_source
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/rec_mac_source_rx
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/rec_mac_destination_rx
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/rec_ip_source_rx
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/rec_ip_destination_rx
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/start
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/lfsr_seed
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/valid_seed
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/lfsr_polynomial
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/mac_destination
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/ip_source
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/ip_destination
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/packet_length
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/timestamp_base
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/time_stamp_flag
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/pkt_tx_full
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/payload_type
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/payload_cycles
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/pkt_rx_avail_in
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/pkt_rx_eop_in
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/pkt_rx_sop_in
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/pkt_rx_val_in
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/pkt_rx_err_in
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/pkt_rx_data_in
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/pkt_rx_mod_in
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/mac_filter
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/seed_A
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/seed_B
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/bypass_66encoder
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/bypass_scram
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/tx_jtm_en
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/jtm_dps_0
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/jtm_dps_1
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/start_fifo
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/start_fifo_rd
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/fill_pcs_tx
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/tx_fifo_spill
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/tx_data_out_0
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/tx_data_out_1
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/tx_data_out_2
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/tx_data_out_3
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/tx_header_out_0
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/tx_header_out_1
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/tx_header_out_2
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/tx_header_out_3
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/tx_valid_out_0
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/tx_valid_out_1
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/tx_valid_out_2
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/tx_valid_out_3
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/pkt_tx_eop_batata
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/pkt_tx_data
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/mac_source_out
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/mac_destination_out
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/ip_source_out
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/ip_destination_out
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/pkt_tx_mod
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/pkt_tx_sop
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/pkt_tx_eop
add wave -noupdate -group TC_ARCH /tb_40gb/Tb_TX_ARCH_INST/pkt_tx_val
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/async_reset_n
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/bypass_66encoder
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/bypass_scram
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/clk_156
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/fill_pcs_tx
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/fill_tx_pcs0
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/fill_tx_pcs1
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/fill_tx_pcs2
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/fill_tx_pcs3
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/jtm_dps_0
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/jtm_dps_1
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/pcs_0_scram_en
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/pcs_1_scram_en
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/pcs_2_scram_en
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/pcs_3_scram_en
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/pcs_sync
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/pkt_tx_data
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/pkt_tx_eop
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/pkt_tx_mod
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/pkt_tx_sop
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/pkt_tx_val
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/reset_rx_n
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/reset_tx_n
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/seed_A
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/seed_B
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/start_fifo
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/start_fifo_rd
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/start_in_0_tx
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/start_in_1_tx
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/start_in_2_tx
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/start_in_3_tx
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/start_out_0_tx
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/start_out_0_tx_r
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/start_out_1_tx
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/start_out_1_tx_r
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/start_out_2_tx
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/start_out_2_tx_r
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/start_out_3_tx
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/start_out_3_tx_r
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/terminate_in_0_tx
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/terminate_in_1_tx
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/terminate_in_2_tx
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/terminate_in_3_tx
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/terminate_out_0_tx
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/terminate_out_1_tx
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/terminate_out_2_tx
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/terminate_out_3_tx
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/tx_clk161
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/tx_data_int_0
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/tx_data_int_1
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/tx_data_int_2
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/tx_data_int_3
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/tx_data_out_0
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/tx_data_out_1
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/tx_data_out_2
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/tx_data_out_3
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/tx_encoded_pcs0
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/tx_encoded_pcs1
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/tx_encoded_pcs2
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/tx_encoded_pcs3
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/tx_fifo_spill
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/tx_fifo_spill_0
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/tx_fifo_spill_1
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/tx_fifo_spill_2
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/tx_fifo_spill_3
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/tx_header_int_0
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/tx_header_int_1
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/tx_header_int_2
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/tx_header_int_3
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/tx_header_out_0
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/tx_header_out_1
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/tx_header_out_2
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/tx_header_out_3
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/tx_jtm_en
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/tx_old_encod_data_out_0
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/tx_old_encod_data_out_1
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/tx_old_encod_data_out_2
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/tx_old_encod_data_out_3
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/tx_old_encod_data_out_3_reg
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/tx_sequence_cnt_out
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/tx_sequence_out_0
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/tx_sequence_out_1
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/tx_sequence_out_2
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/tx_sequence_out_3
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/tx_valid_out_0
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/tx_valid_out_1
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/tx_valid_out_2
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/tx_valid_out_3
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/tx_wr_pcs
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/txlf
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/txlf_0
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/txlf_1
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/txlf_2
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/txlf_3
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/xgmii_txc_lane_0
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/xgmii_txc_lane_1
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/xgmii_txc_lane_2
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/xgmii_txc_lane_3
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/xgmii_txd_lane_0
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/xgmii_txd_lane_1
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/xgmii_txd_lane_2
add wave -noupdate -group TX_PATHWAY /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/xgmii_txd_lane_3
add wave -noupdate -group TX_0_PATH /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/PCS_ID
add wave -noupdate -group TX_0_PATH /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/TXD_Scr
add wave -noupdate -group TX_0_PATH /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/arstb
add wave -noupdate -group TX_0_PATH /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/bypass_66encoder
add wave -noupdate -group TX_0_PATH /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/bypass_scram
add wave -noupdate -group TX_0_PATH /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/clk156
add wave -noupdate -group TX_0_PATH /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/cnt
add wave -noupdate -group TX_0_PATH /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/cnt_h
add wave -noupdate -group TX_0_PATH /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/data_pause
add wave -noupdate -group TX_0_PATH /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/encoded_data
add wave -noupdate -group TX_0_PATH /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/encoded_out
add wave -noupdate -group TX_0_PATH /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/fifo_rd_data
add wave -noupdate -group TX_0_PATH /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/fill_out
add wave -noupdate -group TX_0_PATH /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/jtm_dps_0
add wave -noupdate -group TX_0_PATH /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/jtm_dps_1
add wave -noupdate -group TX_0_PATH /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/pause_ipg
add wave -noupdate -group TX_0_PATH /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/pcs_sync
add wave -noupdate -group TX_0_PATH /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/scr_en_d
add wave -noupdate -group TX_0_PATH /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/scram_en
add wave -noupdate -group TX_0_PATH /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/seed_A
add wave -noupdate -group TX_0_PATH /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/seed_B
add wave -noupdate -group TX_0_PATH /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/spill
add wave -noupdate -group TX_0_PATH /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/start_fifo
add wave -noupdate -group TX_0_PATH /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/start_fifo_rd
add wave -noupdate -group TX_0_PATH /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/start_in
add wave -noupdate -group TX_0_PATH /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/start_out
add wave -noupdate -group TX_0_PATH /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/terminate_in
add wave -noupdate -group TX_0_PATH /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/terminate_out
add wave -noupdate -group TX_0_PATH /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/tx_clk161
add wave -noupdate -group TX_0_PATH /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/tx_data_out
add wave -noupdate -group TX_0_PATH /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/tx_header_out
add wave -noupdate -group TX_0_PATH /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/tx_jtm_en
add wave -noupdate -group TX_0_PATH /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/tx_old_scr_data_in
add wave -noupdate -group TX_0_PATH /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/tx_old_scr_data_out
add wave -noupdate -group TX_0_PATH /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/tx_sequence_out
add wave -noupdate -group TX_0_PATH /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/txlf
add wave -noupdate -group TX_0_PATH /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/xgmii_txc
add wave -noupdate -group TX_0_PATH /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/xgmii_txd
add wave -noupdate -group TX_PATH_FIFO_0_OUT /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/FIFO_FULL
add wave -noupdate -group TX_PATH_FIFO_0_OUT /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/almostempty
add wave -noupdate -group TX_PATH_FIFO_0_OUT /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/almostempty_ff1
add wave -noupdate -group TX_PATH_FIFO_0_OUT /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/almostempty_ff2
add wave -noupdate -group TX_PATH_FIFO_0_OUT /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/almostfull
add wave -noupdate -group TX_PATH_FIFO_0_OUT /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/control_block
add wave -noupdate -group TX_PATH_FIFO_0_OUT /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/empty
add wave -noupdate -group TX_PATH_FIFO_0_OUT /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/fifo_fill
add wave -noupdate -group TX_PATH_FIFO_0_OUT /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/fill_out
add wave -noupdate -group TX_PATH_FIFO_0_OUT /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/full
add wave -noupdate -group TX_PATH_FIFO_0_OUT /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/rclk
add wave -noupdate -group TX_PATH_FIFO_0_OUT /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/rd_count
add wave -noupdate -group TX_PATH_FIFO_0_OUT /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/rd_en
add wave -noupdate -group TX_PATH_FIFO_0_OUT /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/read_idle
add wave -noupdate -group TX_PATH_FIFO_0_OUT /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/read_term
add wave -noupdate -group TX_PATH_FIFO_0_OUT /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/readdata
add wave -noupdate -group TX_PATH_FIFO_0_OUT /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/readen
add wave -noupdate -group TX_PATH_FIFO_0_OUT /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/readen_d
add wave -noupdate -group TX_PATH_FIFO_0_OUT /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/registered_read_enable
add wave -noupdate -group TX_PATH_FIFO_0_OUT /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/registered_write_data
add wave -noupdate -group TX_PATH_FIFO_0_OUT /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/registered_write_enable
add wave -noupdate -group TX_PATH_FIFO_0_OUT /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/registered_write_enable_d
add wave -noupdate -group TX_PATH_FIFO_0_OUT /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/rfifo_data
add wave -noupdate -group TX_PATH_FIFO_0_OUT /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/rst
add wave -noupdate -group TX_PATH_FIFO_0_OUT /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/rst_ext
add wave -noupdate -group TX_PATH_FIFO_0_OUT /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/seq1
add wave -noupdate -group TX_PATH_FIFO_0_OUT /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/seq2
add wave -noupdate -group TX_PATH_FIFO_0_OUT /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/seq_data
add wave -noupdate -group TX_PATH_FIFO_0_OUT /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/seq_data_r
add wave -noupdate -group TX_PATH_FIFO_0_OUT /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/seq_repeat
add wave -noupdate -group TX_PATH_FIFO_0_OUT /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/spill
add wave -noupdate -group TX_PATH_FIFO_0_OUT /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/spill_rr
add wave -noupdate -group TX_PATH_FIFO_0_OUT /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/spill_ww
add wave -noupdate -group TX_PATH_FIFO_0_OUT /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/wclk
add wave -noupdate -group TX_PATH_FIFO_0_OUT /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/wfifo_data
add wave -noupdate -group TX_PATH_FIFO_0_OUT /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/wfifo_en
add wave -noupdate -group TX_PATH_FIFO_0_OUT /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/wr_count
add wave -noupdate -group TX_PATH_FIFO_0_OUT /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/wr_ctrl
add wave -noupdate -group TX_PATH_FIFO_0_OUT /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/wr_ctrl_idle
add wave -noupdate -group TX_PATH_FIFO_0_OUT /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/wr_data
add wave -noupdate -group TX_PATH_FIFO_0_OUT /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/wr_idle_seq
add wave -noupdate -group TX_PATH_FIFO_0_OUT /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/wr_idle_start
add wave -noupdate -group TX_PATH_FIFO_0_OUT /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/wr_seq
add wave -noupdate -group TX_PATH_FIFO_0_OUT /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/wr_seq1
add wave -noupdate -group TX_PATH_FIFO_0_OUT /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/wr_seq2
add wave -noupdate -group TX_PATH_FIFO_0_OUT /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/wr_seq_idle
add wave -noupdate -group TX_PATH_FIFO_0_OUT /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/wr_seq_start
add wave -noupdate -group TX_PATH_FIFO_0_OUT /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/wr_start
add wave -noupdate -group TX_PATH_FIFO_0_OUT /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/wr_term
add wave -noupdate -group TX_PATH_FIFO_0_OUT /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/wr_term_d
add wave -noupdate -group TX_PATH_FIFO_0_OUT /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/wr_term_dd
add wave -noupdate -group TX_PATH_FIFO_0_OUT /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/write_enable
add wave -noupdate -group TX_PATH_FIFO_0_OUT /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/writedata
add wave -noupdate -group TX_PATH_FIFO_0_OUT /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/writedata_d
add wave -noupdate -group TX_PATH_FIFO_0_OUT -radix hexadecimal /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/writen
add wave -noupdate -group TX_PATH_FIFO_0_IN /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/FIFO_DUALCLOCK_MACRO_inst/ALMOSTEMPTY
add wave -noupdate -group TX_PATH_FIFO_0_IN /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/FIFO_DUALCLOCK_MACRO_inst/ALMOSTFULL
add wave -noupdate -group TX_PATH_FIFO_0_IN /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/FIFO_DUALCLOCK_MACRO_inst/ALMOST_EMPTY_OFFSET
add wave -noupdate -group TX_PATH_FIFO_0_IN /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/FIFO_DUALCLOCK_MACRO_inst/ALMOST_FULL_OFFSET
add wave -noupdate -group TX_PATH_FIFO_0_IN /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/FIFO_DUALCLOCK_MACRO_inst/COUNT_WIDTH
add wave -noupdate -group TX_PATH_FIFO_0_IN /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/FIFO_DUALCLOCK_MACRO_inst/DATA_P
add wave -noupdate -group TX_PATH_FIFO_0_IN /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/FIFO_DUALCLOCK_MACRO_inst/DATA_WIDTH
add wave -noupdate -group TX_PATH_FIFO_0_IN /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/FIFO_DUALCLOCK_MACRO_inst/DEVICE
add wave -noupdate -group TX_PATH_FIFO_0_IN /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/FIFO_DUALCLOCK_MACRO_inst/DI
add wave -noupdate -group TX_PATH_FIFO_0_IN /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/FIFO_DUALCLOCK_MACRO_inst/DIP_PATTERN
add wave -noupdate -group TX_PATH_FIFO_0_IN /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/FIFO_DUALCLOCK_MACRO_inst/DIP_WIDTH
add wave -noupdate -group TX_PATH_FIFO_0_IN /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/FIFO_DUALCLOCK_MACRO_inst/DI_PATTERN
add wave -noupdate -group TX_PATH_FIFO_0_IN /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/FIFO_DUALCLOCK_MACRO_inst/DO
add wave -noupdate -group TX_PATH_FIFO_0_IN /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/FIFO_DUALCLOCK_MACRO_inst/DOP_PATTERN
add wave -noupdate -group TX_PATH_FIFO_0_IN /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/FIFO_DUALCLOCK_MACRO_inst/DOP_WIDTH
add wave -noupdate -group TX_PATH_FIFO_0_IN /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/FIFO_DUALCLOCK_MACRO_inst/DO_PATTERN
add wave -noupdate -group TX_PATH_FIFO_0_IN /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/FIFO_DUALCLOCK_MACRO_inst/D_WIDTH
add wave -noupdate -group TX_PATH_FIFO_0_IN /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/FIFO_DUALCLOCK_MACRO_inst/EMPTY
add wave -noupdate -group TX_PATH_FIFO_0_IN /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/FIFO_DUALCLOCK_MACRO_inst/FIFO_SIZE
add wave -noupdate -group TX_PATH_FIFO_0_IN /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/FIFO_DUALCLOCK_MACRO_inst/FIRST_WORD_FALL_THROUGH
add wave -noupdate -group TX_PATH_FIFO_0_IN /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/FIFO_DUALCLOCK_MACRO_inst/FULL
add wave -noupdate -group TX_PATH_FIFO_0_IN /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/FIFO_DUALCLOCK_MACRO_inst/INIT
add wave -noupdate -group TX_PATH_FIFO_0_IN /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/FIFO_DUALCLOCK_MACRO_inst/MAX_COUNT_WIDTH
add wave -noupdate -group TX_PATH_FIFO_0_IN /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/FIFO_DUALCLOCK_MACRO_inst/MAX_DP_WIDTH
add wave -noupdate -group TX_PATH_FIFO_0_IN /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/FIFO_DUALCLOCK_MACRO_inst/MAX_D_WIDTH
add wave -noupdate -group TX_PATH_FIFO_0_IN /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/FIFO_DUALCLOCK_MACRO_inst/RDCLK
add wave -noupdate -group TX_PATH_FIFO_0_IN /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/FIFO_DUALCLOCK_MACRO_inst/RDCOUNT
add wave -noupdate -group TX_PATH_FIFO_0_IN /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/FIFO_DUALCLOCK_MACRO_inst/RDCOUNT_PATTERN
add wave -noupdate -group TX_PATH_FIFO_0_IN /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/FIFO_DUALCLOCK_MACRO_inst/RDEN
add wave -noupdate -group TX_PATH_FIFO_0_IN /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/FIFO_DUALCLOCK_MACRO_inst/RDERR
add wave -noupdate -group TX_PATH_FIFO_0_IN /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/FIFO_DUALCLOCK_MACRO_inst/RST
add wave -noupdate -group TX_PATH_FIFO_0_IN /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/FIFO_DUALCLOCK_MACRO_inst/SIM_MODE
add wave -noupdate -group TX_PATH_FIFO_0_IN /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/FIFO_DUALCLOCK_MACRO_inst/SRVAL
add wave -noupdate -group TX_PATH_FIFO_0_IN /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/FIFO_DUALCLOCK_MACRO_inst/WRCLK
add wave -noupdate -group TX_PATH_FIFO_0_IN /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/FIFO_DUALCLOCK_MACRO_inst/WRCOUNT
add wave -noupdate -group TX_PATH_FIFO_0_IN /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/FIFO_DUALCLOCK_MACRO_inst/WRCOUNT_PATTERN
add wave -noupdate -group TX_PATH_FIFO_0_IN /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/FIFO_DUALCLOCK_MACRO_inst/WREN
add wave -noupdate -group TX_PATH_FIFO_0_IN /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/FIFO_DUALCLOCK_MACRO_inst/WRERR
add wave -noupdate -group TX_PATH_FIFO_0_IN /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/FIFO_DUALCLOCK_MACRO_inst/d_size
add wave -noupdate -group TX_PATH_FIFO_0_IN /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/FIFO_DUALCLOCK_MACRO_inst/fin_width
add wave -noupdate -group TX_PATH_FIFO_0_IN /tb_40gb/Tb_TX_ARCH_INST/inst_tx_pathway/INST_0_tx_path/INST_TX_PATH_FIFO/FIFO_DUALCLOCK_MACRO_inst/sim_device_pm
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/rx_clk161
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/clk_312
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/clk_156
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/reset_rx_n
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/async_reset_n
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/rx_data_in_0
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/rx_data_in_1
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/rx_data_in_2
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/rx_data_in_3
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/rx_header_in_0
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/rx_header_in_1
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/rx_header_in_2
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/rx_header_in_3
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/rx_valid_in_0
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/rx_valid_in_1
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/rx_valid_in_2
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/rx_valid_in_3
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/rx_jtm_en
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/bypass_descram
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/bypass_66decoder
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/clear_errblk
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/clear_ber_cnt
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/RDEN_FIFO_PCS40
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/start_fifo
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/lfsr_seed
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/valid_seed
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/lfsr_polynomial
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/pkt_rx_avail
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/verify_system_rec
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/reset_test
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/pkt_sequence_in
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/pkt_rx_mod
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/payload_type
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/timestamp_base
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/pkt_rx_eop
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/pkt_rx_sop
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/pkt_rx_val
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/pkt_rx_data
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/crc_ok
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/mac_source
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/mac_source_rx
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/mac_destination
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/ip_source
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/ip_destination
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/time_stamp_out
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/received_packet
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/end_latency
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/packets_lost
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/RESET_done
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/pkt_rx_ren
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/pkt_sequence_error_flag
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/pkt_sequence_error
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/count_error
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/IDLE_count
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/crc_pkt_rx_eop_out
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/crc_pkt_rx_sop_out
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/crc_pkt_rx_val_out
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/crc_pkt_rx_data_out
add wave -noupdate -group RX_ARCH /tb_40gb/Tb_RX_ARCH_INST/crc_ok_out
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/rx_clk161
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/clk_312
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/clk_156
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/reset_rx_n
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/async_reset_n
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/rx_data_in_0
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/rx_data_in_1
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/rx_data_in_2
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/rx_data_in_3
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/rx_header_in_0
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/rx_header_in_1
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/rx_header_in_2
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/rx_header_in_3
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/rx_valid_in_0
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/rx_valid_in_1
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/rx_valid_in_2
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/rx_valid_in_3
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/rx_jtm_en
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/bypass_descram
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/bypass_66decoder
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/clear_errblk
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/clear_ber_cnt
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/RDEN_FIFO_PCS40
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/start_fifo
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/pkt_rx_eop
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/pkt_rx_sop
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/pkt_rx_val
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/pkt_rx_data
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/crc_ok
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/pcs_0_valid_out
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/pcs_1_valid_out
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/pcs_2_valid_out
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/pcs_3_valid_out
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/fifo_reorder_empty_0
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/fifo_reorder_empty_1
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/fifo_reorder_empty_2
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/fifo_reorder_empty_3
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/pcs_0_alignment
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/pcs_1_alignment
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/pcs_2_alignment
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/pcs_3_alignment
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/pcs_0_header_out
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/pcs_0_data_out
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/pcs_1_header_out
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/pcs_1_data_out
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/pcs_2_header_out
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/pcs_2_data_out
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/pcs_3_header_out
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/pcs_3_data_out
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/pcs_0_dscr
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/pcs_1_dscr
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/pcs_2_dscr
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/pcs_3_dscr
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/fill_rx_pcs0
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/fill_rx_pcs1
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/fill_rx_pcs2
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/fill_rx_pcs3
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/dscr_en_ipg
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/valid_0_out_wire
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/valid_1_out_wire
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/valid_2_out_wire
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/valid_3_out_wire
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/v0
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/v1
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/v2
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/v3
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/hh0
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/hh1
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/hh2
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/hh3
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/d0
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/d1
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/d2
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/d3
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/dscr_0_out_wire
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/dscr_1_out_wire
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/dscr_2_out_wire
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/dscr_3_out_wire
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/old_data_0
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/old_header_0
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/terminate_out_0_rx
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/terminate_out_1_rx
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/terminate_out_2_rx
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/terminate_out_3_rx
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/start_out_0_rx
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/start_out_1_rx
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/start_out_2_rx
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/start_out_3_rx
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/terminate_in_0_rx
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/terminate_in_1_rx
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/terminate_in_2_rx
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/terminate_in_3_rx
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/start_out_0_rx_r
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/start_out_1_rx_r
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/start_out_2_rx_r
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/start_out_3_rx_r
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/start_in_0_rx
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/start_in_1_rx
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/start_in_2_rx
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/start_in_3_rx
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/hi_ber_0
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/ber_cnt_0
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/errd_blks_0
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/blk_lock_0
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/linkstatus_0
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/rx_fifo_spill_0
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/rxlf_0
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/rxgearboxslip_out_0
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/hi_ber_1
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/ber_cnt_1
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/errd_blks_1
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/blk_lock_1
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/linkstatus_1
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/rx_fifo_spill_1
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/rxlf_1
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/rxgearboxslip_out_1
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/hi_ber_2
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/ber_cnt_2
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/errd_blks_2
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/blk_lock_2
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/linkstatus_2
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/rx_fifo_spill_2
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/rxlf_2
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/rxgearboxslip_out_2
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/hi_ber_3
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/ber_cnt_3
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/errd_blks_3
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/blk_lock_3
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/linkstatus_3
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/rx_fifo_spill_3
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/rxlf_3
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/rxgearboxslip_out_3
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/xgmii_rxc_lane_0
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/xgmii_rxc_lane_1
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/xgmii_rxc_lane_2
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/xgmii_rxc_lane_3
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/xgmii_rxd_lane_0
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/xgmii_rxd_lane_1
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/xgmii_rxd_lane_2
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/xgmii_rxd_lane_3
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/mac_eop
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/mac_sop
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/mac_val
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/mac_data
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/empty_fifo
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/full_fifo
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/fifo_almost_f
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/fifo_almost_e
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/ren_coreif
add wave -noupdate -group RX_PATH /tb_40gb/Tb_RX_ARCH_INST/inst_rx_pathway/almost_e_coreif
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/clk_312
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/reset
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/lfsr_seed
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/lfsr_polynomial
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/valid_seed
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/timestamp_base
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/mac_source
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/mac_source_rx
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/mac_destination
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/ip_source
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/ip_destination
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/time_stamp_out
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/received_packet
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/end_latency
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/packets_lost
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/RESET_done
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/pkt_rx_ren
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/pkt_rx_avail
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/pkt_rx_eop
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/pkt_rx_sop
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/pkt_rx_val
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/pkt_rx_err
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/pkt_rx_data
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/pkt_rx_mod
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/payload_type
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/verify_system_rec
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/reset_test
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/pkt_sequence_in
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/pkt_sequence_error_flag
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/pkt_sequence_error
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/count_error
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/IDLE_count
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/current_s
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/next_s
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/lfsr_state
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/recovery_state
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/pkt_rx_data_buffer
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/pkt_rx_data_nbits
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/pkt_rx_data_N
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/pkt_sequence_error_flag_aux
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/reg_mac_source
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/reg_mac_destination
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/reg_ip_source
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/reg_ip_destination
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/reg_ethernet_type
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/reg_ip_protocol
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/reg_ip_message_length
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/ip_low
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/ip_high
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/ip_pkt_type
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/udp_pkt_type
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/time_stamp_generator
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/time_stamp_receiver
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/time_stamp_ready
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/received_packet_wire
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/id_pkt_tester
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/id_sequence_counter
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/id_checker_reg
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/lost_pkt_flag
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/not_lost_pkt_test
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/lost_counter
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/lost_pkt_tester
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/IDLE_count_reg
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/pkt_zeros
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/pkt_ones
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/RANDOM
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/lfsr_bert
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/start
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/lfsr_start
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/lfsr_start_delay
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/lfsr_resync_ON
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/lfsr_fsm_begin
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/lfsr_test_begin
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/lfsr_load_seed
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/delay_B0
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/delay_B1
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/delay_B2
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/lfsr_resync_SIGNAL
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/lfsr_resync_RANDOM
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/lfsr_counter
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/const_test_begin
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/bert_target_lfsr
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/bert_xor
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/bert_cycle_wrong
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/bert_n_flipped_b
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/bert_count_flip
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/bert_test_begin
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/ALL_ONE
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/ALL_ZERO
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/recovery_n_flipped_b
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/recovery_cycle_wrong
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/recovery_ON
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/recovery_start_pkt
add wave -noupdate -expand -group ECHO_RECEIVER /tb_40gb/Tb_RX_ARCH_INST/inst_echo_receiver/recovery_stop_pkt
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{inicio do pkt no rx} {366601643200 ps} 1} {{Cursor 5} {5145344 ps} 0}
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
WaveRestoreZoom {5138664 ps} {5175038 ps}
bookmark add wave bookmark5 {{770754 ps} {811500 ps}} 13
bookmark add wave bookmark6 {{780000 ps} {800000 ps}} 8
bookmark add wave bookmark7 {{0 ps} {42010 ps}} 0
bookmark add wave bookmark8 {{201305 ps} {266263 ps}} 7
bookmark add wave bookmark9 {{728057 ps} {794311 ps}} 6
bookmark add wave bookmark10 {{1931987 ps} {1965959 ps}} 9
