`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/08/2023 09:27:33 AM
// Design Name: 
// Module Name: Instruction_Parser_R
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


module Instruction_Parser(
input [31:0] instruction,
output [6:0] opcode,
output [4:0] rd,
output [2:0] funct3,
output [4:0] rs1,
output [4:0] rs2,
output [6:0] funct7
    );
assign opcode = instruction[6:0]; // first 7 bits are opcode
assign rd = instruction[11:7]; // 5 bits destination
assign funct3 = instruction[14:12]; // 3 bits opcode ext.
assign rs1 = instruction[19:15]; // 5 bits
assign rs2 = instruction[24: 20]; // 5 bits
assign funct7 = instruction[31:25]; // 7 bits opcode ext.
endmodule
