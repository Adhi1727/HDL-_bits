module top_module;
    reg clk,reset,t;
    wire q;
    tff uut(.clk(clk),.reset(reset),.t(t),.q(q));
    
    initial clk = 0;
    always #5 clk = ~clk;
    
    initial begin
        #10; reset = 1'b0;
        #10; reset = 1'b1;
        #10; reset = 1'b0;   
    end
    
    always @(posedge clk or posedge reset) begin
        if(reset)
            t = 1'b0;
        else 
            t = 1'b1;
    end

endmodule
