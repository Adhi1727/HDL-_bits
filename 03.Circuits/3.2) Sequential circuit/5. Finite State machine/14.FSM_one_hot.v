module top_module(
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);
    
    parameter s0 = 4'h0;
    parameter s1 = 4'h1;
    parameter s2 = 4'h2;
    parameter s3 = 4'h3;
    parameter s4 = 4'h4;
    parameter s5 = 4'h5;
    parameter s6 = 4'h6;
    parameter s7 = 4'h7;
    parameter s8 = 4'h8;
    parameter s9 = 4'h9;
    
    assign next_state[s0] = (state[s0]&~in)|(state[s1]&~in)|(state[s2]&~in)|(state[s3]&~in)|(state[s4]&~in)|(state[s7]&~in)|
                            (state[s8]&~in)|(state[s9]&~in);
	assign next_state[s1] = (state[s0]&in)|(state[s8]&in)|(state[s9]&in);
    assign next_state[s2] = state[s1]&in;
    assign next_state[s3] = state[s2]&in;
    assign next_state[s4] = state[s3]&in;
    assign next_state[s5] = state[s4]&in;
    assign next_state[s6] = state[s5]&in;
    assign next_state[s7] = (state[s6]&in)|(state[s7]&in);
    assign next_state[s8] = state[s5]&~in;
    assign next_state[s9] = state[s6]&~in;

    assign out1 = (state[s8]|state[s9]);
    assign out2 = (state[s7]|state[s9]);
                    
endmodule
