`include "ex_mem_if.vh"
`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;

module ex_mem(
    input logic CLK,
    input logic nRST,
    ex_mem_if.emif exmem_if
);


always_ff@ (posedge CLK, negedge nRST)
begin
        exmem_if.out_RegWr <= exmem_if.out_RegWr;
        exmem_if.out_MemToReg <= exmem_if.out_MemToReg;
        exmem_if.out_Branch <= exmem_if.out_Branch;
        exmem_if.out_MemRead <= exmem_if.out_MemRead;
        exmem_if.out_MemWrite <= exmem_if.out_MemWrite;
        exmem_if.out_JumpAddr <= exmem_if.out_JumpAddr;
        exmem_if.out_npc <= exmem_if.out_npc;
        exmem_if.out_BranchAddr <= exmem_if.out_BranchAddr;
        exmem_if.out_rdat1 <= exmem_if.out_rdat1;
        exmem_if.out_rdat2 <= exmem_if.out_rdat2;
        exmem_if.out_zero <= exmem_if.out_zero;
        exmem_if.out_PortOut <= exmem_if.out_PortOut;
        exmem_if.out_wsel <= exmem_if.out_wsel;
        exmem_if.out_jump <= exmem_if.out_jump;
        exmem_if.out_jr <= exmem_if.out_jr;
        exmem_if.out_jal <= exmem_if.out_jal;  
        exmem_if.out_instr <= exmem_if.out_instr; 
        exmem_if.out_halt <= exmem_if.out_halt; 
        exmem_if.out_beq <= exmem_if.out_beq;
        exmem_if.out_bne <= exmem_if.out_bne;
        exmem_if.out_branchnot <= exmem_if.out_branchnot;
        exmem_if.out_dREN <=exmem_if.out_dREN;
    if(!nRST)begin
        exmem_if.out_RegWr <= '0;
        exmem_if.out_MemToReg <= '0;
        exmem_if.out_Branch <= '0;
        exmem_if.out_MemRead <= '0;
        exmem_if.out_MemWrite <= '0;
        exmem_if.out_JumpAddr <= '0;
        exmem_if.out_npc <= '0;
        exmem_if.out_BranchAddr <= '0;
        exmem_if.out_rdat1 <= '0;
        exmem_if.out_rdat2 <= '0;
        exmem_if.out_zero <= '0;
        exmem_if.out_PortOut <= '0;
        exmem_if.out_wsel <= '0;
        exmem_if.out_jump <= '0;
        exmem_if.out_jr <= '0;
        exmem_if.out_jal <= '0;    
        exmem_if.out_instr <= '0; 
        exmem_if.out_halt <= '0;   
        exmem_if.out_lui <= '0;
        exmem_if.out_beq <= '0;
        exmem_if.out_bne <= '0;
        exmem_if.out_branchnot <= '0;
        exmem_if.out_dREN <='0;
    end
    else if(exmem_if.stall)begin
        exmem_if.out_RegWr <= exmem_if.out_RegWr;
        exmem_if.out_MemToReg <= exmem_if.out_MemToReg;
        exmem_if.out_Branch <= exmem_if.out_Branch;
        exmem_if.out_MemRead <= exmem_if.out_MemRead;
        exmem_if.out_MemWrite <= exmem_if.out_MemWrite;
        exmem_if.out_JumpAddr <= exmem_if.out_JumpAddr;
        exmem_if.out_npc <= exmem_if.out_npc;
        exmem_if.out_BranchAddr <= exmem_if.out_BranchAddr;
        exmem_if.out_rdat1 <= exmem_if.out_rdat1;
        exmem_if.out_rdat2 <= exmem_if.out_rdat2;
        exmem_if.out_zero <= exmem_if.out_zero;
        exmem_if.out_PortOut <= exmem_if.out_PortOut;
        exmem_if.out_wsel <= exmem_if.out_wsel;
        exmem_if.out_jump <= exmem_if.out_jump;
        exmem_if.out_jr <= exmem_if.out_jr;
        exmem_if.out_jal <= exmem_if.out_jal;  
        exmem_if.out_instr <= exmem_if.out_instr; 
        exmem_if.out_halt <= exmem_if.out_halt; 
        exmem_if.out_beq <= exmem_if.out_beq;
        exmem_if.out_bne <= exmem_if.out_bne;
        exmem_if.out_branchnot <= exmem_if.out_branchnot;
        exmem_if.out_dREN <=exmem_if.out_dREN;
    end
    else if(exmem_if.flush)begin
        exmem_if.out_RegWr <= '0;
        exmem_if.out_MemToReg <= '0;
        exmem_if.out_Branch <= '0;
        exmem_if.out_MemRead <= '0;
        exmem_if.out_MemWrite <= '0;
        exmem_if.out_JumpAddr <= '0;
        exmem_if.out_npc <= '0;
        exmem_if.out_BranchAddr <= '0;
        exmem_if.out_rdat1 <= '0;
        exmem_if.out_rdat2 <= '0;
        exmem_if.out_zero <= '0;
        exmem_if.out_PortOut <= '0;
        exmem_if.out_wsel <= '0;
        exmem_if.out_jump <= '0;
        exmem_if.out_jr <= '0;
        exmem_if.out_jal <= '0;  
        exmem_if.out_instr <= '0;  
        exmem_if.out_halt <= '0;
        exmem_if.out_lui <= '0;
        exmem_if.out_beq <= '0;
        exmem_if.out_bne <= '0;
        exmem_if.out_branchnot <= '0;
        exmem_if.out_dREN <='0;
    end
    else if(exmem_if.en)begin
        exmem_if.out_RegWr <= exmem_if.in_RegWr;
        exmem_if.out_MemToReg <= exmem_if.in_MemToReg;
        exmem_if.out_Branch <= exmem_if.in_Branch;
        exmem_if.out_MemRead <= exmem_if.in_MemRead;
        exmem_if.out_MemWrite <= exmem_if.in_MemWrite;
        exmem_if.out_JumpAddr <= exmem_if.in_JumpAddr;
        exmem_if.out_npc <= exmem_if.in_npc;
        exmem_if.out_BranchAddr <= exmem_if.in_BranchAddr;
        exmem_if.out_rdat1 <= exmem_if.in_rdat1;
        exmem_if.out_rdat2 <= exmem_if.in_rdat2;
        exmem_if.out_zero <= exmem_if.in_zero;
        exmem_if.out_PortOut <= exmem_if.in_PortOut;
        exmem_if.out_wsel <= exmem_if.in_wsel;
        exmem_if.out_jump <= exmem_if.in_jump;
        exmem_if.out_jr <= exmem_if.in_jr;
        exmem_if.out_jal <= exmem_if.in_jal;  
        exmem_if.out_instr <= exmem_if.in_instr; 
        exmem_if.out_halt <= exmem_if.in_halt; 
        exmem_if.out_lui <= exmem_if.in_lui;
        exmem_if.out_beq <= exmem_if.in_beq;
        exmem_if.out_bne <= exmem_if.in_bne;
        exmem_if.out_branchnot <= exmem_if.in_branchnot;
        exmem_if.out_dREN <=exmem_if.in_dREN;
    end
end


endmodule
