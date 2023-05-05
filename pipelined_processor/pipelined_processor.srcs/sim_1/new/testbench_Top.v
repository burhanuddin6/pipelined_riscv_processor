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

wire [63:0] FMux1_out;
wire [63:0] FMux2_out;
wire [1:0] sig_ForwardA;
wire [1:0] sig_ForwardB;

wire [63:0] RegFile0;
wire [63:0] RegFile1;
wire [63:0] RegFile2;
wire [63:0] RegFile3;
wire [63:0] RegFile4;
wire [63:0] RegFile5;

wire [63:0] DataMem0;
wire [63:0] DataMem1;
wire [63:0] DataMem2;
wire [63:0] DataMem3;
wire [63:0] DataMem4;
wire [63:0] DataMem5;

wire [63:0] Stack0;
wire [63:0] Stack1;
wire [63:0] Stack2;
wire [63:0] Stack3;
wire [63:0] Stack4;
wire [63:0] Stack5;

Pipelined_Test Test(.clock(clk), .reset(reset),

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
.sig_Shift(sig_Shift),

.FMux1_out(FMux1_out),
.FMux2_out(FMux2_out),
.sig_ForwardA(sig_ForwardA),
.sig_ForwardB(sig_ForwardB),

.RegFile0(RegFile0),
.RegFile1(RegFile1),
.RegFile2(RegFile2),
.RegFile3(RegFile3),
.RegFile4(RegFile4),
.RegFile5(RegFile5),

.DataMem0(DataMem0),
.DataMem1(DataMem1),
.DataMem2(DataMem2),
.DataMem3(DataMem3),
.DataMem4(DataMem4),
.DataMem5(DataMem5),

.Stack0(Stack0),
.Stack1(Stack1),
.Stack2(Stack2),
.Stack3(Stack3),
.Stack4(Stack4),
.Stack5(Stack5)
);

initial begin
clk = 1'b0; reset = 1'b0;
#10 reset = 1'b1;
#10 reset = 1'b0;
end
always
#10 clk = ~clk;
endmodule
