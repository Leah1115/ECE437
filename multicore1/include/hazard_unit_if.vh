`ifndef HAZARD_UNIT_IF
`define HAZARD_UNIT_IF

`include"cpu_types_pkg.vh"
import cpu_types_pkg::*;

interface hazard_unit_if;

  //input
  logic       dhit, ihit;
  word_t      exmem_instr;
  logic       exmem_beq, exmem_bne, exmem_zero;
  logic       idex_RegWr, exmem_RegWr;
  logic       idex_MemRead, exmem_MemRead;
  logic       idex_MemWrite, exmem_MemWrite;
  word_t      ifid_rs, ifid_rt;
  word_t      idex_rt, idex_rd;
  logic [4:0]  idex_wsel, exmem_wsel;

  //output
  logic       ifid_flush, idex_flush, exmem_flush, memwb_flush;
  logic       ifid_stall, idex_stall, exmem_stall, memwb_stall;
  logic       pc_stall;

  modport huif(
    input     dhit, ihit, exmem_instr, exmem_beq, exmem_bne, exmem_zero, idex_RegWr, exmem_RegWr, ifid_rs, ifid_rt, idex_rt, idex_rd, idex_wsel, exmem_wsel, idex_MemRead, exmem_MemRead,idex_MemWrite, exmem_MemWrite,
    output    ifid_flush, idex_flush, exmem_flush, memwb_flush, ifid_stall, idex_stall, exmem_stall, memwb_stall, pc_stall
  );
  
  modport huif_tb(
    input    ifid_flush, idex_flush, exmem_flush, exmem_RegWr, memwb_flush, ifid_stall, idex_stall, exmem_stall, memwb_stall, pc_stall,
    output     dhit, ihit, exmem_instr, exmem_beq, exmem_bne, exmem_zero, idex_RegWr, ifid_rs, ifid_rt, idex_rt, idex_rd, idex_wsel, exmem_wsel, idex_MemRead, exmem_MemRead
  );
 
endinterface

`endif //HAZARD_UNIT_IF 





  