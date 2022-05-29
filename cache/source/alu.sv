`include "alu_if.vh"
`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;

module alu(
    alu_if.alu aluif
);

always_comb
begin
    casez(aluif.ALUOP)
    
    //Add
    ALU_ADD:
    begin
        aluif.PortOut = aluif.PortA + aluif.PortB;
        aluif.Overflow = (aluif.PortA[31] == aluif.PortB[31] && aluif.PortOut[31] != aluif.PortA[31]);
    end

    //Sub
    ALU_SUB:
    begin
        aluif.PortOut = aluif.PortA - aluif.PortB;
        aluif.Overflow = (aluif.PortA[31] != aluif.PortB[31] && aluif.PortOut[31] != aluif.PortA[31]);
    end

    //Sll
    ALU_SLL:
    begin
        aluif.PortOut = aluif.PortB << aluif.PortA [4:0];
        aluif.Overflow=0;
    end

    //Srl
    ALU_SRL:
    begin
        aluif.PortOut = aluif.PortB >> aluif.PortA [4:0];
        aluif.Overflow=0;
    end

    //And
    ALU_AND:
    begin
        aluif.PortOut = aluif.PortA & aluif.PortB;
        aluif.Overflow=0;
    end

    //Or
    ALU_OR:
    begin
        aluif.PortOut = aluif.PortA | aluif.PortB;
        aluif.Overflow=0;
    end

    //Xor
    ALU_XOR:
    begin
        aluif.PortOut = aluif.PortA ^ aluif.PortB;
        aluif.Overflow=0;
    end

    //Nor
    ALU_NOR:
    begin
        aluif.PortOut = ~(aluif.PortA | aluif.PortB);
        aluif.Overflow = 0;
    end

    //Set less than
    ALU_SLT:
    begin
        aluif.PortOut = $signed(aluif.PortA) < $signed(aluif.PortB);
        aluif.Overflow = 0;
    end

    //Set less than unsigned
    ALU_SLTU:
    begin
        aluif.PortOut = (aluif.PortA < aluif.PortB) ? 1:0;
        aluif.Overflow = 0;
    end
    endcase

end
assign aluif.Zero = aluif.PortOut == 0? 1:0;
assign aluif.Negative = aluif.PortOut[31];

endmodule