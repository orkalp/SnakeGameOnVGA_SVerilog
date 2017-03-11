//module RandomPoint (input logic VGA_clk, output int randX, randY);

//int x;
//int y;

////logic[9:0] randomX;
////logic [8:0] randomY;

//always@(posedge VGA_clk) begin
//    x <= x + 123;
//    y <= y + 321;
//end

////pseudo-random x location
////always@(posedge VGA_clk) begin
////    if (x > 1907 ) randomX <= 523;
////    //else if (x <999) randomX <= 32*x;
////    else randomX <=2343*x;
////end

//////pseudo-random y location
////always@(posedge VGA_clk) begin
////    if (y > 2016 ) randomY <= 395;
////    //else if (y <1453) randomY <= 889*x;
////    else randomY <=88*y;
////end

////make them fit to VGA values
 
//assign  randX = x %640;
//assign  randY = y %480;

//endmodule
 
`timescale 1ns/1ps

module RandomPoint(VGA_clk, randX, randY);
	input VGA_clk;
	output reg [9:0]randX;
	output reg [8:0]randY;
	reg [5:0]pointX, pointY = 10;

	always @(posedge VGA_clk)
		pointX <= pointX + 3;	
	always @(posedge VGA_clk)
		pointY <= pointY + 1;
	always @(posedge VGA_clk)
	begin	
		if(pointX>62)
			randX <= 620;
		else if (pointX<2)
			randX <= 20;
		else
			randX <= (pointX * 10);
	end
	
	always @(posedge VGA_clk)
	begin	
		if(pointY>469)//---------------------------------------------------------------Changed to 469
			randY <= 460;
		else if (pointY<2)
			randY <= 20;
		else
			randY <= (pointY * 10);
	end
endmodule

