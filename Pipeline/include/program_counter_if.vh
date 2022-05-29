`ifndef PROGRAM_COUNTER_IF_VH
`define PROGRAM_COUNTER_IF_VH
`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;

interface program_counter_if;

logic PCEN;
word_t npc,pc,NewPC;

modport prc(
    input PCEN, NewPC,
    output pc,npc
);

modport tb(
    output PCEN, NewPC,
    input pc,npc
);
endinterface
`endif
