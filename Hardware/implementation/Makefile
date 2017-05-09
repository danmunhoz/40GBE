all: clean
	vivado -mode batch -source run_implementation.tcl

debug: clean all
	vivado -mode batch -source run_debug.tcl


clean:
	rm -rf vivado*.jou
	rm -rf vivado*.debug
	rm -rf vivado*.str
	rm -rf webtalk*
	rm -rf *.btree
	rm -rf *.log
	rm -rf .Xil
	rm -rf .cache
	rm -rf .sim
	rm -rf output_dir/*
