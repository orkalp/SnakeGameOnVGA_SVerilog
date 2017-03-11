module Snake (input logic clk, reset, l, r, u, d, 
              output logic [3:0] red, [3:0] green, [3:0] blue,
              output logic h_sync, v_sync);
              
              
              logic VGA_clk;
              logic[10:0] xCount;
              logic[9:0] yCount;
              logic[3:0] direction;
              logic [9:0] randX;
              logic [9:0] randomX;
              logic [8:0] randY;
              logic [8:0] randomY;
              logic displayArea, apple;
              logic update_clock, border;
              logic eat;
              logic R,G,B;
              logic snake;
              logic stop;
              logic gameOver;
              logic head;
              logic [9:0] appleX;
              logic [9:0] appleY;
              logic inX, inY;
              logic [9:0] snakeX[0:10];
              logic [8:0] snakeY[0:10];
              logic [9:0] headX;
              logic [9:0] headY;
              logic snakeHead;
              logic snakeBody;
              
              ClockDivider divider(clk, VGA_clk);
              UpdateClock upd(clk, update_clock);
              VGAgenerator vga(VGA_clk, xCount, yCount, displayArea, h_sync, v_sync);
              RandomPoint random(VGA_clk, randX, randY);
              ButtonInput but(clk,l,r,u,d,direction);
              
              assign randomX = randX;
              assign randomY = randY;
                       
              always @(posedge VGA_clk) begin
                      inX <= (xCount > appleX & xCount < (appleX + 10));
                      inY <= (yCount > appleY & yCount < (appleY + 10));
                      apple <= inX & inY;
              end
                                  
              always@(posedge VGA_clk) begin
                     border <= (((xCount >= 0) & (xCount < 15) | (xCount >= 630) & (xCount < 641)) | ((yCount >= 0) & (yCount < 15) | (yCount >= 465) & (yCount < 481)));
              end
                
              always@(posedge VGA_clk) begin    
                  if(reset) begin
                    appleX = 350;
                    appleY = 300;
                  end 
                 if(apple & head) begin 
                    appleX <= randomX % 500;
                    appleY <= randomY % 350;
                 end                        
              end
             
              always@(posedge update_clock) begin
              
              snakeX[10] <= snakeX[9];
              snakeY[10] <= snakeY[9];
              snakeX[9] <= snakeX[8];
              snakeY[9] <= snakeY[8];
              snakeX[8] <= snakeX[7];
              snakeY[8] <= snakeY[7];
              snakeX[7] <= snakeX[6];
              snakeY[7] <= snakeY[6];
              snakeX[6] <= snakeX[5];
              snakeY[6] <= snakeY[5];
              snakeX[5] <= snakeX[4];
              snakeY[5] <= snakeY[4];
              snakeX[4] <= snakeX[3];
              snakeY[4] <= snakeY[3];
              snakeX[3] <= snakeX[2];
              snakeY[3] <= snakeY[2];
              snakeX[2] <= snakeX[1];
              snakeY[2] <= snakeY[1];
              snakeX[1] <= snakeX[0];
              snakeY[1] <= snakeY[0];
                            		//10 changed to 5 for each case
              if(direction == 4'b0001) begin snakeX[0] = snakeX[0] - 5; end //left
                 else if (direction == 4'b0010) begin snakeX[0] = snakeX[0] + 5; end //right
                 else if (direction == 4'b0100) begin snakeY[0] = snakeY[0] - 5; end //up
                 else if(direction == 4'b1000) begin snakeY[0] = snakeY[0] + 5; end //down
                 
              end

           always@(posedge VGA_clk) begin
                snake = ((xCount > snakeX[1] & xCount < snakeX[10]+10) & (yCount > snakeY[1] & yCount < snakeY[10]+10));
           end   
           always@(posedge VGA_clk) begin
                 head  <= (xCount > snakeX[0] & xCount < (snakeX[0]+10)) & (yCount > snakeY[0] & yCount < (snakeY[0]+10));
           end
                        
           always @(posedge VGA_clk) begin
               if((border & (snake|head)) | reset) gameOver<=1;
               else gameOver=0;
           end
                    
           assign R = (displayArea & (apple | head | gameOver));
           assign G = (displayArea & (snake & ~gameOver));
           assign B = (displayArea & (border & ~gameOver));
           
           always@(posedge VGA_clk) begin
                   red = {4{R}};
                   green = {4{G}};
                   blue = {4{B}};
           end          
              
endmodule 

/*           always @(posedge VGA_clk) begin
                if(apple && (snake | head)) begin 
                   eat <= 1;
                end
                else eat <= 0;
           end
            */    
