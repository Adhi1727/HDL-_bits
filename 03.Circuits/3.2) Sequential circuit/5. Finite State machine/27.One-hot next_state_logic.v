module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4);
    always @(*) begin
        Y2 = 0;
        Y4 = 0;
        
        if (y[1] && ~w)
            Y2 = 1;
        else
            Y2 = 0;

        if (w && (y[2] || y[3] || y[5] || y[6]))
            Y4 = 1;
        else
            Y4 = 0;
    end


endmodule
