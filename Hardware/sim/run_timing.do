
if [file exists work] {
    vdel -all
}
vlib work
vmap work work

#Compiling macros
vlog -novopt /soft64/xilinx/ferramentas/Vivado/2016.2/Vivado/2016.2/ids_lite/ISE/verilog/src/glbl.v
vmap secureip /soft64/xilinx/ferramentas/ISE/14.6/ISE_DS/ISE/verilog/mti_se/10.3a/lin64/secureip
vmap unisim /soft64/xilinx/ferramentas/ISE/14.6/ISE_DS/ISE/vhdl/mti_se/10.3a/lin64/unisim
vmap unimacro /soft64/xilinx/ferramentas/ISE/14.6/ISE_DS/ISE/vhdl/mti_se/10.3a/lin64/unimacro
vmap unisims_ver /soft64/xilinx/ferramentas/ISE/14.6/ISE_DS/ISE/verilog/mti_se/10.3a/lin64/unisims_ver
vmap unimacro_ver /soft64/xilinx/ferramentas/ISE/14.6/ISE_DS/ISE/verilog/mti_se/10.3a/lin64/unimacro_ver
vmap simprim /soft64/xilinx/ferramentas/ISE/14.6/ISE_DS/ISE/vhdl/mti_se/10.3a/lin64/simprim
vmap simprims_ver /soft64/xilinx/ferramentas/ISE/14.6/ISE_DS/ISE/verilog/mti_se/10.3a/lin64/simprims_ver
vmap xilinxcorelib /soft64/xilinx/ferramentas/ISE/14.6/ISE_DS/ISE/vhdl/mti_se/10.3a/lin64/xilinxcorelib
vmap xilinxcorelib_ver /soft64/xilinx/ferramentas/ISE/14.6/ISE_DS/ISE/verilog/mti_se/10.3a/lin64/xilinxcorelib_ver

##Compiling macros

#vlog -novopt /soft64/xilinx/ferramentas/Vivado/2016.2/Vivado/2016.2/ids_lite/ISE/verilog/src/uni9000/*.v
#vlog -novopt /soft64/xilinx/ferramentas/Vivado/2016.2/Vivado/2016.2/ids_lite/ISE/verilog/src/unimacro/*.v
#vlog -novopt /soft64/xilinx/ferramentas/Vivado/2016.2/Vivado/2016.2/ids_lite/ISE/verilog/src/simprims/*.v
#vcom -novopt /soft64/xilinx/ferramentas/Vivado/2016.2/Vivado/2016.2/ids_lite/ISE/vhdl/src/unisims/*.vhd
#vcom -novopt /soft64/xilinx/ferramentas/Vivado/2016.2/Vivado/2016.2/ids_lite/ISE/vhdl/src/unimacro/*.vhd
#vlog -novopt /soft64/xilinx/ferramentas/Vivado/2016.2/Vivado/2016.2/ids_lite/ISE/verilog/src/unisims/*.v

#gtwizard
#vcom -novopt ../rtl/gtwizard/gtwizard_0_clock_module.vhd
#vcom -novopt ../rtl/gtwizard/gtwizard_0_common_reset.vhd
#vcom -novopt ../rtl/gtwizard/gtwizard_0_common.vhd
#vcom -novopt ../rtl/gtwizard/gtwizard_0_gt_usrclk_source.vhd
#vcom -novopt ../rtl/gtwizard/gtwizard_0_support.vhd

vlog -novopt ../implementation/output_dir/cpu_impl_netlist.v

scgenmod area_timing_wrapper > area_timing_wrapper.h

sccom dump_output.cpp
sccom scoreboard.cpp
sccom pkt_buffer.cpp
sccom fiber.cpp
sccom -g sc_tb_timing.cpp
sccom -link -B/usr/bin/

#exec "sed -i '/INVERTED/d' ../implementation/output_dir/cpu_impl_netlist.v"

vsim -voptargs=+acc=lprn+notimingchecks -L unisims_ver -L unimacro_ver -L simprims_ver \
-L secureip -L xilinxcorelib work.glbl \
-sdftyp ../implementation/output_dir/cpu_impl_netlist.sdf -sdfnowarn -sdfnoerror \
work.Top -t 1ps


#vsim -voptargs=+acc=lprn -L unisims_ver -L unimacro_ver -L simprims_ver -L unisim -L unimacro -L simprim -L secureip -L xilinxcorelib_ver -L xilinxcorelib work.glbl -sdftyp ../implementation/output_dir/cpu_impl_netlist.sdf work.Top -t 1ps


#vsim -novopt work.glbl  work.Top -t 1ps
# -sdfnowarn

do wave.do
run 1000 ns
