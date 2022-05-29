`ifndef FORWARD_UNIT_IF_VH
`define FORWARD_UNIT_IF_VH

`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;

interface forward_unit_if;

//input
word_t idex_instr;
regbits_t exmem_wsel, memwb_wsel;
logic exmem_RegWr, memwb_RegWr;

//output 
logic [1:0] forwardA, forwardB;

modport fu(
    input idex_instr, exmem_wsel, memwb_wsel, exmem_RegWr, memwb_RegWr,
    output forwardA, forwardB  
);

modport tb(
    output idex_instr, exmem_wsel, memwb_wsel, exmem_RegWr, memwb_RegWr,
    input forwardA, forwardB  
);

endinterface
`endif