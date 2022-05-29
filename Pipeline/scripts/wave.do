onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/imemload
add wave -noupdate -expand -group iiif /system_tb/DUT/CPU/DP/iiif/out_instr
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/flush
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/stall
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/out_halt
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/out_RegDst
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/out_ALUSrc
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/out_RegWr
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/out_Branch
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/out_ALUOp
add wave -noupdate /system_tb/DUT/CPU/DP/ieif/out_instr
add wave -noupdate /system_tb/DUT/CPU/DP/ieif/in_halt
add wave -noupdate /system_tb/DUT/CPU/DP/ieif/out_halt
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/flush
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/stall
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/out_RegWr
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/out_MemToReg
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/out_Branch
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/out_MemRead
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/out_MemWrite
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/out_JumpAddr
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/out_npc
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/out_BranchAddr
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/out_rdat1
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/out_rdat2
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/out_zero
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/out_PortOut
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/out_wsel
add wave -noupdate /system_tb/DUT/CPU/DP/emif/out_instr
add wave -noupdate /system_tb/DUT/CPU/DP/emif/out_halt
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/WEN
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/wsel
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/rsel1
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/rsel2
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/wdat
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/rdat1
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/rdat2
add wave -noupdate -expand -group pcif /system_tb/DUT/CPU/DP/dpif/ihit
add wave -noupdate -expand -group pcif /system_tb/DUT/CPU/DP/pcif/PCEN
add wave -noupdate -expand -group pcif /system_tb/DUT/CPU/DP/pcif/npc
add wave -noupdate -expand -group pcif /system_tb/DUT/CPU/DP/pcif/pc
add wave -noupdate -expand -group pcif /system_tb/DUT/CPU/DP/pcif/NewPC
add wave -noupdate -group ccif /system_tb/DUT/CPU/CC/ccif/iREN
add wave -noupdate -group ccif /system_tb/DUT/CPU/CC/ccif/dREN
add wave -noupdate -group ccif /system_tb/DUT/CPU/CC/ccif/dWEN
add wave -noupdate -group ccif /system_tb/DUT/CPU/CC/ccif/ramstate
add wave -noupdate -group ccif /system_tb/DUT/CPU/CC/ccif/iwait
add wave -noupdate -group ramif /system_tb/DUT/RAM/ramif/ramREN
add wave -noupdate -group ramif /system_tb/DUT/RAM/ramif/ramWEN
add wave -noupdate -group ramif /system_tb/DUT/RAM/addr
add wave -noupdate -group ramif /system_tb/DUT/RAM/ramif/ramaddr
add wave -noupdate -group ramif /system_tb/DUT/RAM/ramif/ramstore
add wave -noupdate -group ramif /system_tb/DUT/RAM/ramif/ramload
add wave -noupdate -group ramif /system_tb/DUT/RAM/ramif/ramstate
add wave -noupdate -group ramif /system_tb/DUT/RAM/ramif/memREN
add wave -noupdate -group ramif /system_tb/DUT/RAM/ramif/memWEN
add wave -noupdate -group ramif /system_tb/DUT/RAM/ramif/memaddr
add wave -noupdate -group ramif /system_tb/DUT/RAM/count
add wave -noupdate -group ramif /system_tb/DUT/RAM/ramif/memstore
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/halt
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/halt
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP/dpif/ihit
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP/dpif/dhit
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP/dpif/imemREN
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP/dpif/imemload
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP/dpif/imemaddr
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP/dpif/datomic
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP/dpif/dmemREN
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP/dpif/dmemWEN
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP/dpif/flushed
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP/dpif/dmemload
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP/dpif/dmemstore
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP/dpif/dmemaddr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {629505 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {434 ns} {744 ns}
