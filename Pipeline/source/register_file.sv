`include "register_file_if.vh"
`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;

module register_file(
    input logic CLK,
    input logic nRST,
    register_file_if.rf rfif
);

//Register
word_t registers [31:0];

//Operation
always_ff@ (negedge CLK, negedge nRST)
begin
    //Reset 
    if(nRST==0)
    registers<='{default:0};
    //Write data and ignore reg0
    else if(rfif.WEN!=0 && rfif.wsel!=0)
    registers[rfif.wsel]<=rfif.wdat;
end

always_comb
begin
    //choose bus based on sel
    rfif.rdat1=registers[rfif.rsel1];
    rfif.rdat2=registers[rfif.rsel2];
end

endmodule
