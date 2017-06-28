onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -childformat {{/Top/rx_xgt4/inst_lane_reorder/barreira_skew.data_0 -radix hexadecimal} {/Top/rx_xgt4/inst_lane_reorder/barreira_skew.data_1 -radix hexadecimal} {/Top/rx_xgt4/inst_lane_reorder/barreira_skew.data_2 -radix hexadecimal} {/Top/rx_xgt4/inst_lane_reorder/barreira_skew.data_3 -radix hexadecimal} {/Top/rx_xgt4/inst_lane_reorder/barreira_skew.header_0 -radix binary -childformat {{/Top/rx_xgt4/inst_lane_reorder/barreira_skew.header_0(1) -radix binary} {/Top/rx_xgt4/inst_lane_reorder/barreira_skew.header_0(0) -radix binary}}} {/Top/rx_xgt4/inst_lane_reorder/barreira_skew.header_1 -radix binary} {/Top/rx_xgt4/inst_lane_reorder/barreira_skew.header_2 -radix binary} {/Top/rx_xgt4/inst_lane_reorder/barreira_skew.header_3 -radix binary} {/Top/rx_xgt4/inst_lane_reorder/barreira_skew.logical_lane_0 -radix unsigned} {/Top/rx_xgt4/inst_lane_reorder/barreira_skew.logical_lane_1 -radix unsigned} {/Top/rx_xgt4/inst_lane_reorder/barreira_skew.logical_lane_2 -radix unsigned} {/Top/rx_xgt4/inst_lane_reorder/barreira_skew.logical_lane_3 -radix unsigned}} -expand -subitemconfig {/Top/rx_xgt4/inst_lane_reorder/barreira_skew.data_0 {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_lane_reorder/barreira_skew.data_1 {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_lane_reorder/barreira_skew.data_2 {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_lane_reorder/barreira_skew.data_3 {-height 16 -radix hexadecimal} /Top/rx_xgt4/inst_lane_reorder/barreira_skew.header_0 {-height 16 -radix binary -childformat {{/Top/rx_xgt4/inst_lane_reorder/barreira_skew.header_0(1) -radix binary} {/Top/rx_xgt4/inst_lane_reorder/barreira_skew.header_0(0) -radix binary}}} /Top/rx_xgt4/inst_lane_reorder/barreira_skew.header_0(1) {-height 16 -radix binary} /Top/rx_xgt4/inst_lane_reorder/barreira_skew.header_0(0) {-height 16 -radix binary} /Top/rx_xgt4/inst_lane_reorder/barreira_skew.header_1 {-height 16 -radix binary} /Top/rx_xgt4/inst_lane_reorder/barreira_skew.header_2 {-height 16 -radix binary} /Top/rx_xgt4/inst_lane_reorder/barreira_skew.header_3 {-height 16 -radix binary} /Top/rx_xgt4/inst_lane_reorder/barreira_skew.logical_lane_0 {-height 16 -radix unsigned} /Top/rx_xgt4/inst_lane_reorder/barreira_skew.logical_lane_1 {-height 16 -radix unsigned} /Top/rx_xgt4/inst_lane_reorder/barreira_skew.logical_lane_2 {-height 16 -radix unsigned} /Top/rx_xgt4/inst_lane_reorder/barreira_skew.logical_lane_3 {-height 16 -radix unsigned}} /Top/rx_xgt4/inst_lane_reorder/barreira_skew
add wave -noupdate -expand -group bip_calculator_0 /Top/rx_xgt4/inst_lane_reorder/bip_calculator_0/clk
add wave -noupdate -expand -group bip_calculator_0 /Top/rx_xgt4/inst_lane_reorder/bip_calculator_0/rst
add wave -noupdate -expand -group bip_calculator_0 -radix hexadecimal /Top/rx_xgt4/inst_lane_reorder/bip_calculator_0/data_in
add wave -noupdate -expand -group bip_calculator_0 -radix binary /Top/rx_xgt4/inst_lane_reorder/bip_calculator_0/header_in
add wave -noupdate -expand -group bip_calculator_0 /Top/rx_xgt4/inst_lane_reorder/bip_calculator_0/enable
add wave -noupdate -expand -group bip_calculator_0 /Top/rx_xgt4/inst_lane_reorder/bip_calculator_0/is_sync
add wave -noupdate -expand -group bip_calculator_0 /Top/rx_xgt4/inst_lane_reorder/bip_calculator_0/bip_ok
add wave -noupdate -expand -group bip_calculator_0 /Top/rx_xgt4/inst_lane_reorder/bip_calculator_0/bip_calc
add wave -noupdate -expand -group bip_calculator_0 /Top/rx_xgt4/inst_lane_reorder/bip_calculator_0/bip_calc_old
add wave -noupdate -expand -group bip_calculator_0 /Top/rx_xgt4/inst_lane_reorder/bip_calculator_0/bip3_old
add wave -noupdate -expand -group bip_calculator_0 /Top/rx_xgt4/inst_lane_reorder/bip_calculator_0/bip3_old_old
add wave -noupdate -expand -group bip_calculator_0 /Top/rx_xgt4/inst_lane_reorder/bip_calculator_0/bip_comp
add wave -noupdate -group bip_calculator_1 /Top/rx_xgt4/inst_lane_reorder/bip_calculator_1/clk
add wave -noupdate -group bip_calculator_1 /Top/rx_xgt4/inst_lane_reorder/bip_calculator_1/rst
add wave -noupdate -group bip_calculator_1 /Top/rx_xgt4/inst_lane_reorder/bip_calculator_1/data_in
add wave -noupdate -group bip_calculator_1 /Top/rx_xgt4/inst_lane_reorder/bip_calculator_1/header_in
add wave -noupdate -group bip_calculator_1 /Top/rx_xgt4/inst_lane_reorder/bip_calculator_1/enable
add wave -noupdate -group bip_calculator_1 /Top/rx_xgt4/inst_lane_reorder/bip_calculator_1/is_sync
add wave -noupdate -group bip_calculator_1 /Top/rx_xgt4/inst_lane_reorder/bip_calculator_1/bip_ok
add wave -noupdate -group bip_calculator_2 /Top/rx_xgt4/inst_lane_reorder/bip_calculator_2/clk
add wave -noupdate -group bip_calculator_2 /Top/rx_xgt4/inst_lane_reorder/bip_calculator_2/rst
add wave -noupdate -group bip_calculator_2 /Top/rx_xgt4/inst_lane_reorder/bip_calculator_2/data_in
add wave -noupdate -group bip_calculator_2 /Top/rx_xgt4/inst_lane_reorder/bip_calculator_2/header_in
add wave -noupdate -group bip_calculator_2 /Top/rx_xgt4/inst_lane_reorder/bip_calculator_2/enable
add wave -noupdate -group bip_calculator_2 /Top/rx_xgt4/inst_lane_reorder/bip_calculator_2/is_sync
add wave -noupdate -group bip_calculator_2 /Top/rx_xgt4/inst_lane_reorder/bip_calculator_2/bip_ok
add wave -noupdate -group bip_calculator_3 /Top/rx_xgt4/inst_lane_reorder/bip_calculator_3/clk
add wave -noupdate -group bip_calculator_3 /Top/rx_xgt4/inst_lane_reorder/bip_calculator_3/rst
add wave -noupdate -group bip_calculator_3 /Top/rx_xgt4/inst_lane_reorder/bip_calculator_3/data_in
add wave -noupdate -group bip_calculator_3 /Top/rx_xgt4/inst_lane_reorder/bip_calculator_3/header_in
add wave -noupdate -group bip_calculator_3 /Top/rx_xgt4/inst_lane_reorder/bip_calculator_3/enable
add wave -noupdate -group bip_calculator_3 /Top/rx_xgt4/inst_lane_reorder/bip_calculator_3/is_sync
add wave -noupdate -group bip_calculator_3 /Top/rx_xgt4/inst_lane_reorder/bip_calculator_3/bip_ok
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {406433 ps} 0} {{Cursor 2} {2396 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 426
configure wave -valuecolwidth 189
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {350149 ps} {411589 ps}
