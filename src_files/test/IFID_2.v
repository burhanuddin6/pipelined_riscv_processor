`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2023 08:52:32 AM
// Design Name: 
// Module Name: IFID
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


module IFID_2(
input clock,
input reset,
input IFIDWrite,
input [63:0] PC,
input [31:0] Instruction,
output reg [63:0] IFID_PC,
output reg [31:0] IFID_Instruction
);
    
always @(posedge clock or posedge reset or IFIDWrite)
begin

if (reset == 1)
begin
   IFID_PC <= 0;
   IFID_Instruction <= 0;
end
else if (IFIDWrite == 1)
begin
    IFID_PC <= PC;
    IFID_Instruction <= Instruction;
end

end

endmodule
