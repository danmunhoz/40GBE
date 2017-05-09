set outputDir ./output_dir

start_gui
open_hw
connect_hw_server
open_hw_target
current_hw_device [lindex [get_hw_devices] 0]
set_property PROGRAM.FILE $outputDir/cpu.bit [lindex [get_hw_devices] 0]
set_property PROBES.FILE {../synthesis/output_dir/probes.ltx} [lindex [get_hw_devices] 0]
program_hw_devices [lindex [get_hw_devices] 0]
refresh_hw_device [lindex [get_hw_devices] 0]
set ila [lindex [get_hw_ilas] 0]
set_property CONTROL.TRIGGER_POSITION 0 $ila

run_hw_ila $ila
wait_on_hw_ila $ila
current_hw_ila_data [upload_hw_ila_data $ila]
display_hw_ila_data [current_hw_ila_data]
