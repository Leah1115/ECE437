`include "cache_control_if.vh"
`include "cpu_ram_if.vh"
`include "caches_if.vh"
`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;
`timescale 1 ns/1 ns

module memory_control_tb;
//clock
parameter PERIOD = 20;

logic CLK = 1, nRST;
always #(PERIOD/2) CLK++;

//interface
caches_if cif0();
caches_if cif1();
cache_control_if #(.CPUS(1)) ccif(cif0, cif1);
cpu_ram_if cprf();

//test program
test PROG(CLK, nRST, ccif);

//DUT
memory_control DUT(CLK, nRST, ccif);
ram DUT2(CLK, nRST, cprf);

assign cprf.ramaddr = ccif.ramaddr;
assign cprf.ramstore = ccif.ramstore;
assign cprf.ramREN = ccif.ramREN;
assign cprf.ramWEN = ccif.ramWEN;
assign ccif.ramload = cprf.ramload;
assign ccif.ramstate = cprf.ramstate;

endmodule

program test(
    input logic CLK,
    output logic nRST,
    cache_control_if ccif
);
parameter PERIOD = 20;
parameter PERIOD2 = 40;
initial 
begin
    //initial
   
    nRST = 0;
    #(PERIOD2);
    nRST = 1;
    cif0.dstore = 32'b0;
    cif0.daddr = 32'b0;
    cif0.iaddr = 32'b0;
    cif0.iREN = 0;
    cif0.dREN = 0;
    cif0.dWEN = 0;
    #(PERIOD2);

    //read instr
    cif0.iREN = 1;
    cif0.dREN = 0;
    cif0.dWEN = 0;
    cif0.dstore = 32'b0;
    cif0.daddr = 32'b0;
    cif0.iaddr = 32'b0;
    for(int i = 0; i < 5; i++)
    begin
        cif0.iaddr = cif0.iaddr + 4;
        #(PERIOD);
        if(cif0.iload != ccif.ramload)
        begin
            $display("Failed to read instruction %h at address %h", ccif.ramload, ccif.ramaddr);
        end
        #(PERIOD);
    end
    $display("Reading Instruction PASSED!");

    //write data
    cif0.iREN = 0;
    cif0.dREN = 0;
    cif0.dWEN = 1;
    cif0.dstore = 32'hffffffff;
    cif0.daddr = 32'h0;
    cif0.iaddr = 32'h0;
    for(int i = 0; i < 5; i++)
    begin
        #(PERIOD);
        if(cif0.dstore!=ccif.ramstore)
        begin
           $display("Failed to write %h at address %h", ccif.ramstore, cif0.daddr); 
        end
        cif0.dstore = cif0.dstore + 10;
        cif0.daddr += 1;
    end
    $display("Writing Data PASSED!");



    //read  data
    cif0.iREN = 0;
    cif0.dREN = 1;
    cif0.dWEN = 0;
    for (int i = 0; i < 5; i++)
    begin
        #(PERIOD);
        if(cif0.dload != ccif.ramload)
        begin
            $display("Failed to read %h at %h", ccif.ramload, cif0.daddr);
        end
        cif0.daddr += 1;
    end
    $display("Reading Data PASSED!");

    //Read ins and data
    cif0.iREN = 1;
    cif0.dREN = 1;
    cif0.dWEN = 0;
    for(int i = 0; i < 5; i++)
    begin
        cif0.iaddr = cif0.iaddr + 4;
        #(PERIOD)
        if(cif0.dload!=ccif.ramload)
        begin
           $display("FAILED to load %h at %h", ccif.ramload, cif0.dload); 
        end
        cif0.daddr += 1;
    end
    $display ("Reading instr and Reading data PASSED!");

    // Read ins and write data
    cif0.iREN = 1;
    cif0.dREN = 0;
    cif0.dWEN = 1;
    cif0.dstore = 32'h12345678;
    for(int i = 0; i < 5; i++)
    begin
        #(PERIOD);
        cif0.iaddr += 4;
        cif0.daddr += 1;
        if(cif0.dstore != ccif.ramstore || cif0.iload != ccif.ramload)
        begin
        $display("Reading instr and Writing data Failed!");
        end
        #(PERIOD);
    end
    $display("Reading instr and Writing data PASSED!");
    dump_memory();
    $finish;
end
   // Dump Memory
task automatic dump_memory();
    string filename = "memcpu.hex";
    int memfd;

    
    cif0.daddr = 0;
    cif0.dWEN = 0;
    cif0.dREN = 0;

    memfd = $fopen(filename,"w");
    if (memfd)
      $display("Starting memory dump.");
    else
      begin $display("Failed to open %s.",filename); $finish; end

    for (int unsigned i = 0; memfd && i < 16384; i++)
    begin
      int chksum = 0;
      bit [7:0][7:0] values;
      string ihex;

      cif0.daddr = i << 2;
      cif0.dREN = 1;
      repeat (4) @(posedge CLK);
      if (cif0.dload === 0)
        continue;
      values = {8'h04,16'(i),8'h00,cif0.dload};
      foreach (values[j])
        chksum += values[j];
      chksum = 16'h100 - chksum;
      ihex = $sformatf(":04%h00%h%h",16'(i),cif0.dload,8'(chksum));
      $fdisplay(memfd,"%s",ihex.toupper());
    end //for
    if (memfd)
    begin
      cif0.dREN = 0;
      $fdisplay(memfd,":00000001FF");
      $fclose(memfd);
      $display("Finished memory dump.");
    end
  endtask
endprogram