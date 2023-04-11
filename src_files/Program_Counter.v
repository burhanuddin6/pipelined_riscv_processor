`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2023 08:34:35 AM
// Design Name: 
// Module Name: Program_Counter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Program_Counter(
input [63:0] PC_In, // the before counter
input clk,
input reset,
output reg [63:0] PC_Out // the counter after checking reset
);
// always do when there is a posedge of the clock or reset
always @(posedge clk or posedge reset)
begin
// if reset, then restart the counter
if (reset == 1)
    begin
    PC_Out = 0;
    end
// else output same as input
else
    begin
    PC_Out = PC_In;
    end
end
endmodule

