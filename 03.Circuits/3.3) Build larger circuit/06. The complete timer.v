module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output reg [3:0] count,
    output counting,
    output done,
    input ack
);
    parameter S0=0;
    parameter S1=1;
    parameter S2=2;
    parameter S3=3;
    parameter B0=4;
    parameter B1=5;
    parameter B2=6;
    parameter B3=7;
    parameter COUNT=8;
    parameter WAIT=9;
    
    reg [3:0] state, next_state;
    reg [9:0] count_1000; 

    always @(posedge clk) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end


    always @(*) begin
        case (state)
            S0:next_state = data ? S1 : S0;
            S1:next_state = data ? S2 : S0;
            S2:next_state = data ? S2 : S3;
            S3:next_state = data ? B0 : S0;
            B0:next_state = B1;
            B1:next_state = B2;
            B2:next_state = B3;
            B3:next_state = COUNT;
            COUNT:next_state = ((count == 0) && (count_1000 == 999)) ? WAIT : COUNT;
            WAIT:next_state = ack ? S0 : WAIT;
            default:next_state = S0;
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            count <= 4'd0;
            count_1000 <= 10'd0;
        end
        else begin
            case (state)
                B0:count[3] <= data;
                B1:count[2] <= data;
                B2:count[1] <= data;
                B3:count[0] <= data;

                COUNT:begin
                    if (count_1000 < 999)
                        count_1000 <= count_1000 + 1;
                    else begin
                        count_1000 <= 0;
                        if (count > 0)
                            count <= count - 1;
                    end
                end

                default:count_1000 <= 0;
            endcase
        end
    end

    assign counting = (state == COUNT);
    assign done = (state == WAIT);

endmodule
