/*
  Eric Villasenor
  evillase@gmail.com

  this block is the coherence protocol
  and artibtration for ram
*/

// interface include
`include "cache_control_if.vh"

// memory types
`include "cpu_types_pkg.vh"

module memory_control (
  input CLK, nRST,
  cache_control_if.cc ccif
);
  // type import
  import cpu_types_pkg::*;

  // number of cpus for cc
  parameter CPUS = 1;

//assign op
// assign ccif.iload = ccif.ramload;
assign ccif.iload = (ccif.iREN && ~(ccif.dWEN) && ~(ccif.dREN))? ccif.ramload:0;
assign ccif.dload = ccif.ramload;
assign ccif.ramstore = ccif.dstore;

//address
assign ccif.ramaddr = (ccif.dREN||ccif.dWEN ? ccif.daddr:ccif.iaddr);
assign ccif.ramWEN = ccif.dWEN;
assign ccif.ramREN = (ccif.dREN||ccif.iREN) && ~(ccif.dWEN);


//wait signal
always_comb 
begin
  // ccif.iload = '0;
  ccif.iwait = 1'b1;
  ccif.dwait = 1'b1;
  casez(ccif.ramstate)
  FREE://Free
  begin
    ccif.iwait = 1'b1;
    ccif.dwait = 1'b1;
  end
  BUSY://Busy
  begin
    ccif.iwait = 1'b1;
    ccif.dwait = 1'b1;
  end
  ACCESS://access
  begin
    if(ccif.dREN||ccif.dWEN)
    begin
      ccif.iwait = 1'b1;
      ccif.dwait = 1'b0;
    end
    else if(ccif.iREN)
    begin
      ccif.iwait = 1'b0;
      ccif.dwait = 1'b1;
    end
  end 
  ERROR://error
  begin
    ccif.iwait = 1'b1;
    ccif.dwait = 1'b1;
  end
  endcase
end
endmodule
