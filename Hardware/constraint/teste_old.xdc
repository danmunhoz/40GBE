################################################################################



## This file is a general .xdc for the NetFPGA SUME Rev. C
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project
## Note: DDR, QDR, and GTH Transceiver constraints are not included with this document. See applicable reference
##       projects on www.netfpga.org for information on using these components

##The following two properties should be set for every design
set_property CFGBVS GND [current_design]
set_property CONFIG_VOLTAGE 1.8 [current_design]

# PadFunction: IO_L13P_T2_MRCC_38
#set_property VCCAUX_IO DONTCARE [get_ports SYSCLK_IN_P]
#set_property IOSTANDARD DIFF_SSTL15 [get_ports SYSCLK_IN_P]

# PadFunction: IO_L13N_T2_MRCC_38
#set_property IOSTANDARD DIFF_SSTL15 [get_ports clk_156]
#set_property PACKAGE_PIN G18 [get_ports clk_156]
#set_property PACKAGE_PIN H19 [get_ports clk_312]

################################## RefClk Location constraints #####################
set_property PACKAGE_PIN E10 [get_ports clk_156]
set_property PACKAGE_PIN E9 [get_ports clk_312]


#CLOCK PARA GERAR TIMING DO WRAPPER... SOMENTE ########################################
create_clock -add -name clk_156 -period 6.4 -waveform {0 3.2} [get_ports clk_156]
create_clock -add -name clk_312 -period 3.2 -waveform {0 1.6} [get_ports clk_312]

#create_clock -add -name clk_xgmii_rx -period 6.4 -waveform {0 3.2}
#create_clock -add -name clk_xgmii_tx -period 6.4 -waveform {0 3.2}
#create_clock -add -name tx_clk_161_13 -period 6.2 -waveform {0 3.1}
#create_clock -add -name rx_clk_161_13 -period 6.2 -waveform {0 3.1}
#######################################################################################

set_false_path -from [get_clocks clk_156] -to [get_clocks clk_312]
set_false_path -from [get_clocks clk_312] -to [get_clocks clk_156]
