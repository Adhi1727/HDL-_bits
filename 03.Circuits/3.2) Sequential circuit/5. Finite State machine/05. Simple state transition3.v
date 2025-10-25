module top_module(
    input in,
    input [1:0] state,
    output [1:0] next_state,
    output out); //

    parameter A=0, B=1, C=2, D=3;
    always @(*) begin
        case(state)
            A: if(in==0)
                 next_state = A;
            else 
                 next_state = B;
            B:if(in==0)
                next_state = C;
            else
                next_state = B;
            C:if(in==0)
                next_state = A;
            else
                next_state = D;
            D:if(in==0)
                next_state = C;
            else
                next_state = B;
        endcase
    end

    assign out = (state==D)?1:0;

endmodule
