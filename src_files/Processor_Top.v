`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2023 09:07:58 AM
// Design Name: 
// Module Name: Processor_Top
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


module Processor_Top(
input clk, reset,

// program counter wires
output [63:0] pc_in,
output [63:0] pc_out,

// instruction parts
output [31:0] instruction,
output [6:0] opcode,
output [4:0] rd,
output [2:0] funct3,
output [4:0] rs1,
output [4:0] rs2,
output [6:0] funct7,

// Data
output [63:0] read_data1,
output [63:0] read_data2,
output [63:0] immediate_data,
output [63:0] write_data,
output [63:0] ALU_Result,
output [63:0] mem_read_data,

output sig_zero
    );

// mux wires
wire [63:0] pc_mux_0, pc_mux_1;


wire [63:0] ALU_mux_O; // output 

wire [63:0] dm_mux_I0;
wire [63:0] dm_mux_I1;
wire [63:0] dm_mux_O;
wire dm_mux_S;

// Control Signals
wire sig_Branch;
wire sig_MemRead;
wire sig_MemToReg;
wire [1:0] sig_ALUOp;
wire sig_MemWrite;
wire sig_ALUSrc;
wire sig_RegWrite;
// tells ALU what operation to perform from AND,OR,SUB,ADD and XOR
wire [3:0]sig_operation;


Program_Counter PC(.PC_In(pc_in), .clk(clk), .reset(reset), .PC_Out(pc_out));

Adder Adder1(.a(pc_out), .b(4), .out(pc_mux_0));

// Branch instruction adder. immediate data is shifted left by 1.
Adder Adder2(.a(pc_out), .b(immediate_data*2), .out(pc_mux_1));

Mux_2x1 Branch_Mux(.a(pc_mux_0),
.b(pc_mux_1),
.sel(0),
.data_out(pc_in));

Instruction_Memory u1(pc_out, instruction);

Instruction_Parser_R u2(instruction, opcode, rd, funct3, rs1, rs2, funct7);


Control_Unit u3(.Opcode(opcode),
.Branch(sig_Branch), 
.MemRead(sig_MemRead), 
.MemtoReg(sig_MemToReg), 
.MemWrite(sig_MemWrite), 
.ALUSrc(sig_ALUSrc), 
.RegWrite(sig_RegWrite), 
.ALUOp(sig_ALUOp));

// Immediate Data Extractor: Reads the sign-extended 64-bit Immediate value
Imm_Data_Extractor u4(instruction, immediate_data);

registerFile u5( .clk(clk),
.reset(reset),
.WriteData(write_data),
.rs1(rs1),
.rs2(rs2),
.rd(rd),
.RegWrite(sig_RegWrite),
.ReadData1(read_data1),
.ReadData2(read_data2));

ALU_Control u6(.ALUOp(sig_ALUOp),
.Funct({instruction[30],instruction[14:12]}),
.Operation(sig_operation));

Mux_2x1 ALU_MUX(.a(read_data2),
.b(immediate_data),
.sel(ALUSrc),
.data_out(ALU_mux_O));

ALU_64_bit u7(.a(read_data1), 
.b(ALU_mux_O),
.ALUOp(sig_operation),
.Result(ALU_Result),
.ZERO(sig_zero));



Data_Memory u8(.Mem_Addr(ALU_Result), // 64 bit input specifiying memroy address
.Write_Data(read_data2), // 64 bit data input
.clk(clk), // clock
.MemWrite(sig_MemWrite), // MemWrite signal from the control unit that determines the write operation
.MemRead(sig_MemRead), // MemRead signal from the control unit that determines the read operation
.Read_Data(mem_read_data) ); // 64 bit output in case if data is read

Mux_2x1 MEM_mux(.a(ALU_Result),
.b(mem_read_data),
.sel(sig_MemToReg),
.data_out(write_data));


endmodule