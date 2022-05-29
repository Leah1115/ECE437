onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/imemload
add wave -noupdate -group iiif /system_tb/DUT/CPU/DP/iiif/flush
add wave -noupdate -group iiif /system_tb/DUT/CPU/DP/iiif/stall
add wave -noupdate -group iiif /system_tb/DUT/CPU/DP/iiif/en
add wave -noupdate /system_tb/DUT/CPU/DP/iiif/out_instr
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/flush
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/stall
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/en
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/out_halt
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/out_RegDst
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/out_rt
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/out_rd
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/cuif/ALUSrc
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/out_ALUSrc
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/out_RegWr
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/out_Branch
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/out_ALUOp
add wave -noupdate -group ieif -color {Violet Red} /system_tb/DUT/CPU/DP/ieif/out_MemRead
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/in_rdat2
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/out_rdat2
add wave -noupdate /system_tb/DUT/CPU/DP/ieif/out_instr
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/flush
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/stall
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/en
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/out_RegWr
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/out_MemToReg
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/out_Branch
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/out_MemWrite
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/out_JumpAddr
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/out_npc
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/out_BranchAddr
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/out_rdat1
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/out_rdat2
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/out_zero
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/out_PortOut
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/out_wsel
add wave -noupdate -group emif -color {Violet Red} /system_tb/DUT/CPU/DP/emif/out_MemRead
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
add wave -noupdate -group dcif /system_tb/DUT/CPU/dcif/halt
add wave -noupdate -group dcif /system_tb/DUT/CPU/dcif/ihit
add wave -noupdate -group dcif /system_tb/DUT/CPU/dcif/imemREN
add wave -noupdate -group dcif /system_tb/DUT/CPU/dcif/imemload
add wave -noupdate -group dcif /system_tb/DUT/CPU/dcif/imemaddr
add wave -noupdate -group dcif /system_tb/DUT/CPU/dcif/dhit
add wave -noupdate -group dcif /system_tb/DUT/CPU/dcif/datomic
add wave -noupdate -group dcif /system_tb/DUT/CPU/dcif/dmemREN
add wave -noupdate -group dcif /system_tb/DUT/CPU/dcif/dmemWEN
add wave -noupdate -group dcif /system_tb/DUT/CPU/dcif/flushed
add wave -noupdate -group dcif /system_tb/DUT/CPU/dcif/dmemstore
add wave -noupdate /system_tb/DUT/CPU/dcif/dmemaddr
add wave -noupdate /system_tb/DUT/CPU/dcif/dmemload
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/WEN
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/wsel
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/rsel1
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/rsel2
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/wdat
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/rdat1
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/rdat2
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
add wave -noupdate -group ccif /system_tb/DUT/CPU/CC/ccif/iwait
add wave -noupdate -group ccif /system_tb/DUT/CPU/CC/ccif/dwait
add wave -noupdate -group ccif /system_tb/DUT/CPU/CC/ccif/iREN
add wave -noupdate -group ccif /system_tb/DUT/CPU/CC/ccif/dREN
add wave -noupdate -group ccif /system_tb/DUT/CPU/CC/ccif/dWEN
add wave -noupdate -group ccif /system_tb/DUT/CPU/CC/ccif/iload
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/daddr
add wave -noupdate -group ccif /system_tb/DUT/CPU/CC/ccif/dload
add wave -noupdate -group ccif /system_tb/DUT/CPU/CC/ccif/dstore
add wave -noupdate -group ccif /system_tb/DUT/CPU/CC/ccif/iaddr
add wave -noupdate -group ccif /system_tb/DUT/CPU/CC/ccif/ramREN
add wave -noupdate -group ccif /system_tb/DUT/CPU/CC/ccif/ramstate
add wave -noupdate -group ccif /system_tb/DUT/CPU/CC/ccif/ramstore
add wave -noupdate -group ccif /system_tb/DUT/CPU/CC/ccif/ramload
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP/BranchAddr
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP/dpif/imemREN
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP/dpif/imemload
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP/dpif/imemaddr
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP/dpif/flushed
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP/dpif/dmemload
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP/dpif/dmemstore
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP/dpif/dmemaddr
add wave -noupdate -color {Violet Red} /system_tb/DUT/CPU/DP/dpif/dmemREN
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/dmemWEN
add wave -noupdate -color {Violet Red} /system_tb/DUT/CPU/DP/dpif/ihit
add wave -noupdate -color Cyan /system_tb/DUT/CPU/DP/dpif/dhit
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/halt
add wave -noupdate /system_tb/DUT/CPU/DP/halt_next
add wave -noupdate -group icache /system_tb/DUT/CPU/CM/ICACHE/cache_table
add wave -noupdate -group icache /system_tb/DUT/CPU/CM/ICACHE/imemaddr
add wave -noupdate -group icache /system_tb/DUT/CPU/CM/ICACHE/tag
add wave -noupdate -group icache /system_tb/DUT/CPU/CM/ICACHE/index
add wave -noupdate -group icache /system_tb/DUT/CPU/CM/ICACHE/hit_en
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/state
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/next_state
add wave -noupdate -expand -group dcache -expand -subitemconfig {{/system_tb/DUT/CPU/CM/DCACHE/cache_table[0]} -expand {/system_tb/DUT/CPU/CM/DCACHE/cache_table[0].frame1} -expand {/system_tb/DUT/CPU/CM/DCACHE/cache_table[0].frame2} -expand} /system_tb/DUT/CPU/CM/DCACHE/cache_table
add wave -noupdate -expand -group dcache /system_tb/DUT/CPU/CM/DCACHE/set
add wave -noupdate -expand -group dcache /system_tb/DUT/CPU/CM/DCACHE/next_set
add wave -noupdate -expand -group dcache -expand /system_tb/DUT/CPU/CM/DCACHE/dcache_addr
add wave -noupdate -expand -group dcache /system_tb/DUT/CPU/CM/DCACHE/hit1
add wave -noupdate -expand -group dcache /system_tb/DUT/CPU/CM/DCACHE/hit2
add wave -noupdate -expand -group dcache /system_tb/DUT/CPU/CM/DCACHE/miss
add wave -noupdate -expand -group dcache /system_tb/DUT/CPU/CM/DCACHE/count
add wave -noupdate -expand -group dcache /system_tb/DUT/CPU/CM/DCACHE/next_count
add wave -noupdate -expand -group dcache /system_tb/DUT/CPU/CM/DCACHE/flush_row
add wave -noupdate -expand -group dcache /system_tb/DUT/CPU/CM/DCACHE/next_flush_row
add wave -noupdate -expand -group dcache /system_tb/DUT/CPU/CM/DCACHE/flush_col
add wave -noupdate -expand -group dcache /system_tb/DUT/CPU/CM/DCACHE/next_flush_col
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
add wave -noupdate -group ram /system_tb/DUT/RAM/count
add wave -noupdate -group ram /system_tb/DUT/RAM/rstate
add wave -noupdate -group ram /system_tb/DUT/RAM/q
add wave -noupdate -group ram /system_tb/DUT/RAM/wren
add wave -noupdate -group ram /system_tb/DUT/RAM/en
add wave -noupdate -group ram /system_tb/DUT/CPU/CC/ccif/daddr
add wave -noupdate -group ram /system_tb/DUT/RAM/addr
add wave -noupdate -group ram /system_tb/DUT/CPU/CC/ccif/ramaddr
add wave -noupdate -group ram /system_tb/DUT/CPU/CC/ccif/ramWEN
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2025090 ps} 0}
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
WaveRestoreZoom {1647640 ps} {2486322 ps}
