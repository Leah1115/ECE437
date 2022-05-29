`include "mem_wb_if.vh"
`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;

module mem_wb(
    input logic CLK,
    input logic nRST,
    mem_wb_if.mwif memwb_if
);


always_ff@ (posedge CLK, negedge nRST)
begin
        memwb_if.out_RegWr <= memwb_if.out_RegWr;
        memwb_if.out_MemToReg <= memwb_if.out_MemToReg;
        memwb_if.out_dmemload <= memwb_if.out_dmemload;
        memwb_if.out_npc <= memwb_if.out_npc;
        memwb_if.out_PortOut <= memwb_if.out_PortOut;
        memwb_if.out_wsel <= memwb_if.out_wsel;
        memwb_if.out_jal <= memwb_if.out_jal;  
        memwb_if.out_instr <= memwb_if.out_instr;  
        memwb_if.out_halt <= memwb_if.out_halt ; 
        memwb_if.out_lui <= memwb_if.out_lui;
    if(!nRST)begin
        memwb_if.out_RegWr <= '0;
        memwb_if.out_MemToReg <= '0;
        memwb_if.out_dmemload <= '0;
        memwb_if.out_npc <= '0;
        memwb_if.out_PortOut <= '0;
        memwb_if.out_wsel <= '0;
        memwb_if.out_jal <= '0;    
        memwb_if.out_instr <= '0;   
        memwb_if.out_halt <= '0;
        memwb_if.out_lui <= '0;
    end
    else if(memwb_if.stall)begin
        memwb_if.out_RegWr <= memwb_if.out_RegWr;
        memwb_if.out_MemToReg <= memwb_if.out_MemToReg;
        memwb_if.out_dmemload <= memwb_if.out_dmemload;
        memwb_if.out_npc <= memwb_if.out_npc;
        memwb_if.out_PortOut <= memwb_if.out_PortOut;
        memwb_if.out_wsel <= memwb_if.out_wsel;
        memwb_if.out_jal <= memwb_if.out_jal;  
        memwb_if.out_instr <= memwb_if.out_instr;  
        memwb_if.out_halt <= memwb_if.out_halt ; 
        memwb_if.out_lui <= memwb_if.out_lui;
    end
    else if(memwb_if.flush)begin
        memwb_if.out_RegWr <= '0;
        memwb_if.out_MemToReg <= '0;
        memwb_if.out_dmemload <= '0;
        memwb_if.out_npc <= '0;
        memwb_if.out_PortOut <= '0;
        memwb_if.out_wsel <= '0;
        memwb_if.out_jal <= '0;    
        memwb_if.out_instr <= '0; 
        memwb_if.out_halt <= '0; 
        memwb_if.out_lui <= '0;
    end
    else if(memwb_if.en)begin
        memwb_if.out_RegWr <= memwb_if.in_RegWr;
        memwb_if.out_MemToReg <= memwb_if.in_MemToReg;
        memwb_if.out_dmemload <= memwb_if.in_dmemload;
        memwb_if.out_npc <= memwb_if.in_npc;
        memwb_if.out_PortOut <= memwb_if.in_PortOut;
        memwb_if.out_wsel <= memwb_if.in_wsel;
        memwb_if.out_jal <= memwb_if.in_jal;  
        memwb_if.out_instr <= memwb_if.in_instr;  
        memwb_if.out_halt <= memwb_if.in_halt; 
        memwb_if.out_lui <= memwb_if.in_lui;
    end
end


endmodule
