/*
  Eric Villasenor
  evillase@gmail.com

  this block holds the i and d cache
*/


// interfaces
`include "datapath_cache_if.vh"
`include "caches_if.vh"

// cpu types
`include "cpu_types_pkg.vh"

module icache (
  input logic CLK, nRST,
  datapath_cache_if.icache dcif,
  caches_if.icache cif
);
  // import types
  import cpu_types_pkg::*;

  icache_frame [15:0] cache_table; 

  icachef_t imemaddr;
  // logic [25:0] tag;
  logic [3:0] index;
  logic hit_en;

  assign hit_en = ((imemaddr.tag == cache_table[imemaddr.idx].tag)&&cache_table[imemaddr.idx].valid) ? 1 : 0;
  assign imemaddr = dcif.imemaddr;
  assign index = dcif.imemaddr[5:2];
	assign cif.iREN = (cache_table[imemaddr.idx].valid && hit_en) ? 0 : dcif.imemREN;
  // assign cif.iREN = (cache_table[imemaddr.idx].valid && hit_en) ? 0 : 1;
	assign cif.iaddr = (cache_table[imemaddr.idx].valid && hit_en) ? 0 : dcif.imemaddr;

  always_ff @(posedge CLK, negedge nRST) begin

    if (nRST == 0) begin
      cache_table <= '{default:'0};
    end
    else begin
      if (cif.iwait == 0) begin //update cache
        cache_table[imemaddr.idx].valid <= 1;
        cache_table[imemaddr.idx].tag<= imemaddr.tag;
        cache_table[imemaddr.idx].data <= cif.iload;
      end
    end
    
  end


always_comb begin
  dcif.ihit = 0;
  dcif.imemload = '0;
  // cif.iREN = 0;

  if (dcif.imemREN) begin
    if (cache_table[imemaddr.idx].valid && hit_en)begin
      dcif.ihit = 1;
      dcif.imemload = cache_table[imemaddr.idx].data;
      // cif.iREN = 1;
    end
    else begin 
      //miss
      // dcif.ihit = !cif.iwait; 
      dcif.ihit = 0; 
      dcif.imemload = 0;//cache_table[imemaddr.idx].data;
    end
  end

end


endmodule
