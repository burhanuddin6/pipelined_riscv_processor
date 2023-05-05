`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2023 08:45:35 AM
// Design Name: 
// Module Name: IDEX
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


module IDEX_2(
input clock,
input reset,

// Control Signals
input RegWrite,
input MemToReg,
input Branch,
input MemRead,
input MemWrite,
input ALUSrc,
input Shift,
input [1:0] ALUOp,

// PC
input [63:0] PC,

// RegisterFile contents
input [63:0] Read_Data_1,
input [63:0] Read_Data_2,

// imm, Funct, rd
input [63:0] Immediate,
input [4:0] Rs1,
input [4:0] Rs2,
input [3:0] Instruction_30_14_12,
input [4:0] Instruction_11_7,


output reg IDEX_RegWrite,
output reg IDEX_MemToReg,
output reg IDEX_Branch,
output reg IDEX_MemRead,
output reg IDEX_MemWrite,
output reg IDEX_ALUSrc,
output reg IDEX_Shift,
output reg [1:0] IDEX_ALUOp,

output reg [63:0] IDEX_PC,

output reg [63:0] IDEX_Read_Data_1,
output reg [63:0] IDEX_Read_Data_2,

output reg [63:0] IDEX_Immediate,
output reg [4:0] IDEX_Rs1,
output reg [4:0] IDEX_Rs2,
output reg [3:0] IDEX_Instruction_30_14_12,
output reg [4:0] IDEX_Instruction_11_7

);
    
always @(posedge clock)
begin

    
    IDEX_RegWrite <= RegWrite; 
    IDEX_MemToReg <= MemToReg;
    IDEX_Branch <= Branch;
    IDEX_MemRead <= MemRead;
    IDEX_MemWrite <= MemWrite;
    IDEX_ALUSrc <= ALUSrc;
    IDEX_Shift <= Shift;
    IDEX_ALUOp <= ALUOp;

    IDEX_PC <= PC;
    
    IDEX_Read_Data_1 <= Read_Data_1;
    IDEX_Read_Data_2 <= Read_Data_2;

    IDEX_Immediate <= Immediate;
    IDEX_Instruction_30_14_12 <= Instruction_30_14_12;
    IDEX_Instruction_11_7 <= Instruction_11_7;
    IDEX_Rs1 <= Rs1;
    IDEX_Rs2 <= Rs2;

end
endmodule
