module top_module (
    input clk,
    input reset,
    output [9:0] q);
    
    reg [9:0] count;
    
    always @(posedge clk) begin
        if(reset)
            count<=10'd0;
        else if(count==10'd999)
            count<=10'd0;
        else 
        count<=count+1;
    end
    
    assign q = count;
            
        
        

endmodule
