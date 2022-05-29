onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate -expand -group dp0 /system_tb/DUT/CPU/DP0/iiif/out_instr
add wave -noupdate -expand -group dp0 /system_tb/DUT/CPU/DP0/ieif/out_instr
add wave -noupdate -expand -group dp0 /system_tb/DUT/CPU/DP0/emif/out_instr
add wave -noupdate -expand -group dp0 /system_tb/DUT/CPU/DP0/mwif/out_instr
add wave -noupdate -expand -group dp0 /system_tb/DUT/CPU/dcif0/imemload
add wave -noupdate -expand -group dp0 /system_tb/DUT/CPU/dcif0/imemaddr
add wave -noupdate -expand -group dp0 /system_tb/DUT/CPU/dcif0/dmemload
add wave -noupdate -expand -group dp0 /system_tb/DUT/CPU/dcif0/dmemstore
add wave -noupdate -expand -group dp0 /system_tb/DUT/CPU/dcif0/dmemaddr
add wave -noupdate -expand -group dp0 /system_tb/DUT/CPU/dcif0/halt
add wave -noupdate -expand -group dp0 /system_tb/DUT/CPU/dcif0/ihit
add wave -noupdate -expand -group dp0 /system_tb/DUT/CPU/dcif0/dhit
add wave -noupdate -expand -group dp0 /system_tb/DUT/CPU/dcif0/dmemREN
add wave -noupdate -expand -group dp0 /system_tb/DUT/CPU/dcif0/dmemWEN
add wave -noupdate -expand -group dp0 /system_tb/DUT/CPU/dcif0/imemREN
add wave -noupdate -group dp1 /system_tb/DUT/CPU/DP1/iiif/out_instr
add wave -noupdate -group dp1 /system_tb/DUT/CPU/DP1/ieif/out_instr
add wave -noupdate -group dp1 /system_tb/DUT/CPU/DP1/emif/out_instr
add wave -noupdate -group dp1 /system_tb/DUT/CPU/DP1/mwif/out_instr
add wave -noupdate -group dp1 /system_tb/DUT/CPU/dcif1/imemREN
add wave -noupdate -group dp1 /system_tb/DUT/CPU/dcif1/imemload
add wave -noupdate -group dp1 /system_tb/DUT/CPU/dcif1/imemaddr
add wave -noupdate -group dp1 /system_tb/DUT/CPU/dcif1/dhit
add wave -noupdate -group dp1 /system_tb/DUT/CPU/dcif1/dmemREN
add wave -noupdate -group dp1 /system_tb/DUT/CPU/dcif1/dmemWEN
add wave -noupdate -group dp1 /system_tb/DUT/CPU/dcif1/dmemload
add wave -noupdate -group dp1 /system_tb/DUT/CPU/dcif1/dmemstore
add wave -noupdate -group dp1 /system_tb/DUT/CPU/dcif1/dmemaddr
add wave -noupdate -group dp1 /system_tb/DUT/CPU/dcif1/halt
add wave -noupdate -group dp1 /system_tb/DUT/CPU/dcif1/ihit
add wave -noupdate -group ramif /system_tb/DUT/RAM/ramif/ramREN
add wave -noupdate -group ramif -color {Dark Orchid} /system_tb/DUT/RAM/ramif/ramWEN
add wave -noupdate -group ramif /system_tb/DUT/RAM/ramif/ramaddr
add wave -noupdate -group ramif /system_tb/DUT/RAM/ramif/ramstore
add wave -noupdate -group ramif /system_tb/DUT/RAM/ramif/ramload
add wave -noupdate -group ramif /system_tb/DUT/RAM/ramif/ramstate
add wave -noupdate -group ramif /system_tb/DUT/RAM/ramif/memREN
add wave -noupdate -group ramif /system_tb/DUT/RAM/ramif/memWEN
add wave -noupdate -group ramif /system_tb/DUT/RAM/ramif/memaddr
add wave -noupdate -group ramif /system_tb/DUT/RAM/ramif/memstore
add wave -noupdate -group ram /system_tb/DUT/RAM/count
add wave -noupdate -group ram /system_tb/DUT/RAM/rstate
add wave -noupdate -group ram /system_tb/DUT/RAM/q
add wave -noupdate -group ram /system_tb/DUT/RAM/wren
add wave -noupdate -group ram /system_tb/DUT/RAM/en
add wave -noupdate -group ram /system_tb/DUT/CPU/CC/ccif/daddr
add wave -noupdate -group ram /system_tb/DUT/RAM/addr
add wave -noupdate -group ram /system_tb/DUT/CPU/CC/ccif/ramaddr
add wave -noupdate -group ram /system_tb/DUT/CPU/CC/ccif/ramWEN
add wave -noupdate -group cif0 /system_tb/DUT/CPU/cif0/iwait
add wave -noupdate -group cif0 /system_tb/DUT/CPU/cif0/dwait
add wave -noupdate -group cif0 /system_tb/DUT/CPU/cif0/iREN
add wave -noupdate -group cif0 /system_tb/DUT/CPU/cif0/dREN
add wave -noupdate -group cif0 /system_tb/DUT/CPU/cif0/dWEN
add wave -noupdate -group cif0 /system_tb/DUT/CPU/cif0/iload
add wave -noupdate -group cif0 /system_tb/DUT/CPU/cif0/dload
add wave -noupdate -group cif0 /system_tb/DUT/CPU/cif0/dstore
add wave -noupdate -group cif0 /system_tb/DUT/CPU/cif0/iaddr
add wave -noupdate -group cif0 /system_tb/DUT/CPU/cif0/daddr
add wave -noupdate -group cif0 /system_tb/DUT/CPU/cif0/ccwait
add wave -noupdate -group cif0 /system_tb/DUT/CPU/cif0/ccinv
add wave -noupdate -group cif0 /system_tb/DUT/CPU/cif0/ccwrite
add wave -noupdate -group cif0 /system_tb/DUT/CPU/cif0/cctrans
add wave -noupdate -group cif0 /system_tb/DUT/CPU/cif0/ccsnoopaddr
add wave -noupdate -group cif1 /system_tb/DUT/CPU/cif1/iwait
add wave -noupdate -group cif1 /system_tb/DUT/CPU/cif1/dwait
add wave -noupdate -group cif1 /system_tb/DUT/CPU/cif1/iREN
add wave -noupdate -group cif1 /system_tb/DUT/CPU/cif1/dREN
add wave -noupdate -group cif1 /system_tb/DUT/CPU/cif1/dWEN
add wave -noupdate -group cif1 /system_tb/DUT/CPU/cif1/iload
add wave -noupdate -group cif1 /system_tb/DUT/CPU/cif1/dload
add wave -noupdate -group cif1 /system_tb/DUT/CPU/cif1/dstore
add wave -noupdate -group cif1 /system_tb/DUT/CPU/cif1/iaddr
add wave -noupdate -group cif1 /system_tb/DUT/CPU/cif1/daddr
add wave -noupdate -group cif1 /system_tb/DUT/CPU/cif1/ccwait
add wave -noupdate -group cif1 /system_tb/DUT/CPU/cif1/ccinv
add wave -noupdate -group cif1 /system_tb/DUT/CPU/cif1/ccwrite
add wave -noupdate -group cif1 /system_tb/DUT/CPU/cif1/cctrans
add wave -noupdate -group cif1 /system_tb/DUT/CPU/cif1/ccsnoopaddr
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/halt
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/ihit
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/imemREN
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/imemload
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/imemaddr
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/dhit
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/datomic
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/dmemREN
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/dmemWEN
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/flushed
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/dmemload
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/dmemstore
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/dmemaddr
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/halt
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/ihit
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/imemREN
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/imemload
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/imemaddr
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/dhit
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/datomic
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/dmemREN
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/dmemWEN
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/flushed
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/dmemload
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/dmemstore
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/dmemaddr
add wave -noupdate -group memory_control /system_tb/DUT/CPU/CC/state
add wave -noupdate -group memory_control /system_tb/DUT/CPU/CC/next_state
add wave -noupdate -group memory_control /system_tb/DUT/CPU/CC/cpu
add wave -noupdate -group memory_control /system_tb/DUT/CPU/CC/next_cpu
add wave -noupdate -group memory_control /system_tb/DUT/CPU/CC/icpu
add wave -noupdate -group memory_control /system_tb/DUT/CPU/CC/next_icpu
add wave -noupdate -group memory_control /system_tb/DUT/CPU/CC/cpu0
add wave -noupdate -group memory_control /system_tb/DUT/CPU/CC/next_cpu0
add wave -noupdate -group icache0 /system_tb/DUT/CPU/CM0/ICACHE/cache_table
add wave -noupdate -group icache0 /system_tb/DUT/CPU/CM0/ICACHE/imemaddr
add wave -noupdate -group icache0 /system_tb/DUT/CPU/CM0/ICACHE/index
add wave -noupdate -group icache0 /system_tb/DUT/CPU/CM0/ICACHE/hit_en
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/CLK
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/nRST
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/state
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/next_state
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/set
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/dcache_addr
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/hit1
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/hit2
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/miss
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/count
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/next_count
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/flush_row
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/next_flush_row
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/flush_c
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/next_flush_c
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/s_index
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/s_tag
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/s_valid0
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/s_valid1
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/s_valid_tag
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/s_tag0
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/s_tag1
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/s_frame
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/next_s_frame
add wave -noupdate -group icache1 /system_tb/DUT/CPU/CM1/ICACHE/cache_table
add wave -noupdate -group icache1 /system_tb/DUT/CPU/CM1/ICACHE/imemaddr
add wave -noupdate -group icache1 /system_tb/DUT/CPU/CM1/ICACHE/index
add wave -noupdate -group icache1 /system_tb/DUT/CPU/CM1/ICACHE/hit_en
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/CLK
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/nRST
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/state
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/next_state
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/set
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/dcache_addr
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/hit1
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/hit2
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/miss
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/count
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/next_count
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/flush_row
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/next_flush_row
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/flush_c
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/next_flush_c
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/s_index
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/s_tag
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/s_valid0
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/s_valid1
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/s_valid_tag
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/s_tag0
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/s_tag1
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/s_frame
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/next_s_frame
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {83113 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 166
configure wave -valuecolwidth 208
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
WaveRestoreZoom {0 ps} {636567 ps}
