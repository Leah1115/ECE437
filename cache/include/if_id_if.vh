`ifndef IF_ID_IF_VH
`define IF_ID_IF_VH

`include"cpu_types_pkg.vh"
import cpu_types_pkg::*;

interface if_id_if;

  logic flush,stall,en,ihit,dhit;
  //input
  word_t in_instr, in_npc;
  //output
  word_t out_instr, out_npc;

  modport iiif(
    input flush,stall, in_instr, in_npc, ihit, dhit, en,
    output out_instr, out_npc
  );

  modport ifidtb(
    input out_instr, out_npc,
    output flush,stall, in_instr, in_npc, ihit, dhit, en
  );
  
 
endinterface

`endif //IF_ID_IF_VH





  