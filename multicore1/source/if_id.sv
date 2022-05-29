`include "if_id_if.vh"
`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;

module if_id(
    input logic CLK,
    input logic nRST,
    if_id_if.iiif ifid_if
);


always_ff@ (posedge CLK, negedge nRST)
begin
    
        ifid_if.out_instr <= ifid_if.out_instr;
        ifid_if.out_npc <= ifid_if.out_npc;
    if(!nRST)begin
        ifid_if.out_instr <= '0;
        ifid_if.out_npc <= '0;
    end
    else if(ifid_if.stall)begin  
        ifid_if.out_instr <= ifid_if.out_instr;
        ifid_if.out_npc <= ifid_if.out_npc;
    end
    else if(ifid_if.flush)begin  
        ifid_if.out_instr <= '0;
        ifid_if.out_npc <= '0;
    end
    else if(ifid_if.en) begin
        ifid_if.out_instr <= ifid_if.in_instr;
        ifid_if.out_npc <= ifid_if.in_npc;
    end
end


endmodule
