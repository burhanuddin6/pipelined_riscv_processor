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
output reg [63:0] Read_Data_1,
output reg [63:0] Read_Data_2
    );
// declare an array of 64-bit registers, Register of size 32
reg [63:0] REG_MEMORY[32:0];
integer i;
initial
begin
    for(i = 0; i < 32; i = i + 1)
    begin
        // loading i in each reg i
        REG_MEMORY[i] = 0;
    end
end
always @(posedge clock) // only at pos edge of clock
begin
    if (RegWrite == 1)
    begin
        // write the input data to destination REG_MEMORY
        REG_MEMORY[rd] = WriteData;
    end
end

always @(*) // at any change
begin
    if (reset == 1)
    begin
        ReadData1 <= 0;
        ReadData2 <= 0;
    end
    else
    begin
        // if reset is not 0, then
        ReadData1 <= REG_MEMORY[rs1];
        ReadData2 <= REG_MEMORY[rs2];
    end
end

endmodule
