`ifndef ALU_IF_VH
`define ALU_IF_VH
`include "cpu_types_pkg.vh"
interface alu_if;
import cpu_types_pkg::*;


    
    //I/O define
    word_t PortA, PortB, PortOut;
    logic Negative, Overflow, Zero;
    aluop_t ALUOP;
    
    //ALU ports
    modport alu(
        input PortA, PortB, ALUOP,
        output PortOut, Negative, Overflow, Zero
    );
    
    //ALU tb
    modport tb(
        output PortA, PortB, ALUOP,
        input PortOut, Negative, Overflow, Zero
    );
endinterface

`endif
