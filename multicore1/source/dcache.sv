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
    SNOOPING,
    CO_WB1,
    CO_WB2,
    HALT
  } CACHE_STATE;

  typedef struct packed{
    dcache_frame frame1;
    dcache_frame frame2;
    logic flush;
    logic lru;
  }cache_set;

CACHE_STATE state,next_state;
// cache_set next_cache_table[dcache_addr.idx];
cache_set set;
cache_set cache_table[7:0];
// cache_set next_cache_table[7:0];
dcachef_t dcache_addr;
logic hit1,hit2,miss;

word_t count , next_count;
word_t linkReg, next_linkReg; //link registers for LL&SC
logic linkValid,next_linkValid; //valid bit for link registers
logic atomsuccess;
logic [5:0] flush_row, next_flush_row ;
logic flush_c, next_flush_c;
logic [2:0] index;

logic [2:0] s_index; 
logic [25:0]s_tag;
logic s_valid0;
logic s_valid1;
logic [1:0] s_valid_tag;
logic [25:0] s_tag0;
logic [25:0] s_tag1;
logic s_frame,next_s_frame;



assign dcache_addr = dcif.dmemaddr; 



always_ff @(posedge CLK, negedge nRST ) begin 
    if(!nRST)begin
        state <= IDLE;
        cache_table<= '{default:'0};
        count <= '0;
        flush_row <= '0;
        flush_c <= 0;
        s_frame <= 0;
        linkReg <='0;
        linkValid <=0;
    end
    else begin
        state <= next_state;
        // cache_table <= next_cache_table;
        cache_table[index].lru <= set.lru;
        cache_table[index].frame1 <= set.frame1;
        cache_table[index].frame2 <= set.frame2;
        cache_table[index].flush <= set.flush;
        count <= next_count;
        flush_row <= next_flush_row;
        flush_c <= next_flush_c;
        s_frame <= next_s_frame;
        linkReg <= next_linkReg;
        linkValid <= next_linkValid;
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
    cif.ccwrite = 0;
    cif.cctrans = '0;

    next_state = state;    
    // next_cache_table= cache_table;
    index = cif.ccwait ? cif.ccsnoopaddr[5:3] : dcif.dmemaddr[5:3];
    set.frame1 = cache_table[index].frame1;
    set.frame2 = cache_table[index].frame2;
    set.lru = cache_table[index].lru;

    next_count = count;
    next_flush_row = flush_row;
    next_flush_c = flush_c;
    next_s_frame = s_frame;
    miss = 0;

    // Snooping var
    s_tag = cif.ccsnoopaddr[31:6];
    s_index = cif.ccsnoopaddr[5:3];
    s_valid0 = cache_table[s_index].frame1.valid;
    s_valid1 = cache_table[s_index].frame2.valid;
    s_tag0 = cache_table[s_index].frame1.tag;
    s_tag1 = cache_table[s_index].frame2.tag;

    //atomicity registers
    next_linkReg = linkReg;
    next_linkValid = linkValid;
    atomsuccess = 0;
    casez(state)
        HALT:begin
            dcif.flushed = 1'b1;
            next_state = HALT;
        end

        IDLE:begin
            
            hit1 = (cache_table[dcache_addr.idx].frame1.tag == dcache_addr.tag)?1:0;
            hit2 = (cache_table[dcache_addr.idx].frame2.tag == dcache_addr.tag)?1:0;
            if(cif.ccwait)begin
                next_state = SNOOPING;
            end
            else if(dcif.dmemREN)begin  //read
                //LL
                if(dcif.datomic) begin
                    next_linkReg = dcif.dmemaddr;
                    next_linkValid = 1;
                end

                // READ
                if(hit1 && cache_table[dcache_addr.idx].frame1.valid)begin
                    //hit frame1
                    next_count = count + 1;
                    dcif.dhit = 1;
                    set.lru = 1;
                    dcif.dmemload = dcache_addr.blkoff? cache_table[dcache_addr.idx].frame1.data[1] : cache_table[dcache_addr.idx].frame1.data[0];
                end
                else if(hit2 && cache_table[dcache_addr.idx].frame2.valid)begin
                    //hit frame1
                    next_count = count + 1;
                    dcif.dhit = 1;
                    set.lru = 0;
                    dcif.dmemload = dcache_addr.blkoff? cache_table[dcache_addr.idx].frame2.data[1] : cache_table[dcache_addr.idx].frame2.data[0];                  
                end
                else begin
                    //miss
                    miss = 1;
                end
            end //end for dmemREN

            else if(dcif.dmemWEN)begin //write
                //SC
                if(dcif.datomic) begin
                    atomsuccess = (linkReg == dcif.dmemaddr)? linkValid : 0;
                    if(atomsuccess)begin
                        dcif.dmemload = 32'd1;
                        if(hit1 && cache_table[dcache_addr.idx].frame1.valid)begin
                        //hit frame1
                            next_count = count + 1;
                            dcif.dhit = 1;
                            set.lru = 1;
                            set.frame1.dirty = 1;
                            next_linkReg = '0;
                            next_linkValid = 0;
                            if(dcache_addr.blkoff==1) set.frame1.data[1] = dcif.dmemstore;
                            else set.frame1.data[0] = dcif.dmemstore;
                        end 
                        else if(hit2 && cache_table[dcache_addr.idx].frame2.valid)begin
                        //hit frame2
                            next_count = count + 1;
                            dcif.dhit = 1;
                            set.lru = 0;
                            set.frame2.dirty = 1;//////
                            next_linkReg = '0;
                            next_linkValid = 0;
                            if(dcache_addr.blkoff==1) set.frame2.data[1] = dcif.dmemstore;
                            else set.frame2.data[0] = dcif.dmemstore;  
                        end 
                        else begin
                            //miss
                            miss = 1;
                        end
                    end// end for atomicity success  
                    else begin
                        dcif.dmemload = '0;
                        dcif.dhit = 1;
                    end
                end//end for atomic

                else begin//for non SC Write

                    if(dcif.dmemaddr == linkReg) begin //if address equals to link register in non SC write, invalidate
                        next_linkReg = '0;
                        next_linkValid = '0;
                    end

                    if(hit1 && cache_table[dcache_addr.idx].frame1.valid)begin
                        //hit frame1
                        next_count = count + 1;
                        dcif.dhit = 1;
                        set.lru = 1;
                        set.frame1.dirty = 1;
                        if(dcache_addr.blkoff==1) set.frame1.data[1] = dcif.dmemstore;
                        else set.frame1.data[0] = dcif.dmemstore;
                    end    
                    else if(hit2 && cache_table[dcache_addr.idx].frame2.valid)begin
                        //hit frame2
                        next_count = count + 1;
                        dcif.dhit = 1;
                        set.lru = 0;
                        set.frame2.dirty = 1;//////
                        if(dcache_addr.blkoff==1) set.frame2.data[1] = dcif.dmemstore;
                        else set.frame2.data[0] = dcif.dmemstore;  
                    end
                    else begin
                        //miss
                        miss = 1;
                    end
                end
            end//end for dmemWEN

            if(cif.ccwait)begin
                next_state = SNOOPING;
            end
            else if(dcif.halt) begin
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
                cif.dREN = '1;
                cif.cctrans = '1;
                cif.daddr = {dcache_addr.tag, dcache_addr.idx, 3'b000};
                if(dcif.dmemWEN) begin
                    cif.ccwrite = '1; 
                end
                if(set.lru)begin
                    set.frame2.data[0] = cif.dload;
                end
                else begin
                    set.frame1.data[0] = cif.dload;
                end

                if(cif.ccwait)begin
                        next_state = SNOOPING;
                end
                else if(!cif.dwait)begin
                    next_state = LOAD2;       
                end
                else begin
                    next_state = LOAD1;       
                end  
    
      end

      LOAD2: begin    
          cif.dREN = 1;
          cif.daddr = {dcache_addr.tag, dcache_addr.idx, 3'b100};
          cif.cctrans = 1;
          if(dcif.dmemWEN && !cif.ccwait) begin
                cif.ccwrite = 1; 
          end
          if(set.lru)begin
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
    	  if (cif.ccwait) begin
			next_state = SNOOPING;
		  end 
          else 
          if((flush_row <= 8)&&(!cif.ccwait))begin//not flush all
            if(cache_table[flush_row].frame1.dirty && flush_c==0)begin//flush frame1
                  next_state = FLUSH1;
              end
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
                
                if(flush_row > 7)next_state = HALT;//next_state = COUNT;
                else next_state = DIRTY;
            end        
          end
          else begin // FINISH flush all dirty next_cache_table[dcache_addr.idx]
            next_state = HALT;
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
          if(flush_c == 0)begin 
              cif.daddr = {cache_table[flush_row].frame1.tag , flush_row[2:0] ,  3'b100};
              cif.dstore = cache_table[flush_row].frame1.data[1];             
          end
          else begin
              cif.daddr = {cache_table[flush_row].frame2.tag , flush_row[2:0] ,  3'b100};
              cif.dstore = cache_table[flush_row].frame2.data[1];  
          end

          if (!cif.dwait) begin
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

	SNOOPING: begin
        cif.cctrans = '1;
        if(!cif.ccwait) begin
            next_state = IDLE;
        end
        else begin
            if(cif.ccsnoopaddr[31:6] == cache_table[cif.ccsnoopaddr[5:3]].frame1.tag && cache_table[cif.ccsnoopaddr[5:3]].frame1.valid)begin
                if(cache_table[cif.ccsnoopaddr[5:3]].frame1.dirty)begin
                    cif.ccwrite = '1;
                    next_state = CO_WB1;
                    next_s_frame = 0;
                    if(dcif.dmemREN) begin //M--> S, deasserting dirty bit
                        set.frame1.dirty = '0;
                    end 
                end
                if(cif.ccinv)begin
                    if(cif.ccsnoopaddr == linkReg)begin
                        next_linkReg = '0;
                        next_linkValid = 0;
                    end
                end
            end
            else if(cif.ccsnoopaddr[31:6] == cache_table[cif.ccsnoopaddr[5:3]].frame2.tag && cache_table[cif.ccsnoopaddr[5:3]].frame2.valid)begin
                if(cache_table[cif.ccsnoopaddr[5:3]].frame2.dirty)begin
                    cif.ccwrite = '1;
                    next_state = CO_WB1;
                    next_s_frame = 1;
                    if(dcif.dmemREN) begin //M--> S, deasserting dirty bit
                        set.frame2.dirty = '0;
                    end 
                end
                if(cif.ccinv)begin
                    if(cif.ccsnoopaddr == linkReg)begin
                        next_linkReg = '0;
                        next_linkValid = 0;
                    end
                end
            end
            
        end

            if(cif.ccinv)begin
                if(s_frame==0)set.frame1.valid = 0;
                if(s_frame==1)set.frame2.valid = 0;
            end
	end

	CO_WB1: begin
          cif.dWEN = 1;
        //   cif.ccwrite = 1;
          if(s_frame)begin
              cif.daddr = {cache_table[cif.ccsnoopaddr[5:3]].frame2.tag , cif.ccsnoopaddr[5:3] ,  3'b000};
              cif.dstore = cache_table[cif.ccsnoopaddr[5:3]].frame2.data[0];  
          end
          else begin
              cif.daddr = {cache_table[cif.ccsnoopaddr[5:3]].frame1.tag , cif.ccsnoopaddr[5:3] ,  3'b000};
              cif.dstore = cache_table[cif.ccsnoopaddr[5:3]].frame1.data[0];
          end  

          if(!cif.dwait) begin 
              next_state = CO_WB2;
          end       
          else begin
              next_state = CO_WB1;
          end
	end

	CO_WB2: begin
          cif.dWEN = 1;
          if(s_frame)begin
              cif.daddr = {cache_table[cif.ccsnoopaddr[5:3]].frame2.tag , cif.ccsnoopaddr[5:3] ,  3'b100};
              cif.dstore = cache_table[cif.ccsnoopaddr[5:3]].frame2.data[1];  
          end
          else begin
              cif.daddr = {cache_table[cif.ccsnoopaddr[5:3]].frame1.tag , cif.ccsnoopaddr[5:3] ,  3'b100};
              cif.dstore = cache_table[cif.ccsnoopaddr[5:3]].frame1.data[1];
          end  
          
          if(!cif.dwait) begin 
              next_state = IDLE;
          end       
          else begin
              next_state = CO_WB2;
          end
	end
      
    endcase
end
endmodule