`include "alu_if.vh"
`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;

`timescale 1 ns / 1 ns

module alu_tb;

parameter PERIOD = 10;
//clock
logic CLK=0;
always #(PERIOD/2) CLK++;

//interface
alu_if aluif ();

//test program
test PROG (aluif,CLK);

//DUT
`ifndef MAPPED
  alu DUT(aluif);
`else
  alu DUT(
      .\aluif.PortA (aluif.PortA),
      .\aluif.PortB (aluif.PortB),
      .\aluif.PortOut (aluif.PortOut),
      .\aluif.ALUOP (aluif.ALUOP),
      .\aluif.Negative (aluif.Negative),
      .\aluif.Overflow (aluif.Overflow),
      .\aluif.Zero (aluif.Zero)
  );
`endif 
endmodule

program test (
    alu_if.tb aif,
    input logic CLK
);

initial 
begin

    @(posedge CLK);
    //Test Add 
    aif.ALUOP=ALU_ADD;
    aif.PortA=2;
    aif.PortB=1;
    @(posedge CLK);
    if(aif.PortOut == (aif.PortA + aif.PortB))
    $display("Add test passed!");
    else
    $display("Add test failed!");

    //Test Sub
    aif.ALUOP=ALU_SUB;
    aif.PortA=2;
    aif.PortB=1;
    @(posedge CLK);
    if(aif.PortOut == (aif.PortA - aif.PortB))
    $display("Sub test passed!");
    else
    $display("Sub test failed!");
  
    //Test sll
    aif.ALUOP=ALU_SLL;
    aif.PortA=2;
    aif.PortB=1;
    @(posedge CLK);
    if(aif.PortOut == (aif.PortB << aif.PortA))
    $display("Sll test passed!");
    else
    $display("Sll test failed!");

    //Test srl
    aif.ALUOP=ALU_SRL;
    aif.PortA=2;
    aif.PortB=1;
    @(posedge CLK);
    if(aif.PortOut == (aif.PortB >> aif.PortA))
    $display("Srl test passed!");
    else
    $display("Srl test failed!");

    //Test and
    aif.ALUOP=ALU_AND;
    aif.PortA=2;
    aif.PortB=1;
    @(posedge CLK);
    if(aif.PortOut == (aif.PortA & aif.PortB))
    $display("And test passed!");
    else
    $display("And test failed!");

    //Test or
    aif.ALUOP=ALU_OR;
    aif.PortA=2;
    aif.PortB=1;
    @(posedge CLK);
    if(aif.PortOut == (aif.PortA | aif.PortB))
    $display("Or  test passed!");
    else
    $display("Or  test failed!");

    //Test xor
    aif.ALUOP=ALU_XOR;
    aif.PortA=2;
    aif.PortB=1;
    @(posedge CLK);
    if(aif.PortOut == (aif.PortA ^ aif.PortB))
    $display("Xor test passed!");
    else
    $display("Xor test failed!");

    //Test nor
    aif.ALUOP=ALU_NOR;
    aif.PortA=2;
    aif.PortB=1;
    @(posedge CLK);
    if(aif.PortOut == ~(aif.PortA | aif.PortB))
    $display("Nor test passed!");
    else
    $display("Nor test failed!");

    //Test slt
    aif.ALUOP=ALU_SLT;
    aif.PortA=2;
    aif.PortB=1;
    @(posedge CLK);
    if(aif.PortOut == ($signed(aif.PortA) < $signed (aif.PortB)))
    $display("Slt test passed!");
    else
    $display("Slt test failed!");

    //Test sltu
    aif.ALUOP=ALU_SLTU;
    aif.PortA=32'hFFFFFFFF;
    aif.PortB=32'h1;
    @(posedge CLK);
    if(aif.PortOut == (aif.PortA < aif.PortB))
    $display("Sltu test passed!");
    else
    $display("Sltu test failed!");

    //Test Zero
    aif.ALUOP=ALU_ADD;
    aif.PortA=0;
    aif.PortB=0;
    @(posedge CLK);
    if(aif.Zero==1)
    $display("Zero test passed!");
    else
    $display("Zero test failed!");

    //Test Negative
    aif.ALUOP=ALU_ADD;
    aif.PortA=1;
    aif.PortB=-2;
    @(posedge CLK);
    if(aif.Negative == 1)
    $display("Negative test passed!");
    else
    $display("Negative test failed!");

    //Test Overflow--Add case 
    aif.ALUOP=ALU_ADD;
    aif.PortA=32'h7FFFFFFF;
    aif.PortB=32'h1;
    @(posedge CLK);
    if(aif.Overflow == 1)
    $display("Overflow Add case test passed!");
    else
    $display("Overflow Add case test failed!");

    //Test Overflow--Sub case 
    aif.ALUOP=ALU_SUB;
    aif.PortA=32'h70000000;
    aif.PortB=32'hf0000000;
    @(posedge CLK);
    if(aif.Overflow == 1)
    $display("Overflow Sub case test passed!");
    else
    $display("Overflow Sub case test failed!");

    //Test corner condition 
    aif.ALUOP=ALU_ADD;
    aif.PortA=32'hFFFFFFFF;
    aif.PortB=32'h2;
    @(posedge CLK);
    $display("Output=%d",aif.PortOut);
    $display("Zero=%d",aif.Zero);
    $display("Negative=%d",aif.Negative);
    $display("Overflow=%d",aif.Overflow);

end
endprogram