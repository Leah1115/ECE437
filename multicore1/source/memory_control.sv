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
  parameter CPUS = 2;
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
  } MC_STATE;

MC_STATE state,next_state;
logic cpu, next_cpu, icpu, next_icpu, cpu0, next_cpu0;

always_ff @(posedge CLK, negedge nRST ) begin 
    if(!nRST)begin
        state <= IDLE;
        cpu <= 0;
        cpu0 <= 0;
        icpu <= 0;
    end
    else begin
        state <= next_state;
        cpu <= next_cpu;
        cpu0 <= next_cpu0;
        icpu <= next_icpu;
    end
end


always_comb begin
    next_state = state; 
    casez(state)
        IDLE:begin
            next_state = IDLE;
            if(ccif.iREN != 0)begin
                next_state = IF;
            end
            if((ccif.dREN!=0) && (ccif.cctrans!=0))begin
                next_state = SNOOPING;
            end
            if(ccif.dWEN!=0)begin
                next_state = WB1;
            end
        end

        IF:begin
            next_state = IF;
            if(ccif.ramstate == ACCESS) begin
                // if(ccif.cctrans!='0)begin
                //     next_state = SNOOPING;
                // end else begin
                    next_state = IDLE;
                // end
            end
            // if(ccif.dWEN[0] || ccif.dWEN[1])begin
            //     next_state = WB1;
            // end
        end

        CACHE_CACHE1:begin
            next_state = CACHE_CACHE1;
            if (ccif.ramstate == ACCESS) begin
              next_state = CACHE_CACHE2;
            end          
        end

        CACHE_CACHE2:begin
            next_state = CACHE_CACHE2;
            if (ccif.ramstate == ACCESS) begin
              next_state = IDLE;
            end           
        end

        WB1:begin
            next_state = WB1;
            if (ccif.ramstate == ACCESS) begin
              next_state = WB2;
            end             
        end

        WB2:begin
            next_state = WB2;
            if (ccif.ramstate == ACCESS) begin
              next_state = IDLE;
            end             
        end

        RAM_CACHE1:begin
            next_state = RAM_CACHE1;
            if (ccif.ramstate == ACCESS) begin
                next_state = RAM_CACHE2;
            end             
        end

        RAM_CACHE2:begin
            next_state = RAM_CACHE2;
            if (ccif.ramstate == ACCESS) begin    
                next_state = IDLE;     
            end          
        end

        SNOOPING:begin
            next_state = SNOOPING;
			if(ccif.dREN[0] || ccif.dREN[1]) begin
				next_state=SNOOPING1;
			end
            
        end

        SNOOPING1:begin
            next_state = RAM_CACHE1;
            if(ccif.ccwrite[cpu0] && ccif.cctrans[cpu0])begin
                next_state = CACHE_CACHE1;
            end          
        end

    endcase
    
end

