`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/01/2023 09:16:50 AM
// Design Name: 
// Module Name: Instruction_Memory
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


module Instruction_Memory(
input [63:0] Instruction_Address, // Input instruction memory
output reg [31:0] Instruction); // Output 32-bit instruction

reg [7:0] MEMORY [15:0]; // 16-bytes instruction memory
integer i; // integer i used by for loop
reg t;
initial
begin
// Assigning arbitrary values for each instruction
//for (i = 0; i < 64; i = i + 1)
//begin
//    MEMORY[i] = i; // assigning arbitrary values    
//end
MEMORY[0] = 8'b10000011;
MEMORY[1] = 8'b00110100;
MEMORY[2] = 8'b10000101;
MEMORY[3] = 8'b00000010;
MEMORY[4] = 8'b10110011;
MEMORY[5] = 8'b10000100;
MEMORY[6] = 8'b10011010;
MEMORY[7] = 8'b00000000;
MEMORY[8] = 8'b10011010;
MEMORY[9] = 8'b10000100;
MEMORY[10] = 8'b00010100;
MEMORY[11] = 8'b00000000;
MEMORY[12] = 8'b00100011;
MEMORY[13] = 8'b00110100;
MEMORY[14] = 8'b10010101;
MEMORY[15] = 8'b00000010;

end
// Always execute if the Instruction Address is changed
always @(Instruction_Address)
begin
// Assigning each of the four bytes of the instruction from memroy that are stored side by side
Instruction[7:0] =  MEMORY[Instruction_Address];
Instruction[15:8] = MEMORY[Instruction_Address+1];
Instruction[23:16] = MEMORY[Instruction_Address+2];
Instruction[31:24] = MEMORY[Instruction_Address+3];
end
endmodule