`include "hazard_unit_if.vh"
`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;

`timescale 1 ns/1 ns

module hazard_unit_tb;
parameter PERIOD = 10;
logic CLK = 0, nRST;

//clock
always #(PERIOD/2) CLK++;

hazard_unit_if huif();
test PROG (CLK, nRST, huif);
hazard_unit DUT(CLK, nRST, huif);
endmodule

program test(
    input logic CLK, 
    output logic nRST,
    hazard_unit_if.huif_tb huif
);

initial
begin
    //initial
    nRST = 0;
    huif.exmem_instr = 0;
    huif.exmem_beq = 0;
    huif.exmem_bne = 0;
    huif.exmem_zero = 0;
    huif.idex_RegWr = 0;
    huif.exmem_RegWr = 0;
    huif.idex_MemRead = 0;
    huif.exmem_MemRead = 0;
    huif.ifid_rs = 0;
    huif.ifid_rt = 0;
    huif.idex_rt = 0;
    huif.idex_rd = 0;
    huif.idex_wsel = 0;
    huif.exmem_wsel = 0;
    @(posedge CLK);
    nRST = 1;
    @(posedge CLK);
    
    //-------------------RAW hazard---------------------//
    $display ("//----------RAW Hazard----------//");
    //SW hazard in ID/EX
    huif.ifid_rs   = 5'b01010;
    huif.idex_wsel = 5'b01010;
    huif.idex_RegWr = 1;
    huif.idex_MemRead = 0;
    @(posedge CLK);
    if(huif.ifid_stall == 1 && huif.idex_flush == 1 && huif.pc_stall == 1)
      $display ("SW hazard in ID/EX PASSED!");
    else
      $display ("SW hazard in ID/EX FAILED!");
    @(posedge CLK);

    //SW hazard in EX/MEM
    huif.ifid_rs   = 5'b01010;
    huif.exmem_wsel = 5'b01010;
    huif.exmem_RegWr = 1;
    huif.exmem_MemRead = 0;
    @(posedge CLK);
    if(huif.ifid_stall == 1 && huif.idex_flush == 1 && huif.pc_stall == 1)
      $display ("SW hazard in EX/MEM PASSED!");
    else
      $display ("SW hazard in EX/MEM FAILED!");
    @(posedge CLK);

    //LW hazard in ID/EX
    huif.ifid_rs   = 5'b01010;
    huif.idex_wsel = 5'b01010;
    huif.idex_MemRead = 1;
    huif.idex_RegWr = 0;
    @(posedge CLK);
    if(huif.ifid_stall == 1 && huif.idex_flush == 1 && huif.pc_stall == 1)
      $display ("LW hazard in ID/EX PASSED!");
    else
      $display ("LW hazard in ID/EX FAILED!");
    @(posedge CLK);

    //LW hazard in EX/MEM
    huif.ifid_rs   = 5'b01010;
    huif.exmem_wsel = 5'b01010;
    huif.exmem_MemRead = 1;
    huif.exmem_RegWr = 0;
    @(posedge CLK);
    if(huif.ifid_stall == 1 && huif.idex_flush == 1 && huif.pc_stall == 1)
      $display ("LW hazard in EX/MEM PASSED!");
    else
      $display ("LW hazard in EX/MEM FAILED!");
    @(posedge CLK);
    
  
    
    //--------------------Control Hazard-------------------
    $display("//----------Control Hazard----------//");

    //BEQ hazard
    huif.exmem_instr[31:26] = BEQ;
    huif.exmem_beq = 1;
    huif.exmem_bne = 0;
    huif.exmem_zero = 1;
    @(posedge CLK);
    if (huif.ifid_flush == 1 && huif.idex_flush == 1 && huif.exmem_flush == 1)
      $display ("BEQ hazard PASSED!");
    else
      $display ("BEQ hazard FAILED!");
    @(posedge CLK);

    //BNE hazard
    huif.exmem_instr[31:26] = BNE;
    huif.exmem_beq = 0;
    huif.exmem_bne = 1;
    huif.exmem_zero = 0;
    @(posedge CLK);
    if (huif.ifid_flush == 1 && huif.idex_flush == 1 && huif.exmem_flush == 1)
      $display ("BNE hazard PASSED!");
    else
      $display ("BNE hazard FAILED!");
    @(posedge CLK);

    //Jump hazard
    huif.exmem_instr[31:26] = J;
    @(posedge CLK);
    if (huif.ifid_flush == 1 && huif.idex_flush == 1 && huif.exmem_flush == 1)
      $display ("Jump hazard PASSED!");
    else
      $display ("Jump hazard PASSED!");
    @(posedge CLK);

     //JAL hazard
    huif.exmem_instr[31:26] = JAL;
    @(posedge CLK);
    if (huif.ifid_flush == 1 && huif.idex_flush == 1 && huif.exmem_flush == 1)
      $display ("JAL hazard PASSED!");
    else
      $display ("JAL hazard PASSED!");
    @(posedge CLK);

     //Jr hazard
    huif.exmem_instr[31:26] = RTYPE;
    huif.exmem_instr[5:0] = JR;
    @(posedge CLK);
    if (huif.ifid_flush == 1 && huif.idex_flush == 1 && huif.exmem_flush == 1)
      $display ("JR hazard PASSED!");
    else
      $display ("JR hazard PASSED!");
    @(posedge CLK);
 


end
endprogram
