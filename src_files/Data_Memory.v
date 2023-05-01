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
input [63:0] Memory_Address, // 64 bit input specifiying memroy address
input[63:0] Write_Data, // 64 bit data input
input clock, // clock
input MemWrite, // MemWrite signal from the control unit that determines the write operation
input MemRead, // MemRead signal from the control unit that determines the read operation
output reg [63:0] Read_Data, // 64 bit output in case if data is read 

output [63:0] DataMem0,
output [63:0] DataMem1,
output [63:0] DataMem2,
output [63:0] DataMem3,
output [63:0] DataMem4,
output [63:0] DataMem5,

output [63:0] Stack0,
output [63:0] Stack1,
output [63:0] Stack2,
output [63:0] Stack3,
output [63:0] Stack4,
output [63:0] Stack5);

parameter i = 200;

reg [7:0] DATA [i:0]; // 200-bytes Data Memory 
integer counter; // integer i used for forloop
initial 
begin
// Initializing the DATA with i, where i is simply the address of that byte in memory
for (counter = 0; counter < i; counter = counter + 1)
begin
    DATA[counter] = 0;    
end
end

// Do if any input changes
always @(*)
begin
    // Read if MemRead signal is asserted
    if (MemRead == 1)
    begin
        // Reading 8-bytes of data
        Read_Data[7:0] = DATA[Memory_Address];
        Read_Data[15:8] = DATA[Memory_Address + 1];
        Read_Data[23:16] = DATA[Memory_Address + 2];
        Read_Data[31:24] = DATA[Memory_Address + 3];
        Read_Data[39:32] = DATA[Memory_Address + 4];
        Read_Data[47:40] = DATA[Memory_Address + 5];
        Read_Data[55:48] = DATA[Memory_Address + 6];
        Read_Data[63:56] = DATA[Memory_Address + 7];

    end
end
// Do only at positive edge of the clock
always @(posedge clock)
begin  
    // Write if memWrite signal is asserted
    if (MemWrite == 1)
    begin
        // Write 8-bytes of data
        DATA[Memory_Address + 0] = Write_Data[7:0];
        DATA[Memory_Address + 1] = Write_Data[15:8];
        DATA[Memory_Address + 2] = Write_Data[23:16];
        DATA[Memory_Address + 3] = Write_Data[31:24];
        DATA[Memory_Address + 4] = Write_Data[39:32];
        DATA[Memory_Address + 5] = Write_Data[47:40];
        DATA[Memory_Address + 6] = Write_Data[55:48];
        DATA[Memory_Address + 7] = Write_Data[63:56];
    end
end


assign DataMem0[7:0] = DATA[0];
assign DataMem0[15:8] = DATA[0 + 1];
assign DataMem0[23:16] = DATA[0 + 2];
assign DataMem0[31:24] = DATA[0 + 3];
assign DataMem0[39:32] = DATA[0 + 4];
assign DataMem0[47:40] = DATA[0 + 5];
assign DataMem0[55:48] = DATA[0 + 6];
assign DataMem0[63:56] = DATA[0 + 7];

assign DataMem1[7:0] = DATA[8];
assign DataMem1[15:8] = DATA[8 + 1];
assign DataMem1[23:16] = DATA[8 + 2];
assign DataMem1[31:24] = DATA[8 + 3];
assign DataMem1[39:32] = DATA[8 + 4];
assign DataMem1[47:40] = DATA[8 + 5];
assign DataMem1[55:48] = DATA[8 + 6];
assign DataMem1[63:56] = DATA[8 + 7];

assign DataMem2[7:0] = DATA[16];
assign DataMem2[15:8] = DATA[16 + 1];
assign DataMem2[23:16] = DATA[16 + 2];
assign DataMem2[31:24] = DATA[16 + 3];
assign DataMem2[39:32] = DATA[16 + 4];
assign DataMem2[47:40] = DATA[16 + 5];
assign DataMem2[55:48] = DATA[16 + 6];
assign DataMem2[63:56] = DATA[16 + 7];

assign DataMem3[7:0] = DATA[24];
assign DataMem3[15:8] = DATA[24 + 1];
assign DataMem3[23:16] = DATA[24 + 2];
assign DataMem3[31:24] = DATA[24 + 3];
assign DataMem3[39:32] = DATA[24 + 4];
assign DataMem3[47:40] = DATA[24 + 5];
assign DataMem3[55:48] = DATA[24 + 6];
assign DataMem3[63:56] = DATA[24 + 7];

