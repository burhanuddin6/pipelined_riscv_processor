`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2023 08:52:32 AM
// Design Name: 
// Module Name: MEMWB
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


module MEMWB(
input clock,
input reset,

// Control Signals
input RegWrite,
input MemToReg,

// ALU contents
input [63:0] ALU_Result,

// Data Memory contents
input [63:0] Read_Data,

// rd
input [4:0] Instruction_11_7,

output reg MEMWB_RegWrite,
output reg MEMWB_MemToReg,

output reg [63:0] MEMWB_ALU_Result,

output reg [63:0] MEMWB_Read_Data,

output reg [4:0] MEMWB_Instruction_11_7

    );
    
always @(posedge clock)
begin

//if (reset == 1)
//begin
//    MEMWB_RegWrite <= 0;
//    MEMWB_MemToReg <= 0;
//    MEMWB_ALU_Result <= 0;
//    MEMWB_Read_Data <= 0;
//    MEMWB_Instruction_11_7 <= 0;
//end
//else
//begin
    MEMWB_RegWrite <= RegWrite;
    MEMWB_MemToReg <= MemToReg;
    MEMWB_ALU_Result <= ALU_Result;
    MEMWB_Read_Data <= Read_Data;
    MEMWB_Instruction_11_7 <= Instruction_11_7;
//end

end
endmodule
