module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);
    
    parameter none=4'h1;
    parameter one=4'h2;
    parameter two=4'h3;
    parameter three=4'h4;
    parameter four=4'h5;
    parameter five=4'h6;
    parameter six=4'h7;
    parameter discard=4'h8;
    parameter flg=4'h9;
    parameter error=4'ha;
    
    reg [3:0] state,next_state;
   
    always @(*) begin
        case(state)
            none:begin
                if(in==1) next_state=one;
                else next_state=none;
            end
            one:begin
                if(in==1) next_state=two;
                else next_state=none;
            end
            two:begin
                if(in==1) next_state=three;
                else next_state=none;
            end
            three:begin
                if(in==1) next_state=four;
                else next_state=none;
            end
            four:begin
                if(in==1) next_state=five;
                else next_state=none;
            end
            five:begin
                if(in==1) next_state=six;
                else next_state=discard;
            end
            six:begin
                if(in==1) next_state=error;
                else next_state=flg;
            end
            discard:begin
                if(in==1) next_state=one;
                else next_state=none;
            end
            flg:begin
                if(in==1) next_state=one;
                else next_state=none;
            end
            error:begin
                if(in==1) next_state=error;
                else next_state=none;
            end
            default:next_state=none;
        endcase
    end
    
    always @(posedge clk ) begin
        if(reset)
            state<=none;
        else 
            state<=next_state;
    end
    
    assign disc = (state==discard);
    assign flag = (state==flg);
    assign err = (state==error);
    
            

endmodule
