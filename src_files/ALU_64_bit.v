`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/05/2023 09:44:00 AM
// Design Name: 
// Module Name: ALU_64_bit
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

module ALU_64_bit
(
	input [63:0]a, 
	input [63:0] b,
	input [3:0] ALUOp,
	input Shift,
	
	output reg [63:0] Result,
	output reg Zero
);

localparam [3:0]
AND = 4'b0000,
OR	= 4'b0001,
ADD	= 4'b0010,
Sub	= 4'b0110,
NOR = 4'b1100,
LESSTHAN = 4'b0111;

reg signed [64:0] signed_a;
reg signed [64:0] signed_b;

initial
Zero <= 0;

always @ (ALUOp, a, b)
begin
    signed_a <= a;
    signed_b <= b;
	case (ALUOp)
		AND: Result = a & b;
		OR:	 Result = a | b;
		ADD: 
			case(Shift)
				0: Result = a + b;
				1: Result = a << b[4:0];
				default: Result = a + b;
			endcase
		Sub: Result = a - b;
		NOR: Result = ~(a | b);
		LESSTHAN:
		begin
		  if (a[63] == 1)
		  begin
		      if (b[63] == 1)
		          Result = ( a < b )? 0: 1;
		      else
		          Result = 0;
		  end
		  else
		  begin
		      if (b[63] == 1)
		          Result = 1;
		      else
		          Result = ( a < b )? 0: 1;
		  end
		end
		
		default: Result = 64'bx;
	endcase
	Zero = (Result == 0)? 1: 0;
end
endmodule 
