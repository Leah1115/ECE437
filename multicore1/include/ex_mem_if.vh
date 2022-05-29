`ifndef EX_MEM_IF_VH
`define EX_MEM_IF_VH

`include"cpu_types_pkg.vh"
import cpu_types_pkg::*;

interface ex_mem_if;

  logic flush,stall;
  //input
  logic in_RegWr, in_MemToReg;     //WB
  logic in_Branch, in_MemRead, in_MemWrite; //MEM
  word_t in_JumpAddr, in_npc, in_BranchAddr, in_rdat1, in_rdat2,in_dREN;
  logic in_zero;
  word_t in_PortOut;
  logic [4:0] in_wsel;
  logic in_jump, in_jr, in_jal;
  word_t in_instr;
  logic in_halt;
  logic ihit, dhit, en, in_lui, in_beq, in_bne, in_branchnot;

  //output
  logic out_RegWr, out_MemToReg;     //WB
  logic out_Branch, out_MemRead, out_MemWrite; //MEM
  word_t out_JumpAddr, out_npc, out_BranchAddr, out_rdat1, out_rdat2,out_dREN;
  logic out_zero;
  word_t out_PortOut;
  logic [4:0] out_wsel;
  logic out_jump, out_jr, out_jal;
  word_t out_instr; 
  logic out_halt,out_lui, out_beq, out_bne,out_branchnot;

  modport emif(
    input flush,stall,ihit, dhit, en,
    input in_RegWr, in_MemToReg, in_Branch, in_MemRead, in_MemWrite, in_JumpAddr, in_npc, in_BranchAddr, in_rdat1,in_rdat2,
          in_zero, in_PortOut, in_wsel, in_jump, in_jr, in_jal, in_instr, in_halt, in_lui, in_beq, in_bne,in_branchnot,in_dREN,
    output out_RegWr, out_MemToReg, out_Branch, out_MemRead, out_MemWrite, out_JumpAddr, out_npc, out_BranchAddr, out_rdat1, out_rdat2,
          out_zero, out_PortOut, out_wsel, out_jump, out_jr, out_jal, out_instr, out_halt, out_lui, out_beq, out_bne, out_branchnot,out_dREN
  );
  
 
endinterface

`endif //EX_MEM_IF_VH





  