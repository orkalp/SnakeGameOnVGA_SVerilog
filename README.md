This is basically a classic snake game implementation on BASYS 3 FPGA board and VGA monitor using SystemVerilog.

*Functions, Timings and Descriptions*

Clock Divider: This block divides 100 MHz clock of BASYS 3 to around 25 MHz for VGA display.

Update Clock: This block divides 100 MHz clock of BASYS 3 to around 25 Hz for the motion of
snake.

Button Input: This block generates a 4 bit direction output from the inputs of the user by the push
buttons of BASYS 3. Uses the clock of BASYS 3 to check which buttons are pushed at that
instance.

Random Point: This block generates two pseudo-random numbers for the coordinates of apples &
snake. Uses the clock of BASYS 3 to increment, divide, substract numbers in a so-called random
way.

VGA Generator: This block generates horizontal and vertical synchronization signals for VGA, as
well as traversing the screen and giving x-y coordinates constantly. Uses the VGA_clock generated
via the ClockDivider module.

Snake: This block manages the overall game by basically feeding VGA with pixel-level inputs
according to the game. As it’s the main module, it uses the outputs of both UpdateClock and
ClockDivider.

SSD Display: This block gets the number of apples eaten at that point and reflects that numerical
value to seven segment LED display of BASYS 3. 
