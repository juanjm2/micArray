onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /testbench/s2_clk
add wave -noupdate -radix hexadecimal /testbench/sample_ready
add wave -noupdate -radix hexadecimal /testbench/sample_aud
add wave -noupdate -radix hexadecimal /testbench/output_sample
add wave -noupdate -radix hexadecimal /testbench/float_val
add wave -noupdate -radix hexadecimal /testbench/top/fsm/s2_result
add wave -noupdate -radix hexadecimal /testbench/top/fsm/s2_dataa
add wave -noupdate -radix hexadecimal /testbench/top/fsm/s2_datab
add wave -noupdate -radix hexadecimal /testbench/top/fsm/s2_n
add wave -noupdate -radix hexadecimal /testbench/top/fsm/s2_start
add wave -noupdate -radix hexadecimal /testbench/top/fsm/s2_done
add wave -noupdate -radix hexadecimal /testbench/top/fsm/state
add wave -noupdate -radix hexadecimal /testbench/top/inst/s2_result
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {115559 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 232
configure wave -valuecolwidth 100
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
WaveRestoreZoom {66429 ps} {509297 ps}
