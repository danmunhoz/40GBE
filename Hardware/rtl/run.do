
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
vlog -novopt PCS/descramble.v
vlog -novopt PCS/tx_path.v
vlog -novopt PCS/RX_FSM.v
vlog -novopt PCS/T_TYPE_Encode.v
vlog -novopt PCS/timescale.v
vlog -novopt PCS/XGMII_to_PCS.v
vlog -novopt PCS/opt_fifo_new.v
vlog -novopt PCS/TX_FSM.v
vlog -novopt PCS/defines_PCS.v
vlog -novopt PCS/rx_path.v
vlog -novopt PCS/PCS_to_XGMII.v
vlog -novopt PCS/definitions.v
vlog -novopt PCS/scramble.v
vlog -novopt PCS/R_TYPE_Decode.v
vlog -novopt PCS/Encode.v
vlog -novopt PCS/Decode.v
vlog -novopt PCS/frame_sync.v
vlog -novopt PCS/PCS_core.v

#vlog -novopt MAC/*.v
vlog -novopt MAC/fault_sm.v
vlog -novopt MAC/rx_dequeue.v
vlog -novopt MAC/tx_stats_fifo.v
vlog -novopt MAC/tx_dequeue.v
vlog -novopt MAC/sync_clk_wb.v
vlog -novopt MAC/stats_sm.v
vlog -novopt MAC/defines.v
vlog -novopt MAC/stats.v
vlog -novopt MAC/generic_mem_small.v
vlog -novopt MAC/rx_data_fifo.v
vlog -novopt MAC/meta_sync_single.v
vlog -novopt MAC/tx_hold_fifo.v
vlog -novopt MAC/rx_hold_fifo.v
vlog -novopt MAC/generic_mem_medium.v
vlog -novopt MAC/meta_sync.v
vlog -novopt MAC/tx_data_fifo.v
vlog -novopt MAC/tx_enqueue.v
vlog -novopt MAC/sync_clk_core.v
vlog -novopt MAC/rx_stats_fifo.v
vlog -novopt MAC/generic_fifo.v
vlog -novopt MAC/wishbone_if.v
vlog -novopt MAC/sync_clk_xgmii_tx.v
vlog -novopt MAC/generic_fifo_ctrl.v
vlog -novopt MAC/rx_enqueue.v
vlog -novopt MAC/xge_mac.v

vlog -novopt XGETH_tester/Verilog/wrapper_macpcs.v
vlog -novopt XGETH_tester/Verilog/wrapper_macpcs_rx.v

vcom -novopt XGETH_tester/VHD/lfsr.vhd
vcom -novopt XGETH_tester/VHD/txsequence_counter.vhd
vcom -novopt XGETH_tester/VHD/echo_generator.vhd

vcom -novopt tb_xgt4.vhd
vcom -novopt rx_xgt4.vhd

scgenmod tb_xgt4 > tb_xgt4.h
scgenmod rx_xgt4 > rx_xgt4.h

sccom -novopt -g sc_tb.cpp
sccom -link -B/usr/bin/

vsim -novopt work.glbl work.Top -t 1ps

do wave.do
run 300 ns
