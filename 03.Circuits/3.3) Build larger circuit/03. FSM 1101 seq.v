module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting);
    
    parameter s0 = 0;
    parameter s1 = 1;
    parameter s2 = 2;
    parameter s3 = 3;
    parameter s4 = 4;
    
    reg [2:0] state,next_state;
    
    always @(*) begin
        case(state)
            s0:begin
                if(data==1) next_state = s1;
                else next_state = s0;
            end
            s1:begin
                if(data==1) next_state = s2;
                else next_state = s0;
            end
            s2:begin
                if(data==1) next_state = s2;
                else next_state = s3;
            end
            s3:begin
                if(data==1) next_state = s4;
                else next_state = s0;
            end 
            s4:begin
                next_state = s4;
            end
            default:next_state = s0;
        endcase
    end
    
    always @(posedge clk) begin
        if(reset)
            state <= s0;
        else
            state <= next_state;
    end
   
    
         
    assign start_shifting = (state == s4);
 
            
               

endmodule
