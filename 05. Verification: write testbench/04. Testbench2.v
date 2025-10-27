module top_module;
    reg clk,in;
    reg [2:0] s;
    wire out;
    
    q7 uut(.clk(clk),.in(in),.s(s),.out(out));
    
    initial clk = 0;
    always #5 clk = ~clk;
    
    initial begin
        in = 0;
        s = 2;
        #10 s = 6;
        #10 in=1; s=2;
        #10 in=0; s=7;
        #10 in=1; s=0;
        #30 in=0;
        
    end
    
   
    
   

endmodule
