onerror {resume}
#add list /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_0/FIFO_SYNC_MACRO_inst/WRCOUNT
#add list /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_0/FIFO_SYNC_MACRO_inst/RDCOUNT
#add list /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_1/FIFO_SYNC_MACRO_inst/WRCOUNT
#add list /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_1/FIFO_SYNC_MACRO_inst/RDCOUNT
#add list /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_2/FIFO_SYNC_MACRO_inst/WRCOUNT
#add list /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_2/FIFO_SYNC_MACRO_inst/RDCOUNT
#add list /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_3/FIFO_SYNC_MACRO_inst/WRCOUNT
#add list /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_3/FIFO_SYNC_MACRO_inst/RDCOUNT
add list /Top/tb_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_TX_PATH_FIFO/wr_count
add list /Top/tb_xgt4/inst_wrapper_macpcs/INST_PCS_core/INST_tx_path/INST_TX_PATH_FIFO/rd_count
add list /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/wr_count
add list /Top/rx_xgt4/inst_wrapper_macpcs/INST_0_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/rd_count
add list /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/wr_count
add list /Top/rx_xgt4/inst_wrapper_macpcs/INST_1_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/rd_count
add list /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/wr_count
add list /Top/rx_xgt4/inst_wrapper_macpcs/INST_2_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/rd_count
add list /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/wr_count
add list /Top/rx_xgt4/inst_wrapper_macpcs/INST_3_PCS_core/INST_rx_path/INST_RX_PATH_FIFO/rd_count
#add list /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/w_ptr
#add list /Top/rx_xgt4/inst_wrapper_macpcs/INST_core_interface/fifo_b/r_ptr_h
configure list -usestrobe 0
configure list -strobestart {0 ps} -strobeperiod {0 ps}
configure list -usesignaltrigger 1
configure list -delta all
configure list -signalnamewidth 0
configure list -datasetprefix 0
configure list -namelimit 5

exec rm -f tests/list.lst

write list -window .main_pane.list.interior.cs.body -events tests/list.lst

#exec python tests/plot.py
