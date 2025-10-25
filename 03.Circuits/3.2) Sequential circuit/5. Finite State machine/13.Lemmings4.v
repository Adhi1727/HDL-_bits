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
    
    parameter walk_l = 0;
    parameter walk_r = 1;
    parameter fall_l = 2;
    parameter fall_r = 3;
    parameter dig_l = 4;
    parameter dig_r = 5;
    parameter splat = 6;
    
    reg [2:0] state,next_state;
    reg [7:0] count;
    
    always @(*) begin
        case(state) 
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
            fall_l:next_state=(ground==0)?fall_l:(count>19)?splat:walk_l;
            fall_r:next_state=(ground==0)?fall_r:(count>19)?splat:walk_r;
            dig_l:next_state=(ground==1)?dig_l:fall_l;
            dig_r:next_state=(ground==1)?dig_r:fall_r;
            splat:next_state=splat;
            default:next_state=walk_l;
        endcase
    end
            
            always @(posedge clk or posedge areset) begin
                if(areset) begin
                    state<=walk_l;
                    count<=0;
                end
                else if ((state==fall_l)||(state==fall_r))
                    begin
                        state<=next_state;
                        count<=count+1;
                    end
                else
                    begin
                        state<=next_state;
                        count<=0;
                    end
            end
            
            assign walk_left = (state==walk_l);
            assign walk_right = (state==walk_r);
            assign aaah = (state==fall_l)||(state==fall_r);
            assign digging = (state==dig_l)||(state==dig_r);
                      
endmodule
