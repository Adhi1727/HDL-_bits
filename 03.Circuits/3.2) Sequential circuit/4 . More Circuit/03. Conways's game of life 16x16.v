module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q ); 
    reg [255:0] next;
    integer x,y,nx,ny;
    integer count;
    
    always @(*) begin
        for (y=0;y<16;y=y+1) begin
            for(x=0;x<16;x=x+1)begin
                count=0;
                for(ny=-1;ny<=1;ny=ny+1) begin
                    for(nx=-1;nx<=1;nx=nx+1) begin
                        if(!(nx==0 && ny==0)) begin
                            integer xx,yy;
                            xx=(x+nx+16)%16;
                            yy=(y+ny+16)%16;
                            count=count+q[xx+yy*16];
                        end
                    end
                end
                if(count==3)
                    next[x+y*16]=1;
                else if(count==2)
                    next[x+y*16]=q[x+y*16];
                else
                    next[x+y*16]=0;
            end
                end
    end
    
    always @(posedge clk) begin
                    if(load)
                        q<=data;
                    else
                        q<=next;
                end
endmodule
