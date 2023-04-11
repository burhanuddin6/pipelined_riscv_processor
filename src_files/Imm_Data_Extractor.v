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
input [31:0] instruction, // the 32-bit instruction
output reg [63:0] out // sign extended immediate output
    );
    
//wire t1,t2; // toggle 1, toggle2
//mux u1(0,1,instruction[5],toggle1); // t1 = instruction[5]
//mux u2(0,1,instruction[6],toggle2); // t2 = instruction[6]

always @(instruction[6:5]) // two bit case statement, with 4 possible configurations
begin
case(instruction[6:5])
    2'b00: // I format
    begin
        out = {{52{instruction[31]}},instruction[31:20]};
    end 
    2'b01: // S-format
    begin
        out = {{52{instruction[31]}}, instruction[31:25], instruction[11:7]};
    end
    2'b11: // Sb-format
    begin
        out = {{52{instruction[31]}}, instruction[31:25], instruction[11:7]};
    end
    default:
        out = 0;
endcase
end
endmodule
