module top_module(
    input clk,
    input reset,    
    input j,
    input k,
    output out); 

    parameter OFF=0, ON=1; 
    reg state, next_state;

    always @(*) begin
        case(state)
            OFF:if(j==1)
                next_state=ON;
            else 
                next_state=OFF;
            ON:if(k==1)
                next_state=OFF;
            else
                next_state=ON;
        endcase
    end

    always @(posedge clk) begin
         if(reset) begin
            state <= OFF;
        end
        else begin
            state <= next_state;
        end
    end
    
    assign out = (state==ON);
 
endmodule
