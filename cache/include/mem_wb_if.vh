`ifndef MEM_WB_IF_VH
`define MEM_WB_IF_VH

`include"cpu_types_pkg.vh"
import cpu_types_pkg::*;

interface mem_wb_if;

  logic flush,stall;
  //input
  logic in_RegWr, in_MemToReg;     //WB
  word_t in_instr;
  word_t in_dmemload, in_npc;
  word_t in_PortOut;
  logic [4:0] in_wsel;
  logic in_jal, in_halt;
  logic ihit, dhit, in_lui, en;

  //output
  logic out_RegWr, out_MemToReg;     //WB
  word_t out_instr;
  word_t out_dmemload, out_npc;
  word_t out_PortOut;
  logic [4:0] out_wsel;
  logic out_jal, out_halt,out_lui;

  modport mwif(
    input flush,stall,ihit, dhit, en,
    input in_RegWr, in_MemToReg, in_npc, in_instr, in_dmemload,
          in_PortOut, in_wsel, in_jal, in_halt, in_lui,
    output out_RegWr, out_MemToReg, out_npc, out_instr, out_dmemload,
           out_PortOut, out_wsel, out_jal, out_halt,out_lui
  );
  
 
endinterface

`endif //MEM_WB_IF_VH





  