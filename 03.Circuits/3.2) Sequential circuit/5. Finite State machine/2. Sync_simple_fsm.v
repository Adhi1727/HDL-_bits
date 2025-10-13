module top_module(clk, reset, in, out);
    input clk;
    input reset;    
    input in;
    output out;
    reg out;

    parameter A=0;
    parameter B=1;

    reg present_state, next_state;

    always @(posedge clk) begin
        if (reset) begin  
            present_state <= B;
        end 
        else begin
               present_state<=next_state;
        end
    end
        
        always @(*) begin
            case (present_state)
                A:if(in==0)
                    next_state=B;
                else
                    next_state=A;
                B:if(in==0)
                    next_state=A;
                else
                    next_state=B;
            endcase
        end
    
    assign out = (present_state==B);
endmodule
