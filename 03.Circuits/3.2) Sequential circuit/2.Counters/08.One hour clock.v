module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 
     always @(posedge clk) begin
        if (reset) begin
            ss <= 8'h00;
            mm <= 8'h00;
            hh <= 8'h12; 
            pm <= 0;     
        end
        else if (ena) begin
            if (ss == 8'h59) begin
                ss <= 8'h00;
			    if (mm == 8'h59) begin
                    mm <= 8'h00;
                    if (hh == 8'h11) begin
                        hh <= 8'h12;
                        pm <= ~pm;        
                    end
                    else if (hh == 8'h12)
                        hh <= 8'h01;      
                    else if (hh[3:0] == 4'h9) begin
                        hh[3:0] <= 4'h0;
                        hh[7:4] <= hh[7:4] + 1'b1;
                    end
                    else
                        hh[3:0] <= hh[3:0] + 1'b1;
                end
                else begin
                    if (mm[3:0] == 4'h9) begin
                        mm[3:0] <= 4'h0;
                        mm[7:4] <= mm[7:4] + 1'b1;
                    end
                    else
                        mm[3:0] <= mm[3:0] + 1'b1;
                end
            end
            else begin
                if (ss[3:0] == 4'h9) begin
                    ss[3:0] <= 4'h0;
                    ss[7:4] <= ss[7:4] + 1'b1;
                end
                else
                    ss[3:0] <= ss[3:0] + 1'b1;
            end
        end
    end

endmodule
