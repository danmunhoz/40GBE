set device       "xc7vx690t"
set package      "ffg1761"
set speed        "-3"
set part         $device$package$speed


#
# STEP#1: define the output directory area.

set outputDir ./output_dir
file mkdir $outputDir
#
# STEP#2: setup design sources and constraints

#read_vhdl [ glob ../rtl/GTH_tester.vhd ]
read_vhdl [ glob ../rtl/gtwizard/*.vhd ]
read_vhdl [ glob ../rtl/I2C/*.vhd ]
read_vhdl [ glob ../rtl/SerialInterface/*.vhd ]
read_vhdl [ glob ../rtl/utils/*.vhd ]
read_vhdl [ glob ../rtl/XGETH_tester/VHD/*.vhd ]
read_vhdl [ glob ../rtl/PCS_interface_MAC/*.vhd ]
read_vhdl [ glob ../rtl/PCS/*.vhd ]
read_ip [ glob ../rtl/ip/gtwizard_0/gtwizard_0.xci ]
read_ip [ glob ../rtl/ip/pcie3_7x_0/pcie3_7x_0.xci ]
read_verilog [ glob ../rtl/MAC/*.v ]
read_verilog [ glob ../rtl/PCIe/*.v ]
read_verilog [ glob ../rtl/PCS/*.v ]
read_verilog [ glob ../rtl/utils/*.v ]
read_verilog [ glob ../rtl/XGETH_tester/Verilog/*.v ]
read_vhdl [ glob ../rtl/area_timing_wrapper.vhd ]
read_xdc ../constraint/constraints.xdc


#
# STEP#3: run synthesis, write design checkpoint, report timing,
# and utilization estimates

# NAO USAR A LINHA SEGUINTE PARA GERAR .bit
set_property SEVERITY {Warning} [get_drc_checks NSTD-1]
set_property SEVERITY {Warning} [get_drc_checks UCIO-1]

#synth_design -top GTH_tester -flatten_hierarchy none -fanout_limit 50 -fsm_extraction one_hot -no_lc -part $part

synth_design -top area_timing_wrapper -flatten_hierarchy none -fanout_limit 50 -fsm_extraction one_hot -no_lc -part $part

write_checkpoint -force $outputDir/post_synth.dcp
report_timing_summary -file $outputDir/post_synth_timing_summary.rpt
report_utilization -file $outputDir/post_synth_util.rpt

# Run custom script to report critical timing paths
reportCriticalPaths $outputDir/post_synth_critpath_report.csv
