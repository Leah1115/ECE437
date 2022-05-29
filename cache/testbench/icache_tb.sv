/*
  Eric Villasenor
  evillase@gmail.com

  register file test bench
*/

// mapped needs this
`include "caches_if.vh"
`include "cpu_types_pkg.vh"
`include "datapath_cache_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module icache_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // test vars
  int v1 = 1;
  int v2 = 4721;
  int v3 = 25119;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  datapath_cache_if dcif();
  caches_if cif ();
  // test program
  test PROG (CLK, nRST, dcif, cif);
  // DUT
`ifndef MAPPED
  icache DUT(CLK, nRST, dcif,cif);
`else

`endif

endmodule

program test(
	input logic CLK,
  output logic nRST,
  datapath_cache_if tbdcif,
	caches_if tbcif
);
    parameter PERIOD = 10;
    int test = 0;
  initial begin
    nRST= 0;
      //Reset
      #(PERIOD);
    nRST = 1;

    tbdcif.imemREN = 0;
    tbdcif.halt = 0;
    tbdcif.imemaddr = '0;
    tbcif.iwait = 1;
    tbcif.iload = '0;

    //Test case 1: Cache must miss after reset. iREN should be high and iaddr is imemaddr)
    test++;
    #(PERIOD);
    tbdcif.imemREN = 1;
    tbdcif.halt = 0;
    tbdcif.imemaddr = 32'hFFFFFFFF;
    tbcif.iwait = 1;
    tbcif.iload = 32'hAAAAAAAA;
    #(PERIOD);
    // $display("tbdcif.ihit %d",tbdcif.ihit);
    assert(!tbdcif.ihit && tbdcif.imemload == 32'hAAAAAAAA && tbcif.iREN && tbcif.iaddr == 32'hFFFFFFFF)
    $display("Test %d ok.", test);
    else $display("Test %d failed.", test);
      #(PERIOD);
    #(PERIOD);
    tbcif.iwait = 0;
    tbcif.iload = 32'hFFFFFFFF;

    //Test case 2: insert halt
    
    test++;
    #(PERIOD);
    tbdcif.imemREN = 1;
    tbdcif.halt = 1;
    tbdcif.imemaddr = 32'hAABBCCDD;
    tbcif.iwait = 1;
    tbcif.iload = 32'hBABADADA;
      #(PERIOD);
    assert(!tbdcif.ihit && tbdcif.imemload == '0 && !tbcif.iREN && tbcif.iaddr == '0)
    $display("Test %d ok.", test);
    else $display("Test case 2 failed.");

    //Test case 3: 1,
    //1. Load a word  from RAM into the cache 
    //2.  cache should hit when the tag matches
    #(PERIOD)
    test++;
    tbdcif.halt = 0;
    tbdcif.imemREN = 1;
    tbdcif.imemaddr = 32'h12345678;
    tbcif.iwait = 0;
    tbcif.iload = 32'hFFFFFFFF;
    #(PERIOD)
    tbdcif.imemREN = 1;
    tbdcif.imemaddr = 32'h12345678;
    #(PERIOD)
    assert(tbdcif.ihit && tbdcif.imemload == 32'hFFFFFFFF && !tbcif.iREN)
    $display("Test %d ok.", test);
    else $display("Test %d failed.", test);
    #(PERIOD)
    #(PERIOD)
    #(PERIOD)
    
    //Test case 4: 
    // load a word from RAM to cache (overwrite)
    // but datapath request value from another address
    test++;
    #(PERIOD)
    //load word
    tbdcif.imemREN = 0;
    tbdcif.halt = 0;
    tbdcif.imemaddr = 32'h87654321;
    tbcif.iwait = 0;
    tbcif.iload = 32'h10000000;
    #(PERIOD)
    #(PERIOD)
    tbdcif.imemREN = 1;
    tbdcif.halt = 0;
    tbcif.iwait = 1;
    tbdcif.imemaddr = 32'h88654321;
    tbcif.iload = 32'h00000001;
    #(PERIOD)
    assert(!tbdcif.ihit && tbdcif.imemload == 32'h00000001 && tbcif.iREN && tbcif.iaddr == 32'h88654321)
    $display("Test %d ok.", test);
    else $display("Test %d failed.", test);
    tbcif.iwait = 0;
    #(PERIOD)
      tbdcif.imemREN = 0;
    #(PERIOD)
    //Test case 5: read the address from test 4 and get a hit.
    
    #(PERIOD)
    test++;
    // tbdcif.imemaddr = 32'h87654321;
    tbdcif.imemaddr = 32'h88654321;
    tbcif.iwait = 1;
    tbcif.iload = '0;
    tbdcif.imemREN = 1;
    tbdcif.halt = 0;
    #(PERIOD)
    // assert(tbdcif.ihit && tbdcif.imemload == 32'h10000000 && !tbcif.iREN && tbcif.iaddr == '0)
    assert(tbdcif.ihit && tbdcif.imemload == 32'h00000001 && !tbcif.iREN && tbcif.iaddr == '0)
    $display("Test %d ok.", test);
    else $display("Test %d failed.", test);
    #(PERIOD)
    #(PERIOD) $finish;
    
  end
endprogram
