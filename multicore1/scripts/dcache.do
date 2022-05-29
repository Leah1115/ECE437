onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /dcache_tb/CLK
add wave -noupdate /dcache_tb/nRST
add wave -noupdate /dcache_tb/PROG/testcase
add wave -noupdate -group cif /dcache_tb/cif/iwait
add wave -noupdate -group cif /dcache_tb/cif/dwait
add wave -noupdate -group cif /dcache_tb/cif/iREN
add wave -noupdate -group cif /dcache_tb/cif/dREN
add wave -noupdate -group cif /dcache_tb/cif/dWEN
add wave -noupdate -group cif /dcache_tb/cif/iload
add wave -noupdate -group cif /dcache_tb/cif/dload
add wave -noupdate -group cif /dcache_tb/cif/dstore
add wave -noupdate -group cif /dcache_tb/cif/iaddr
add wave -noupdate -group cif /dcache_tb/cif/daddr
add wave -noupdate -group cif /dcache_tb/cif/ccwait
add wave -noupdate -group cif /dcache_tb/cif/ccinv
add wave -noupdate -group cif /dcache_tb/cif/ccwrite
add wave -noupdate -group cif /dcache_tb/cif/cctrans
add wave -noupdate -group cif /dcache_tb/cif/ccsnoopaddr
add wave -noupdate -color Red /dcache_tb/DUT/state
add wave -noupdate /dcache_tb/DUT/next_state
add wave -noupdate /dcache_tb/DUT/set
add wave -noupdate /dcache_tb/DUT/cache_table
add wave -noupdate /dcache_tb/DUT/dcache_addr
add wave -noupdate /dcache_tb/DUT/miss
add wave -noupdate /dcache_tb/DUT/hit1
add wave -noupdate /dcache_tb/DUT/hit2
add wave -noupdate /dcache_tb/DUT/count
add wave -noupdate /dcache_tb/DUT/next_count
add wave -noupdate /dcache_tb/DUT/flush_row
add wave -noupdate /dcache_tb/DUT/next_flush_row
add wave -noupdate /dcache_tb/DUT/s_frame
add wave -noupdate /dcache_tb/DUT/next_s_frame
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {593 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 264
configure wave -justifyvalue left
configure wave -signalnamewidth 1
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
WaveRestoreZoom {568 ns} {647 ns}
