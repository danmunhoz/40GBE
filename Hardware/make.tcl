source ./tclLib/config.tcl
source ./tclLib/compareSignals.tcl
source ./tclLib/reportCriticalPaths.tcl

cd synthesis
source run_synth.tcl
source run_place.tcl

cd ../implementation
source run_implementation.tcl
