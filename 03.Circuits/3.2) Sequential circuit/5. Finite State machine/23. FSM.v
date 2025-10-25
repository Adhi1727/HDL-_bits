module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);
    parameter A = 0;
    parameter B = 1;
    reg state,next_state;
    reg [1:0] count;
    reg [1:0] count1;
    
    always @(*) begin
        case(state)
            A:begin
            if(s==1) next_state=B;
            else next_state=A;
            end
            B:begin
                next_state=B;
            end
        endcase
    end
    
    always @(posedge clk) begin
        if(reset) begin
            state<=A;
            count=0;
            count1=0;
        end
        else begin
            state <= next_state;
            	if(state==B)
                    begin
                        if(count1==3)begin
                            count=0;
                            count1=0;
                        end
                        if(w==1) count=count+1;
                        	count1=count1+1;
                		end
        			end
    end
 		
    assign z = ((count == 2) & (count1 == 3) );
        
            

endmodule
