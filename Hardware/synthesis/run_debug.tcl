set outputDir ./output_dir
# STEP#3.5(OPTIONAL): inserts debug cores and signals to the
# project

create_debug_core u_ila_0 ila

#set debug core properties
set_property C_DATA_DEPTH 4096 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]

set debug_nets [get_nets -hierarchical -top_net_of_hierarchical_group -filter {MARK_DEBUG==1}]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list clk_156 ]]
set_property port_width [llength $debug_nets] [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [lsort -command compareSignals $debug_nets]

write_checkpoint -force $outputDir/post_debug.dcp
write_debug_probes -force $outputDir/probes.ltx
