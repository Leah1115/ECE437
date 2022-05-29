`include "control_unit_if.vh"
`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;

`timescale 1 ns/1 ns

module control_unit_tb;
parameter PERIOD = 10;
logic CLK = 0;

//clock
always #(PERIOD/2) CLK++;

control_unit_if cuif();
test PROG(CLK, cuif);
control_unit DUT(cuif);
endmodule

program test(
    input logic CLK,
    control_unit_if.tb cuif
);

initial 
begin
//Test R-Type
cuif.instr[31:26] = RTYPE;
$display("------------R-Type TEST------------");
//ADDU
cuif.instr[5:0] = ADDU;
@(posedge CLK);
if(cuif.aluop == ALU_ADD && cuif.RegWEN == 1)
begin
    $display("ADDU PASSED!");
end
else
begin
    $display("ADDU FAILED!");
end

//ADD
cuif.instr[5:0] = ADD;
@(posedge CLK);
if(cuif.aluop == ALU_ADD && cuif.RegWEN == 1)
begin
    $display("ADD PASSED!");
end
else
begin
    $display("ADD FAILED!");
end

//AND
cuif.instr[5:0] = AND;
@(posedge CLK);
if(cuif.aluop == ALU_AND && cuif.RegWEN == 1)
begin
    $display("AND PASSED!");
end
else
begin
    $display("AND FAILED!");
end

//JR
cuif.instr[5:0] = JR;
@(posedge CLK);
if(cuif.PCSrc == 3'b011)
begin
    $display("JR PASSED!");
end
else
begin
    $display("JR FAILED!");
end

//NOR
cuif.instr[5:0] = NOR;
@(posedge CLK);
if(cuif.aluop == ALU_NOR && cuif.RegWEN)
begin
    $display("NOR PASSED!");
end
else
begin
    $display("NOR FAILED!");
end

//OR
cuif.instr[5:0] = OR;
@(posedge CLK);
if(cuif.aluop == ALU_OR && cuif.RegWEN)
begin
    $display("OR PASSED!");
end
else
begin
    $display("OR FAILED!");
end

//SLT
cuif.instr[5:0] = SLT;
@(posedge CLK);
if(cuif.aluop == ALU_SLT && cuif.RegWEN)
begin
    $display("SLT PASSED!");
end
else
begin
    $display("SLT FAILED!");
end

//SLTU
cuif.instr[5:0] = SLTU;
@(posedge CLK);
if(cuif.aluop == ALU_SLTU && cuif.RegWEN)
begin
    $display("SLTU PASSED!");
end
else
begin
    $display("SLTU FAILED!");
end

//SLLV
cuif.instr[5:0] = SLLV;
@(posedge CLK);
if(cuif.aluop == ALU_SLL && cuif.ALUSrc == 3'b011 && cuif.RegWEN)
begin
    $display("SLLV PASSED!");
end
else
begin
    $display("SLLV FAILED!");
end

//SRLV
cuif.instr[5:0] = SRLV;
@(posedge CLK);
if(cuif.aluop == ALU_SRL && cuif.ALUSrc == 3'b011 && cuif.RegWEN)
begin
    $display("SRLV PASSED!");
end
else
begin
    $display("SRLV FAILED!");
end

//SUBU
cuif.instr[5:0] = SUBU;
@(posedge CLK);
if(cuif.aluop == ALU_SUB && cuif.RegWEN)
begin
    $display("SUBU PASSED!");
end
else
begin
    $display("SUBU FAILED!");
end

//SUB
cuif.instr[5:0] = SUB;
@(posedge CLK);
if(cuif.aluop == ALU_SUB && cuif.RegWEN)
begin
    $display("SUB PASSED!");
end
else
begin
    $display("SUB FAILED!");
end

//XOR
cuif.instr[5:0] = XOR;
@(posedge CLK);
if(cuif.aluop == ALU_XOR  && cuif.RegWEN)
begin
    $display("XOR PASSED!");
end
else
begin
    $display("XOR FAILED!");
end

//Test J-Type
//J
cuif.instr[31:26] = J;
$display ("------------J-Type TEST------------");
@(posedge CLK);
if(cuif.PCSrc == 3'b001)
begin
    $display("J PASSED!");
end
else
begin
    $display("J FAILED!");
end

//JAL
cuif.instr[31:26] = JAL;
@(posedge CLK);
if(cuif.PCSrc == 3'b010 && cuif.RegDst == 2'b10 && cuif.RegWEN == 1)
begin
    $display("JAL PASSED!");
end
else
begin
    $display("JAL FAILED!");
end

//I-Type test
$display("------------I-Type TEST------------");
//ADDIU
cuif.instr[31:26] = ADDIU;
@(posedge CLK);
if(cuif.aluop == ALU_ADD && cuif.ALUSrc == 3'b001 && cuif.RegWEN == 1)
begin
    $display("ADDIU PASSED!");
end
else
begin
    $display("ADDIU FAILED!");
end

//ADDI
cuif.instr[31:26] = ADDI;
@(posedge CLK);
if(cuif.aluop == ALU_ADD && cuif.ALUSrc == 3'b001 && cuif.RegWEN == 1)
begin
    $display("ADDI PASSED!");
end
else
begin
    $display("ADDI FAILED!");
end

//ANDI
cuif.instr[31:26] = ANDI;
@(posedge CLK);
if(cuif.aluop == ALU_AND && cuif.ALUSrc == 3'b010 && cuif.RegWEN == 1)
begin
    $display("ANDI PASSED!");
end
else
begin
    $display("ANDI FAILED!");
end

//BEQ
cuif.instr[31:26] = BEQ;
cuif.zero = 1;
@(posedge CLK);
if(cuif.aluop == ALU_SUB && cuif.branch)
begin
    $display("BEQ PASSED!");
end
else
begin
    $display("BEQ FAILED!");
end

//BEQ
cuif.instr[31:26] = BNE;
@(posedge CLK);
if(cuif.aluop == ALU_SUB && cuif.branch)
begin
    $display("BNE PASSED!");
end
else
begin
    $display("BNE FAILED!");
end

//LUI
cuif.instr[31:26] = LUI;
@(posedge CLK);
if(cuif.ALUSrc == 3'b100 && cuif.RegWEN == 1)
begin
    $display("LUI PASSED!");
end
else
begin
    $display("LUI FAILED!");
end

//LW
cuif.instr[31:26] = LW;
@(posedge CLK);
if(cuif.aluop == ALU_ADD && cuif.ALUSrc == 3'b001 && cuif.MemReg == 1 && cuif.RegWEN ==1 && cuif.dREN == 1)
begin
    $display("LW PASSED!");
end
else
begin
    $display("LW FAILED!");
end

//ORI
cuif.instr[31:26] = ORI;
@(posedge CLK);
if(cuif.RegWEN == 1 && cuif.aluop == ALU_OR && cuif.ALUSrc == 3'b010)
begin
    $display("ORI PASSED!");
end
else
begin
    $display("ORI FAILED!");
end

//SLTI
cuif.instr[31:26] = SLTI;
@(posedge CLK);
if(cuif.RegWEN == 1 && cuif.aluop == ALU_SLT && cuif.ALUSrc == 3'b001)
begin
    $display("SLTI PASSED!");
end
else
begin
    $display("SLTI FAILED!");
end

//SLTIU
cuif.instr[31:26] = SLTIU;
@(posedge CLK);
if(cuif.RegWEN == 1 && cuif.aluop == ALU_SLTU && cuif.ALUSrc == 3'b001)
begin
    $display("SLTIU PASSED!");
end
else
begin
    $display("SLTIU FAILED!");
end

//SW
cuif.instr[31:26] = SW;
@(posedge CLK);
if(cuif.aluop == ALU_ADD && cuif.ALUSrc == 3'b001 && cuif.MemReg == 0 && cuif.dWEN == 1)
begin
    $display("SW PASSED!");
end
else
begin
    $display("SW FAILED!");
end

//XORI
cuif.instr[31:26] = XORI;
@(posedge CLK);
if(cuif.RegWEN == 1 && cuif.aluop == ALU_XOR && cuif.ALUSrc == 3'b010)
begin
    $display("XORI PASSED!");
end
else
begin
    $display("XORI FAILED!");
end

//HALT
cuif.instr[31:26] = HALT;
@(posedge CLK);
if(cuif.halt == 1)
begin
    $display("HALT PASSED!");
end
else
begin
    $display("HALT FAILED!");
end

end
endprogram