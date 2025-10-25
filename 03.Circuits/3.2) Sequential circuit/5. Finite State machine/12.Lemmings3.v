module top_module(
    input clk,
    input areset,    
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging );
    
    parameter walk_l=0;
    parameter walk_r=1;
    parameter fall_l=2;
    parameter fall_r=3;
    parameter dig_l=4;
    parameter dig_r=5;

    reg [2:0] State,next_state;

    always @(posedge clk or posedge areset) begin
        case(State)
            walk_l:begin
                if(ground==0) next_state = fall_l;
                else if(dig==1) next_state = dig_l;
                else if(bump_left==1) next_state = walk_r;
                else next_state = walk_l;
            end
            walk_r:begin
                if(ground==0) next_state = fall_r;
                else if(dig==1) next_state = dig_r;
                else if(bump_right==1) next_state = walk_l;
                else next_state = walk_r;
            end
            fall_l:next_state=(ground==1)?walk_l:fall_l;
            fall_r:next_state=(ground==1)?walk_r:fall_r;
            dig_l:next_state=(ground==1)?dig_l:fall_l;
            dig_r:next_state=(ground==1)?dig_r:fall_r;
        endcase
    end
    always @(posedge clk or posedge areset) begin 
        if(areset)
            State<=walk_l;
        else
            State<=next_state;
    end
    
    assign walk_left = (State==walk_l);
    assign walk_right = (State==walk_r);
    assign aaah = (State==fall_l) || (State==fall_r);
    assign digging = (State==dig_l) || (State==dig_r);
    
endmodule
