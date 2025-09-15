module top_module ( 
    input p1a, p1b, p1c, p1d, p1e, p1f,
    output p1y,
    input p2a, p2b, p2c, p2d,
    output p2y );
    wire w,x,y,z;
    assign w=(p1c&p1b&p1a);
    assign x=(p1f&p1e&p1d);
    assign p1y=w|x;
    assign y=p2a&p2b;
    assign z=p2d&p2c;
    assign p2y=y|z;

endmodule
