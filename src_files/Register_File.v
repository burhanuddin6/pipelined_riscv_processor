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


module registerFile(
input clk,
input reset,
input [63:0] WriteData,
input [4:0] rs1,
input [4:0] rs2,
input [4:0] rd,
input RegWrite,
output reg [63:0] ReadData1,
output reg [63:0] ReadData2
    );
// declare an array of 64-bit registers, Register of size 32
reg [63:0] Register[32:0];
integer i;
initial
begin
    for(i = 0; i < 32; i = i + 1)
    begin
        // loading i in each reg i
        Register[i] = i+1;
    end
end
always @(posedge clk) // only at pos edge of clk
begin
    if (RegWrite == 1)
    begin
        // write the input data to destination register
        Register[rd] = WriteData;
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
        ReadData1 <= Register[rs1];
        ReadData2 <= Register[rs2];
    end
end

endmodule
