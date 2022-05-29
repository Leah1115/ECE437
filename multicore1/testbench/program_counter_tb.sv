`include"program_counter_if.vh"
`include"cpu_types_pkg.vh"
import cpu_types_pkg::*;

`timescale 1 ns/1 ns

module program_counter_tb;
//clock
parameter PERIOD = 10;
logic CLK = 1, nRST;
always #(PERIOD/2) CLK++;

//interface
program_counter_if pcif();

//test program
test PROG(CLK, nRST, pcif);

//DUT
program_counter DUT(CLK, nRST, pcif);
endmodule

program test(
    input logic CLK, 
    output logic nRST,
    program_counter_if.tb pcif
);

initial 
begin
    //initial
    nRST = 0;
    @(posedge CLK)
    nRST = 1;
    pcif.PCEN = 1;
    pcif.NewPC = 32'hdeadbeef;
    @(posedge CLK)
    if(pcif.pc == pcif.NewPC)
    begin
        $display("New PC PASSED!");
    end
    else
    begin
        $display("New PC FAILED!");
    end
    if(pcif.npc == pcif.pc + 4)
    begin
        $display("npc PASSED!");
    end
    else
    begin
        $display("npc FAILED!");
    end
    @(posedge CLK);
end
endprogram