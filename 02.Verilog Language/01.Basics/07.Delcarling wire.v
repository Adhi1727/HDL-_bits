`default_nettype none
module top_module(
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n   ); 
    wire x,z;
    assign x=a&b;
    assign z=c&d;
    assign out=x|z;
    assign out_n=~out;

endmodule
