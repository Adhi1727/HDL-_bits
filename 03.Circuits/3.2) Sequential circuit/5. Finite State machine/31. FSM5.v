module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output [3:1] g   // grant
); 
    parameter A = 0;
    parameter B = 1;
    parameter C = 2;
    parameter D = 3;
    
    reg [1:0] state, next_state;
    
    always@(*) begin
        case(state)
            A:begin
                if(r[1]) next_state = B;
                else if(~r[1] & r[2]) next_state = C;
                else if(~r[1] & ~r[2] & r[3]) next_state = D;
                else next_state = A;
            end
            B:begin
                if(r[1]) next_state = B;
                else next_state = A;
            end
            C:begin
                if(r[2]) next_state = C;
                else next_state = A;
            end
            D:begin
                if(r[3]) next_state = D;
                else next_state = A;
            end
        endcase
    end

    always@(posedge clk) begin
        if(resetn)
            state <= next_state;
        else
            state <= A;
    end
    
    assign g[1] = (state == B);
    assign g[2] = (state == C);
    assign g[3] = (state == D);
endmodule
