// mapped needs this
`include "datapath_cache_if.vh"
`include "caches_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module dcache_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
	datapath_cache_if dcif ();
  caches_if cif ();
	
  // test program
  test PROG (CLK, nRST, dcif, cif);
  // DUT
`ifndef MAPPED
  dcache DUT(CLK, nRST, dcif, cif);
`endif

endmodule

program test(
	input logic CLK,
	output logic nRST,
	datapath_cache_if.cache dcif,
  caches_if.dcache cif
);

	parameter PERIOD = 10;
	int testcase = 4;
	int hitcount = 0;

	logic [3:0]  idx1 				= 4'd1;
	logic [25:0] tag1_frame1 	= 26'd1;
	logic [25:0] tag1_frame2 	= 26'd11;

	logic [3:0]  idx4					= 4'd4;
	logic [25:0] tag4				 	= 26'd20;
	logic [3:0]	 idx7					= 4'd7;

	logic [25:0] tag_junk 		= 26'd69;
	logic [25:0] tag_hit			=	26'd69;
	logic [25:0] tag_new			= 26'd18;
	logic [25:0] tag_last			= 26'd500;
	logic [25:0] tag_last2			= 26'd600;

	logic offset0 						= 1'b0;
	logic offset1 						= 1'b1;

	logic [25:0] tag_junk_2 		= 26'd99;
	
	initial begin

		
  end

endprogram
