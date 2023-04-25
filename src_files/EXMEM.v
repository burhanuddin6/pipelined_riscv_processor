`timescale 1ns / 1ps


module EXMEM(

input clock,
input reset,

// Control Signals
input RegWrite,
input MemToReg,
input Branch,
input MemRead,
input MemWrite,

input [63:0] PC,

// ALU contents
input Zero,
input [63:0] ALU_Result,

input [63:0] Read_Data_2,// RegisterFile contents
input [4:0] Instruction_11_7, //rd

output reg EXMEM_RegWrite,
output reg EXMEM_MemToReg,
output reg EXMEM_Branch,
output reg EXMEM_MemRead,
output reg EXMEM_MemWrite,

output reg [63:0] EXMEM_PC,

output reg [63:0] EXMEM_ALU_Result,
output reg EXMEM_Zero,

output reg [63:0] EXMEM_Read_Data_2,
output reg [4:0] EXMEM_Instruction_11_7
);



always @(posedge clock)
begin

//if (reset == 1)
//begin

//    EXMEM_RegWrite <= 0;
//    EXMEM_MemToReg <= 0;
//    EXMEM_Branch <= 0;
//    EXMEM_MemRead <= 0;
//    EXMEM_MemWrite <= 0;

//    EXMEM_PC <= 0;
    
//    EXMEM_ALU_Result <= 0;
//    EXMEM_Zero <= 0;

//    EXMEM_Read_Data_2 <= 0;

//    EXMEM_Instruction_11_7 <= 0;

//end
//else
//begin
    
    EXMEM_RegWrite <= RegWrite; 
    EXMEM_MemToReg <= MemToReg;
    EXMEM_Branch <= Branch;
    EXMEM_MemRead <= MemRead;
    EXMEM_MemWrite <= MemWrite;

    EXMEM_PC <= PC;
    
    EXMEM_ALU_Result <= ALU_Result;
    EXMEM_Zero <= Zero;

    EXMEM_Read_Data_2 <= Read_Data_2;

    EXMEM_Instruction_11_7 <= Instruction_11_7;

//end

end


endmodule