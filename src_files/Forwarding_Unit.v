`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/05/2023 09:11:27 AM
// Design Name: 
// Module Name: Control_Unit
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

// create forwarding module
module Forwarding_Unit
(
	input [4:0] MEMWB_rd,
	input [4:0] EXMEM_rd,
	input MEMWB_RegWrite,
	input EXMEM_RegWrite,
	input [4:0] IDEX_Rs1,
	input [4:0] IDEX_Rs2,
	output reg [1:0] ForwardA,
	output reg [1:0] ForwardB
);

	// check if the register is being written to in the MEMWB stage
	// if it is, check if the register is being read in the IDEX stage
	// if it is, forward the data from the MEMWB stage to the IDEX stage
	// if it is not, check if the register is being read in the EXMEM stage
	// if it is, forward the data from the EXMEM stage to the IDEX stage
	// if it is not, forward the data from the register file to the IDEX stage
	always @ (MEMWB_RegWrite or EXMEM_RegWrite or MEMWB_rd or EXMEM_rd or IDEX_Rs1 or IDEX_Rs2)
	begin
		if (MEMWB_RegWrite && (MEMWB_rd != 0) && (MEMWB_rd == IDEX_Rs1))
			ForwardA = 2'b01;
		else if (EXMEM_RegWrite && (EXMEM_rd != 0) && (EXMEM_rd == IDEX_Rs1))
			ForwardA = 2'b10;
		else
			ForwardA = 2'b00;
		
		if (MEMWB_RegWrite && (MEMWB_rd != 0) && (MEMWB_rd == IDEX_Rs2))
			ForwardB = 2'b01;
		else if (EXMEM_RegWrite && (EXMEM_rd != 0) && (EXMEM_rd == IDEX_Rs2))
			ForwardB = 2'b10;
		else
			ForwardB = 2'b00;
	end
endmodule