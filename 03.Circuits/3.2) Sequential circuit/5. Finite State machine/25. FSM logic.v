module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output z
);
     parameter S0 = 0;
    parameter S1 = 1;
    parameter S2 = 2;
    parameter S3 = 3;
    parameter S4 = 4;
   
    reg [2:0] Y;
    
    always @(*) begin
        case(y)
                S0: Y = (x==1)? S1: S0;
                S1: Y = (x==1)? S4: S1;
                S2: Y = (x==1)? S1: S2;
                S3: Y = (x==1)? S2: S1;
                S4: Y = (x==1)? S4: S3;
                default:Y = S0;
            endcase
        end
    
    assign z=(y == S3) || (y == S4);
    assign Y0 = Y[0];

endmodule
