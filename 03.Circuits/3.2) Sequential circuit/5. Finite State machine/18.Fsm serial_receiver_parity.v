module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); 
    parameter IDLE = 3'b000;
	parameter START = 3'b001;
	parameter DATA = 3'b010;
	parameter WAIT = 3'b011;
	parameter STOP = 3'b100;
    parameter CHECK = 3'b101;

    reg [2:0] state, next_state;
	reg [3:0] i;
    reg [7:0] out;
    reg odd_reset;
    reg odd_reg;
    wire odd;

	always @(*) begin
		case(state)
			IDLE:next_state=(in)?IDLE:START;
			START:next_state=DATA;
            DATA:next_state=(i==8)?CHECK:DATA;
            CHECK:next_state=(in)?STOP:WAIT;
			WAIT:next_state=(in)?IDLE:WAIT;
			STOP:next_state=(in)?IDLE:START;
		endcase
	end
    
    always @(posedge clk) begin
        if(reset) state<=IDLE;
        else state<=next_state;
    end
    
    always @(posedge clk) begin
        if (reset) begin
            i <= 0;
        end
        else begin
            case(next_state)
                DATA:begin
                    i = i + 1;
                end
                STOP:begin
                    i <= 0;
                end
                default:begin
                    i <= 0;
                end
            endcase
        end
    end  
    
    always @(posedge clk) begin
        if (reset) out <= 0;
        else if (next_state==DATA)
            out[i] <= in;
    end
  
    parity u_parity(
        .clk(clk),
        .reset(reset | odd_reset),
        .in(in),
        .odd(odd)
    );
    
    always @(posedge clk) begin
        if(reset) odd_reg <= 0;
        else odd_reg <= odd;
    end
    
    always @(posedge clk) begin
        case(next_state)
            IDLE : odd_reset <= 1;
            STOP : odd_reset <= 1;
            default : odd_reset <= 0;
        endcase
    end
    
    assign done = ((state == STOP) && odd_reg);
    assign out_byte = (done)?out:8'b0;
   
endmodule
