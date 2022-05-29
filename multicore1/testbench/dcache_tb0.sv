/*
  Eric Villasenor
  evillase@gmail.com

  register file test bench
*/

// mapped needs this
`include "caches_if.vh"
`include "cpu_types_pkg.vh"
`include "datapath_cache_if.vh"
`include "cpu_ram_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module dcache_tb;

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
  cpu_ram_if ramif();
  // test program
  test PROG (CLK, nRST, dcif, cif);
  // DUT
`ifndef MAPPED
  dcache DUT(CLK, nRST, dcif,cif);
  ram DUT2(CLK,nRST,ramif);
`else
`endif

assign ramif.ramaddr = cif.daddr;
assign ramif.ramREN = cif.dREN;
assign ramif.ramWEN = cif.dWEN;
assign ramif.ramstore = cif.dstore;

endmodule

program test(
	input logic CLK,
  output logic nRST,
  datapath_cache_if tbdcif,
	caches_if tbcif
);
    parameter PERIOD = 5;
    int test = 0;


  initial begin

    
    #(PERIOD);
    #(PERIOD);

  $finish;
    
  end
endprogram
