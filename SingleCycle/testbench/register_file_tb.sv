/*
  Eric Villasenor
  evillase@gmail.com

  register file test bench
*/

// mapped needs this
`include "register_file_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module register_file_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // test vars
  int v1 = 1;
  int v2 = 4721;
  int v3 = 25119;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  register_file_if rfif ();

  // test program
  test PROG (CLK, nRST, rfif, v1, v2, v3);
  
  // DUT
`ifndef MAPPED
  register_file DUT(CLK, nRST, rfif);
`else
  register_file DUT(
    .\rfif.rdat2 (rfif.rdat2),
    .\rfif.rdat1 (rfif.rdat1),
    .\rfif.wdat (rfif.wdat),
    .\rfif.rsel2 (rfif.rsel2),
    .\rfif.rsel1 (rfif.rsel1),
    .\rfif.wsel (rfif.wsel),
    .\rfif.WEN (rfif.WEN),
    .\nRST (nRST),
    .\CLK (CLK)
  );
`endif

endmodule

program test(
  input logic CLK,
  output logic nRST,
  register_file_if.tb rfif,
  input int v1,v2,v3
);



initial 
begin
  
  int i;
  //Initial
  rfif.WEN=0;
  rfif.wdat=0;
  rfif.wsel=0;
  rfif.rsel1=0;
  rfif.rsel2=0;
  nRST=1'b0;
  @(posedge CLK)
  nRST=1'b1;
  //Test reg0
  @(posedge CLK)
  rfif.WEN=1;
  rfif.wdat=v3;
  rfif.wsel=0;
  rfif.rsel1=0;
  rfif.rsel2=0;
  @(posedge CLK)
  if(rfif.rdat1 == 0 && rfif.rdat2 == 0)
       $display("Reg0 Passed");
  else
       $error("Reg0 Failed");

  //Test general reg (reg2)
  // @(posedge CLK)
  // rfif.wdat=v2;
  // rfif.wsel=2;
  // rfif.rsel1=2;
  // rfif.rsel2=2;
  // @(posedge CLK);
  // if (rfif.rdat1==v2&&rfif.rdat2==v2)
  //      $display("Normal Reg Passed");
  // else if(rfif.rdat1!=v2||rfif.rdat2!=v2)
  //      $error("Normal Reg FAILED");
  // @(posedge CLK);
  @(posedge CLK);
  for(i=1; i<32;i++)
  begin
       @(posedge CLK)
       rfif.wdat=i;
       rfif.wsel=i;
       rfif.rsel1=i;
       rfif.rsel2=i;
       @(posedge CLK)
       if(rfif.rdat1==rfif.wdat&&rfif.rdat2==rfif.wdat)
           $display("Register %d Passed",i);
       else if(rfif.rdat1!=rfif.wdat||rfif.rdat2!=rfif.wdat)
           $error("Register %d Failed", i);
  end  
  
//Reset
  @(posedge CLK)
  nRST=1'b0;
  @(posedge CLK);
  
end
endprogram
