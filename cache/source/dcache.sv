/*
  Eric Villasenor
  evillase@gmail.com

  this block holds the d cache
*/


// interfaces
`include "datapath_cache_if.vh"
`include "caches_if.vh"

// cpu types
`include "cpu_types_pkg.vh"

module dcache (
  input logic CLK, nRST,
  datapath_cache_if dcif,
  caches_if cif
);
  import cpu_types_pkg::*;
  typedef enum logic [3:0] {
    IDLE, 
    LOAD1, 
    LOAD2, 
    WB1, 
    WB2, 
    COUNT,
    DIRTY,
    FLUSH1, 
    FLUSH2, 
    HALT
  } CACHE_STATE;

  typedef struct packed{
    dcache_frame frame1;
    dcache_frame frame2;
    logic flush;
    logic lru;
  }cache_set;

CACHE_STATE state,next_state;
cache_set set;
cache_set cache_table[7:0];
dcachef_t dcache_addr;
logic hit1,hit2,miss;
word_t count , next_count;
logic [3:0] flush_row, next_flush_row ;
// logic [2:0]flush_col;
// logic  [2:0]next_flush_col;//flush[a]==1 -> idx = a  frame2 need to be flushed
logic flush_c, next_flush_c;

assign dcache_addr = dcif.dmemaddr; 

always_ff @(posedge CLK, negedge nRST ) begin 
    if(!nRST)begin
        state <= IDLE;
        cache_table <= '{default:'0};
        count <= '0;
        flush_row <= '0;
        // flush_col <= '0;
        flush_c <= 0;
    end
    else begin
        state <= next_state;
        cache_table[dcache_addr.idx].lru <= set.lru;
        cache_table[dcache_addr.idx].frame1 <= set.frame1;
        cache_table[dcache_addr.idx].frame2 <= set.frame2;
        cache_table[dcache_addr.idx].flush <= set.flush;
        count <= next_count;
        flush_row <= next_flush_row;
        flush_c <= next_flush_c;
        // flush_col <= next_flush_col;
    end
end

always_comb begin
    hit1 = 0;
    hit2 = 0;
    dcif.dhit = 0;
    dcif.dmemload = '0;
    dcif.flushed = 0;

    cif.dREN = 0;
    cif.dWEN = 0;
    cif.daddr = '0;
    cif.dstore = '0;

    next_state = state;    
    set.frame1 = cache_table[dcache_addr.idx].frame1;
    set.frame2 = cache_table[dcache_addr.idx].frame2;
    set.lru = cache_table[dcache_addr.idx].lru;
    set.flush = 0;
    next_count = count;
    next_flush_row = flush_row;
    // next_flush_col = flush_col;
    next_flush_c = flush_c;
    miss = 0;
    casez(state)
        HALT:begin
            dcif.flushed = 1'b1;
            next_state = HALT;
        end

        IDLE:begin
            
            hit1 = (cache_table[dcache_addr.idx].frame1.tag == dcache_addr.tag)?1:0;
            hit2 = (cache_table[dcache_addr.idx].frame2.tag == dcache_addr.tag)?1:0;
            if(dcif.dmemREN)begin            
                // READ
                if(hit1 && cache_table[dcache_addr.idx].frame1.valid)begin
                    //hit frame1
                    next_count = count + 1;
                    dcif.dhit = 1;
                    set.lru = 1;
                    // next_state = IDLE;
                    dcif.dmemload = dcache_addr.blkoff? cache_table[dcache_addr.idx].frame1.data[1] : cache_table[dcache_addr.idx].frame1.data[0];
                end
                else if(hit2 && cache_table[dcache_addr.idx].frame2.valid)begin
                    //hit frame1
                    next_count = count + 1;
                    dcif.dhit = 1;
                    set.lru = 0;
                    // next_state = IDLE;
                    dcif.dmemload = dcache_addr.blkoff? cache_table[dcache_addr.idx].frame2.data[1] : cache_table[dcache_addr.idx].frame2.data[0];                  
                end
                else begin
                    //miss
                    miss = 1;
                end
            end
            else if(dcif.dmemWEN)begin
                //Write
                if(hit1 && cache_table[dcache_addr.idx].frame1.valid)begin
                    //hit frame1
                    next_count = count + 1;
                    dcif.dhit = 1;
                    set.lru = 1;
                    // next_state = IDLE;
                    set.frame1.dirty = 1;
                    if(dcache_addr.blkoff==1)set.frame1.data[1] = dcif.dmemstore;
                    else set.frame1.data[0] = dcif.dmemstore;
                end    
                else if(hit2 && cache_table[dcache_addr.idx].frame2.valid)begin
                    //hit frame2
                    next_count = count + 1;
                    dcif.dhit = 1;
                    set.lru = 0;
                    // next_state = IDLE;
                    set.frame2.dirty = 1;//////
                    if(dcache_addr.blkoff==1)set.frame2.data[1] = dcif.dmemstore;
                    else set.frame2.data[0] = dcif.dmemstore;  
                end
                else begin
                    //miss
                    miss = 1;
                end
            end

            if(dcif.halt) begin
                next_state = DIRTY;
                // next_state = HALT;
            end
            else if(miss)begin
                next_count = count - 1;
                dcif.dhit = 0;
                if (cache_table[dcache_addr.idx].lru) begin
                  next_state = cache_table[dcache_addr.idx].frame2.dirty ? WB1 : LOAD1;
                end
                else begin
                  next_state = cache_table[dcache_addr.idx].frame1.dirty ? WB1 : LOAD1;
                end
            end
            else begin
                next_state = IDLE;
            end
      end

      LOAD1: begin
          cif.dREN = 1;
          cif.daddr = {dcache_addr.tag, dcache_addr.idx, 3'b000};
          if(cache_table[dcache_addr.idx].lru)begin
              set.frame2.data[0] = cif.dload;
          end
          else begin
              set.frame1.data[0] = cif.dload;
          end

          if(!cif.dwait)begin
            next_state = LOAD2;       
          end
          else begin
            next_state = LOAD1;       
          end      
      end

      LOAD2: begin
          cif.dREN = 1;
          cif.daddr = {dcache_addr.tag, dcache_addr.idx, 3'b100};
          if(cache_table[dcache_addr.idx].lru)begin
              set.frame2.data[1] = cif.dload;
              set.frame2.valid = 1;
              set.frame2.dirty = 0;
              set.frame2.tag = dcache_addr.tag;
          end
          else begin
              set.frame1.data[1] = cif.dload;
              set.frame1.valid = 1;
              set.frame1.dirty = 0;
              set.frame1.tag = dcache_addr.tag;
          end

          if(!cif.dwait)begin
            next_state = IDLE;       
          end
          else begin
            next_state = LOAD2;       
          end      
      end

      WB1: begin
          cif.dWEN = 1;
          if(cache_table[dcache_addr.idx].lru)begin
              cif.daddr = {cache_table[dcache_addr.idx].frame2.tag , dcache_addr.idx ,  3'b000};
              cif.dstore = cache_table[dcache_addr.idx].frame2.data[0];  
          end
          else begin
              cif.daddr = {cache_table[dcache_addr.idx].frame1.tag , dcache_addr.idx ,  3'b000};
              cif.dstore = cache_table[dcache_addr.idx].frame1.data[0];
          end   
          if(!cif.dwait) begin 
              next_state = WB2;
          end       
          else begin
              next_state = WB1;
          end
      end

      WB2: begin
          cif.dWEN = 1;
          if(cache_table[dcache_addr.idx].lru)begin
              cif.daddr = {cache_table[dcache_addr.idx].frame2.tag , dcache_addr.idx ,  3'b100};
              cif.dstore = cache_table[dcache_addr.idx].frame2.data[1];  
          end
          else begin
              cif.daddr = {cache_table[dcache_addr.idx].frame1.tag , dcache_addr.idx ,  3'b100};
              cif.dstore = cache_table[dcache_addr.idx].frame1.data[1];
          end 
          if(!cif.dwait) begin 
              next_state = LOAD1;
          end       
          else begin
              next_state = WB2;
          end         
      end
      

      DIRTY:begin
          if(flush_row <= 8)begin//not flush all
            //   if(cache_table[flush_row].frame1.dirty && (flush_col[flush_row])==0)begin//flush frame1
            if(cache_table[flush_row].frame1.dirty && flush_c==0)begin//flush frame1
                  next_state = FLUSH1;
              end
            //   else if(cache_table[flush_row].frame2.dirty && flush_col[flush_row])begin//flush frame2
            else if(cache_table[flush_row].frame2.dirty && flush_c)begin//flush frame2
                  next_state = FLUSH1;
              end      
            else begin
                if(flush_c==0)begin
                    next_flush_c = 1;
                    next_flush_row = flush_row;
                end
                else begin
                    next_flush_c = 0;
                    next_flush_row = flush_row + 1;
                end
                
                if(flush_row > 7)next_state = COUNT;
                else next_state = DIRTY;
            end        
          end
          else begin // FINISH flush all dirty set
             next_state = COUNT;
            //  next_state = HALT;
          end
      end

      COUNT: begin
          cif.dWEN = 1;
          cif.daddr = 32'h3100;
          cif.dstore = count; //nummber of hit
          if(!cif.dwait) begin
              next_state = HALT;
          end    
          else begin
              next_state = COUNT;
          end   
      end

      FLUSH1:begin
          cif.dWEN = 1;
        //   if(flush_col[flush_row]==0)begin
          if(flush_c == 0)begin  
              cif.daddr = {cache_table[flush_row].frame1.tag , flush_row[2:0] ,  3'b000};
              cif.dstore = cache_table[flush_row].frame1.data[0];              
          end
          else begin
              cif.daddr = {cache_table[flush_row].frame2.tag , flush_row[2:0] ,  3'b000};
              cif.dstore = cache_table[flush_row].frame2.data[0];  
          end
         
          if (!cif.dwait) begin
            next_state = FLUSH2;
          end
          else begin
            next_state = FLUSH1;
          end        
      end

      FLUSH2: begin
          cif.dWEN = 1;
        //   if(flush_col[flush_row]==0)begin
          if(flush_c == 0)begin 
              cif.daddr = {cache_table[flush_row].frame1.tag , flush_row[2:0] ,  3'b100};
              cif.dstore = cache_table[flush_row].frame1.data[1];              
          end
          else begin
              cif.daddr = {cache_table[flush_row].frame2.tag , flush_row[2:0] ,  3'b100};
              cif.dstore = cache_table[flush_row].frame2.data[1];  
          end

          if (!cif.dwait) begin
            // if(flush_col[flush_row]==0)begin
            if(flush_c == 0)begin 
                next_flush_c = 1;
            end
            else begin
                next_flush_c = 0;
                next_flush_row = flush_row + 1;
            end
            next_state = DIRTY;
          end
          else begin
            next_state = FLUSH2;
          end           
      end
      
    endcase
end
endmodule
