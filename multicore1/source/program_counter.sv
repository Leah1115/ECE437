`include"program_counter_if.vh"
`include"cpu_types_pkg.vh"
import cpu_types_pkg::*;

module program_counter(
    input logic CLK, nRST,
    program_counter_if.prc pcif
);

always_ff @(posedge CLK, negedge nRST)
begin
    if(nRST == 0)
    //reset
    begin
        // pcif.pc <= '{default:'0};
        pcif.pc <= pcif.pc_init;
    end
    else begin 
        if(pcif.PCEN)
    //assign newpc
        pcif.pc <= pcif.NewPC;
end
end

//assign npc
assign pcif.npc = pcif.pc + 4;

endmodule 