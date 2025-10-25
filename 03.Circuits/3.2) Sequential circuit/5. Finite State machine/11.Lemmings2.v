module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 
    
    parameter walk_l = 0;
    parameter walk_r = 1;
    parameter fall_l = 2;
    parameter fall_r = 3;
	
    reg [1:0] state,next_state;
    
    always@(posedge clk or posedge areset) begin
        case(state)
        walk_l:begin
            if(ground==0)
                next_state=fall_l;
            else if(bump_left==1)
                next_state=walk_r;
            else
                next_state=walk_l;
        end
        walk_r:begin
            if(ground==0)
                next_state=fall_r;
            else if(bump_right==1)
                next_state=walk_l;
            else
                next_state=walk_r;
        end
       fall_l:begin
           if(ground==1)
               next_state=walk_l;
           else
               next_state=fall_l;
       end
        fall_r:begin
            if(ground==1)
                next_state=walk_r;
            else
                next_state=fall_r;
        end
        endcase
            
    end
    
    always @ (posedge clk or posedge areset) begin
        if(areset)
            state <= walk_l;
        else 
            state <= next_state;
    end
    
    assign walk_left = (state==walk_l);
    assign walk_right = (state==walk_r);
    assign aaah = (state==fall_l) || (state==fall_r);
         
endmodule
