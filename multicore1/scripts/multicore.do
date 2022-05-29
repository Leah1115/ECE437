onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate -group System /system_tb/DUT/syif/tbCTRL
add wave -noupdate -group System /system_tb/DUT/syif/halt
add wave -noupdate -group System /system_tb/DUT/syif/WEN
add wave -noupdate -group System /system_tb/DUT/syif/REN
add wave -noupdate -group System /system_tb/DUT/syif/addr
add wave -noupdate -group System /system_tb/DUT/syif/store
add wave -noupdate -group System /system_tb/DUT/syif/load
add wave -noupdate -expand -group Core0 -expand -group dp0 /system_tb/DUT/CPU/DP0/dpif/halt
add wave -noupdate -expand -group Core0 -expand -group dp0 /system_tb/DUT/CPU/DP0/dpif/ihit
add wave -noupdate -expand -group Core0 -expand -group dp0 /system_tb/DUT/CPU/DP0/dpif/imemREN
add wave -noupdate -expand -group Core0 -expand -group dp0 /system_tb/DUT/CPU/DP0/dpif/imemload
add wave -noupdate -expand -group Core0 -expand -group dp0 /system_tb/DUT/CPU/DP0/dpif/imemaddr
add wave -noupdate -expand -group Core0 -expand -group dp0 /system_tb/DUT/CPU/DP0/dpif/dhit
add wave -noupdate -expand -group Core0 -expand -group dp0 /system_tb/DUT/CPU/DP0/dpif/datomic
add wave -noupdate -expand -group Core0 -expand -group dp0 /system_tb/DUT/CPU/DP0/dpif/dmemREN
add wave -noupdate -expand -group Core0 -expand -group dp0 /system_tb/DUT/CPU/DP0/dpif/dmemWEN
add wave -noupdate -expand -group Core0 -expand -group dp0 /system_tb/DUT/CPU/DP0/dpif/flushed
add wave -noupdate -expand -group Core0 -expand -group dp0 -color Gold /system_tb/DUT/CPU/DP0/dpif/dmemload
add wave -noupdate -expand -group Core0 -expand -group dp0 -color Gold /system_tb/DUT/CPU/DP0/dpif/dmemstore
add wave -noupdate -expand -group Core0 -expand -group dp0 -color Gold /system_tb/DUT/CPU/DP0/dpif/dmemaddr
add wave -noupdate -expand -group Core0 -expand -group dp0 -color {Light Blue} /system_tb/DUT/CPU/DP0/ALUSrcMuxOut
add wave -noupdate -expand -group Core0 -expand -group dp0 -color Gold -label ieif_our_rdat2 /system_tb/DUT/CPU/DP0/ieif/out_rdat2
add wave -noupdate -expand -group Core0 -expand -group dp0 -label aluif.PortA /system_tb/DUT/CPU/DP0/aluif/PortA
add wave -noupdate -expand -group Core0 -expand -group dp0 -label aluif.PortB /system_tb/DUT/CPU/DP0/aluif/PortB
add wave -noupdate -expand -group Core0 -expand -group dp0 -color Gold -label aluif.PortOut /system_tb/DUT/CPU/DP0/ALU/aluif/PortOut
add wave -noupdate -expand -group Core0 -expand -group dp0 -color {Light Blue} -label emif_in_rdat2 /system_tb/DUT/CPU/DP0/emif/in_rdat2
add wave -noupdate -expand -group Core0 -expand -group dp0 -color Gold -label emif_out_rdat2 /system_tb/DUT/CPU/DP0/emif/out_rdat2
add wave -noupdate -expand -group Core0 -expand -group dp0 -color Gold -label emif_PortOut /system_tb/DUT/CPU/DP0/emif/out_PortOut
add wave -noupdate -expand -group Core0 -expand -group dp0 -color Gold -label mwif.out_Portout /system_tb/DUT/CPU/DP0/mwif/out_PortOut
add wave -noupdate -expand -group Core0 -expand -group dp0 -color Gold -label mwif.out_dmemload /system_tb/DUT/CPU/DP0/mwif/out_dmemload
add wave -noupdate -expand -group Core0 -expand -group dp0 -group hazard -color Gold /system_tb/DUT/CPU/DP0/huif/dhit
add wave -noupdate -expand -group Core0 -expand -group dp0 -group hazard -color Gold /system_tb/DUT/CPU/DP0/huif/ihit
add wave -noupdate -expand -group Core0 -expand -group dp0 -group hazard -color Gold /system_tb/DUT/CPU/DP0/huif/exmem_instr
add wave -noupdate -expand -group Core0 -expand -group dp0 -group hazard -color Gold /system_tb/DUT/CPU/DP0/huif/exmem_beq
add wave -noupdate -expand -group Core0 -expand -group dp0 -group hazard -color Gold /system_tb/DUT/CPU/DP0/huif/exmem_bne
add wave -noupdate -expand -group Core0 -expand -group dp0 -group hazard -color Gold /system_tb/DUT/CPU/DP0/huif/exmem_zero
add wave -noupdate -expand -group Core0 -expand -group dp0 -group hazard -color Gold /system_tb/DUT/CPU/DP0/huif/idex_RegWr
add wave -noupdate -expand -group Core0 -expand -group dp0 -group hazard -color Gold /system_tb/DUT/CPU/DP0/huif/exmem_RegWr
add wave -noupdate -expand -group Core0 -expand -group dp0 -group hazard -color Gold /system_tb/DUT/CPU/DP0/huif/idex_MemRead
add wave -noupdate -expand -group Core0 -expand -group dp0 -group hazard -color Gold /system_tb/DUT/CPU/DP0/huif/exmem_MemRead
add wave -noupdate -expand -group Core0 -expand -group dp0 -group hazard -color Gold /system_tb/DUT/CPU/DP0/huif/idex_MemWrite
add wave -noupdate -expand -group Core0 -expand -group dp0 -group hazard -color Gold /system_tb/DUT/CPU/DP0/huif/exmem_MemWrite
add wave -noupdate -expand -group Core0 -expand -group dp0 -group hazard -color Gold /system_tb/DUT/CPU/DP0/huif/ifid_rs
add wave -noupdate -expand -group Core0 -expand -group dp0 -group hazard -color Gold /system_tb/DUT/CPU/DP0/huif/ifid_rt
add wave -noupdate -expand -group Core0 -expand -group dp0 -group hazard -color Gold /system_tb/DUT/CPU/DP0/huif/idex_rt
add wave -noupdate -expand -group Core0 -expand -group dp0 -group hazard -color Gold /system_tb/DUT/CPU/DP0/huif/idex_rd
add wave -noupdate -expand -group Core0 -expand -group dp0 -group hazard -color Gold /system_tb/DUT/CPU/DP0/huif/idex_wsel
add wave -noupdate -expand -group Core0 -expand -group dp0 -group hazard -color Gold /system_tb/DUT/CPU/DP0/huif/exmem_wsel
add wave -noupdate -expand -group Core0 -expand -group dp0 -group hazard -color Gold /system_tb/DUT/CPU/DP0/huif/ifid_flush
add wave -noupdate -expand -group Core0 -expand -group dp0 -group hazard -color Gold /system_tb/DUT/CPU/DP0/huif/idex_flush
add wave -noupdate -expand -group Core0 -expand -group dp0 -group hazard -color Gold /system_tb/DUT/CPU/DP0/huif/exmem_flush
add wave -noupdate -expand -group Core0 -expand -group dp0 -group hazard -color Gold /system_tb/DUT/CPU/DP0/huif/memwb_flush
add wave -noupdate -expand -group Core0 -expand -group dp0 -group hazard -color Gold /system_tb/DUT/CPU/DP0/huif/ifid_stall
add wave -noupdate -expand -group Core0 -expand -group dp0 -group hazard -color Gold /system_tb/DUT/CPU/DP0/huif/idex_stall
add wave -noupdate -expand -group Core0 -expand -group dp0 -group hazard -color Gold /system_tb/DUT/CPU/DP0/huif/exmem_stall
add wave -noupdate -expand -group Core0 -expand -group dp0 -group hazard -color Gold /system_tb/DUT/CPU/DP0/huif/memwb_stall
add wave -noupdate -expand -group Core0 -expand -group dp0 -group hazard -color Gold /system_tb/DUT/CPU/DP0/huif/pc_stall
add wave -noupdate -expand -group Core0 -expand -group dp0 -group forward -color Gold /system_tb/DUT/CPU/DP0/fuif/idex_instr
add wave -noupdate -expand -group Core0 -expand -group dp0 -group forward -color Gold /system_tb/DUT/CPU/DP0/fuif/exmem_wsel
add wave -noupdate -expand -group Core0 -expand -group dp0 -group forward -color Gold /system_tb/DUT/CPU/DP0/fuif/memwb_wsel
add wave -noupdate -expand -group Core0 -expand -group dp0 -group forward -color Gold /system_tb/DUT/CPU/DP0/fuif/exmem_RegWr
add wave -noupdate -expand -group Core0 -expand -group dp0 -group forward -color Gold /system_tb/DUT/CPU/DP0/fuif/memwb_RegWr
add wave -noupdate -expand -group Core0 -expand -group dp0 -group forward -label emif.out_RegWr /system_tb/DUT/CPU/DP0/emif/out_RegWr
add wave -noupdate -expand -group Core0 -expand -group dp0 -group forward -label emif.out_MemToReg /system_tb/DUT/CPU/DP0/emif/out_MemToReg
add wave -noupdate -expand -group Core0 -expand -group dp0 -group forward -label emif.MemRead /system_tb/DUT/CPU/DP0/emif/out_MemRead
add wave -noupdate -expand -group Core0 -expand -group dp0 -group forward -label emif.MemWrite /system_tb/DUT/CPU/DP0/emif/out_MemWrite
add wave -noupdate -expand -group Core0 -expand -group dp0 -group forward -color Gold -subitemconfig {{/system_tb/DUT/CPU/DP0/fuif/forwardA[1]} {-color Gold} {/system_tb/DUT/CPU/DP0/fuif/forwardA[0]} {-color Gold}} /system_tb/DUT/CPU/DP0/fuif/forwardA
add wave -noupdate -expand -group Core0 -expand -group dp0 -group forward -color Gold /system_tb/DUT/CPU/DP0/fuif/forwardB
add wave -noupdate -expand -group Core0 -expand -group dp0 -label iiif_instr_out /system_tb/DUT/CPU/DP0/iiif/out_instr
add wave -noupdate -expand -group Core0 -expand -group dp0 -label ieif_instr_out /system_tb/DUT/CPU/DP0/ieif/out_instr
add wave -noupdate -expand -group Core0 -expand -group dp0 -label emif_instr_out /system_tb/DUT/CPU/DP0/emif/out_instr
add wave -noupdate -expand -group Core0 -expand -group dp0 -label mwif_instr_out /system_tb/DUT/CPU/DP0/mwif/out_instr
add wave -noupdate -expand -group Core0 -group cache0 /system_tb/DUT/CPU/cif0/iwait
add wave -noupdate -expand -group Core0 -group cache0 /system_tb/DUT/CPU/cif0/dwait
add wave -noupdate -expand -group Core0 -group cache0 /system_tb/DUT/CPU/cif0/iREN
add wave -noupdate -expand -group Core0 -group cache0 /system_tb/DUT/CPU/cif0/dREN
add wave -noupdate -expand -group Core0 -group cache0 /system_tb/DUT/CPU/cif0/dWEN
add wave -noupdate -expand -group Core0 -group cache0 /system_tb/DUT/CPU/cif0/iload
add wave -noupdate -expand -group Core0 -group cache0 /system_tb/DUT/CPU/cif0/dload
add wave -noupdate -expand -group Core0 -group cache0 /system_tb/DUT/CPU/cif0/dstore
add wave -noupdate -expand -group Core0 -group cache0 /system_tb/DUT/CPU/cif0/iaddr
add wave -noupdate -expand -group Core0 -group cache0 /system_tb/DUT/CPU/cif0/daddr
add wave -noupdate -expand -group Core0 -group cache0 /system_tb/DUT/CPU/cif0/ccwait
add wave -noupdate -expand -group Core0 -group cache0 /system_tb/DUT/CPU/cif0/ccinv
add wave -noupdate -expand -group Core0 -group cache0 /system_tb/DUT/CPU/cif0/ccwrite
add wave -noupdate -expand -group Core0 -group cache0 /system_tb/DUT/CPU/cif0/cctrans
add wave -noupdate -expand -group Core0 -group cache0 /system_tb/DUT/CPU/cif0/ccsnoopaddr
add wave -noupdate -expand -group Core0 -group cache0 -expand -group Dcache0 /system_tb/DUT/CPU/CM0/DCACHE/CLK
add wave -noupdate -expand -group Core0 -group cache0 -expand -group Dcache0 /system_tb/DUT/CPU/CM0/DCACHE/nRST
add wave -noupdate -expand -group Core0 -group cache0 -expand -group Dcache0 /system_tb/DUT/CPU/CM0/DCACHE/state
add wave -noupdate -expand -group Core0 -group cache0 -expand -group Dcache0 /system_tb/DUT/CPU/CM0/DCACHE/next_state
add wave -noupdate -expand -group Core0 -group cache0 -expand -group Dcache0 -expand /system_tb/DUT/CPU/CM0/DCACHE/cache_table
add wave -noupdate -expand -group Core0 -group cache0 -expand -group Dcache0 /system_tb/DUT/CPU/CM0/DCACHE/next_cache_table
add wave -noupdate -expand -group Core0 -group cache0 -expand -group Dcache0 /system_tb/DUT/CPU/CM0/DCACHE/dcache_addr
add wave -noupdate -expand -group Core0 -group cache0 -expand -group Dcache0 /system_tb/DUT/CPU/CM0/DCACHE/hit1
add wave -noupdate -expand -group Core0 -group cache0 -expand -group Dcache0 /system_tb/DUT/CPU/CM0/DCACHE/hit2
add wave -noupdate -expand -group Core0 -group cache0 -expand -group Dcache0 /system_tb/DUT/CPU/CM0/DCACHE/miss
add wave -noupdate -expand -group Core0 -group cache0 -expand -group Dcache0 /system_tb/DUT/CPU/CM0/DCACHE/count
add wave -noupdate -expand -group Core0 -group cache0 -expand -group Dcache0 /system_tb/DUT/CPU/CM0/DCACHE/next_count
add wave -noupdate -expand -group Core0 -group cache0 -expand -group Dcache0 /system_tb/DUT/CPU/CM0/DCACHE/flush_row
add wave -noupdate -expand -group Core0 -group cache0 -expand -group Dcache0 /system_tb/DUT/CPU/CM0/DCACHE/next_flush_row
add wave -noupdate -expand -group Core0 -group cache0 -expand -group Dcache0 /system_tb/DUT/CPU/CM0/DCACHE/flush_c
add wave -noupdate -expand -group Core0 -group cache0 -expand -group Dcache0 /system_tb/DUT/CPU/CM0/DCACHE/next_flush_c
add wave -noupdate -expand -group Core0 -group cache0 -expand -group Dcache0 /system_tb/DUT/CPU/CM0/DCACHE/s_index
add wave -noupdate -expand -group Core0 -group cache0 -expand -group Dcache0 /system_tb/DUT/CPU/CM0/DCACHE/s_tag
add wave -noupdate -expand -group Core0 -group cache0 -expand -group Dcache0 /system_tb/DUT/CPU/CM0/DCACHE/s_valid0
add wave -noupdate -expand -group Core0 -group cache0 -expand -group Dcache0 /system_tb/DUT/CPU/CM0/DCACHE/s_valid1
add wave -noupdate -expand -group Core0 -group cache0 -expand -group Dcache0 /system_tb/DUT/CPU/CM0/DCACHE/s_valid_tag
add wave -noupdate -expand -group Core0 -group cache0 -expand -group Dcache0 /system_tb/DUT/CPU/CM0/DCACHE/s_tag0
add wave -noupdate -expand -group Core0 -group cache0 -expand -group Dcache0 /system_tb/DUT/CPU/CM0/DCACHE/s_tag1
add wave -noupdate -expand -group Core0 -group cache0 -expand -group Dcache0 /system_tb/DUT/CPU/CM0/DCACHE/s_frame
add wave -noupdate -expand -group Core0 -group cache0 -expand -group Dcache0 /system_tb/DUT/CPU/CM0/DCACHE/next_s_frame
add wave -noupdate -group Core1 -expand -group dp1 /system_tb/DUT/CPU/DP1/dpif/halt
add wave -noupdate -group Core1 -expand -group dp1 /system_tb/DUT/CPU/DP1/dpif/ihit
add wave -noupdate -group Core1 -expand -group dp1 /system_tb/DUT/CPU/DP1/dpif/imemREN
add wave -noupdate -group Core1 -expand -group dp1 /system_tb/DUT/CPU/DP1/dpif/imemload
add wave -noupdate -group Core1 -expand -group dp1 /system_tb/DUT/CPU/DP1/dpif/imemaddr
add wave -noupdate -group Core1 -expand -group dp1 /system_tb/DUT/CPU/DP1/dpif/dhit
add wave -noupdate -group Core1 -expand -group dp1 /system_tb/DUT/CPU/DP1/dpif/datomic
add wave -noupdate -group Core1 -expand -group dp1 /system_tb/DUT/CPU/DP1/dpif/dmemREN
add wave -noupdate -group Core1 -expand -group dp1 /system_tb/DUT/CPU/DP1/dpif/dmemWEN
add wave -noupdate -group Core1 -expand -group dp1 /system_tb/DUT/CPU/DP1/dpif/flushed
add wave -noupdate -group Core1 -expand -group dp1 /system_tb/DUT/CPU/DP1/dpif/dmemload
add wave -noupdate -group Core1 -expand -group dp1 /system_tb/DUT/CPU/DP1/dpif/dmemstore
add wave -noupdate -group Core1 -expand -group dp1 /system_tb/DUT/CPU/DP1/dpif/dmemaddr
add wave -noupdate -group Core1 -expand -group dp1 -label iiif_instr_out /system_tb/DUT/CPU/DP1/iiif/out_instr
add wave -noupdate -group Core1 -expand -group dp1 -label ieif_instr_out /system_tb/DUT/CPU/DP1/ieif/out_instr
add wave -noupdate -group Core1 -expand -group dp1 -label emif_instr_out /system_tb/DUT/CPU/DP1/emif/out_instr
add wave -noupdate -group Core1 -expand -group dp1 -label mwif_instr_out /system_tb/DUT/CPU/DP1/mwif/out_instr
add wave -noupdate -group Core1 -expand -group cache1 /system_tb/DUT/CPU/CM1/cif/iwait
add wave -noupdate -group Core1 -expand -group cache1 /system_tb/DUT/CPU/CM1/cif/dwait
add wave -noupdate -group Core1 -expand -group cache1 /system_tb/DUT/CPU/CM1/cif/iREN
add wave -noupdate -group Core1 -expand -group cache1 /system_tb/DUT/CPU/CM1/cif/dREN
add wave -noupdate -group Core1 -expand -group cache1 /system_tb/DUT/CPU/CM1/cif/dWEN
add wave -noupdate -group Core1 -expand -group cache1 /system_tb/DUT/CPU/CM1/cif/iload
add wave -noupdate -group Core1 -expand -group cache1 /system_tb/DUT/CPU/CM1/cif/dload
add wave -noupdate -group Core1 -expand -group cache1 /system_tb/DUT/CPU/CM1/cif/dstore
add wave -noupdate -group Core1 -expand -group cache1 /system_tb/DUT/CPU/CM1/cif/iaddr
add wave -noupdate -group Core1 -expand -group cache1 /system_tb/DUT/CPU/CM1/cif/daddr
add wave -noupdate -group Core1 -expand -group cache1 /system_tb/DUT/CPU/CM1/cif/ccwait
add wave -noupdate -group Core1 -expand -group cache1 /system_tb/DUT/CPU/CM1/cif/ccinv
add wave -noupdate -group Core1 -expand -group cache1 /system_tb/DUT/CPU/CM1/cif/ccwrite
add wave -noupdate -group Core1 -expand -group cache1 /system_tb/DUT/CPU/CM1/cif/cctrans
add wave -noupdate -group Core1 -expand -group cache1 /system_tb/DUT/CPU/CM1/cif/ccsnoopaddr
add wave -noupdate -group Core1 -expand -group cache1 -group Dcache1 /system_tb/DUT/CPU/CM1/DCACHE/CLK
add wave -noupdate -group Core1 -expand -group cache1 -group Dcache1 /system_tb/DUT/CPU/CM1/DCACHE/nRST
add wave -noupdate -group Core1 -expand -group cache1 -group Dcache1 /system_tb/DUT/CPU/CM1/DCACHE/state
add wave -noupdate -group Core1 -expand -group cache1 -group Dcache1 /system_tb/DUT/CPU/CM1/DCACHE/next_state
add wave -noupdate -group Core1 -expand -group cache1 -group Dcache1 /system_tb/DUT/CPU/CM1/DCACHE/dcache_addr
add wave -noupdate -group Core1 -expand -group cache1 -group Dcache1 /system_tb/DUT/CPU/CM1/DCACHE/hit1
add wave -noupdate -group Core1 -expand -group cache1 -group Dcache1 /system_tb/DUT/CPU/CM1/DCACHE/hit2
add wave -noupdate -group Core1 -expand -group cache1 -group Dcache1 /system_tb/DUT/CPU/CM1/DCACHE/miss
add wave -noupdate -group Core1 -expand -group cache1 -group Dcache1 /system_tb/DUT/CPU/CM1/DCACHE/count
add wave -noupdate -group Core1 -expand -group cache1 -group Dcache1 /system_tb/DUT/CPU/CM1/DCACHE/next_count
add wave -noupdate -group Core1 -expand -group cache1 -group Dcache1 /system_tb/DUT/CPU/CM1/DCACHE/flush_row
add wave -noupdate -group Core1 -expand -group cache1 -group Dcache1 /system_tb/DUT/CPU/CM1/DCACHE/next_flush_row
add wave -noupdate -group Core1 -expand -group cache1 -group Dcache1 /system_tb/DUT/CPU/CM1/DCACHE/flush_c
add wave -noupdate -group Core1 -expand -group cache1 -group Dcache1 /system_tb/DUT/CPU/CM1/DCACHE/next_flush_c
add wave -noupdate -group Core1 -expand -group cache1 -group Dcache1 /system_tb/DUT/CPU/CM1/DCACHE/s_index
add wave -noupdate -group Core1 -expand -group cache1 -group Dcache1 /system_tb/DUT/CPU/CM1/DCACHE/s_tag
add wave -noupdate -group Core1 -expand -group cache1 -group Dcache1 /system_tb/DUT/CPU/CM1/DCACHE/s_valid0
add wave -noupdate -group Core1 -expand -group cache1 -group Dcache1 /system_tb/DUT/CPU/CM1/DCACHE/s_valid1
add wave -noupdate -group Core1 -expand -group cache1 -group Dcache1 /system_tb/DUT/CPU/CM1/DCACHE/s_valid_tag
add wave -noupdate -group Core1 -expand -group cache1 -group Dcache1 /system_tb/DUT/CPU/CM1/DCACHE/s_tag0
add wave -noupdate -group Core1 -expand -group cache1 -group Dcache1 /system_tb/DUT/CPU/CM1/DCACHE/s_tag1
add wave -noupdate -group Core1 -expand -group cache1 -group Dcache1 /system_tb/DUT/CPU/CM1/DCACHE/s_frame
add wave -noupdate -group Core1 -expand -group cache1 -group Dcache1 /system_tb/DUT/CPU/CM1/DCACHE/next_s_frame
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/iwait
add wave -noupdate -group ccif -expand /system_tb/DUT/CPU/ccif/dwait
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/iREN
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/dREN
add wave -noupdate -group ccif -color Magenta -expand -subitemconfig {{/system_tb/DUT/CPU/ccif/dWEN[1]} {-color Magenta -height 16} {/system_tb/DUT/CPU/ccif/dWEN[0]} {-color Magenta -height 16}} /system_tb/DUT/CPU/ccif/dWEN
add wave -noupdate -group ccif -expand /system_tb/DUT/CPU/ccif/iload
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/dload
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/dstore
add wave -noupdate -group ccif -expand /system_tb/DUT/CPU/ccif/iaddr
add wave -noupdate -group ccif -expand /system_tb/DUT/CPU/ccif/daddr
add wave -noupdate -group ccif -expand /system_tb/DUT/CPU/ccif/ccwait
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/ccinv
add wave -noupdate -group ccif -color Yellow -expand -subitemconfig {{/system_tb/DUT/CPU/ccif/ccwrite[1]} {-color Yellow -height 16} {/system_tb/DUT/CPU/ccif/ccwrite[0]} {-color Yellow -height 16}} /system_tb/DUT/CPU/ccif/ccwrite
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/cctrans
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/ccsnoopaddr
add wave -noupdate -group ccif -color {Orange Red} /system_tb/DUT/CPU/ccif/ramWEN
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/ramREN
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/ramstate
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/ramaddr
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/ramstore
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/ramload
add wave -noupdate -expand -group Memory_control /system_tb/DUT/CPU/CC/cpu
add wave -noupdate -expand -group Memory_control /system_tb/DUT/CPU/CC/icpu
add wave -noupdate -expand -group Memory_control /system_tb/DUT/CPU/CC/cpu0
add wave -noupdate -expand -group Memory_control /system_tb/DUT/CPU/CC/state
add wave -noupdate -expand -group Ram /system_tb/DUT/RAM/ramif/ramREN
add wave -noupdate -expand -group Ram -color {Orange Red} /system_tb/DUT/RAM/ramif/ramWEN
add wave -noupdate -expand -group Ram /system_tb/DUT/RAM/ramif/ramaddr
add wave -noupdate -expand -group Ram /system_tb/DUT/RAM/ramif/ramstore
add wave -noupdate -expand -group Ram /system_tb/DUT/RAM/ramif/ramload
add wave -noupdate -expand -group Ram /system_tb/DUT/RAM/ramif/ramstate
add wave -noupdate -expand -group Ram /system_tb/DUT/RAM/ramif/memREN
add wave -noupdate -expand -group Ram -color {Orange Red} /system_tb/DUT/RAM/ramif/memWEN
add wave -noupdate -expand -group Ram /system_tb/DUT/RAM/ramif/memaddr
add wave -noupdate -expand -group Ram /system_tb/DUT/RAM/ramif/memstore
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1033016 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 289
configure wave -valuecolwidth 260
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
WaveRestoreZoom {0 ps} {2150887 ps}
