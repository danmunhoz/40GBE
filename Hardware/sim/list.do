onerror {resume}
add list /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_0/FIFO_SYNC_MACRO_inst/WRCOUNT 
add list /Top/rx_xgt4/inst_wrapper_macpcs/INST_lane_reorder/fifo_0/FIFO_SYNC_MACRO_inst/RDCOUNT 
configure list -usestrobe 0
configure list -strobestart {0 ps} -strobeperiod {0 ps}
configure list -usesignaltrigger 1
configure list -delta all
configure list -signalnamewidth 0
configure list -datasetprefix 0
configure list -namelimit 5
