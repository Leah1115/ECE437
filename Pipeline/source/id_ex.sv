`include "id_ex_if.vh"
`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;

module id_ex(
    input logic CLK, nRST,
    id_ex_if.ieif idex_if
);

always_ff @(posedge CLK, negedge nRST) 
begin
        idex_if.out_instr <= idex_if.out_instr;
        idex_if.out_halt <= idex_if.out_halt; 
        idex_if.out_RegWr <= idex_if.out_RegWr;
        idex_if.out_MemToReg <= idex_if.out_MemToReg;
        idex_if.out_RegDst <= idex_if.out_RegDst;
        idex_if.out_ALUSrc <= idex_if.out_ALUSrc;
        idex_if.out_Branch <= idex_if.out_Branch;
        idex_if.out_MemRead <= idex_if.out_MemRead;
        idex_if.out_MemWrite <= idex_if.out_MemWrite;
        idex_if.out_jump <= idex_if.out_jump;
        idex_if.out_jal <= idex_if.out_jal;
        idex_if.out_jr <= idex_if.out_jr;
        idex_if.out_ALUOp <= idex_if.out_ALUOp;
        idex_if.out_instr <= idex_if.out_instr;
        idex_if.out_npc <= idex_if.out_npc;
        idex_if.out_JumpAddr <= idex_if.out_JumpAddr;
        idex_if.out_rdat1 <= idex_if.out_rdat1;
        idex_if.out_rdat2 <= idex_if.out_rdat2;
        idex_if.out_SignExt <= idex_if.out_SignExt;
        idex_if.out_rt <= idex_if.out_rt;
        idex_if.out_rd <= idex_if.out_rd;
        idex_if.out_rs <= idex_if.out_rs;
        idex_if.out_lui <= idex_if.out_lui;
        idex_if.out_beq <= idex_if.out_beq;
        idex_if.out_bne <= idex_if.out_bne;
        idex_if.out_branchnot <=idex_if.out_branchnot;
    if(!nRST)
    begin
        idex_if.out_instr <= '0;
        idex_if.out_halt <= '0; 
        idex_if.out_RegWr <= '0;
        idex_if.out_MemToReg <= '0;
        idex_if.out_RegDst <= '0;
        idex_if.out_ALUSrc <= '0;
        idex_if.out_Branch <= '0;
        idex_if.out_MemRead <= '0;
        idex_if.out_MemWrite <= '0;
        idex_if.out_jump <= '0;
        idex_if.out_jal <= '0;
        idex_if.out_jr <= '0;
        idex_if.out_ALUOp <= ALU_SLL;
        idex_if.out_instr <= '0;
        idex_if.out_npc <= '0;
        idex_if.out_JumpAddr <= '0;
        idex_if.out_rdat1 <= '0;
        idex_if.out_rdat2 <= '0;
        idex_if.out_SignExt <= '0;
        idex_if.out_rt <= '0;
        idex_if.out_rd <= '0;
        idex_if.out_rs <= '0;
        idex_if.out_lui <= '0;
        idex_if.out_beq <= '0;
        idex_if.out_bne <= '0;
        idex_if.out_branchnot <='0;
    end
    else if(idex_if.stall)
    begin
        idex_if.out_instr <= idex_if.out_instr;
        idex_if.out_halt <= idex_if.out_halt; 
        idex_if.out_RegWr <= idex_if.out_RegWr;
        idex_if.out_MemToReg <= idex_if.out_MemToReg;
        idex_if.out_RegDst <= idex_if.out_RegDst;
        idex_if.out_ALUSrc <= idex_if.out_ALUSrc;
        idex_if.out_Branch <= idex_if.out_Branch;
        idex_if.out_MemRead <= idex_if.out_MemRead;
        idex_if.out_MemWrite <= idex_if.out_MemWrite;
        idex_if.out_jump <= idex_if.out_jump;
        idex_if.out_jal <= idex_if.out_jal;
        idex_if.out_jr <= idex_if.out_jr;
        idex_if.out_ALUOp <= idex_if.out_ALUOp;
        idex_if.out_instr <= idex_if.out_instr;
        idex_if.out_npc <= idex_if.out_npc;
        idex_if.out_JumpAddr <= idex_if.out_JumpAddr;
        idex_if.out_rdat1 <= idex_if.out_rdat1;
        idex_if.out_rdat2 <= idex_if.out_rdat2;
        idex_if.out_SignExt <= idex_if.out_SignExt;
        idex_if.out_rt <= idex_if.out_rt;
        idex_if.out_rd <= idex_if.out_rd;
        idex_if.out_rs <= idex_if.out_rs;
        idex_if.out_lui <= idex_if.out_lui;
        idex_if.out_beq <= idex_if.out_beq;
        idex_if.out_bne <= idex_if.out_bne;
        idex_if.out_branchnot <=idex_if.out_branchnot;
    end
    // else if(idex_if.flush && idex_if.ihit)
    else if(idex_if.flush)
    begin
        idex_if.out_instr <= '0;
        idex_if.out_halt <= '0; 
        idex_if.out_RegWr <= '0;
        idex_if.out_MemToReg <= '0;
        idex_if.out_RegDst <= '0;
        idex_if.out_ALUSrc <= '0;
        idex_if.out_Branch <= '0;
        idex_if.out_MemRead <= '0;
        idex_if.out_MemWrite <= '0;
        idex_if.out_jump <= '0;
        idex_if.out_jal <= '0;
        idex_if.out_jr <= '0;
        idex_if.out_ALUOp <= ALU_SLL;
        idex_if.out_instr <= '0;
        idex_if.out_npc <= '0;
        idex_if.out_JumpAddr <= '0;
        idex_if.out_rdat1 <= '0;
        idex_if.out_rdat2 <= '0;
        idex_if.out_SignExt <= '0;
        idex_if.out_rt <= '0;
        idex_if.out_rd <= '0;
        idex_if.out_rs <= '0;
        idex_if.out_lui <= '0;
        idex_if.out_beq <= '0;
        idex_if.out_bne <= '0;
        idex_if.out_branchnot <='0;
    end
    else if(idex_if.en)
    begin
        idex_if.out_instr <= idex_if.in_instr;
        idex_if.out_halt <= idex_if.in_halt; 
        idex_if.out_RegWr <= idex_if.in_RegWr;
        idex_if.out_MemToReg <= idex_if.in_MemToReg;
        idex_if.out_RegDst <= idex_if.in_RegDst;
        idex_if.out_ALUSrc <= idex_if.in_ALUSrc;
        idex_if.out_Branch <= idex_if.in_Branch;
        idex_if.out_MemRead <= idex_if.in_MemRead;
        idex_if.out_MemWrite <= idex_if.in_MemWrite;
        idex_if.out_jump <= idex_if.in_jump;
        idex_if.out_jal <= idex_if.in_jal;
        idex_if.out_jr <= idex_if.in_jr;
        idex_if.out_ALUOp <= idex_if.in_ALUOp;
        idex_if.out_instr <= idex_if.in_instr;
        idex_if.out_npc <= idex_if.in_npc;
        idex_if.out_JumpAddr <= idex_if.in_JumpAddr;
        idex_if.out_rdat1 <= idex_if.in_rdat1;
        idex_if.out_rdat2 <= idex_if.in_rdat2;
        idex_if.out_SignExt <= idex_if.in_SignExt;
        idex_if.out_rt <= idex_if.in_rt;
        idex_if.out_rd <= idex_if.in_rd;
        idex_if.out_rs <= idex_if.in_rs;
        idex_if.out_lui <= idex_if.in_lui;
        idex_if.out_beq <= idex_if.in_beq;
        idex_if.out_bne <= idex_if.in_bne;
        idex_if.out_branchnot <=idex_if.in_branchnot;
    end
end
endmodule