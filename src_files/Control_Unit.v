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

module Control_Unit
(
	input [6:0] opcode, 
	input [2:0] funct3,
	output reg Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, Shift,
	output reg [1:0] ALUOp
);

	always @ (opcode or funct3)
	begin
		case (opcode)
			7'b0010011: //slli
				case(funct3)
				3'b001: //slli				
					begin
						Branch = 0;
						MemRead = 0;
						MemtoReg = 0;
						MemWrite = 0;
						ALUSrc = 1;
						RegWrite = 1;
						ALUOp = 2'b00;
						Shift = 1;
					end
				3'b000: //addi
					begin
						Branch = 0;
						MemRead = 0;
						MemtoReg = 0;
						MemWrite = 0;
						ALUSrc = 1;
						RegWrite = 1;
						ALUOp = 2'b00;
						Shift = 0;
					end
				default:
					begin
						Branch = 1'b0;
						MemRead = 1'bx;
						MemtoReg = 1'bx;
						MemWrite = 1'bx;
						ALUSrc = 1'bx;
						RegWrite = 1'bx;
						ALUOp = 2'bx;
						Shift = 1'bx;
		        	end
				endcase
			7'b0110011: //R type
				begin
					Branch = 0;
					MemRead = 0;
					MemtoReg = 0;
					MemWrite = 0;
					ALUSrc = 0;
					RegWrite = 1;
					ALUOp = 2'b10;
					Shift = 0;
				end
			7'b0000011: //ld
				begin
					Branch = 0;
					MemRead = 1;
					MemtoReg = 1;
					MemWrite = 0;
					ALUSrc = 1;
					RegWrite = 1;
					ALUOp = 2'b00;
					Shift = 0;
				end
			7'b0100011: // I type SD
				begin
					Branch = 0;
					MemRead = 0;
					MemtoReg = 1'bx;
					MemWrite = 1;
					ALUSrc = 1;
					RegWrite = 0;
					ALUOp = 2'b00;
					Shift = 0;
				end
			7'b1100011:  //SB branch
				case(funct3)
				3'b000: //beq
					begin
						Branch = 1;
						MemRead = 0;
						MemtoReg = 1'bx;
						MemWrite = 0;
						ALUSrc = 0;
						RegWrite = 0;
						ALUOp = 2'b01;
						Shift = 0;
					end
				3'b100: //blt
					begin
						Branch = 1;
						MemRead = 0;
						MemtoReg = 1'bx;
						MemWrite = 0;
						ALUSrc = 0;
						RegWrite = 0;
						ALUOp = 2'b11;
						Shift = 0;
					end
				default:
					begin
						Branch = 1'b0;
						MemRead = 1'bx;
						MemtoReg = 1'bx;
						MemWrite = 1'bx;
						ALUSrc = 1'bx;
						RegWrite = 1'bx;
						ALUOp = 2'bx;
						Shift = 1'bx;
		        	end
				endcase
		    default:
		        begin
					Branch = 1'b0;
					MemRead = 1'bx;
					MemtoReg = 1'bx;
					MemWrite = 1'bx;
					ALUSrc = 1'bx;
					RegWrite = 1'bx;
					ALUOp = 2'bx;
					Shift = 1'bx;
		        end
		endcase
	end

endmodule 
