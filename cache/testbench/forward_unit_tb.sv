`include "forward_unit_if.vh"
`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;

`timescale 1 ns/1 ns

module forward_unit_tb;
parameter PERIOD = 10;
logic CLK = 0, nRST;

//clock
always #(PERIOD/2) CLK++;

forward_unit_if fuif();
test PROG (CLK, nRST, fuif);
forward_unit DUT(CLK, nRST, fuif);
endmodule

program test(
    input logic CLK, 
    output logic nRST,
    forward_unit_if.tb huif
);
initial
begin
    //initial
    nRST = 0;
    fuif.idex_instr = 0;
    fuif.exmem_wsel = 0;
    fuif.memwb_wsel = 0;
    fuif.exmem_RegWr = 0;
    fuif.memwb_RegWr = 0;
    @(posedge CLK);
    nRST = 1;
    @(posedge CLK);

    //---------MEM forward---------//
    for(int i = 1; i < 32; i++)
    begin
    @(posedge CLK);
    huif.memwb_RegWr = 1;
    fuif.memwb_wsel = i;
    fuif.idex_instr[25:21] = i;
    @(posedge CLK);
    if(fuif.forwardA != 2'b01)
    begin
      $display("MEM forwardA FAILED at %d", i);
    end
    end
    $display("MEM forwardA ALL PASSED!");
    
    for(int i = 1; i < 32; i++)
    begin
    @(posedge CLK);
    huif.memwb_RegWr = 1;
    fuif.memwb_wsel = i;
    fuif.idex_instr[20:16] = i;
    @(posedge CLK);
    if(fuif.forwardB != 2'b01)
    begin
      $display("MEM forwardB FAILED at %d", i);
    end
    end
    $display("MEM forwardB ALL PASSED!");

    //---------EX forward---------//
    fuif.memwb_RegWr = 0;
    fuif.memwb_wsel = 0;
    for(int i = 1; i < 32; i++)
    begin
    @(posedge CLK);
    huif.exmem_RegWr = 1;
    fuif.exmem_wsel = i;
    fuif.idex_instr[25:21] = i;
    @(posedge CLK);
    if(fuif.forwardA != 2'b10)
    begin
      $display("EX forwardA FAILED at %d", i);
    end
    end
    $display("EX forwardA ALL PASSED!");
    
    for(int i = 1; i < 32; i++)
    begin
    @(posedge CLK);
    huif.exmem_RegWr = 1;
    fuif.exmem_wsel = i;
    fuif.idex_instr[20:16] = i;
    @(posedge CLK);
    if(fuif.forwardB != 2'b10)
    begin
      $display("EX forwardB FAILED at %d", i);
    end
    end
    $display("EX forwardB ALL PASSED!");
end
endprogram