`ifndef CONTROL_UNIT_IF_VH
`define CONTROL_UNIT_IF_VH
`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;

interface control_unit_if;

logic[31:0] instr;
regbits_t rs, rt, rd;
aluop_t aluop;
logic[IMM_W-1:0] imm;    //IMM_W = 16
logic[SHAM_W-1:0] shamt; //SHAM_W = 5
logic[2:0] ALUSrc;
logic[1:0] RegDst;
logic MemReg, RegWEN, dWEN, dREN, branchsel, branch, zero, halt, jump, jal, jr, lui, beq, bne, branchnot;

modport cu(
    input instr, zero, branchnot,
    output rs, rt, rd, aluop, imm, shamt, ALUSrc, RegDst, MemReg, RegWEN, dWEN, dREN, branchsel, branch,  jump, jal, jr, lui, halt, beq, bne
);

modport tb(
    output instr, zero,branchnot,
    input  rs, rt, rd, aluop, imm, shamt, ALUSrc, RegDst, MemReg, RegWEN, dWEN, dREN, branchsel, branch,  jump, jal, jr, lui, halt, beq, bne
);

endinterface
`endif