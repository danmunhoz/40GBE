all: clean
	vivado -mode batch -source run_synth.tcl
	vivado -mode batch -source run_place.tcl -tclargs post_synth.dcp

debug: clean
	vivado -mode batch -source run_synth.tcl
	vivado -mode batch -source run_debug.tcl
	vivado -mode batch -source run_place.tcl -tclargs post_debug.dcp

clean:
	rm -rf vivado*.log
	rm -rf vivado*.jou
	rm -f fsm_encoding.os
	rm -rf .Xil
	rm -rf .cache
	rm -rf webtalk*
	rm -rf output_dir/*
