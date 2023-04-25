`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/18/2023 11:05:13 AM
// Design Name: 
// Module Name: testbench_Top
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


module testbench_Top();
reg clk;
reg reset;

wire [63:0] pc_in;
wire [63:0] pc_out;

wire [31:0] instruction;
wire [4:0] rs1;
wire [4:0] rs2;
wire [4:0] rd;
wire [6:0] opcode;
wire [2:0] funct3;
wire [6:0] funct7;

wire [63:0] write_data;
wire [63:0] read_data1;
wire [63:0] read_data2;
wire [63:0] immediate_data;
wire [63:0] ALU_Result;
wire [63:0] mem_read_data;
wire sig_zero;
wire sig_Branch;
wire sig_MemRead;
wire sig_MemToReg;
wire [1:0] sig_ALUOp;
wire sig_MemWrite;
wire sig_ALUSrc;
wire sig_RegWrite;
wire [3:0]sig_operation;
wire sig_Shift;
wire sig_zero;


Pipelined_Processor Test(.clock(clk), .reset(reset),

// program counter wires
.pc_in(pc_in),
.pc_out(pc_out),

// instruction parts
.instruction(instruction),
.opcode(opcode),
.rd(rd),
.funct3(funct3),
.rs1(rs1),
.rs2(rs2),
.funct7(funct7),

// Data
.read_data1(read_data1),
.read_data2(read_data2),
.immediate_data(immediate_data),
.write_data(write_data),
.ALU_Result(ALU_Result),
.mem_read_data(mem_read_data),

.sig_zero(sig_zero),
.sig_Branch(sig_Branch),
.sig_MemRead(sig_MemRead),
.sig_MemToReg(sig_MemToReg),
.sig_ALUOp(sig_ALUOp),
.sig_MemWrite(sig_MemWrite),
.sig_ALUSrc(sig_ALUSrc),
.sig_RegWrite(sig_RegWrite),
.sig_operation(sig_operation),
.sig_Shift(sig_Shift)
);

initial begin
clk = 1'b0; reset = 1'b0;
#10 reset = 1'b1;
#10 reset = 1'b0;
end
always
#10 clk = ~clk;
endmodule