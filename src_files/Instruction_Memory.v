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
input [63:0] Instr_Addr, // Input instruction memory
output reg [31:0]Instruction); // Output 32-bit instruction

reg [7:0] InstructionMemory [15:0]; // 16-bytes instruction memory
integer i; // integer i used by for loop
reg t;
initial
begin
// Assigning arbitrary values for each instruction
//for (i = 0; i < 64; i = i + 1)
//begin
//    InstructionMemory[i] = i; // assigning arbitrary values    
//end
InstructionMemory[0] = 8'b10000011;
InstructionMemory[1] = 8'b00110100;
InstructionMemory[2] = 8'b10000101;
InstructionMemory[3] = 8'b00000010;
InstructionMemory[4] = 8'b10110011;
InstructionMemory[5] = 8'b10000100;
InstructionMemory[6] = 8'b10011010;
InstructionMemory[7] = 8'b00000000;
InstructionMemory[8] = 8'b10011010;
InstructionMemory[9] = 8'b10000100;
InstructionMemory[10] = 8'b00010100;
InstructionMemory[11] = 8'b00000000;
InstructionMemory[12] = 8'b00100011;
InstructionMemory[13] = 8'b00110100;
InstructionMemory[14] = 8'b10010101;
InstructionMemory[15] = 8'b00000010;

end
// Always execute if the Instruction Address is changed
always @(Instr_Addr)
begin
// Assigning each of the four bytes of the instruction from memroy that are stored side by side
Instruction[7:0] =  InstructionMemory[Instr_Addr];
Instruction[15:8] = InstructionMemory[Instr_Addr+1];
Instruction[23:16] = InstructionMemory[Instr_Addr+2];
Instruction[31:24] = InstructionMemory[Instr_Addr+3];
end
endmodule