always_comb begin

    ccif.ramstore = '0;
    ccif.ramaddr = '0;
    ccif.ramWEN = '0;
    ccif.ramREN = '0;

    ccif.dload = '0;  
    ccif.iload = '0;
    ccif.iwait[0] = 1;
    ccif.iwait[1] = 1;
    ccif.dwait[0] = 1;
    ccif.dwait[1] = 1;

    next_cpu = cpu;
    next_icpu = icpu;
    next_cpu0 = cpu0;
    ccif.ccwait = 0; 
    ccif.ccsnoopaddr = {ccif.daddr[0],ccif.daddr[1]}; 
    ccif.ccinv={ccif.ccwrite[0],ccif.ccwrite[1]};
    casez(state)

        IDLE:begin
        ccif.ccwait = 0;
            if(ccif.dWEN!=0) begin
                if(ccif.dWEN[0]) begin
                    next_cpu0 = 0;
                end else begin
                    next_cpu0 = 1;
                end
            end

            if(ccif.iREN[0] || ccif.iREN[1])begin
                next_icpu <= !icpu;
            end
            if (ccif.iREN[icpu])begin
                next_icpu <= icpu;
            end
            if(ccif.iREN[0] && ccif.iREN[1])begin
                next_icpu <= !icpu;
            end      

        end

        IF:begin
            if(ccif.iREN[icpu])begin
                ccif.ramaddr = ccif.iaddr[icpu];
                ccif.iload[icpu] = ccif.ramload;
                ccif.ramREN = ccif.iREN[icpu];
                if (ccif.ramstate != ACCESS) begin
                    ccif.iwait[icpu] = 1;
                end 
                else begin
                    ccif.iwait[icpu] = 0;
                end
            end
            else if(ccif.iREN[~icpu])begin
                ccif.ramaddr = ccif.iaddr[~icpu];
                ccif.iload[~icpu] = ccif.ramload;
                ccif.ramREN = ccif.iREN[~icpu];
                if (ccif.ramstate != ACCESS) begin
                    ccif.iwait[~icpu] = 1;
                end 
                else begin
                    ccif.iwait[~icpu] = 0;
                end
            end

            // if(ccif.iREN[0])begin
            //     ccif.ramaddr = ccif.iaddr[0];
            //     ccif.iload[0] = ccif.ramload;
            //     ccif.ramREN = ccif.iREN[0];
            //     if (ccif.ramstate != ACCESS) begin
            //         ccif.iwait[0] = 1;
            //     end 
            //     else begin
            //         ccif.iwait[0] = 0;
            //     end
            // end
            // else if(ccif.iREN[1])begin
            //     ccif.ramaddr = ccif.iaddr[1];
            //     ccif.iload[1] = ccif.ramload;
            //     ccif.ramREN = ccif.iREN[1];
            //     if (ccif.ramstate != ACCESS) begin
            //         ccif.iwait[1] = 1;
            //     end 
            //     else begin
            //         ccif.iwait[1] = 0;
            //     end
            // end

            // if(ccif.ramstate == ACCESS)begin
            //     //  if (ccif.iREN[0])begin
            //     //     next_icpu <= 0;
            //     // end
            //         next_icpu = ~icpu;
            // end
                // ccif.ramaddr = ccif.iaddr[icpu];
                // ccif.iload[icpu] = ccif.ramload;
                // ccif.ramREN = ccif.iREN[icpu];
                // if (next_state == IDLE) begin
                //     ccif.iwait[icpu] = 0;
                // end 
 
        end

        CACHE_CACHE1:begin
            // ccif.ramWEN = ccif.ccwrite[cpu0];
            ccif.ramWEN = ccif.dWEN[cpu0];  
            ccif.ramstore = ccif.dstore[cpu0];
            ccif.ramaddr = ccif.daddr[cpu0];
            ccif.dload[cpu] = ccif.dstore[cpu0];  
            // ccif.ccsnoopaddr[cpu0]=ccif.daddr[cpu];
            ccif.ccwait[cpu0]=1;
            // ccif.ccinv[cpu0] = 0;
            if (ccif.ramstate == ACCESS) begin
                ccif.dwait[0] = 0;
                ccif.dwait[1] = 0;
            end   
            else begin
                ccif.dwait[0] = 1;
                ccif.dwait[1] = 1;
            end
        end

        CACHE_CACHE2:begin
            // ccif.ramWEN = ccif.ccwrite[cpu0]; 
            ccif.ramWEN = ccif.dWEN[cpu0];   
            ccif.ramstore = ccif.dstore[cpu0];
            ccif.ramaddr = ccif.daddr[cpu0];
            ccif.dload[cpu] = ccif.dstore[cpu0];  
            // ccif.ccsnoopaddr[cpu0]=ccif.daddr[cpu];
            ccif.ccwait[cpu0]=1;
            // ccif.ccinv[cpu0] = 0;
            if (ccif.ramstate == ACCESS) begin
                ccif.dwait[0] = 0;
                ccif.dwait[1] = 0;
            end    
            else begin
                ccif.dwait[0] = 1;
                ccif.dwait[1] = 1;
            end           
        end

        WB1:begin
				ccif.ramaddr=ccif.daddr[cpu0];
				ccif.ramstore=ccif.dstore[cpu0];
				ccif.ramWEN=ccif.dWEN[cpu0];
				// ccif.ccwait[cpu0]=1;
			
                if(ccif.ramstate==ACCESS) ccif.dwait[cpu0] = 0;
                else ccif.dwait[cpu0] = 1;                   
        end

        WB2:begin
			ccif.ramaddr=ccif.daddr[cpu0];
				ccif.ramstore=ccif.dstore[cpu0];
				ccif.ramWEN=ccif.dWEN[cpu0];
				// ccif.ccwait[cpu0]=1;
			
                if(ccif.ramstate==ACCESS) ccif.dwait[cpu0] = 0;
                else ccif.dwait[cpu0] = 1;         
        end

        RAM_CACHE1:begin
            ccif.ccwait[cpu0]=1;
            // ccif.ramREN = ccif.dREN[cpu];   
            ccif.ramREN = 1;       
            ccif.ramaddr = ccif.daddr[cpu];
            // ccif.dwait[cpu] = 1;
			ccif.dload[cpu]=ccif.ramload;
            // ccif.ccinv[cpu0] = 0;
            if (ccif.ramstate == ACCESS) begin
              ccif.dwait[cpu] = 0;
            end      
        end

        RAM_CACHE2:begin
            ccif.ccwait[cpu0]=1;
            // ccif.ramREN = ccif.dREN[cpu];          
            // ccif.ramaddr = ccif.daddr[cpu];
            // ccif.dwait[cpu] = 1;
            // // ccif.ccinv[cpu0] = 0;

            ccif.ramREN = 1;       
            ccif.ramaddr = ccif.daddr[cpu];
            // ccif.dwait[cpu] = 1;
			ccif.dload[cpu]=ccif.ramload;
            // ccif.ccinv[cpu0] = 0;
            if (ccif.ramstate == ACCESS) begin
              ccif.dwait[cpu] = 0;
            end            
        end

        SNOOPING:begin
			if(ccif.dREN[0]||ccif.dREN[1]) begin
				if(ccif.dREN[0]) begin
					next_cpu = 0;
					next_cpu0 = 1;
                    if(ccif.ccwrite[0] == 1) begin
                        // ccif.ccinv[1] = 1;
                    end
				end else if(ccif.dREN[1]) begin
					next_cpu = 1;
					next_cpu0 = 0;
                    if(ccif.ccwrite[1] == 1) begin
                        // ccif.ccinv[0] = 1;
                    end
				end
			end
			ccif.ccwait[next_cpu0]=1;
            // ccif.ccwait[cpu0] = '1;
			// ccif.ccsnoopaddr[next_cpu0]=ccif.daddr[next_cpu];
            
            if(ccif.cctrans!=0)begin
                if(ccif.cctrans[0]) begin
                    ccif.ccwait[1] = '1;
                end
                else if(ccif.cctrans[1]) begin
                    ccif.ccwait[0] = '1;
                end                
            end
        end

        SNOOPING1:begin
            ccif.ccwait[cpu0] = '1;
			// ccif.ccsnoopaddr[cpu0]=ccif.daddr[cpu];
        end

    endcase
    

end


endmodule