assign DataMem4[7:0] = DATA[32];
assign DataMem4[15:8] = DATA[32 + 1];
assign DataMem4[23:16] = DATA[32 + 2];
assign DataMem4[31:24] = DATA[32 + 3];
assign DataMem4[39:32] = DATA[32 + 4];
assign DataMem4[47:40] = DATA[32 + 5];
assign DataMem4[55:48] = DATA[32 + 6];
assign DataMem4[63:56] = DATA[32 + 7];

assign DataMem5[7:0] = DATA[40];
assign DataMem5[15:8] = DATA[40 + 1];
assign DataMem5[23:16] = DATA[40 + 2];
assign DataMem5[31:24] = DATA[40 + 3];
assign DataMem5[39:32] = DATA[40 + 4];
assign DataMem5[47:40] = DATA[40 + 5];
assign DataMem5[55:48] = DATA[40 + 6];
assign DataMem5[63:56] = DATA[40 + 7];

assign Stack0[7:0] = DATA[i - 8];
assign Stack0[15:8] = DATA[i - 8 + 1];
assign Stack0[23:16] = DATA[i - 8 + 2];
assign Stack0[31:24] = DATA[i - 8 + 3];
assign Stack0[39:32] = DATA[i - 8 + 4];
assign Stack0[47:40] = DATA[i - 8 + 5];
assign Stack0[55:48] = DATA[i - 8 + 6];
assign Stack0[63:56] = DATA[i - 8 + 7];

assign Stack1[7:0] = DATA[i - 16];
assign Stack1[15:8] = DATA[i - 16 + 1];
assign Stack1[23:16] = DATA[i - 16 + 2];
assign Stack1[31:24] = DATA[i - 16 + 3];
assign Stack1[39:32] = DATA[i - 16 + 4];
assign Stack1[47:40] = DATA[i - 16 + 5];
assign Stack1[55:48] = DATA[i - 16 + 6];
assign Stack1[63:56] = DATA[i - 16 + 7];

assign Stack2[7:0] = DATA[i - 24];
assign Stack2[15:8] = DATA[i - 24 + 1];
assign Stack2[23:16] = DATA[i - 24 + 2];
assign Stack2[31:24] = DATA[i - 24 + 3];
assign Stack2[39:32] = DATA[i - 24 + 4];
assign Stack2[47:40] = DATA[i - 24 + 5];
assign Stack2[55:48] = DATA[i - 24 + 6];
assign Stack2[63:56] = DATA[i - 24 + 7];

assign Stack3[7:0] = DATA[i - 32];
assign Stack3[15:8] = DATA[i - 32 + 1];
assign Stack3[23:16] = DATA[i - 32 + 2];
assign Stack3[31:24] = DATA[i - 32 + 3];
assign Stack3[39:32] = DATA[i - 32 + 4];
assign Stack3[47:40] = DATA[i - 32 + 5];
assign Stack3[55:48] = DATA[i - 32 + 6];
assign Stack3[63:56] = DATA[i - 32 + 7];

assign Stack4[7:0] = DATA[i - 40];
assign Stack4[15:8] = DATA[i - 40 + 1];
assign Stack4[23:16] = DATA[i - 40 + 2];
assign Stack4[31:24] = DATA[i - 40 + 3];
assign Stack4[39:32] = DATA[i - 40 + 4];
assign Stack4[47:40] = DATA[i - 40 + 5];
assign Stack4[55:48] = DATA[i - 40 + 6];
assign Stack4[63:56] = DATA[i - 40 + 7];

assign Stack5[7:0] = DATA[i - 48];
assign Stack5[15:8] = DATA[i - 48 + 1];
assign Stack5[23:16] = DATA[i - 48 + 2];
assign Stack5[31:24] = DATA[i - 48 + 3];
assign Stack5[39:32] = DATA[i - 48 + 4];
assign Stack5[47:40] = DATA[i - 48 + 5];
assign Stack5[55:48] = DATA[i - 48 + 6];
assign Stack5[63:56] = DATA[i - 48 + 7];
endmodule

