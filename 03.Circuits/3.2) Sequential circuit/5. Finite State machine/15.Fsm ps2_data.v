module top_module(
    input clk,
    input [7:0] in,
    input reset,    
    output [1:0] next_state,
    output [23:0] out_bytes,
    output done);
    
    parameter byte1 = 0;
    parameter byte2 = 1;
    parameter byte3 = 2;
    parameter DONE = 3;
   
    reg [1:0] state;
    reg [23:0] data;
    
    assign next_state = (state==byte1)?(in[3]?byte2:byte1):(state==byte2)?byte3:(state==byte3)?DONE:(state==DONE)?(in[3]?byte2:byte1):byte1;
    
    
    always @(posedge clk or posedge reset) begin
        if(reset)
            state<=byte1;
        else 
            state<=next_state;
    end
    always @(posedge clk) begin
        if(reset)
            data<=24'b0;
        else
            data<={data[15:8],data[7:0],in};
    end
    
    assign done = (state==DONE);
  assign out_bytes=(done)?data:23'b0;

endmodule
