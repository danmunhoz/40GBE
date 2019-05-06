onerror {resume}
quietly virtual function -install /glbl -env /glbl { 907643} virtual_000001
quietly WaveActivateNextPane {} 0
add wave -noupdate -height 30 -expand -group {TX 10} -group ECHO_GEN -divider outputs
add wave -noupdate -height 30 -expand -group {TX 10} -group MAC -expand -group XGE_MAC -divider outputs
add wave -noupdate -height 30 -expand -group {TX 10} -group MAC -expand -group tx_data_fifo -divider out
add wave -noupdate -height 30 -expand -group {TX 10} -group MAC -expand -group tx_hold_fifo -divider out
add wave -noupdate -divider <NULL>
add wave -noupdate -divider <NULL>
add wave -noupdate -divider <NULL>
add wave -noupdate -height 30 -expand -group RX -divider -height 30 REORDER
add wave -noupdate -height 30 -expand -group RX -divider -height 40 {LANE REORDER - ESTAGIO 0}
add wave -noupdate -height 30 -expand -group RX -divider -height 16 {ESTAGIO 1}
add wave -noupdate -height 30 -expand -group RX -divider -height 16 ESTAGIO
add wave -noupdate -height 30 -expand -group RX -divider -height 16 {ESTAGIO 2}
add wave -noupdate -height 30 -expand -group RX -divider {ESTAGIO 3}
add wave -noupdate -height 30 -expand -group RX -divider <NULL>
add wave -noupdate -height 30 -expand -group RX -divider <NULL>
add wave -noupdate -height 30 -expand -group RX -divider -height 30 {RX PCS's}
add wave -noupdate -height 30 -expand -group RX -height 30 -expand -group ALIG_REMOVAL -group antigo -divider <NULL>
add wave -noupdate -height 30 -expand -group RX -height 30 -expand -group ALIG_REMOVAL -group antigo -divider <NULL>
add wave -noupdate -height 30 -expand -group RX -height 30 -expand -group ALIG_REMOVAL -group antigo -divider <NULL>
add wave -noupdate -height 30 -expand -group RX -height 30 -expand -group ALIG_REMOVAL -group antigo -divider <NULL>
add wave -noupdate -height 30 -expand -group RX -height 30 -expand -group ALIG_REMOVAL -group antigo -divider <NULL>
add wave -noupdate -height 30 -expand -group RX -height 30 -expand -group ALIG_REMOVAL -divider <NULL>
add wave -noupdate -height 30 -expand -group RX -height 30 -expand -group ALIG_REMOVAL -divider <NULL>
add wave -noupdate -height 30 -expand -group RX -height 30 -expand -group ALIG_REMOVAL -divider <NULL>
add wave -noupdate -height 30 -expand -group RX -height 30 -expand -group ALIG_REMOVAL -divider <NULL>
add wave -noupdate -height 30 -expand -group RX -height 30 -expand -group ALIG_REMOVAL -divider <NULL>
add wave -noupdate -height 30 -expand -group RX -height 30 -expand -group ALIG_REMOVAL -divider <NULL>
add wave -noupdate -height 30 -expand -group RX -divider <NULL>
add wave -noupdate -height 30 -expand -group RX -expand -group RX_PCS -group PCS_0 -group PCS0_Descramble -divider inputs
add wave -noupdate -height 30 -expand -group RX -expand -group RX_PCS -group PCS_0 -group PCS0_Descramble -divider outputs
add wave -noupdate -height 30 -expand -group RX -expand -group RX_PCS -group PCS_0 -expand -group PCS0_Decoder -divider inputs
add wave -noupdate -height 30 -expand -group RX -expand -group RX_PCS -group PCS_0 -expand -group PCS0_Decoder -divider outputs
add wave -noupdate -height 30 -expand -group RX -expand -group RX_PCS -group PCS_2 -group PCS2_Descramble -divider inputs
add wave -noupdate -height 30 -expand -group RX -expand -group RX_PCS -group PCS_2 -group PCS2_Descramble -divider outputs
add wave -noupdate -height 30 -expand -group RX -expand -group RX_PCS -group PCS_2 -group PCS2_Descramble -divider {sinais internos}
add wave -noupdate -height 30 -expand -group RX -expand -group RX_PCS -group PCS_2 -group PCS2_Decoder -divider inputs
add wave -noupdate -height 30 -expand -group RX -expand -group RX_PCS -group PCS_2 -group PCS2_Decoder -divider outputs
add wave -noupdate -height 30 -expand -group RX -expand -group RX_PCS -group PCS_3 -group PCS3_Descramble -divider inputs
add wave -noupdate -height 30 -expand -group RX -expand -group RX_PCS -group PCS_3 -group PCS3_Descramble -divider outputs
add wave -noupdate -height 30 -expand -group RX -expand -group RX_PCS -group PCS_3 -group PCS3_Decoder -divider inputs
add wave -noupdate -height 30 -expand -group RX -expand -group RX_PCS -group PCS_3 -group PCS3_Decoder -divider outputs
add wave -noupdate -height 30 -expand -group RX -divider -height 30 {CORE INTERFACE}
add wave -noupdate -height 30 -expand -group RX -expand -group fifo_BRAM -divider <NULL>
add wave -noupdate -height 30 -expand -group RX -expand -group fifo_BRAM -divider <NULL>
add wave -noupdate -height 30 -expand -group RX -expand -group fifo_BRAM -divider <NULL>
add wave -noupdate -height 30 -expand -group RX -expand -group fifo_BRAM -divider dbug
add wave -noupdate -divider -height 30 TX_40
add wave -noupdate -height 40 -group frame_builder -expand -group regs -divider <NULL>
add wave -noupdate -height 40 -group frame_builder -expand -group regs -divider <NULL>
add wave -noupdate -height 40 -group frame_builder -expand -group regs -divider <NULL>
add wave -noupdate -height 40 -group frame_builder -expand -group regs -divider <NULL>
add wave -noupdate -height 40 -group frame_builder -expand -group regs -divider <NULL>
add wave -noupdate -height 40 -group frame_builder -expand -group regs -divider <NULL>
add wave -noupdate -expand -group CRC-S_FIFO -divider <NULL>
add wave -noupdate -expand -group CRC-S_FIFO -divider <NULL>
add wave -noupdate -expand -group CRC-S_FIFO -divider <NULL>
add wave -noupdate -expand -group CRC-S_FIFO -divider <NULL>
add wave -noupdate -expand -group CRC-S_FIFO -divider <NULL>
add wave -noupdate -divider -height 30 TX_PCS
add wave -noupdate -height 30 -group TX_PCS -expand -group PCS_0 -expand -group fifo_0 -divider <NULL>
add wave -noupdate -height 30 -group TX_PCS -expand -group PCS_0 -expand -group scr_0 -divider <NULL>
add wave -noupdate -height 30 -group TX_PCS -divider -height 30 <NULL>
add wave -noupdate -height 30 -group TX_PCS -expand -group PCS_1 -group fifo_1 -divider <NULL>
add wave -noupdate -height 30 -group TX_PCS -divider -height 30 <NULL>
add wave -noupdate -height 30 -group TX_PCS -expand -group PCS_2 -group fifo_2 -divider <NULL>
add wave -noupdate -height 30 -group TX_PCS -divider -height 30 <NULL>
add wave -noupdate -height 30 -group TX_PCS -expand -group PCS_3 -group fifo_3 -divider <NULL>
add wave -noupdate -height 30 -group TX_PCS -divider <NULL>
add wave -noupdate -group {DEBUG SCRAMB} -divider -height 30 10
add wave -noupdate -group {DEBUG SCRAMB} -divider -height 30 40
add wave -noupdate -divider -height 30 {PLOT PYTHON}
add wave -noupdate -divider PCS_RX_40
add wave -noupdate -divider <NULL>
add wave -noupdate -divider <NULL>
add wave -noupdate -label antigo -group ALIG_REMOVAL -divider <NULL>
add wave -noupdate -label antigo -group ALIG_REMOVAL -divider <NULL>
add wave -noupdate -label antigo -group ALIG_REMOVAL -divider <NULL>
add wave -noupdate -label antigo -group ALIG_REMOVAL -divider <NULL>
add wave -noupdate -divider <NULL>
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/pkt_tx_data
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/pkt_tx_eop
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/pkt_tx_mod
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/pkt_tx_sop
add wave -noupdate -group GEN_1 /tb_4xgth/TESTER_0/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/pkt_tx_val
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/pkt_rx_data
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/pkt_rx_eop
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/pkt_rx_mod
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/pkt_rx_sop
add wave -noupdate -group REC_1 /tb_4xgth/TESTER_0/RX_ARCH_INST/inst_echo_receiver/pkt_rx_val
add wave -noupdate -group REC_2 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/pkt_rx_data
add wave -noupdate -group REC_2 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/pkt_rx_eop
add wave -noupdate -group REC_2 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/pkt_rx_mod
add wave -noupdate -group REC_2 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/pkt_rx_sop
add wave -noupdate -group REC_2 /tb_4xgth/TESTER_1/RX_ARCH_INST/inst_echo_receiver/pkt_rx_val
add wave -noupdate -group GEN_2 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/pkt_tx_data
add wave -noupdate -group GEN_2 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/pkt_tx_eop
add wave -noupdate -group GEN_2 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/pkt_tx_mod
add wave -noupdate -group GEN_2 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/pkt_tx_sop
add wave -noupdate -group GEN_2 /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/pkt_tx_val
add wave -noupdate -group REGISTERS /tb_4xgth/TESTER_0/inst_interface_upc/CURRENT_STATE
add wave -noupdate -group REGISTERS /tb_4xgth/TESTER_0/inst_interface_upc/NEXT_STATE
add wave -noupdate -group REGISTERS /tb_4xgth/TESTER_0/inst_interface_upc/registers_q_out
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/clock
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/reset
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/start
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/lfsr_seed
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/valid_seed
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/lfsr_polynomial
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/mac_source
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/mac_destination
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/ip_source
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/ip_destination
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/packet_length
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/timestamp_base
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/time_stamp_flag
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/it_payload
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/payload_cycles
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/pkt_tx_data
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/pkt_tx_val
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/pkt_tx_sop
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/pkt_tx_eop
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/pkt_tx_mod
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/payload_type
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/payload_last_size
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/current_s
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/next_s
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/pkt_tx_data_out
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/pkt_tx_data_N
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/pkt_tx_data_buffer
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/HEADER
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/PAYLOAD
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/PAYLOAD_PKT
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/PAYLOAD_LAST
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/RANDOM
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/SEED
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/IP
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/MAC
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/EOH_SOF
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/ID_COUNTER_L
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/ID_COUNTER_H
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/ALL_ONE
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/ALL_ZERO
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/IDLE_VALUE
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/PKT_COUNTER
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/UPD_INFO
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/start_lfsr
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/preset_lfsr
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/count
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/pkt_split
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/pkt_tx_mod_ctrl
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/pkt_tx_sop_reg
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/pkt_tx_sop_buffer
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/pkt_tx_val_buffer
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/pkt_tx_val_reg
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/last_pkt_delay0
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/last_pkt_delay1
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/last_pkt
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/time_stamp
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/it_mod
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/ip_checksum
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/aux_checksum
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/ip_message_length
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/udp_message_length
add wave -noupdate /tb_4xgth/TESTER_1/TX_ARCH_INST/inst_pkt_creation_mngr/echo_gen_inst/ifg
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {erro1 {10164800 ps} 1} {erro3 {53179200 ps} 1} {erro2 {31668800 ps} 1} {{Cursor 4} {5154405 ps} 0}
quietly wave cursor active 4
configure wave -namecolwidth 284
configure wave -valuecolwidth 147
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
WaveRestoreZoom {5153368 ps} {5183516 ps}
bookmark add wave bookmark5 {{770754 ps} {811500 ps}} 13
bookmark add wave bookmark6 {{780000 ps} {800000 ps}} 8
bookmark add wave bookmark7 {{0 ps} {42010 ps}} 0
bookmark add wave bookmark8 {{201305 ps} {266263 ps}} 7
bookmark add wave bookmark9 {{728057 ps} {794311 ps}} 6
bookmark add wave bookmark10 {{1931987 ps} {1965959 ps}} 9
