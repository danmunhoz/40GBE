RESOURCES=$(shell find ./rtl/ -name *.vhd)
RESOURCES+= $(shell find ./rtl/ -name *.v)

all: clean
all: $(RESOURCES)
	vivado -mode tcl -source make.tcl

debug: clean
debug: $(RESOURCES)
	vivado -mode tcl -source make_debug.tcl

program:
	djtgcfg init -d NetSUME
	dsumecfg write -d NetSUME -f implementation/output_dir/cpu.bit -s 0
	dsumecfg setbootsec -s 0 -d NetSUME
	dsumecfg reconfig -s 0 -d NetSUME

clean:
	cd ./synthesis; make clean
	cd ./implementation; make clean
	rm -rf *.deb
	rm -rf vivado*.log
	rm -rf vivado*.jou
	rm -f fsm_encoding.os
	rm -rf .Xil
	rm -rf .cache
	rm -rf webtalk*
	rm -rf output_dir/*
