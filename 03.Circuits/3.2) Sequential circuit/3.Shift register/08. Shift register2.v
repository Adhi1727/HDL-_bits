module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
); 
    always @(posedge KEY[0]) begin
        if(KEY[2]) begin
            LEDR <= SW;
        end
        else if(KEY[1]) begin
            LEDR <= {KEY[3],LEDR[3:1]};
        end
        else begin
            LEDR <= LEDR;
        end
    end

endmodule
