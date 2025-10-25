module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    parameter s0 = 0;
    parameter s1 = 1;
    parameter s2 = 2;
    
    reg [1:0] state,next_state;
    
    always @(*) begin
        next_state = s0;
        z = 0;
        case(state)
            s0:begin
                if(x==1)begin
                    next_state=s1;
                    z=1;
                end
                else begin 
                    next_state=s0;
                    z=0;
                end
            end
            s1:begin
                if(x==1)begin 
                    next_state=s2;
                    z=0;
                end
                else begin
                    next_state=s1;
                     z=1;
                end
            end
            s2:begin
                if(x==1)begin 
                    next_state=s2;
                    z=0;
                end
                else begin 
                    next_state=s1;
                    z=1;
                end
            end
            default:begin
                next_state=s0;
                z=0;
            end
        endcase
    end
    
    always @(posedge clk or posedge areset) begin
        if(areset)
            state<=s0;
        else
            state<=next_state;
    end
   
                    

endmodule
