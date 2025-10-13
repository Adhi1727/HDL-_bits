module top_module (
    input clk,
    input resetn,   
    input in,
    output out);
    reg [2:0] q;
    
    always @(posedge clk) begin
        if(!resetn) begin
            q <= 0;
            out <= 0;
        end
        else begin
            q <= {in,q[2:1]};
            out <= q[0];
        end
    end
endmodule

