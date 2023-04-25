`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/22/2023 09:15:06 AM
// Design Name: 
// Module Name: registerFile
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


module Register_File(
input clock,
input reset,
input [63:0] Write_Data,
input [4:0] rs1,
input [4:0] rs2,
input [4:0] rd,
input RegWrite,
output [63:0] Read_Data_1,
output [63:0] Read_Data_2,

output [63:0] RegFile0,
output [63:0] RegFile1,
output [63:0] RegFile2,
output [63:0] RegFile3,
output [63:0] RegFile4,
output [63:0] RegFile5,
    );
// declare an array of 64-bit registers, Register of size 32
reg [63:0] REG_MEMORY[32:0];
integer i;
initial
begin
    for(i = 0; i < 32; i = i + 1)
    begin
        // loading i in each reg i
        REG_MEMORY[i] = i;
    end
end

always @(posedge clock) // only at pos edge of clock
begin
    if (RegWrite == 1)
    begin
        // write the input data to destination REG_MEMORY
        REG_MEMORY[rd] = Write_Data;
        RegFile0 = REG_MEMORY[0];
        RegFile1 = REG_MEMORY[1];
        RegFile2 = REG_MEMORY[2];
        RegFile3 = REG_MEMORY[3];
        RegFile4 = REG_MEMORY[4];
        RegFile5 = REG_MEMORY[5];        
    end
end

assign Read_Data_1 = REG_MEMORY[rs1];
assign Read_Data_2 = REG_MEMORY[rs2];


endmodule
