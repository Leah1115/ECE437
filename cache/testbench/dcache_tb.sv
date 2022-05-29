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

    //Test case 0: Reset everything
    nRST = 0;
    @(posedge CLK)
    @(posedge CLK)
    nRST = 1;
    tbdcif.halt = 0;
    tbdcif.datomic = 0;
    tbdcif.dmemstore = '0;
    tbdcif.dmemaddr = '0;
    tbcif.dwait = 1;
    tbcif.dload = '0;
    tbdcif.dmemREN = 0;
    tbdcif.dmemWEN = 0;


    $display("dcache:");
      //READ READ READ READ
    //Test case 1: test miss
    @(posedge CLK)
    test = 1;
    tbdcif.dmemREN = 1;
    tbdcif.dmemWEN = 0;
    tbdcif.halt = 0;
    tbdcif.datomic = 0;
    tbdcif.dmemstore = '0;
    tbdcif.dmemaddr = 32'h00001234;
    tbcif.dwait = 1;
    tbcif.dload = 32'hABABABAB;
    #(PERIOD);
    assert(!tbdcif.dhit && !tbcif.dREN && !tbcif.dWEN && tbcif.daddr == '0 && tbdcif.dmemload == '0 && !tbdcif.flushed && tbcif.dstore == '0)
    $display("Test %d ok.", test);
    else $display("Test %d failed.", test);
    
    //Test case 2: Test LD1, load abababab into the addr 00001234
    @(posedge CLK)
    test++;
    @(posedge CLK)
    @(posedge CLK)
    @(posedge CLK)
    tbcif.dwait = 1;
    assert(!tbdcif.dhit && tbcif.dREN && !tbcif.dWEN && tbcif.daddr == {tbdcif.dmemaddr[31:3],3'b000} && tbdcif.dmemload == '0 && !tbdcif.flushed && tbcif.dstore == '0)
    $display("Test %d ok.", test);
    else $display("Test %d failed.", test);

    //Test case 3: In LD1 first, wanna load new data 12345678 in the data[0], then in LD2, wanna load 12345678 in data[1]
    @(posedge CLK)
    test++;

      tbcif.dload = 32'h12345678;
    tbdcif.dmemaddr = 32'h00001234;
    tbcif.dwait = 0; //next_state = LOAD2  state = LD1
    #(PERIOD);	
    // tbcif.dload = 32'h12345678;//SATE = LD2
    #(PERIOD);	
    assert(!tbdcif.dhit && tbcif.dREN && !tbcif.dWEN && tbcif.daddr == {tbdcif.dmemaddr[31:3],3'b100} && tbdcif.dmemload == '0 && !tbdcif.flushed && tbcif.dstore == '0)
    $display("Test %d ok.", test);
    else $display("Test %d failed.", test);
    
    //Test case 4: both of the data should be 12345678 now
    tbcif.dwait = 1;	
    @(posedge CLK)
    test++;
    @(posedge CLK)
    @(posedge CLK)
    #(PERIOD);
    assert(!tbdcif.dhit && tbcif.dREN && !tbcif.dWEN && tbcif.daddr == {tbdcif.dmemaddr[31:3],3'b100} && tbdcif.dmemload == '0 && !tbdcif.flushed && tbcif.dstore == '0)
    $display("Test %d ok.", test);
    else $display("Test %d failed.", test);
    
    //Test case 5: WE got two data in the cahce, test hit.
    // idx :6   frame1  data0:12345678 data1:1234568     addr:h00001234
    @(posedge CLK)
    test++;
    tbcif.dwait = 0;
    //tbcif.dload = 32'h01234537;
    #(PERIOD);
    #(PERIOD);
    assert(tbdcif.dhit && !tbcif.dREN && !tbcif.dWEN && tbcif.daddr == '0 && tbdcif.dmemload == 32'h12345678 && !tbdcif.flushed && tbcif.dstore == '0)
    $display("Test %d ok.", test);
    else $display("Test %d failed.", test);

    //Test case 6: continue test 5
    @(posedge CLK)
    test++;
    #(PERIOD);
    assert(!tbcif.dWEN && tbcif.daddr == '0 &&  tbdcif.dhit && !tbcif.dREN   && tbdcif.dmemload == 32'h12345678 && !tbdcif.flushed && tbcif.dstore == '0)
    $display("Test %d ok.", test);
    else $display("Test %d failed.", test);

    //Test case 7: do nothing, still in the same state as test6
    test++;
    tbdcif.dmemREN = 0;
    tbdcif.dmemWEN = 0;
    #(PERIOD);
    assert(!tbdcif.dhit && !tbcif.dREN && !tbcif.dWEN && tbcif.daddr == '0 && tbdcif.dmemload == '0 && !tbdcif.flushed && tbcif.dstore == '0)
    $display("Test %d ok.", test);
    else $display("Test %d failed.", test);

    //Test case 8: We have a hit in the left side of data, we can hit the right.,too (They are the same)
    @(posedge CLK)
    test++;
    tbdcif.dmemREN = 1;
    tbdcif.dmemaddr = 32'h00001230;

    tbcif.dwait = 0;
    #(PERIOD);
    assert(tbdcif.dhit && !tbcif.dREN && !tbcif.dWEN && tbcif.daddr == '0 && tbdcif.dmemload == 32'h12345678 && !tbdcif.flushed && tbcif.dstore == '0)
    $display("Test %d ok.", test);
    else $display("Test %d failed.", test);
    
      //Write  Write  Write  Write  Write
    //Test case 9: 0001234 is in the cache, if we write, should be hit and dirty
    @(posedge CLK)
    test++;
    tbdcif.dmemWEN = 1;
    tbdcif.dmemREN = 0;
    tbdcif.dmemaddr = 32'h00001234;
    tbdcif.dmemstore = 32'h22223333;
    #(PERIOD);
    assert(tbdcif.dhit && !tbcif.dREN && !tbcif.dWEN && tbcif.daddr == '0 && tbdcif.dmemload == '0 && !tbdcif.flushed && tbcif.dstore == '0)
    $display("Test %d ok.", test);
    else $display("Test %d failed.", test);

    //Test case 10: After write (hit), we read again, which should be a direct hit
    @(posedge CLK)
    test++;
    tbdcif.dmemWEN = 0;
    tbdcif.dmemREN = 1;
    tbdcif.dmemaddr = 32'h00001234;
    #(PERIOD);
    assert(tbdcif.dhit && !tbcif.dREN && !tbcif.dWEN && tbcif.daddr == '0 && tbdcif.dmemload == 32'h22223333 && !tbdcif.flushed && tbcif.dstore == '0)
    $display("Test %d ok.", test);
    else $display("Test %d failed.", test);

    //Test case 11: write to a cache block that does not have data yet, so it is a miss and dirt bit will be high
    @(posedge CLK)
    test++;
    tbdcif.dmemWEN = 1;
    tbdcif.dmemREN = 0;
    tbdcif.dmemaddr = 32'h0000124C;
    tbdcif.dmemstore = 32'h02120203;
    tbcif.dwait = 1;
    @(posedge CLK)
    assert(!tbdcif.dhit && tbcif.dREN && !tbcif.dWEN && tbcif.daddr == {tbdcif.dmemaddr[31:3],3'b000} && tbdcif.dmemload == '0 && !tbdcif.flushed && tbcif.dstore == '0)
    $display("Test %d ok.", test);
    else $display("Test %d failed.", test);

    //Test case 12: RAM will act. Load the left data
    @(posedge CLK)
    test++;
    tbdcif.dmemaddr = 32'h0000124C;
    tbcif.dload = 32'haaaaaaaa;
    tbcif.dwait = 0;
    #(PERIOD);
    assert(!tbdcif.dhit && tbcif.dREN && !tbcif.dWEN && tbcif.daddr == {tbdcif.dmemaddr[31:3],3'b000} && tbdcif.dmemload == '0 && !tbdcif.flushed && tbcif.dstore == '0)
    $display("Test %d ok.", test);
    else $display("Test %d failed.", test);

    //Test case 13: Load the right data
    @(posedge CLK)
    test++;
    tbcif.dload = 32'hbbbbbbbb;
    #(PERIOD);
    assert(!tbdcif.dhit && tbcif.dREN && !tbcif.dWEN && tbcif.daddr == {tbdcif.dmemaddr[31:3],3'b100} && tbdcif.dmemload == '0 && !tbdcif.flushed && tbcif.dstore == '0)
    $display("Test %d ok.", test);
    else $display("Test %d failed.", test);

    //Test case 14: statemachien now should be in IDLE state. write will return a hit
    @(posedge CLK)
    test++;
    tbcif.dwait = 1;
    #(PERIOD);
    assert(tbdcif.dhit && !tbcif.dREN && !tbcif.dWEN && tbcif.daddr == '0 && tbdcif.dmemload == '0 && !tbdcif.flushed && tbcif.dstore == '0)
    $display("Test %d ok.", test);
    else $display("Test %d failed.", test);

    //Test case 15: Weite the the other word. Since the block is in the cache, we should get a hit
    @(posedge CLK)
    test++;
    tbdcif.dmemaddr = 32'h00001248; //124c -4 
    tbdcif.dmemstore = 32'heeeeeeee;
    #(PERIOD);
    assert(tbdcif.dhit && !tbcif.dREN && !tbcif.dWEN && tbcif.daddr == '0 && tbdcif.dmemload == '0 && !tbdcif.flushed && tbcif.dstore == '0)
    $display("Test %d ok.", test);
    else $display("Test %d failed.", test);
    ////READ READ READ READ
    //Test case 16: Same index, different tag.  the block was previously written, so get a cache miss
    @(posedge CLK)
    test++;
    tbdcif.dmemaddr = 32'h010112C8; //1001001001100 -> 1001011001000
    tbcif.dload = 32'hdddddddd;
    tbdcif.dmemREN = 1;
    tbdcif.dmemWEN = 0;
    tbcif.dwait = 1;
    #(PERIOD);
    assert(!tbdcif.dhit && !tbcif.dREN && !tbcif.dWEN && tbcif.daddr == '0 && tbdcif.dmemload == '0 && !tbdcif.flushed && tbcif.dstore == '0)
    $display("Test 16.1 OK.");
    else $display("Test case 16.1 failed.");
    @(posedge CLK)
    @(posedge CLK)
    @(posedge CLK)
    //16.1 Now the data is ready
    tbcif.dwait = 0;
    @(posedge CLK)
    tbcif.dwait = 1;
    tbcif.dload = 32'hBEEFFACE;
    @(posedge CLK)
    @(posedge CLK)
    tbcif.dwait = 0;
    @(posedge CLK)
    tbcif.dwait = 1;
    #(PERIOD);
    //now shoud get a hit
    assert(tbdcif.dhit && !tbcif.dREN && !tbcif.dWEN && tbcif.daddr == '0 && tbdcif.dmemload == 32'hdddddddd && !tbdcif.flushed && tbcif.dstore == '0)
    $display("Test 16.2 OK.");
    else $display("Test case 16.2 failed.");

    //Test case 17: read agagin, same DIRTY index, different tag, the row that is completely filled (should get a cache miss, and a replacement should occur)
    //need to write dity blocks back to RAM
    @(posedge CLK)

    test++;
    tbdcif.dmemaddr = 32'h123412CC; //1001011001100
    tbcif.dload = 32'h98765432;
    tbdcif.dmemREN = 1;
    tbdcif.dmemWEN = 0;
    tbcif.dwait = 1;
    #(PERIOD);
    assert(!tbdcif.dhit && !tbcif.dREN && !tbcif.dWEN && tbcif.daddr == '0 && tbdcif.dmemload == '0 && !tbdcif.flushed && tbcif.dstore == '0)
    $display("Test case 17 OK.");
    else $display("Test case 17.1 failed.");
    @(posedge CLK)
    @(posedge CLK)
    //Writes first word back to RAM
    assert(!tbdcif.dhit && !tbcif.dREN && tbcif.dWEN && tbcif.daddr == 32'h00001248 && tbdcif.dmemload == '0 && !tbdcif.flushed && tbcif.dstore == 32'h1eeeeeeee)
    $display("MEM WB1 OK.");
    else $display("Test case failed.");
    @(posedge CLK)
    tbcif.dwait = 0;
    @(posedge CLK)
    tbcif.dwait = 1;
    @(posedge CLK)
    //Writes second word to memory
    assert(!tbdcif.dhit && !tbcif.dREN && tbcif.dWEN && tbcif.daddr == 32'h0000124C && tbdcif.dmemload == '0 && !tbdcif.flushed && tbcif.dstore == 32'h02120203)
    $display("MEM WB2 OK.");
    else $display("Test case failed.");
    @(posedge CLK)
    tbcif.dwait = 0;
    @(posedge CLK)
    tbcif.dwait = 1;
    @(posedge CLK)
    //Loads first word from memory into the block (dload = 98765432)
    @(posedge CLK)
    tbcif.dwait = 0;
    @(posedge CLK)
    tbcif.dwait = 1;
    tbcif.dload = 32'hBAD0C0DE;
    @(posedge CLK)
    //Loads second word from memory into the block (dload = BAD0C0DE)
    @(posedge CLK)
    tbcif.dwait = 0;
    @(posedge CLK)
    tbcif.dwait = 1;
    #(PERIOD);
    //IDLE state
    assert(tbdcif.dhit && !tbcif.dREN && !tbcif.dWEN && tbcif.daddr == '0 && tbdcif.dmemload == 32'hBAD0C0DE && !tbdcif.flushed && tbcif.dstore == '0)
    $display("read hit OK.");
    else $display("Test case failed.");

    //Test case 18: write again  with a new tag same index. Cache miss
    @(posedge CLK)
    test++;
    tbdcif.dmemaddr = 32'h432112CC;
    tbdcif.dmemstore = 32'hDDDDDDDD;
    tbcif.dload = 32'h00000001;
    tbdcif.dmemREN = 0;
    tbdcif.dmemWEN = 1;
    tbcif.dwait = 1;
    #(PERIOD);
    assert(!tbdcif.dhit && !tbcif.dREN && !tbcif.dWEN && tbcif.daddr == '0 && tbdcif.dmemload == '0 && !tbdcif.flushed && tbcif.dstore == '0)
    $display("Test 18 OK.");
    else $display("Test case failed.");
    @(posedge CLK)
    @(posedge CLK)
    @(posedge CLK)
    tbcif.dwait = 0;
    @(posedge CLK)
    tbcif.dwait = 1;
    @(posedge CLK)
    //Loads first word from memory into the block (dload = 00000001)
    @(posedge CLK)
    tbcif.dwait = 0;
    tbcif.dload = 32'hC0DE0007;
    @(posedge CLK)
    tbcif.dwait = 1;
    
    @(posedge CLK)
    //Loads second word from memory into the block (dload = C0DE0007)
    @(posedge CLK)
    tbcif.dwait = 0;
    @(posedge CLK)
    tbcif.dwait = 1;
    #(PERIOD);
    //IDLE state
    assert(tbdcif.dhit && !tbcif.dREN && !tbcif.dWEN && tbcif.daddr == '0 && tbdcif.dmemload == '0 && !tbdcif.flushed && tbcif.dstore == '0)
    $display("memory load ok.");
    else $display("Test case failed.");

    //Test case 19: Assert halt and then check the design's behavior
    @(posedge CLK)
    test++;
    tbdcif.halt = 1;
    tbcif.dwait = 0;
    #(PERIOD*10);
    #(PERIOD*10);
    #(PERIOD*10);
    #(PERIOD*10);
    #(PERIOD*10);
    #(PERIOD*10);
    assert(tbdcif.flushed)
    $display("FLUSH ok.", test);
    else $display("Test %d failed.", test);
    
    #(PERIOD);
    #(PERIOD);

  $finish;
    
  end
endprogram
