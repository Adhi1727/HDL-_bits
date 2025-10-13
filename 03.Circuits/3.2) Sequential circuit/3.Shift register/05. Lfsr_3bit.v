module top_module (
	input [2:0] SW,      
    input [1:0] KEY,     
	output [2:0] LEDR);  
    
    wire L = KEY[1];
    wire clk = KEY[0];
    reg [2:0] Q;
    
    always @(posedge clk) begin
        if(L)
            Q<=SW;
        else
            Q <= {Q[1]^Q[2],Q[0],Q[2]};
    end
    
     assign LEDR = Q;
 endmodule

