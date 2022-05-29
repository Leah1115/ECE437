onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /dcache_tb/CLK
add wave -noupdate /dcache_tb/nRST
add wave -noupdate /dcache_tb/PROG/tbcif/dwait
add wave -noupdate -radix decimal /dcache_tb/PROG/test
add wave -noupdate -expand -group dcif /dcache_tb/PROG/tbdcif/dhit
add wave -noupdate -expand -group dcif /dcache_tb/PROG/tbdcif/dmemREN
add wave -noupdate -expand -group dcif /dcache_tb/PROG/tbdcif/dmemWEN
add wave -noupdate -expand -group dcif /dcache_tb/PROG/tbdcif/flushed
add wave -noupdate -expand -group dcif /dcache_tb/PROG/tbdcif/dmemload
add wave -noupdate -expand -group dcif /dcache_tb/PROG/tbdcif/dmemstore
add wave -noupdate -expand -group dcif /dcache_tb/PROG/tbdcif/dmemaddr
add wave -noupdate -expand -group cif /dcache_tb/PROG/tbcif/dREN
add wave -noupdate -expand -group cif /dcache_tb/PROG/tbcif/dWEN
add wave -noupdate -expand -group cif /dcache_tb/PROG/tbcif/dload
add wave -noupdate -expand -group cif /dcache_tb/PROG/tbcif/dstore
add wave -noupdate -expand -group cif -radix hexadecimal -childformat {{{/dcache_tb/PROG/tbcif/daddr[31]} -radix hexadecimal} {{/dcache_tb/PROG/tbcif/daddr[30]} -radix hexadecimal} {{/dcache_tb/PROG/tbcif/daddr[29]} -radix hexadecimal} {{/dcache_tb/PROG/tbcif/daddr[28]} -radix hexadecimal} {{/dcache_tb/PROG/tbcif/daddr[27]} -radix hexadecimal} {{/dcache_tb/PROG/tbcif/daddr[26]} -radix hexadecimal} {{/dcache_tb/PROG/tbcif/daddr[25]} -radix hexadecimal} {{/dcache_tb/PROG/tbcif/daddr[24]} -radix hexadecimal} {{/dcache_tb/PROG/tbcif/daddr[23]} -radix hexadecimal} {{/dcache_tb/PROG/tbcif/daddr[22]} -radix hexadecimal} {{/dcache_tb/PROG/tbcif/daddr[21]} -radix hexadecimal} {{/dcache_tb/PROG/tbcif/daddr[20]} -radix hexadecimal} {{/dcache_tb/PROG/tbcif/daddr[19]} -radix hexadecimal} {{/dcache_tb/PROG/tbcif/daddr[18]} -radix hexadecimal} {{/dcache_tb/PROG/tbcif/daddr[17]} -radix hexadecimal} {{/dcache_tb/PROG/tbcif/daddr[16]} -radix hexadecimal} {{/dcache_tb/PROG/tbcif/daddr[15]} -radix hexadecimal} {{/dcache_tb/PROG/tbcif/daddr[14]} -radix hexadecimal} {{/dcache_tb/PROG/tbcif/daddr[13]} -radix hexadecimal} {{/dcache_tb/PROG/tbcif/daddr[12]} -radix hexadecimal} {{/dcache_tb/PROG/tbcif/daddr[11]} -radix hexadecimal} {{/dcache_tb/PROG/tbcif/daddr[10]} -radix hexadecimal} {{/dcache_tb/PROG/tbcif/daddr[9]} -radix hexadecimal} {{/dcache_tb/PROG/tbcif/daddr[8]} -radix hexadecimal} {{/dcache_tb/PROG/tbcif/daddr[7]} -radix hexadecimal} {{/dcache_tb/PROG/tbcif/daddr[6]} -radix hexadecimal} {{/dcache_tb/PROG/tbcif/daddr[5]} -radix hexadecimal} {{/dcache_tb/PROG/tbcif/daddr[4]} -radix hexadecimal} {{/dcache_tb/PROG/tbcif/daddr[3]} -radix hexadecimal} {{/dcache_tb/PROG/tbcif/daddr[2]} -radix hexadecimal} {{/dcache_tb/PROG/tbcif/daddr[1]} -radix hexadecimal} {{/dcache_tb/PROG/tbcif/daddr[0]} -radix hexadecimal}} -subitemconfig {{/dcache_tb/PROG/tbcif/daddr[31]} {-radix hexadecimal} {/dcache_tb/PROG/tbcif/daddr[30]} {-radix hexadecimal} {/dcache_tb/PROG/tbcif/daddr[29]} {-radix hexadecimal} {/dcache_tb/PROG/tbcif/daddr[28]} {-radix hexadecimal} {/dcache_tb/PROG/tbcif/daddr[27]} {-radix hexadecimal} {/dcache_tb/PROG/tbcif/daddr[26]} {-radix hexadecimal} {/dcache_tb/PROG/tbcif/daddr[25]} {-radix hexadecimal} {/dcache_tb/PROG/tbcif/daddr[24]} {-radix hexadecimal} {/dcache_tb/PROG/tbcif/daddr[23]} {-radix hexadecimal} {/dcache_tb/PROG/tbcif/daddr[22]} {-radix hexadecimal} {/dcache_tb/PROG/tbcif/daddr[21]} {-radix hexadecimal} {/dcache_tb/PROG/tbcif/daddr[20]} {-radix hexadecimal} {/dcache_tb/PROG/tbcif/daddr[19]} {-radix hexadecimal} {/dcache_tb/PROG/tbcif/daddr[18]} {-radix hexadecimal} {/dcache_tb/PROG/tbcif/daddr[17]} {-radix hexadecimal} {/dcache_tb/PROG/tbcif/daddr[16]} {-radix hexadecimal} {/dcache_tb/PROG/tbcif/daddr[15]} {-radix hexadecimal} {/dcache_tb/PROG/tbcif/daddr[14]} {-radix hexadecimal} {/dcache_tb/PROG/tbcif/daddr[13]} {-radix hexadecimal} {/dcache_tb/PROG/tbcif/daddr[12]} {-radix hexadecimal} {/dcache_tb/PROG/tbcif/daddr[11]} {-radix hexadecimal} {/dcache_tb/PROG/tbcif/daddr[10]} {-radix hexadecimal} {/dcache_tb/PROG/tbcif/daddr[9]} {-radix hexadecimal} {/dcache_tb/PROG/tbcif/daddr[8]} {-radix hexadecimal} {/dcache_tb/PROG/tbcif/daddr[7]} {-radix hexadecimal} {/dcache_tb/PROG/tbcif/daddr[6]} {-radix hexadecimal} {/dcache_tb/PROG/tbcif/daddr[5]} {-radix hexadecimal} {/dcache_tb/PROG/tbcif/daddr[4]} {-radix hexadecimal} {/dcache_tb/PROG/tbcif/daddr[3]} {-radix hexadecimal} {/dcache_tb/PROG/tbcif/daddr[2]} {-radix hexadecimal} {/dcache_tb/PROG/tbcif/daddr[1]} {-radix hexadecimal} {/dcache_tb/PROG/tbcif/daddr[0]} {-radix hexadecimal}} /dcache_tb/PROG/tbcif/daddr
add wave -noupdate -color Red /dcache_tb/DUT/state
add wave -noupdate /dcache_tb/DUT/next_state
add wave -noupdate /dcache_tb/DUT/set
add wave -noupdate -subitemconfig {{/dcache_tb/DUT/cache_table[6].frame1} -expand {/dcache_tb/DUT/cache_table[1]} -expand} /dcache_tb/DUT/cache_table
add wave -noupdate /dcache_tb/DUT/dcache_addr
add wave -noupdate /dcache_tb/DUT/miss
add wave -noupdate /dcache_tb/DUT/hit1
add wave -noupdate /dcache_tb/DUT/hit2
add wave -noupdate /dcache_tb/DUT/count
add wave -noupdate /dcache_tb/DUT/next_count
add wave -noupdate /dcache_tb/DUT/flush_row
add wave -noupdate /dcache_tb/DUT/next_flush_row
add wave -noupdate /dcache_tb/DUT/flush_col
add wave -noupdate /dcache_tb/DUT/next_flush_col
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
WaveRestoreZoom {568 ns} {693 ns}
