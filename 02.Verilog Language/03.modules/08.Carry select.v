module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire cy1,cy2,cy3;
    wire [15:0]s1,s2;
    add16(a[15:0],b[15:0],1'b0,sum[15:0],cy1);
    add16(a[31:16],b[31:16],1'b0,s1[15:0],cy2);
    add16(a[31:16],b[31:16],1'b1,s2[15:0],cy3);
    
    always @(*) begin
        if(cy1)
            sum[31:16] = s2;
        else
            sum[31:16] = s1;
    end

endmodule
