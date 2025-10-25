module top_module(
    input clk,
    input [7:0] in,
    input reset,
    output [1:0] next_state,
    output done); 
    
    parameter byte1 = 0;
    parameter byte2 = 1;
    parameter byte3 = 2;
    parameter DONE = 3;
    
    reg [1:0] state;
    
    assign next_state = (state==byte1)?(in[3]?byte2:byte1):(state==byte2)?byte3:(state==byte3)?DONE:(state==DONE)?(in[3]?byte2:byte1):byte1;
    
    always @(posedge clk or posedge reset) begin
        if(reset)
            state<=byte1;
        else
            state<=next_state;
    end
        
        assign done=(state==DONE);

endmodule
