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
input clock, reset,

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


output sig_Branch,
output sig_MemRead,
output sig_MemToReg,
output [1:0] sig_ALUOp,
output sig_MemWrite,
output sig_ALUSrc,
output sig_RegWrite,
// tells ALU what operation to perform from AND,OR,SUB,ADD and XOR
output [3:0]sig_operation,
output sig_Shift,
output sig_zero,

output [63:0] RegFile0,
output [63:0] RegFile1,
output [63:0] RegFile2,
output [63:0] RegFile3,
output [63:0] RegFile4,
output [63:0] RegFile5,

output [63:0] DataMem0,
output [63:0] DataMem1,
output [63:0] DataMem2,
output [63:0] DataMem3,
output [63:0] DataMem4,
output [63:0] DataMem5,

output [63:0] Stack0,
output [63:0] Stack1,
output [63:0] Stack2,
output [63:0] Stack3,
output [63:0] Stack4,
output [63:0] Stack5

    );

// mux wires
wire [63:0] pc_mux_0, pc_mux_1;


wire [63:0] ALU_mux_O; // output 



Program_Counter pc_module_1(.PC_In(pc_in), 
        .clock(clock), 
        .reset(reset), 
        .PC_Out(pc_out));

Adder Adder_1(.a(pc_out), 
        .b(4), 
        .out(pc_mux_0));

// Branch instruction adder. immediate data is shifted left by 1.
Adder Adder_2(.a(pc_out), 
        .b(immediate_data), 
        .out(pc_mux_1));

Mux_2x1 Branch_Mux(.a(pc_mux_0),
        .b(pc_mux_1),
        .sel_bit(sig_Branch & sig_zero),
        .data_out(pc_in));

Instruction_Memory IM_module_1(.Instruction_Address(pc_out),
        .Instruction(instruction));

Instruction_Parser IP_module_1(.instruction(instruction),
        .opcode(opcode),
        .rd(rd),
        .funct3(funct3),
        .rs1(rs1),
        .rs2(rs2),
        .funct7(funct7));


Control_Unit CU_module_1(.opcode(opcode),
        .funct3(funct3),
        .Branch(sig_Branch), 
        .MemRead(sig_MemRead), 
        .MemtoReg(sig_MemToReg), 
        .MemWrite(sig_MemWrite), 
        .ALUSrc(sig_ALUSrc), 
        .RegWrite(sig_RegWrite), 
        .ALUOp(sig_ALUOp),
        .Shift(sig_Shift));

// Immediate Data Extractor: Reads the sign-extended 64-bit Immediate value
Imm_Data_Extractor IDE_module_1(.Instruction(instruction), // the 32-bit Instruction
        .immediate(immediate_data));

Register_File_SC RF_module_1(.clock(clock),
        .reset(reset),
        .Write_Data(write_data),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .RegWrite(sig_RegWrite),
        .Read_Data_1(read_data1),
        .Read_Data_2(read_data2),
        .RegFile0(RegFile0),
        .RegFile1(RegFile1),
        .RegFile2(RegFile2),
        .RegFile3(RegFile3),
        .RegFile4(RegFile4),
        .RegFile5(RegFile5));

ALU_Control ALUC_module_1(.ALUOp(sig_ALUOp),
        .Funct({instruction[30],instruction[14:12]}),
        .Operation(sig_operation));

Mux_2x1 ALU_Mux(.a(read_data2),
        .b(immediate_data),
        .sel_bit(sig_ALUSrc),
        .data_out(ALU_mux_O));

ALU_64_bit ALU_module_1(.a(read_data1), 
        .b(ALU_mux_O),
        .ALUOp(sig_operation),
        .Shift(sig_Shift),
        .Result(ALU_Result),
        .Zero(sig_zero));


Data_Memory DM_module_1(.Memory_Address(ALU_Result), // 64 bit input specifiying memroy address
        .Write_Data(read_data2), // 64 bit data input
        .clock(clock), // clock
        .MemWrite(sig_MemWrite), // MemWrite signal from the control unit that determines the write operation
        .MemRead(sig_MemRead), // MemRead signal from the control unit that determines the read operation
        .Read_Data(mem_read_data),
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
        .Stack5(Stack5) ); // 64 bit output in case if data is read

Mux_2x1 MEM_Mux(.a(ALU_Result),
        .b(mem_read_data),
        .sel_bit(sig_MemToReg),
        .data_out(write_data));


endmodule