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

reg [7:0] MEMORY [300:0]; // 16-bytes instruction memory

initial
begin
$readmemb("instructions.mem", MEMORY);
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