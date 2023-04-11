`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/01/2023 09:52:35 AM
// Design Name: 
// Module Name: Data_Memory
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


module Data_Memory(
input [63:0] Mem_Addr, // 64 bit input specifiying memroy address
input[63:0] Write_Data, // 64 bit data input
input clk, // clock
input MemWrite, // MemWrite signal from the control unit that determines the write operation
input MemRead, // MemRead signal from the control unit that determines the read operation
output reg [63:0] Read_Data ); // 64 bit output in case if data is read
reg [7:0] DataMemory [63:0]; // 64-bytes Data Memory 
integer i; // integer i used for forloop
initial 
begin
// Initializing the DataMemory with i, where i is simply the address of that byte in memory
for (i = 0; i < 64; i = i + 1)
begin
    DataMemory[i] = i;    
end
end
// Do if any input changes
always @(*)
begin
    // Read if MemRead signal is asserted
    if (MemRead == 1)
    begin
        // Reading 8-bytes of data
        Read_Data[7:0] = DataMemory[Mem_Addr];
        Read_Data[15:8] = DataMemory[Mem_Addr + 1];
        Read_Data[23:16] = DataMemory[Mem_Addr + 2];
        Read_Data[31:24] = DataMemory[Mem_Addr + 3];
        Read_Data[39:32] = DataMemory[Mem_Addr + 4];
        Read_Data[47:40] = DataMemory[Mem_Addr + 5];
        Read_Data[55:48] = DataMemory[Mem_Addr + 6];
        Read_Data[63:56] = DataMemory[Mem_Addr + 7];

    end
end
// Do only at positive edge of the clock
always @(posedge clk)
begin  
    // Write if memWrite signal is asserted
    if (MemWrite == 1)
    begin
        // Write 8-bytes of data
        DataMemory[Mem_Addr + 0] = Write_Data[7:0];
        DataMemory[Mem_Addr + 1] = Write_Data[15:8];
        DataMemory[Mem_Addr + 2] = Write_Data[23:16];
        DataMemory[Mem_Addr + 3] = Write_Data[31:24];
        DataMemory[Mem_Addr + 4] = Write_Data[39:32];
        DataMemory[Mem_Addr + 5] = Write_Data[47:40];
        DataMemory[Mem_Addr + 6] = Write_Data[55:48];
        DataMemory[Mem_Addr + 7] = Write_Data[63:56];
    end
end
endmodule
