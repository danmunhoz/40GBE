
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

#vlog -novopt PCS/*.v
vlog -novopt ../rtl/PCS/descramble.v
vlog -novopt ../rtl/PCS/tx_path.v
vlog -novopt ../rtl/PCS/RX_FSM.v
vlog -novopt ../rtl/PCS/T_TYPE_Encode.v
vlog -novopt ../rtl/PCS/timescale.v
vlog -novopt ../rtl/PCS/XGMII_to_PCS.v
vlog -novopt ../rtl/PCS/opt_fifo_new.v
vlog -novopt ../rtl/PCS/TX_FSM.v
vlog -novopt ../rtl/PCS/defines_PCS.v
vlog -novopt ../rtl/PCS/rx_path.v
vlog -novopt ../rtl/PCS/PCS_to_XGMII.v
vlog -novopt ../rtl/PCS/definitions.v
vlog -novopt ../rtl/PCS/scramble.v
vlog -novopt ../rtl/PCS/R_TYPE_Decode.v
vlog -novopt ../rtl/PCS/Encode.v
vlog -novopt ../rtl/PCS/Decode.v
vlog -novopt ../rtl/PCS/frame_sync.v
vlog -novopt ../rtl/PCS/PCS_core.v

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
vlog -novopt ../rtl/MAC/xge_mac.v

vlog -novopt ../rtl/XGETH_tester/Verilog/wrapper_macpcs.v
vlog -novopt ../rtl/XGETH_tester/Verilog/wrapper_macpcs_rx.v

vcom -novopt ../rtl/XGETH_tester/VHD/lfsr.vhd
vcom -novopt ../rtl/XGETH_tester/VHD/txsequence_counter.vhd
vcom -novopt ../rtl/XGETH_tester/VHD/echo_generator.vhd

vcom -novopt tb_xgt4.vhd
vcom -novopt rx_xgt4.vhd

scgenmod tb_xgt4 > tb_xgt4.h
scgenmod rx_xgt4 > rx_xgt4.h

sccom -novopt -g sc_tb.cpp
sccom -link -B/usr/bin/

vsim -novopt work.glbl work.Top -t 1ps

do wave.do
run 300 ns
