`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/08/2023 10:02:03 AM
// Design Name: 
// Module Name: Imm_Data_Extractor
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


module Imm_Data_Extractor(
input [31:0] Instruction, // the 32-bit Instruction
output reg [63:0] immediate // sign extended immediate 
    );
    
//wire t1,t2; // toggle 1, toggle2
//mux u1(0,1,Instruction[5],toggle1); // t1 = Instruction[5]
//mux u2(0,1,Instruction[6],toggle2); // t2 = Instruction[6]

always @(Instruction) // two bit case statement, with 4 possible configurations
begin
case(Instruction[6:5])
    2'b00: // I format
    begin
        immediate = {{52{Instruction[31]}},Instruction[31:20]};            
    end 
    2'b01: // S-format
    begin
        immediate = {{52{Instruction[31]}}, Instruction[31:25], Instruction[11:7]};
    end
    2'b11: // Sb-format
    begin
        immediate = {{52{Instruction[31]}}, Instruction[31:25], Instruction[11:7]};
    end
    default:
        immediate = 0;
endcase
end
endmodule
