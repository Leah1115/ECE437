`include"control_unit_if.vh"
`include"cpu_types_pkg.vh"
import cpu_types_pkg::*;

module control_unit (
    control_unit_if.cu cuif
);
always_comb 
begin
    //Initialize
    cuif.rs = 0;
    cuif.rt = 0;
    cuif.rd = 0;
    cuif.aluop = ALU_SLL;//Default aluop
    cuif.imm = 0;              //                     Table of Src
    cuif.shamt = 0;            //          (0)00    (0)01      (0)10     (0)11    100            
    cuif.ALUSrc = 0;           // ALUSrc   Reg      signExt    ZeroExt   shamt    LUI
    cuif.RegDst = 0;           // RegDst   rd,      rt,        r31
    cuif.MemReg = 0;
    cuif.RegWEN = 0;
    cuif.dWEN = 0;
    cuif.dREN = 0;
    cuif.branch = 0; 
    cuif.jump = 0;
    cuif.jal = 0;
    cuif.jr = 0;
    cuif.halt = 0;
    cuif.lui = 0;
    cuif.beq = 0;
    cuif.bne = 0;
    
    //J-Type
    if(cuif.instr[31:26] == J) //J
    begin
        cuif.jump = 1;
        cuif.jal = 0;
        cuif.jr   = 0;
        cuif.aluop = ALU_SLL;
        cuif.RegWEN = 0;
        cuif.ALUSrc = 0;
        cuif.RegDst = 0;       
        cuif.MemReg = 0;
        
    end
    else if(cuif.instr[31:26] == JAL) //JAL
    begin
        cuif.jump = 1;
        cuif.jal  = 1;
        cuif.jr   = 0;
        cuif.aluop = ALU_SLL;
        cuif.RegWEN = 1;
        cuif.ALUSrc = 0;
        cuif.RegDst = 2'b10;  //10: r31
        cuif.MemReg = 0;
    end

    //R-Type
    else if(cuif.instr[31:26] == RTYPE)
    begin
        cuif.rs = cuif.instr[25:21]; //set rs
        cuif.rt = cuif.instr[20:16]; //set rt
        cuif.rd = cuif.instr[15:11]; //set rd
        cuif.shamt = {'0, cuif.instr[10:6]}; //set shamt
        cuif.MemReg = 0;
        cuif.RegDst = 2'b00; //rd is the destination
        cuif.ALUSrc = 3'b000; //Reg
        cuif.RegWEN = 1;
        cuif.jump = 0;
        casez(cuif.instr[5:0])
        
            ADD: //Add
            begin
                cuif.aluop = ALU_ADD;
            end

            ADDU: //Add Unsigned
            begin
                cuif.aluop = ALU_ADD;
            end

            AND: //And
            begin
                cuif.aluop = ALU_AND;
            end

            JR: //JR
            begin
                cuif.jr     = 1;
                cuif.RegWEN = 0;
            end

            NOR: //Nor
            begin
                cuif.aluop = ALU_NOR;
            end

            OR: //Or
            begin
                cuif.aluop = ALU_OR;
            end

            SLT: //Slt
            begin
                cuif.aluop = ALU_SLT;
            end

            SLTU: //sltu
            begin
                cuif.aluop = ALU_SLTU;
            end

            SLLV: //sllv
            begin
                cuif.aluop = ALU_SLL;
            end

            SRLV: //srlv
            begin
                cuif.aluop = ALU_SRL;
            end

            SUBU://Sub
            begin
                cuif.aluop = ALU_SUB;
            end

            SUB: //Sub
            begin
                cuif.aluop = ALU_SUB;
            end

            XOR: //xor
            begin
                cuif.aluop = ALU_XOR;
            end
        endcase
    end 

    //I-Type
    else 
    begin 
        cuif.rs = cuif.instr[25:21]; //set rs
        cuif.rt = cuif.instr[20:16]; //set rt
        cuif.imm = cuif.instr[15:0]; //set imm
        cuif.RegDst = 2'b01;         //rt is the destination
        cuif.RegWEN = 1;
        cuif.jump = 0;
        casez(cuif.instr[31:26])

        ADDIU://add imme unsigned
        begin
            cuif.aluop = ALU_ADD;
            cuif.ALUSrc = 3'b001; //ALUsource from SignExt
        end

        ADDI://add imme
        begin
            cuif.aluop = ALU_ADD;
            cuif.ALUSrc = 3'b001; //ALUsource from SignExt
        end

        ANDI://and imme
        begin
            cuif.aluop = ALU_AND;
            cuif.ALUSrc = 3'b010; //ALUsource from ZeroExt
        end

        BEQ: //beq
        begin
            cuif.beq = 1;
            cuif.branch = 1;
            cuif.RegWEN = 0;
            cuif.aluop = ALU_SUB;
        end

        BNE: //bne
        begin
            cuif.bne = 1;
            cuif.branch = 1;
            cuif.RegWEN = 0;
            cuif.aluop = ALU_SUB;
        end

        LUI: //lui
        begin
            cuif.lui = 1;
            cuif.ALUSrc = 3'b000;
        end

        ORI: //ori
        begin
            cuif.aluop = ALU_OR;
            cuif.ALUSrc = 3'b010; //ALUsource from ZeroExt
        end

        SLTI: //slti
        begin
            cuif.aluop = ALU_SLT;
            cuif.ALUSrc = 3'b001; //ALUsource from SignExt
        end

        SLTIU: //sltiu
        begin
            cuif.aluop = ALU_SLTU;
            cuif.ALUSrc = 3'b001; //SignExt
        end

        XORI: //xori
        begin
            cuif.aluop = ALU_XOR;
            cuif.ALUSrc = 3'b010; //ZeroExt
        end

        LW: //lw
        begin
            cuif.RegWEN = 1;
            cuif.aluop = ALU_ADD;
            cuif.ALUSrc = 3'b001; //ALUSource from SignExt
            cuif.MemReg = 1;
            cuif.dREN = 1;
        end
        
        SW: //sw
        begin
            cuif.RegWEN = 0;
            cuif.aluop = ALU_ADD;
            cuif.ALUSrc = 3'b001; //SignExt
            cuif.MemReg = 0;
            cuif.dWEN = 1; 
        end
        
        LL: //LL
        begin
            cuif.RegWEN = 1;
            cuif.aluop = ALU_ADD;
            cuif.ALUSrc = 3'b001;
            cuif.MemReg = 1;
            cuif.dREN = 1;
            cuif.dWEN = 0;
            // cuif.atomic = 1;
        end

        SC: //SC
        begin
            cuif.RegWEN = 1;
            cuif.aluop = ALU_ADD;
            cuif.ALUSrc = 3'b001;
            cuif.MemReg = 1;
            cuif.dREN = 0;
            cuif.dWEN = 1;
            // cuif.atomic = 1;
        end 

        HALT: //halt
        begin
            cuif.halt = 1;
        end
        endcase
    end
end
endmodule