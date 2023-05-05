`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

// 4x1 Mux
module Mux_3x1
(
	input [63:0] in0,
	input [63:0] in1,
	input [63:0] in2,
	input [1:0] sel,
	output reg [63:0] data_out
);

always @ (in0 or in1 or in2 or sel)
begin
	case(sel)
		2'b00: data_out = in0;
		2'b01: data_out = in1;
		2'b10: data_out = in2;
		2'b11: data_out = 64'bx;
		default: data_out = 64'bx;
	endcase
end

endmodule