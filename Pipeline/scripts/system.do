onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/imemload
add wave -noupdate -group iiif /system_tb/DUT/CPU/DP/iiif/flush
add wave -noupdate -group iiif /system_tb/DUT/CPU/DP/iiif/stall
add wave -noupdate -group iiif /system_tb/DUT/CPU/DP/iiif/en
add wave -noupdate /system_tb/DUT/CPU/DP/iiif/out_instr
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/flush
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/stall
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/en
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/out_halt
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/out_RegDst
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/out_rt
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/out_rd
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/cuif/ALUSrc
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/out_ALUSrc
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/out_RegWr
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/out_Branch
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/out_ALUOp
add wave -noupdate -expand -group ieif -color {Violet Red} /system_tb/DUT/CPU/DP/ieif/out_MemRead
add wave -noupdate /system_tb/DUT/CPU/DP/ieif/out_instr
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/flush
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/stall
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/en
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/out_RegWr
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/out_MemToReg
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/out_Branch
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/out_MemWrite
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/out_JumpAddr
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/out_npc
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/out_BranchAddr
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/out_rdat1
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/out_rdat2
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/out_zero
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/out_PortOut
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/out_wsel
add wave -noupdate -expand -group emif -color {Violet Red} /system_tb/DUT/CPU/DP/emif/out_MemRead
add wave -noupdate /system_tb/DUT/CPU/DP/emif/out_instr
add wave -noupdate -group mwif /system_tb/DUT/CPU/DP/mwif/flush
add wave -noupdate -group mwif /system_tb/DUT/CPU/DP/mwif/out_RegWr
add wave -noupdate -group mwif /system_tb/DUT/CPU/DP/mwif/out_MemToReg
add wave -noupdate -group mwif /system_tb/DUT/CPU/DP/mwif/out_instr
add wave -noupdate -group mwif /system_tb/DUT/CPU/DP/mwif/out_dmemload
add wave -noupdate -group mwif /system_tb/DUT/CPU/DP/mwif/out_npc
add wave -noupdate -group mwif /system_tb/DUT/CPU/DP/mwif/out_PortOut
add wave -noupdate -group mwif /system_tb/DUT/CPU/DP/mwif/out_wsel
add wave -noupdate -group mwif /system_tb/DUT/CPU/DP/mwif/out_jal
add wave -noupdate -group mwif /system_tb/DUT/CPU/DP/mwif/out_halt
add wave -noupdate -group mwif /system_tb/DUT/CPU/DP/mwif/out_lui
add wave -noupdate -group mwif /system_tb/DUT/CPU/DP/mwif/stall
add wave -noupdate -group mwif /system_tb/DUT/CPU/DP/mwif/en
add wave -noupdate /system_tb/DUT/CPU/DP/mwif/out_instr
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/WEN
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/wsel
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/rsel1
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/rsel2
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/wdat
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/rdat1
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/rdat2
add wave -noupdate -group ramif /system_tb/DUT/RAM/ramif/ramREN
add wave -noupdate -group ramif /system_tb/DUT/RAM/ramif/ramWEN
add wave -noupdate -group ramif /system_tb/DUT/RAM/ramif/ramaddr
add wave -noupdate -group ramif /system_tb/DUT/RAM/ramif/ramstore
add wave -noupdate -group ramif /system_tb/DUT/RAM/ramif/ramload
add wave -noupdate -group ramif /system_tb/DUT/RAM/ramif/ramstate
add wave -noupdate -group ramif /system_tb/DUT/RAM/ramif/memREN
add wave -noupdate -group ramif /system_tb/DUT/RAM/ramif/memWEN
add wave -noupdate -group ramif /system_tb/DUT/RAM/ramif/memaddr
add wave -noupdate -group ramif /system_tb/DUT/RAM/ramif/memstore
add wave -noupdate -group ccif /system_tb/DUT/CPU/CC/ccif/iwait
add wave -noupdate -group ccif /system_tb/DUT/CPU/CC/ccif/dwait
add wave -noupdate -group ccif /system_tb/DUT/CPU/CC/ccif/iREN
add wave -noupdate -group ccif /system_tb/DUT/CPU/CC/ccif/dREN
add wave -noupdate -group ccif /system_tb/DUT/CPU/CC/ccif/dWEN
add wave -noupdate -group ccif /system_tb/DUT/CPU/CC/ccif/iload
add wave -noupdate -group ccif /system_tb/DUT/CPU/CC/ccif/dload
add wave -noupdate -group ccif /system_tb/DUT/CPU/CC/ccif/dstore
add wave -noupdate -group ccif /system_tb/DUT/CPU/CC/ccif/iaddr
add wave -noupdate -group ccif /system_tb/DUT/CPU/CC/ccif/daddr
add wave -noupdate -group ccif /system_tb/DUT/CPU/CC/ccif/ramWEN
add wave -noupdate -group ccif /system_tb/DUT/CPU/CC/ccif/ramREN
add wave -noupdate -group ccif /system_tb/DUT/CPU/CC/ccif/ramstate
add wave -noupdate -group ccif /system_tb/DUT/CPU/CC/ccif/ramaddr
add wave -noupdate -group ccif /system_tb/DUT/CPU/CC/ccif/ramstore
add wave -noupdate -group ccif /system_tb/DUT/CPU/CC/ccif/ramload
add wave -noupdate /system_tb/DUT/CPU/DP/JumpAddr
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/BranchAddr
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/ihit
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/dhit
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/imemREN
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/imemload
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/imemaddr
add wave -noupdate -expand -group dpif -color {Violet Red} /system_tb/DUT/CPU/DP/dpif/dmemREN
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/dmemWEN
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/flushed
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/dmemload
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/dmemstore
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/dmemaddr
add wave -noupdate -group cuif -color {Medium Violet Red} /system_tb/DUT/CPU/DP/cuif/dREN
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/dWEN
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/instr
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/rs
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/rt
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/rd
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/aluop
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/ALUSrc
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/RegDst
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/MemReg
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/RegWEN
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/dWEN
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/dREN
add wave -noupdate /system_tb/DUT/CPU/DP/huif/exmem_flush
add wave -noupdate -group huif /system_tb/DUT/CPU/DP/HU/opcode
add wave -noupdate -group huif /system_tb/DUT/CPU/DP/huif/idex_RegWr
add wave -noupdate -group huif /system_tb/DUT/CPU/DP/huif/exmem_RegWr
add wave -noupdate -group huif /system_tb/DUT/CPU/DP/huif/idex_MemRead
add wave -noupdate -group huif /system_tb/DUT/CPU/DP/huif/exmem_MemRead
add wave -noupdate -group huif /system_tb/DUT/CPU/DP/huif/idex_wsel
add wave -noupdate -group huif /system_tb/DUT/CPU/DP/huif/exmem_wsel
add wave -noupdate -group huif /system_tb/DUT/CPU/DP/huif/ifid_rs
add wave -noupdate -group huif /system_tb/DUT/CPU/DP/huif/ifid_rt
add wave -noupdate -group huif /system_tb/DUT/CPU/DP/huif/idex_rt
add wave -noupdate -group huif /system_tb/DUT/CPU/DP/huif/idex_rd
add wave -noupdate -group huif /system_tb/DUT/CPU/DP/huif/ifid_stall
add wave -noupdate -group huif /system_tb/DUT/CPU/DP/huif/idex_stall
add wave -noupdate -group huif /system_tb/DUT/CPU/DP/huif/ifid_flush
add wave -noupdate -group huif /system_tb/DUT/CPU/DP/huif/exmem_stall
add wave -noupdate -group huif /system_tb/DUT/CPU/DP/huif/idex_flush
add wave -noupdate -group huif /system_tb/DUT/CPU/DP/huif/exmem_flush
add wave -noupdate -group pcif /system_tb/DUT/CPU/DP/dpif/ihit
add wave -noupdate -group pcif /system_tb/DUT/CPU/DP/pcif/PCEN
add wave -noupdate -group pcif /system_tb/DUT/CPU/DP/pcif/npc
add wave -noupdate -group pcif /system_tb/DUT/CPU/DP/pcif/pc
add wave -noupdate -group pcif /system_tb/DUT/CPU/DP/pcif/NewPC
add wave -noupdate -group forward /system_tb/DUT/CPU/DP/fuif/idex_instr
add wave -noupdate -group forward /system_tb/DUT/CPU/DP/fuif/exmem_wsel
add wave -noupdate -group forward /system_tb/DUT/CPU/DP/fuif/memwb_wsel
add wave -noupdate -group forward /system_tb/DUT/CPU/DP/fuif/exmem_RegWr
add wave -noupdate -group forward /system_tb/DUT/CPU/DP/fuif/memwb_RegWr
add wave -noupdate -group forward /system_tb/DUT/CPU/DP/fuif/forwardA
add wave -noupdate -group forward /system_tb/DUT/CPU/DP/fuif/forwardB
add wave -noupdate -group forward /system_tb/DUT/CPU/DP/FU/idex_rs
add wave -noupdate -group forward /system_tb/DUT/CPU/DP/FU/idex_rt
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/aluif/PortA
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/aluif/PortB
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/aluif/PortOut
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/aluif/Negative
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/aluif/Overflow
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/aluif/Zero
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/aluif/ALUOP
add wave -noupdate /system_tb/DUT/CPU/DP/ALUSrcMuxOut
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {418463 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 235
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
WaveRestoreZoom {153993 ps} {593986 ps}
