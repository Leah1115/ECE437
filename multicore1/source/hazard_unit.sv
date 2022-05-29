`include "hazard_unit_if.vh"
`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;

module hazard_unit(
    input logic CLK,
    input logic nRST,
    hazard_unit_if.huif hu_if
);



opcode_t opcode;

assign opcode = opcode_t'(hu_if.exmem_instr[31:26]);

always_comb begin
    hu_if.ifid_flush = 0;
    hu_if.idex_flush = 0;
    hu_if.exmem_flush = 0;
    hu_if.memwb_flush = 0;
    hu_if.ifid_stall = 0;
    hu_if.idex_stall = 0;
    hu_if.exmem_stall = 0;
    hu_if.memwb_stall = 0;
    hu_if.pc_stall = 0;
    
    ///////////////////////////////////////////////////////
    //                  branch
    if (((opcode==BEQ) && (hu_if.exmem_beq && hu_if.exmem_zero)) || ((opcode==BNE) && (hu_if.exmem_bne&&(!hu_if.exmem_zero))))begin
      hu_if.ifid_flush = 1;//noops
      hu_if.idex_flush = 1;
      hu_if.exmem_flush = 1;
    end else if (((opcode==J) || (opcode==JAL)) || (opcode==RTYPE&&hu_if.exmem_instr[5:0]==JR)) begin
      hu_if.ifid_flush = 1;//noops
      hu_if.idex_flush = 1;
      hu_if.exmem_flush = 1;
    end
    else begin
        ///////////////////////////////////////////////////////
        //                  RAW SW
        if((hu_if.ifid_rs == hu_if.idex_wsel) || (hu_if.ifid_rt == hu_if.idex_wsel) )begin
            // IFID STALL
            // Other flush
            if(hu_if.idex_RegWr && (hu_if.idex_wsel != 0))begin
                // hu_if.ifid_stall = 1;  
                // hu_if.idex_flush = 1;
                // hu_if.pc_stall = 1;
            end
        end

        if((hu_if.ifid_rs == hu_if.exmem_wsel) || (hu_if.ifid_rt == hu_if.exmem_wsel))begin
            // IFID STALL
            // Other flush
            if(hu_if.exmem_RegWr && (hu_if.exmem_wsel != 0))begin
                // hu_if.ifid_stall = 1;  
                // hu_if.idex_flush = 1;
                // hu_if.pc_stall = 1;
            end
        end

        ///////////////////////////////////////////////////////
        //                  RAW LD
        if((hu_if.ifid_rs == hu_if.idex_wsel) || (hu_if.ifid_rt == hu_if.idex_wsel))begin
            // IFID STALL
            // Other flush
            if(hu_if.idex_MemRead && (hu_if.idex_wsel != 0))begin
                hu_if.ifid_stall = 1;  
                hu_if.idex_flush = 1;
                hu_if.pc_stall = 1;
            end
        end
        if(hu_if.exmem_RegWr && ((hu_if.ifid_rs == hu_if.idex_wsel) || (hu_if.ifid_rt == hu_if.idex_wsel)) && (hu_if.idex_MemRead||hu_if.idex_MemWrite))
        begin
                hu_if.ifid_stall = 1;  
                hu_if.idex_flush = 1;
                hu_if.pc_stall = 1;
        end

        if((hu_if.ifid_rs == hu_if.exmem_wsel) || (hu_if.ifid_rt == hu_if.exmem_wsel) )begin
            // IFID STALL
            // Other flush
            if(hu_if.exmem_MemRead && (hu_if.exmem_wsel != 0))begin
                // hu_if.ifid_stall = 1;  
                // hu_if.idex_flush = 1;
                // hu_if.pc_stall = 1;
            end
        end

    end


end


endmodule
