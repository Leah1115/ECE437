`include "cache_control_if.vh"
`include "cpu_ram_if.vh"
`include "caches_if.vh"
`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;
`timescale 1 ns/1 ns

module memory_control_tb;

	caches_if cif0(), cif1();
	cache_control_if #(.CPUS(2)) tbccif (cif0, cif1);
	cpu_ram_if tbramif();
	logic CLK = 0;
	logic nRST;
	parameter PERIOD = 10;
	
	always #(PERIOD/2) CLK++;

	test PROG (CLK, nRST, tbccif);

	`ifndef MAPPED
	memory_control DUT(CLK, nRST, tbccif);
	`else
	memory_control DUT(
	.\tbccif.iREN (tbccif.iREN),
	.\tbccif.dREN (tbccif.dREN),
	.\tbccif.dWEN (tbccif.dWEN),
	.\tbccif.dstore (tbccif.dstore),
	.\tbccif.iaddr (tbccif.iaddr),
	.\tbccif.daddr (tbccif.daddr),
	.\tbccif.ramload (tbccif.ramload),
	.\tbccif.ramstate (tbccif.ramstate),
	.\tbccif.ccwrite (tbccif.ccwrite),
	.\tbccif.cctrans (tbccif.cctrans),
	.\tbccif.iwait (tbccif.iwait),
	.\tbccif.dwait (tbccif.dwait),
	.\tbccif.iload (tbccif.iload),
	.\tbccif.dload (tbccif.dload),
	.\tbccif.ramstore (tbccif.ramstore),
	.\tbccif.ramaddr (tbccif.ramaddr),
	.\tbccif.ramWEN (tbccif.ramWEN),
	.\tbccif.ramREN (tbccif.ramREN),
	.\tbccif.ccwait (tbccif.ccwait),
	.\tbccif.ccinv (tbccif.ccinv),
	.\tbccif.ccsnoopaddr (tbccif.ccsnoopaddr)
	);
	`endif
	`ifndef MAPPED
	ram RAMDUT (CLK, nRST, tbramif);
	
	`else
	ram RAMDUT(
	.\tbramif.ramaddr (tbramif.ramaddr),
	.\tbramif.ramstore (tbramif.ramstore),
	.\tbramif.ramREN(tbramif.ramREN),
	.\tbramif.ramWEN(tbramif.ramWEN),
	.\tbramif.ramstate(tbramif.ramstate),
	.\tbramif.ramload(tbramif.ramload)
	);
	`endif
	

assign tbramif.ramaddr = tbccif.ramaddr;
assign tbramif.ramREN = tbccif.ramREN;
assign tbramif.ramWEN = tbccif.ramWEN;
assign tbramif.ramstore = tbccif.ramstore;

endmodule

program test
(
	input logic CLK,
	output logic nRST,
	cache_control_if tbccif
);

int test = 0;
parameter PERIOD = 5;

typedef enum logic [3:0] {
    IDLE, 
    IF, 
    CACHE_CACHE1, 
    CACHE_CACHE2, 
    WB1, 
    WB2, 
    RAM_CACHE1, 
    RAM_CACHE2, 
    SNOOPING,
    SNOOPING1
	} bus_ctrl;
bus_ctrl EXPECTED_STATE;

initial begin

	$display("Cache Controller Test Cases: ");
	
	cif0.dstore = '0;


$finish;
end

endprogram