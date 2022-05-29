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
`include "request_unit_if.vh"
`include "alu_if.vh"
`include "program_counter_if.vh"

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
  request_unit_if ruif();
  alu_if aluif();
  program_counter_if pcif();

  //mapping
  register_file RF(CLK, nRST, rfif);
  control_unit CU(cuif);
  request_unit RU(CLK, nRST, ruif);
  alu ALU(aluif);
  program_counter PC(CLK, nRST, pcif);
  word_t SignExtImm, ZeroExtImm, JumpAddr, BranchAddr;

  //Instru
  assign cuif.instr = dpif.imemload;
  //ZeroBranchAddr = pcif.npc;
  assign ZeroExtImm = {16'h0000, cuif.imm};
  //Jump
  assign JumpAddr = {pcif.npc[31:28], dpif.imemload[25:0], 2'b00};
  //RegSel
  assign rfif.rsel1 = cuif.rs;
  assign rfif.rsel2 = cuif.rt;
  //PCEn
  assign pcif.PCEN = dpif.ihit && ~dpif.dhit;
  //ALU
  assign aluif.PortA = rfif.rdat1;
  assign aluif.ALUOP = cuif.aluop;
  assign cuif.zero = aluif.Zero; 
  //Request Unit
  assign ruif.dWEN = cuif.dWEN;
  assign ruif.dREN = cuif.dREN;
  assign ruif.dhit = dpif.dhit;
  assign ruif.ihit = dpif.ihit;
  //Memory
  assign dpif.imemREN = ruif.imemREN;
  assign dpif.imemaddr = pcif.pc;
  assign dpif.dmemREN = ruif.dmemREN;
  assign dpif.dmemWEN = ruif.dmemWEN;
  assign dpif.dmemstore = rfif.rdat2;
  assign dpif.dmemaddr = aluif.PortOut;

  always_comb 
  begin
    //Initialize
    SignExtImm = 0;
    BranchAddr = 0;
    rfif.WEN = 0;
    rfif.wsel = 0;
    rfif.wdat = 0;
    aluif.PortB = 0;
    pcif.NewPC = 0;

    //ALUSrc Extend
    if(cuif.imm[15] == 1) 
    begin
      SignExtImm = {16'hffff, cuif.imm};
    end
    else 
    begin
      SignExtImm = {16'h0000, cuif.imm};
    end

    //Branch
    if(cuif.branch == 1)
    begin
    if(cuif.branchsel == 1)
    begin
      BranchAddr = pcif.npc + {ZeroExtImm[29:0], 2'b00};
    end else 
    begin
      BranchAddr = pcif.npc;
    end
    end

    //RegFile
    //RegWEN
    if(cuif.RegWEN && (dpif.ihit | dpif.dhit))
    begin
      rfif.WEN = 1;
    end
    else
    begin
      rfif.WEN = 0;
    end

    //RegDst
    casez(cuif.RegDst)

        2'b00://rd
        begin
          rfif.wsel = cuif.rd;
        end

        2'b01://rt
        begin
          rfif.wsel = cuif.rt;
        end      

        2'b10://r31
        begin
          rfif.wsel = 5'b11111;
        end
    endcase

    casez(cuif.ALUSrc)

        3'b000:
        begin
          aluif.PortB = rfif.rdat2;
        end

        3'b001:
        begin
          aluif.PortB = SignExtImm;
        end

        3'b010:
        begin
          aluif.PortB = ZeroExtImm;
        end

        3'b011:
        begin
          aluif.PortB = cuif.shamt;
        end
    endcase

    //Regdata 
    if(cuif.ALUSrc ==3'b100)
    begin
      rfif.wdat = {cuif.imm, 16'b0};
    end
    else if (cuif.instr[31:26] ==  JAL)
    begin
      rfif.wdat = pcif.npc;
    end
    else if (cuif.MemReg)
    begin
      rfif.wdat = dpif.dmemload;
    end
    else
    begin
      rfif.wdat = aluif.PortOut;
    end
  

    //PC address of jtype
    if(cuif.jump == 0 )
    begin
      if(cuif.jr == 1)
      begin
        pcif.NewPC = rfif.rdat1;
      end
      else
      begin
        pcif.NewPC = pcif.npc;
      end
    end
    else 
    begin
      pcif.NewPC = JumpAddr;
    end
    //PC address of branch
    if(cuif.branchsel == 1) 
    begin
      pcif.NewPC = BranchAddr;
    end
  end

//halt
always_ff @(posedge CLK or negedge nRST)
begin
  if(~nRST)
  begin
    dpif.halt<=0;
  end
  else 
  begin
    dpif.halt<= cuif.halt | dpif.halt;
  end
end


endmodule
