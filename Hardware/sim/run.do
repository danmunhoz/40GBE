
if [file exists work] {
    vdel -all
}
vlib work
vmap work work

vmap unisims_ver /soft64/xilinx/ferramentas/ISE/14.6/ISE_DS/ISE/verilog/mti_se/10.3a/lin64/unisims_ver
vmap unimacro_ver /soft64/xilinx/ferramentas/ISE/14.6/ISE_DS/ISE/verilog/mti_se/10.3a/lin64/unimacro_ver
vmap simprims_ver /soft64/xilinx/ferramentas/ISE/14.6/ISE_DS/ISE/verilog/mti_se/10.3a/lin64/simprims_ver
vmap xilinxcorelib /soft64/xilinx/ferramentas/ISE/14.6/ISE_DS/ISE/vhdl/mti_se/10.3a/lin64/xilinxcorelib
vmap xilinxcorelib_ver /soft64/xilinx/ferramentas/ISE/14.6/ISE_DS/ISE/verilog/mti_se/10.3a/lin64/xilinxcorelib_ver
vmap unimacro /soft64/xilinx/ferramentas/ISE/14.6/ISE_DS/ISE/vhdl/mti_se/10.3a/lin64/unimacro
vmap simprim /soft64/xilinx/ferramentas/ISE/14.6/ISE_DS/ISE/vhdl/mti_se/10.3a/lin64/simprim
vmap unisim /soft64/xilinx/ferramentas/ISE/14.6/ISE_DS/ISE/vhdl/mti_se/10.3a/lin64/unisim
#vmap secureip /soft64/xilinx/ferramentas/ISE/14.6/ISE_DS/ISE/verilog/mti_se/10.3a/lin64/secureip

