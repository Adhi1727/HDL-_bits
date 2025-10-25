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
        case(state)
            s0:begin
                if(x==1) next_state = s1;
                else next_state=s0;
            end
            s1:begin
                if(x==1) next_state = s2;
                else next_state = s1;
            end
            s2:begin
                if(x==1) next_state = s2;
                else next_state = s1;
            end
            default:next_state=s0;
        endcase
    end 
    
    always @(posedge clk or posedge areset) begin
        if(areset)
            state<=s0;
        else 
            state<=next_state;
    end
    
    assign z = (state==s1);
endmodule
