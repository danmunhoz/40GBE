set outputDir ./output_dir
file mkdir $outputDir

# STEP#5: run the router, write the post-route design checkpoint, report the routing
# status, report timing, power, and DRC, and finally save the Verilog netlist.

route_design
##
## Optionally run optimization if there are timing violations after placement
if {[get_property SLACK [get_timing_paths -max_paths 1 -nworst 1 -setup]] < 0.3} {
 puts "Found setup timing violations => running post route physical optimization"
 phys_opt_design
}
write_checkpoint -force $outputDir/post_route.dcp
report_route_status -file $outputDir/post_route_status.rpt
report_timing_summary -file $outputDir/post_route_timing_summary.rpt
report_power -file $outputDir/post_route_power.rpt
report_drc -file $outputDir/post_imp_drc.rpt

#write_verilog -force $outputDir/cpu_impl_netlist.v -mode timesim -sdf_anno true
#-include_xilinx_libs


write_sdf -force $outputDir/cpu_impl_netlist.sdf -mode timesim

write_verilog -force $outputDir/cpu_impl_netlist.v -mode design


#
# STEP#6: generate a bitstream

write_bitstream -force $outputDir/cpu.bit
#exit