vlog -novopt /soft64/xilinx/ferramentas/Vivado/2016.2/Vivado/2016.2/ids_lite/ISE/verilog/src/glbl.v
vlog -novopt /soft64/xilinx/ferramentas/Vivado/2016.2/Vivado/2016.2/ids_lite/ISE/verilog/src/uni9000/*.v


#vlog -novopt PCS/*.v
vlog -novopt ../rtl/PCS/descramble.v
vlog -novopt ../rtl/PCS/descramble_rx.v
vlog -novopt ../rtl/PCS/tx_path.v
vlog -novopt ../rtl/PCS/tx_path_tx.v
vlog -novopt ../rtl/PCS/RX_FSM.v
vlog -novopt ../rtl/PCS/RX_FSM_rx.v
vlog -novopt ../rtl/PCS/T_TYPE_Encode.v
vlog -novopt ../rtl/PCS/timescale.v
vlog -novopt ../rtl/PCS/XGMII_to_PCS.v
vlog -novopt ../rtl/PCS/opt_fifo_new.v
vlog -novopt ../rtl/PCS/opt_fifo_new_tx.v
vlog -novopt ../rtl/PCS/TX_FSM.v
vlog -novopt ../rtl/PCS/TX_FSM_tx.v
vlog -novopt ../rtl/PCS/defines_PCS.v
vlog -novopt ../rtl/PCS/rx_path.v
vlog -novopt ../rtl/PCS/rx_path_rx.v
vlog -novopt ../rtl/PCS/PCS_to_XGMII.v
vlog -novopt ../rtl/PCS/definitions.v
vlog -novopt ../rtl/PCS/scramble.v
vlog -novopt ../rtl/PCS/scramble_tx.v
vlog -novopt ../rtl/PCS/R_TYPE_Decode.v
vlog -novopt ../rtl/PCS/Encode.v
vlog -novopt ../rtl/PCS/Encode_tx.v
vlog -novopt ../rtl/PCS/Decode.v
vlog -novopt ../rtl/PCS/Decode_rx.v
vlog -novopt ../rtl/PCS/frame_sync.v
vlog -novopt ../rtl/PCS/PCS_core.v
vlog -novopt ../rtl/PCS/PCS_core_rx.v
vcom -novopt ../rtl/PCS/register.vhd

#vlog -novopt MAC/*.v
vlog -novopt ../rtl/MAC/fault_sm.v
vcom -novopt ../rtl/MAC/fault_sm_rx.vhd
vlog -novopt ../rtl/MAC/rx_dequeue.v
vlog -novopt ../rtl/MAC/tx_stats_fifo.v
vlog -novopt ../rtl/MAC/tx_dequeue.v
#vlog -novopt ../rtl/MAC/tx_enqueue_tx.v
vlog -novopt ../rtl/MAC/sync_clk_wb.v
vlog -novopt ../rtl/MAC/stats_sm.v
vlog -novopt ../rtl/MAC/defines.v
vlog -novopt ../rtl/MAC/stats.v
vlog -novopt ../rtl/MAC/generic_mem_small.v
vlog -novopt ../rtl/MAC/rx_data_fifo.v
vlog -novopt ../rtl/MAC/meta_sync_single.v
vlog -novopt ../rtl/MAC/tx_hold_fifo.v
vlog -novopt ../rtl/MAC/rx_hold_fifo.v
vlog -novopt ../rtl/MAC/generic_mem_medium.v
vlog -novopt ../rtl/MAC/meta_sync.v
vlog -novopt ../rtl/MAC/tx_data_fifo.v
vlog -novopt ../rtl/MAC/tx_enqueue.v
vlog -novopt ../rtl/MAC/sync_clk_core.v
vlog -novopt ../rtl/MAC/rx_stats_fifo.v
vlog -novopt ../rtl/MAC/generic_fifo.v
vlog -novopt ../rtl/MAC/wishbone_if.v
vlog -novopt ../rtl/MAC/sync_clk_xgmii_tx.v
vlog -novopt ../rtl/MAC/generic_fifo_ctrl.v
vlog -novopt ../rtl/MAC/rx_enqueue.v
vlog -novopt ../rtl/MAC/rx_enqueue_rx.v
vlog -novopt ../rtl/MAC/xge_mac_rx.v
vlog -novopt ../rtl/MAC/xge_mac.v

vcom -novopt ../rtl/PCS_interface_MAC/defines.vhd
vcom -novopt ../rtl/PCS_interface_MAC/control.vhd
vcom -novopt ../rtl/PCS_interface_MAC/mii_shift_register.vhd
vcom -novopt ../rtl/PCS_interface_MAC/mii_shifter.vhd
vcom -novopt ../rtl/PCS_interface_MAC/ring_fifo.vhd
vcom -novopt ../rtl/PCS_interface_MAC/ring_fifo_bram.vhd
vcom -novopt ../rtl/PCS_interface_MAC/core_interface.vhd

vcom -novopt ../rtl/CRC_RX/CRC32_D8.vhd
vcom -novopt ../rtl/CRC_RX/CRC32_D16.vhd
vcom -novopt ../rtl/CRC_RX/CRC32_D24.vhd
vcom -novopt ../rtl/CRC_RX/CRC32_D32.vhd
vcom -novopt ../rtl/CRC_RX/CRC32_D40.vhd
vcom -novopt ../rtl/CRC_RX/CRC32_D48.vhd
vcom -novopt ../rtl/CRC_RX/CRC32_D56.vhd
vcom -novopt ../rtl/CRC_RX/CRC32_D64.vhd
vcom -novopt ../rtl/CRC_RX/CRC32_D72.vhd
vcom -novopt ../rtl/CRC_RX/CRC32_D80.vhd
vcom -novopt ../rtl/CRC_RX/CRC32_D88.vhd
vcom -novopt ../rtl/CRC_RX/CRC32_D96.vhd
vcom -novopt ../rtl/CRC_RX/CRC32_D104.vhd
vcom -novopt ../rtl/CRC_RX/CRC32_D112.vhd
vcom -novopt ../rtl/CRC_RX/CRC32_D120.vhd
vcom -novopt ../rtl/CRC_RX/CRC32_D128.vhd
vcom -novopt ../rtl/CRC_RX/CRC32_D136.vhd
vcom -novopt ../rtl/CRC_RX/CRC32_D144.vhd
vcom -novopt ../rtl/CRC_RX/CRC32_D152.vhd
vcom -novopt ../rtl/CRC_RX/CRC32_D160.vhd
vcom -novopt ../rtl/CRC_RX/CRC32_D168.vhd
vcom -novopt ../rtl/CRC_RX/CRC32_D176.vhd
vcom -novopt ../rtl/CRC_RX/CRC32_D184.vhd
vcom -novopt ../rtl/CRC_RX/CRC32_D192.vhd
vcom -novopt ../rtl/CRC_RX/CRC32_D200.vhd
vcom -novopt ../rtl/CRC_RX/CRC32_D208.vhd
vcom -novopt ../rtl/CRC_RX/CRC32_D216.vhd
vcom -novopt ../rtl/CRC_RX/CRC32_D224.vhd
vcom -novopt ../rtl/CRC_RX/CRC32_D232.vhd
vcom -novopt ../rtl/CRC_RX/CRC32_D240.vhd
vcom -novopt ../rtl/CRC_RX/CRC32_D248.vhd
vcom -novopt ../rtl/CRC_RX/CRC32_D256.vhd

vcom -novopt ../rtl/CRC_RX/crc_rx.vhd

vcom -novopt ../rtl/MAC/data_frame_fifo.vhd
vcom -novopt ../rtl/MAC/frame_builder.vhd
vcom -novopt ../rtl/MAC/mii_if_SM.vhd
vcom -novopt ../rtl/MAC/mac_tx_path.vhd

# vcom -novopt ../rtl/PCS/pcs_selector.vhd

vcom -novopt ../rtl/PCS/pcs_alignment.vhd
vlog -novopt ../rtl/XGETH_tester/Verilog/wrapper_macpcs.v
vlog -novopt ../rtl/XGETH_tester/Verilog/wrapper_macpcs_rx.v

vcom -novopt ../rtl/XGETH_tester/VHD/lfsr.vhd
vcom -novopt ../rtl/XGETH_tester/VHD/txsequence_counter.vhd
vcom -novopt ../rtl/XGETH_tester/VHD/echo_generator.vhd
vcom -novopt ../rtl/XGETH_tester/VHD/LFSR_GEN.vhd
vcom -novopt ../rtl/XGETH_tester/VHD/LFSR_REC.vhd
vcom -novopt ../rtl/XGETH_tester/VHD/loopback.vhd
vcom -novopt ../rtl/XGETH_tester/VHD/loopback_v2.vhd
vcom -novopt ../rtl/XGETH_tester/VHD/echo_generator_256.vhd
vcom -novopt ../rtl/XGETH_tester/VHD/echo_receiver_128_v2.vhd
vcom -novopt ../rtl/XGETH_tester/VHD/pkt_creation_mngr.vhd

vcom -novopt tx_xgt4.vhd
vcom -novopt rx_xgt4.vhd
vcom -novopt ../rtl/PCS/shuffle.vhd
vcom -novopt ../rtl/PCS/bip_calculator.vhd
vcom -novopt ../rtl/PCS/reorder_fifo.vhd
vcom -novopt ../rtl/PCS/lane_reordering.vhd


scgenmod tx_xgt4 > tx_xgt4.h
scgenmod rx_xgt4 > rx_xgt4.h
scgenmod lane_reorder > lane_reorder.h
scgenmod shuffle > shuffle.h


sccom dump_output.cpp
sccom pkt_buffer.cpp
sccom pkt_buffer_tx40.cpp
sccom fiber.cpp
sccom app_tx.cpp
sccom -novopt -g sc_tb.cpp
sccom -link -B/usr/bin/

vsim -novopt -L unisims_ver -L unimacro_ver -L simprims_ver \
-L secureip -L xilinxcorelib work.glbl \
work.Top -t 1ps

do wave.do
#do wave_matheus.do

run 50 us
#run 200 us

exec cp lane0.txt lane0_rx.txt
exec cp lane1.txt lane1_rx.txt
exec cp lane2.txt lane2_rx.txt
exec cp lane3.txt lane3_rx.txt

exec cp lane0_tx40.txt lane0_rx40.txt
exec cp lane1_tx40.txt lane1_rx40.txt
exec cp lane2_tx40.txt lane2_rx40.txt
exec cp lane3_tx40.txt lane3_rx40.txt

exec cp dump_mii_tx.txt dump_app.txt

do list.do
#exit
