module ClockDivider(input logic clk, output logic VGA_clk);

//divides 100 MHz clock to 25 MHz 
    integer check = 4;
    integer a = 0;
	always@(posedge clk)
 begin 
        if(a<check) begin
            a <= a + 1;
            VGA_clk <= 0;
        end
        else begin
            a <= 0;
            VGA_clk <= 1;
        end
	end
	
endmodule