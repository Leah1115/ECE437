`include "forward_unit_if.vh"
`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;

module  forward_unit(
    input CLK, nRST,
    forward_unit_if.fu fuif
);
    //setup rs, rt from ex
    regbits_t idex_rs, idex_rt;
    assign idex_rs = fuif.idex_instr[25:21];
    assign idex_rt = fuif.idex_instr[20:16];

    always_comb
    begin
    //forwarding
    fuif.forwardA = 0;
    fuif.forwardB = 0;

    //MEM forward
    if(fuif.memwb_RegWr && fuif.memwb_wsel && (fuif.memwb_wsel == idex_rs))
    begin
      fuif.forwardA = 2'b01;
    end
    if(fuif.memwb_RegWr && fuif.memwb_wsel && (fuif.memwb_wsel == idex_rt))
    begin
      fuif.forwardB = 2'b01;
    end
    
    //EX forward
    // EX Forwarding has higher priority!!!!!!
    if(fuif.exmem_RegWr && fuif.exmem_wsel && (fuif.exmem_wsel == idex_rs))
    begin
      fuif.forwardA = 2'b10;
    end
    if(fuif.exmem_RegWr && fuif.exmem_wsel && (fuif.exmem_wsel == idex_rt))
    begin
      fuif.forwardB = 2'b10;
    end

end
endmodule