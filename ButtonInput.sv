`timescale 1ns / 1ps

module ButtonInput (input logic clk,l,r,u,d, output logic [3:0] direction);
 
    always@(posedge clk) begin
    
        if(l == 1) begin 
            direction <= 4'b0001; //left
        end 
        else if(r == 1) begin 
            direction <= 4'b0010; //right
        end 
        else if(u == 1) begin 
            direction <= 4'b0100; //up
        end 
        else if(d == 1) begin 
            direction <=4'b1000; //down
        end 
        else begin 
            direction <= direction; //keep last input
            //hopelly this stops the requirement of a debouncer
            //life's too short for spending time on debouncers
        end 
    end

endmodule