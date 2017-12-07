
if [file exists work] {
    vdel -all
}
vlib work

#Compiling macros
vlog -novopt /soft64/xilinx/ferramentas/Vivado/2016.2/Vivado/2016.2/ids_lite/ISE/verilog/src/*.v
vlog -novopt /soft64/xilinx/ferramentas/Vivado/2016.2/Vivado/2016.2/ids_lite/ISE/verilog/src/uni9000/*.v
vlog -novopt /soft64/xilinx/ferramentas/Vivado/2016.2/Vivado/2016.2/ids_lite/ISE/verilog/src/unimacro/*.v
vlog -novopt /soft64/xilinx/ferramentas/Vivado/2016.2/Vivado/2016.2/ids_lite/ISE/verilog/src/unisims/*.v
vlog -novopt /soft64/xilinx/ferramentas/Vivado/2016.2/Vivado/2016.2/ids_lite/ISE/verilog/src/simprims/*.v
vcom -novopt /soft64/xilinx/ferramentas/Vivado/2016.2/Vivado/2016.2/ids_lite/ISE/vhdl/src/unisims/*.vhd
vcom -novopt /soft64/xilinx/ferramentas/Vivado/2016.2/Vivado/2016.2/ids_lite/ISE/vhdl/src/unimacro/*.vhd

#vlog -novopt PCS/*.v
vlog -novopt ../rtl/PCS/descramble.v
vlog -novopt ../rtl/PCS/descramble_rx.v
vlog -novopt ../rtl/PCS/tx_path.v
vlog -novopt ../rtl/PCS/RX_FSM.v
vlog -novopt ../rtl/PCS/RX_FSM_rx.v
vlog -novopt ../rtl/PCS/T_TYPE_Encode.v
vlog -novopt ../rtl/PCS/timescale.v
vlog -novopt ../rtl/PCS/XGMII_to_PCS.v
vlog -novopt ../rtl/PCS/opt_fifo_new.v
vlog -novopt ../rtl/PCS/TX_FSM.v
vlog -novopt ../rtl/PCS/defines_PCS.v
vlog -novopt ../rtl/PCS/rx_path.v
vlog -novopt ../rtl/PCS/rx_path_rx.v
vlog -novopt ../rtl/PCS/PCS_to_XGMII.v
vlog -novopt ../rtl/PCS/definitions.v
vlog -novopt ../rtl/PCS/scramble.v
vlog -novopt ../rtl/PCS/R_TYPE_Decode.v
vlog -novopt ../rtl/PCS/Encode.v
vlog -novopt ../rtl/PCS/Decode.v
vlog -novopt ../rtl/PCS/Decode_rx.v
vlog -novopt ../rtl/PCS/frame_sync.v
vlog -novopt ../rtl/PCS/PCS_core.v
vlog -novopt ../rtl/PCS/PCS_core_rx.v
vcom -novopt ../rtl/PCS/register.vhd

#vlog -novopt MAC/*.v
vlog -novopt ../rtl/MAC/fault_sm.v
vlog -novopt ../rtl/MAC/rx_dequeue.v
vlog -novopt ../rtl/MAC/tx_stats_fifo.v
vlog -novopt ../rtl/MAC/tx_dequeue.v
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

vcom -novopt ../rtl/PCS/pcs_selector.vhd

vlog -novopt ../rtl/XGETH_tester/Verilog/wrapper_macpcs.v
vlog -novopt ../rtl/XGETH_tester/Verilog/wrapper_macpcs_rx.v

vcom -novopt ../rtl/XGETH_tester/VHD/lfsr.vhd
vcom -novopt ../rtl/XGETH_tester/VHD/txsequence_counter.vhd
vcom -novopt ../rtl/XGETH_tester/VHD/echo_generator.vhd

vcom -novopt tb_xgt4.vhd
vcom -novopt rx_xgt4.vhd
vcom -novopt ../rtl/PCS/shuffle.vhd
vcom -novopt ../rtl/PCS/bip_calculator.vhd
vcom -novopt ../rtl/PCS/reorder_fifo.vhd
vcom -novopt ../rtl/PCS/lane_reordering.vhd
vcom -novopt ../rtl/CRC_RX/CRC32_D8.vhd
vcom -novopt ../rtl/CRC_RX/CRC32_D64.vhd
vcom -novopt ../rtl/CRC_RX/CRC32_D128.vhd


scgenmod tb_xgt4 > tb_xgt4.h
scgenmod rx_xgt4 > rx_xgt4.h
scgenmod lane_reorder > lane_reorder.h
scgenmod shuffle > shuffle.h


sccom dump_output.cpp
sccom scoreboard.cpp
sccom pkt_buffer.cpp
sccom fiber.cpp
sccom -novopt -g sc_tb.cpp
sccom -link -B/usr/bin/

vsim -novopt work.glbl work.Top -t 1ps

do wave.do
# do wave_interface_fifo.do
run 30000 ns

exec cp lane0.txt lane0_rx.txt
exec cp lane1.txt lane1_rx.txt
exec cp lane2.txt lane2_rx.txt
exec cp lane3.txt lane3_rx.txt

exit
