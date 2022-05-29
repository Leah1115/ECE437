`include"request_unit_if.vh"
`include"cpu_types_pkg.vh"
import cpu_types_pkg::*;

//clock
`timescale 1 ns/1 ns


module request_unit_tb;
//clock
parameter PERIOD = 10;
logic CLK = 0, nRST;
always #(PERIOD/2) CLK++;

//interface
request_unit_if ruif();

//test program
test PROG(CLK,nRST,ruif);

//DUT
request_unit DUT(CLK, nRST, ruif);
endmodule

program test(
    input logic CLK,
    output logic nRST,
    request_unit_if.tb ruif
);

initial
begin
    //initial
    nRST = 0;
    @(posedge CLK);
    nRST = 1;

    //test dhit
    ruif.ihit = 0;
    ruif.dhit = 1;
    @(posedge CLK);
    if(!(ruif.dmemREN && ruif.dmemWEN))
    begin
        $display("dhit PASSED!");
    end
    else
    begin
        $display("dhit FAILED!");
    end

    //test ihit
    @(posedge CLK);
    ruif.ihit = 1;
    ruif.dhit = 0;
    ruif.dREN = 1;
    ruif.dWEN = 1;
    @(posedge CLK);
    if((ruif.dmemREN == ruif.dREN)&&(ruif.dmemWEN == ruif.dWEN))
    begin
        $display("ihit PASSED!");
    end
    else
    begin
        $display("ihit FAILED!");
    end
    
    //test ihit and dhit
    @(posedge CLK);
    ruif.ihit = 1;
    ruif.dhit = 1;
    ruif.dREN = 1;
    ruif.dWEN = 1;
    @(posedge CLK);
    @(posedge CLK);
    if(!(ruif.dmemREN && ruif.dmemWEN))
    begin
        $display("ihit and dhit PASSED!");
    end
    else
    begin
        $display("ihit and dhit FAILED!");
    end
end
endprogram


