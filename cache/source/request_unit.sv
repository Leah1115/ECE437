`include "request_unit_if.vh"
`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;

module request_unit(
    input logic CLK, nRST,
    request_unit_if.ru ruif
);

always_ff @(posedge CLK, negedge nRST)
begin
    if(nRST == 0)
    begin
        ruif.dmemREN <= 0;
        ruif.dmemWEN <= 0;
    end
    else 
      begin 
        if(ruif.dhit)
        begin
        ruif.dmemREN <= 0;
        ruif.dmemWEN <= 0;
        end
    else if(ruif.ihit)
    begin
        ruif.dmemREN <= ruif.dREN;
        ruif.dmemWEN <= ruif.dWEN;
    end
end
end

assign ruif.imemREN = 1;
endmodule