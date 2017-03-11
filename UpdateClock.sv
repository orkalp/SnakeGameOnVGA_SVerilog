`timescale 1ns / 1ps

module UpdateClock (input logic clk, output logic update_clk);
 
//Divides 100 MHz clock to around 25 Hz
    logic [21:0] check;
    
    always @ (posedge clk) begin
        if(check < 4000000) begin //4 million
            check <= check + 1;
            update_clk <= 0;
        end
        else begin 
            check <= 0;
            update_clk <= 1;
        end
    end
            
endmodule