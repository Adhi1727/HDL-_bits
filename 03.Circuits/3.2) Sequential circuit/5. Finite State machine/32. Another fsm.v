module top_module (
    input clk,
    input resetn,    
    input x,
    input y,
    output f,
    output g
); 
      parameter A = 0;
    parameter B = 1;
    parameter F0 = 2;
    parameter F1 = 3;
    parameter F2 = 4;
    parameter G1 = 5;
    parameter C = 6;
    parameter G1P = 7;
    parameter G0P = 8;
    
    reg [3:0] state, next_state;
    
    always @(posedge clk) begin
        if(!resetn)
            state <= A;
        else
            state = next_state;
    end
    
    always @(*) begin
        case(state)
            A:next_state = resetn ? B:A;
            B:next_state = F0;
            F0:next_state = x ? F1:F0;
            F1:next_state = x ? F1:F2;
            F2:next_state = x ? G1:F0;
            G1:next_state = y ? G1P:C;
            C:next_state = y ? G1P:G0P;
            G1P:next_state = resetn ? G1P:A;
            G0P:next_state = resetn ? G0P:A;
        endcase
    end
        
    assign f = (state == B);
    assign g = (state == C) || (state == G1) || (state == G1P);
        
endmodule
