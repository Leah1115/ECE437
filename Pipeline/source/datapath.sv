/*
  Eric Villasenor
  evillase@gmail.com

  datapath contains register file, control, hazard,
  muxes, and glue logic for processor
*/

// data path interface
`include "datapath_cache_if.vh"
`include "register_file_if.vh"
`include "control_unit_if.vh"
`include "alu_if.vh"
`include "program_counter_if.vh"
`include "if_id_if.vh"
`include "id_ex_if.vh"
`include "ex_mem_if.vh"
`include "mem_wb_if.vh"
`include "hazard_unit_if.vh"
`include "forward_unit_if.vh"

// alu op, mips op, and instruction type
`include "cpu_types_pkg.vh"

module datapath (
  input logic CLK, nRST,
  datapath_cache_if.dp dpif
);
  // import types
  import cpu_types_pkg::*;

  // pc init
  parameter PC_INIT = 0;

  //interface
  register_file_if rfif();
  control_unit_if cuif();
  alu_if aluif();
  program_counter_if pcif();
  if_id_if iiif();
  id_ex_if ieif();
  ex_mem_if emif();
  mem_wb_if mwif();
  hazard_unit_if huif();
  forward_unit_if fuif();

  //mapping
  register_file RF(CLK, nRST, rfif);
  control_unit CU(cuif);
  alu ALU(aluif);
  program_counter PC(CLK, nRST, pcif);
  if_id IFID(CLK, nRST, iiif);
  id_ex IDEX(CLK, nRST, ieif);
  ex_mem EXMEM(CLK, nRST, emif);
  mem_wb MEMWB(CLK, nRST, mwif);
  hazard_unit HU(CLK, nRST, huif);
  forward_unit FU(CLK, nRST, fuif);
  word_t SignExtImm, ZeroExtImm, JumpAddr, BranchAddr,shamt, ALUSrcMuxOut;
  logic branchnot;

  ////////////////////////  IF_ID ////////////////////////////////
  always_comb begin
      iiif.in_instr = dpif.imemload;
      iiif.in_npc = pcif.npc;
      iiif.ihit = dpif.ihit;
      iiif.dhit = dpif.dhit;
  end

   ////////////////////////  ID_EX ////////////////////////////////
  always_comb begin
      ieif.ihit = dpif.ihit;
      ieif.dhit = dpif.dhit;
      ieif.in_halt = cuif.halt; 
      ieif.in_RegWr = cuif.RegWEN;
      ieif.in_MemToReg = cuif.MemReg;
      ieif.in_RegDst = cuif.RegDst;
      ieif.in_ALUSrc = cuif.ALUSrc;
      ieif.in_Branch = cuif.branch;
      ieif.in_MemRead = cuif.dREN;
      ieif.in_MemWrite = cuif.dWEN;
      ieif.in_jump = cuif.jump;
      ieif.in_jal = cuif.jal;
      ieif.in_jr = cuif.jr;
      ieif.in_ALUOp = cuif.aluop;
      ieif.in_instr = iiif.out_instr;
      ieif.in_npc = iiif.out_npc;
      ieif.in_JumpAddr = JumpAddr;
      ieif.in_rdat1 = rfif.rdat1;
      ieif.in_rdat2 = rfif.rdat2;
      ieif.in_SignExt = SignExtImm;
      ieif.in_rt = cuif.rt;
      ieif.in_rd = cuif.rd;
      ieif.in_rs = cuif.rs;
      ieif.in_lui = cuif.lui;
      ieif.in_beq = cuif.beq;
      ieif.in_bne = cuif.bne;
      ieif.in_branchnot = cuif.branchnot;
  end

  ////////////////////////  EX_MEM ////////////////////////////////
  always_comb begin
      emif.ihit = dpif.ihit;
      emif.dhit = dpif.dhit;
      emif.in_RegWr = ieif.out_RegWr;
      emif.in_MemToReg = ieif.out_MemToReg;
      emif.in_Branch = ieif.out_Branch;
      emif.in_MemRead = ieif.out_MemRead;
      emif.in_MemWrite = ieif.out_MemWrite;
      emif.in_JumpAddr = ieif.out_JumpAddr;
      emif.in_npc = ieif.out_npc;
      emif.in_BranchAddr = BranchAddr;
      emif.in_rdat1 = ieif.out_rdat1;
      emif.in_rdat2 = ALUSrcMuxOut;
      emif.in_zero = aluif.Zero;
      emif.in_PortOut = aluif.PortOut;
      
      emif.in_wsel = ieif.out_rd;
      if(ieif.out_RegDst==2'b00) emif.in_wsel = ieif.out_rd;
      else if(ieif.out_RegDst==2'b01) emif.in_wsel = ieif.out_rt;
      else if(ieif.out_RegDst==2'b10) emif.in_wsel = 5'b11111;

      emif.in_jump = ieif.out_jump;
      emif.in_jr = ieif.out_jr;
      emif.in_jal = ieif.out_jal;
      emif.in_instr = ieif.out_instr;
      emif.in_halt = ieif.out_halt;
      emif.in_lui = ieif.out_lui;
      emif.in_beq = ieif.out_beq;
      emif.in_bne = ieif.out_bne;
      emif.in_branchnot = ieif.out_branchnot;
  end

    ////////////////////////  MEM_WB ////////////////////////////////
  always_comb begin
      mwif.ihit = dpif.ihit;
      mwif.dhit = dpif.dhit;
      mwif.in_RegWr = emif.out_RegWr;
      mwif.in_MemToReg = emif.out_MemToReg;
      mwif.in_instr = emif.out_instr;
      mwif.in_dmemload = dpif.dmemload;
      mwif.in_npc = emif.out_npc;
      mwif.in_PortOut = emif.out_PortOut;
      mwif.in_wsel = emif.out_wsel;
      mwif.in_jal = emif.out_jal;
      mwif.in_halt = emif.out_halt;
      mwif.in_lui = emif.out_lui;
  end
  

  //Forward
  always_comb
  begin
    aluif.PortA = ieif.out_rdat1;
    if(fuif.forwardA == 2'b00)
    begin
      aluif.PortA = ieif.out_rdat1;
    end
    else if(fuif.forwardA == 2'b10)
    begin
      aluif.PortA = emif.out_PortOut;
      if(emif.out_lui)
      begin
        aluif.PortA = {emif.out_instr[15:0],16'h0};
      end
    end
    else if(fuif.forwardA == 2'b01)
      begin
        aluif.PortA = mwif.out_PortOut;
        if(mwif.out_MemToReg)
        begin
          aluif.PortA = mwif.out_dmemload;
        end
        else if (mwif.out_jal)
        begin
          aluif.PortA = mwif.out_npc;
        end
        else if (mwif.out_lui)
        begin
          aluif.PortA = {mwif.out_instr[15:0],16'h0};
        end
    end
  

  end

  always_comb
  begin
    aluif.PortB = ieif.out_rdat2;
    ALUSrcMuxOut = ieif.out_rdat2;
    if(fuif.forwardB == 2'b00)
    begin
    ALUSrcMuxOut = ieif.out_rdat2;
    end
    else if(fuif.forwardB == 2'b10)
    begin
    ALUSrcMuxOut = emif.out_PortOut;
    if(emif.out_lui)
    begin
      ALUSrcMuxOut = {emif.out_instr[15:0],16'h0};
    end
    end
    else if(fuif.forwardB == 2'b01)
    begin
    ALUSrcMuxOut= mwif.out_PortOut;
      if(mwif.out_MemToReg)
      begin
        ALUSrcMuxOut = mwif.out_dmemload;
      end
      else if(mwif.out_jal)
      begin
        ALUSrcMuxOut = mwif.out_npc;
      end
      else if(mwif.out_lui)
        ALUSrcMuxOut = {mwif.out_instr[15:0],16'h0};
    end

    if(ieif.out_ALUSrc == 3'b000)
    begin
      aluif.PortB = ALUSrcMuxOut;
    end
    else if(ieif.out_ALUSrc == 3'b001)
    begin
      aluif.PortB = SignExtImm;
    end
    else if(ieif.out_ALUSrc == 3'b010)
    begin
      aluif.PortB = {16'h0000, ieif.out_instr[15:0]}; //ZeroExtImm
    end
    else if(ieif.out_ALUSrc == 3'b011)
    begin
      aluif.PortB = {'0, ieif.out_instr[10:6]};
    end



  end

  always_comb 
  begin
    //Initialize
    SignExtImm = 0;
    BranchAddr = 0;
    rfif.wdat = 0;
    //aluif.PortB = 0;
    pcif.NewPC = 0;

    //SignExtImm
    if(ieif.out_instr[15] == 1) 
    begin
      SignExtImm = {16'hffff, ieif.out_instr[15:0]};
    end
    else 
    begin
      SignExtImm = {16'h0000, ieif.out_instr[15:0]};
    end

    //LUI
    if(mwif.out_lui)
    begin
        rfif.wdat = {mwif.out_instr[15:0],16'h0};
    end
    else if (mwif.out_jal)begin
        rfif.wdat = mwif.out_npc; //jal
    end
    else if (mwif.out_MemToReg)begin
        rfif.wdat = mwif.out_dmemload;
    end else begin
        rfif.wdat = mwif.out_PortOut;
    end

    //PC address of jtype
    BranchAddr = ieif.out_npc + (SignExtImm << 2);
    if(emif.out_jr == 1) begin
      pcif.NewPC = emif.out_rdat1;
    end
    else if (emif.out_jump)begin
      pcif.NewPC = emif.out_JumpAddr;
    end
    else if (emif.out_beq && emif.out_zero)begin
      pcif.NewPC = emif.out_BranchAddr;
    end
    else if(emif.out_bne && ~emif.out_zero)begin
      pcif.NewPC = emif.out_BranchAddr;
    end
    else begin
      pcif.NewPC = pcif.npc;
    end

  end


 //Instr, rs & rt
  assign cuif.instr = iiif.out_instr;

  //Jump
  assign JumpAddr = {iiif.out_npc[31:28], iiif.out_instr[25:0], 2'b0};
  assign shamt = {24'h000000,3'b00, iiif.out_instr[10:6]};

  //Always not taken branch
  assign cuif.branchnot = branchnot;

  //RegSel
  assign rfif.rsel1 =  cuif.rs;
  assign rfif.rsel2 =  cuif.rt;
  assign rfif.wsel = mwif.out_wsel;
  assign rfif.WEN = mwif.out_RegWr;

  //PCEn
  assign pcif.PCEN = dpif.ihit && ~huif.pc_stall; // && ~huif.stall_ifid; //&& ~dpif.dhit && ~mwif.out_halt;

  //ALU
  //assign aluif.PortA = ieif.out_rdat1;
  assign aluif.ALUOP = ieif.out_ALUOp;

  //Memory
  assign dpif.imemREN = 1;
  assign dpif.imemaddr = pcif.pc;
  assign dpif.dmemREN = emif.out_MemRead;   //assign dpif.dmemREN = (dpif.dhit)?0:emif.out_MemRead;
  assign dpif.dmemWEN = emif.out_MemWrite;  //assign dpif.dmemWEN = (dpif.dhit)?0:emif.out_MemWrite;
  assign dpif.dmemstore = emif.out_rdat2;
  assign dpif.dmemaddr = emif.out_PortOut;

  // flush stall en
  assign iiif.flush = (dpif.ihit||dpif.dhit)&&huif.ifid_flush;
  assign iiif.stall = (dpif.ihit||dpif.dhit)&&huif.ifid_stall;
  assign iiif.en = (dpif.ihit || dpif.dhit);

  assign ieif.flush = (dpif.ihit||dpif.dhit)&&huif.idex_flush;   
  assign ieif.stall = (dpif.ihit||dpif.dhit)&&huif.idex_stall;
  assign ieif.en = (dpif.ihit || dpif.dhit);

  assign emif.flush = (dpif.ihit||dpif.dhit)&&huif.exmem_flush;
  assign emif.stall = (dpif.ihit||dpif.dhit)&&huif.exmem_stall;
  assign emif.en = (dpif.ihit || dpif.dhit);

  assign mwif.flush = (dpif.ihit||dpif.dhit)&&huif.memwb_flush;
  assign mwif.stall = (dpif.ihit||dpif.dhit)&&huif.memwb_stall;
  assign mwif.en = (dpif.ihit || dpif.dhit);

  assign huif.exmem_instr = emif.out_instr;
  assign huif.exmem_beq = emif.out_beq;
  assign huif.exmem_bne = emif.out_bne;
  assign huif.exmem_zero = emif.out_zero;
  assign huif.idex_RegWr = ieif.out_RegWr;
  assign huif.exmem_RegWr = emif.out_RegWr;
  assign huif.ifid_rs = iiif.out_instr[25:21];
  assign huif.ifid_rt = iiif.out_instr[20:16];
  assign huif.idex_rt = ieif.out_rt;
  assign huif.idex_rd = ieif.out_rd;
  assign huif.idex_wsel = emif.in_wsel;
  assign huif.exmem_wsel = emif.out_wsel;
  assign huif.idex_MemRead = ieif.out_MemRead;
  assign huif.exmem_MemRead = emif.out_MemRead;
  
  //forward
  assign fuif.idex_instr = ieif.out_instr;
  assign fuif.exmem_wsel = emif.out_wsel;
  assign fuif.memwb_wsel = mwif.out_wsel;
  assign fuif.exmem_RegWr = emif.out_RegWr;
  assign fuif.memwb_RegWr = mwif.out_RegWr;
//halt
logic halt_next;

always_ff @(negedge CLK or negedge nRST)
begin
  if(~nRST)
    dpif.halt<=0;
  else begin  
    if(halt_next)
      dpif.halt<= 1; 
  end
end

always_comb begin
    // halt_next = emif.out_halt;
    halt_next = mwif.out_halt;
end


endmodule
