`ifndef ID_EX_IF_VH
`define ID_EX_IF_VH
`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;

interface id_ex_if;

  logic flush,stall;
  logic ihit, dhit, en;
  logic in_halt, out_halt, in_lui, out_lui, in_beq, out_beq, in_bne, out_bne, in_branchnot, out_branchnot,out_dREN,in_dREN;
  logic [1:0]in_RegDst, out_RegDst;
  logic [2:0]in_ALUSrc, out_ALUSrc;
  logic in_RegWr, in_MemToReg, in_Branch, in_MemRead, in_MemWrite, in_jump, in_jal, in_jr;
  logic out_RegWr, out_MemToReg, out_Branch, out_MemRead, out_MemWrite, out_jump, out_jal, out_jr;
  aluop_t in_ALUOp, out_ALUOp;
  word_t in_instr, in_npc, in_JumpAddr, in_rdat1, in_rdat2, in_SignExt, in_rt, in_rd, in_rs;
  word_t out_instr, out_npc, out_JumpAddr, out_rdat1, out_rdat2, out_SignExt, out_rt, out_rd, out_rs;

  modport ieif(
      input flush,stall,in_halt,in_RegWr, in_MemToReg, in_RegDst,in_ALUSrc, in_Branch, in_MemRead, in_MemWrite, in_jump, in_jal, in_jr,
            in_ALUOp,in_instr, in_npc, in_JumpAddr, in_rdat1, in_rdat2, in_SignExt, in_rt, in_rd, in_rs,ihit, dhit, en, in_lui, in_beq, in_bne, in_branchnot,in_dREN,
      output out_halt, out_RegWr, out_MemToReg, out_RegDst, out_ALUSrc, out_Branch, out_MemRead, out_MemWrite, out_jump, out_jal, out_jr,
            out_ALUOp,out_instr, out_npc, out_JumpAddr, out_rdat1, out_rdat2, out_SignExt, out_rt, out_rd, out_rs, out_lui, out_beq, out_bne, out_branchnot,out_dREN
  );

  modport tb(
      input  out_halt, out_RegWr, out_MemToReg, out_RegDst, out_ALUSrc, out_Branch, out_MemRead, out_MemWrite, out_jump, out_jal, out_jr,
             out_ALUOp,out_instr, out_npc, out_JumpAddr, out_rdat1, out_rdat2, out_SignExt, out_rt, out_rd, out_rs,out_dREN,

      output flush,stall,in_halt,in_RegWr, in_MemToReg, in_RegDst,in_ALUSrc, in_Branch, in_MemRead, in_MemWrite, in_jump, in_jal, in_jr,
             in_ALUOp,in_instr, in_npc, in_JumpAddr, in_rdat1, in_rdat2, in_SignExt, in_rt, in_rd,in_rs,ihit, dhit, en
  );
  
endinterface
`endif