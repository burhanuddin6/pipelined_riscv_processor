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


module Pipelined_Test(
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

output [63:0] FMux1_out,
output [63:0] FMux2_out,
output [1:0] sig_ForwardA,
output [1:0] sig_ForwardB,

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
wire [63:0] adder1_out;
wire [63:0] adder2_out;

wire [63:0] ALU_mux_out; // output of ALU mux

////////////////////////////////INSTRUCTION FETCH STAGE/////////////////////////////////////////////////////////
Program_Counter pc_module_1(.PC_In(pc_in), 
        .clock(clock), 
        .reset(reset), 
        .PC_Out(pc_out));

Adder Adder_1(.a(pc_out), 
        .b(4), 
        .out(adder1_out));

Mux_2x1 Branch_Mux(.a(adder1_out),
        .b(EXMEM_PC),
        .sel_bit(EXMEM_Branch & EXMEM_Zero),
        .data_out(pc_in));

Instruction_Memory IM_module_1(.Instruction_Address(pc_out),
        .Instruction(instruction));

////////////////////////////IF/ID Pipeline Register////////////////////////////////////////////////////////
wire [63:0] IFID_PC;
wire [31:0] IFID_Instruction;
IFID IFID_Register(.clock(clock),
    .reset(reset),
    .PC(pc_out),
    .Instruction(instruction),
    .IFID_PC(IFID_PC),
    .IFID_Instruction(IFID_Instruction));
////////////////////////////INSTRUCTION DECODE STAGE/////////////////////////////////////////////////////////

Instruction_Parser IP_module_1(.instruction(IFID_Instruction),
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
        .Shift(sig_Shift),
        .ALUOp(sig_ALUOp));

Register_File RF_module_1(.clock(clock),
        .reset(reset),
        .Write_Data(write_data),
        .rs1(rs1),
        .rs2(rs2),
        .rd(MEMWB_rd),
        .RegWrite(MEMWB_RegWrite), // WB.RegWrite
        .Read_Data_1(read_data1),
        .Read_Data_2(read_data2),

        .RegFile0(RegFile0),
        .RegFile1(RegFile1),
        .RegFile2(RegFile2),
        .RegFile3(RegFile3),
        .RegFile4(RegFile4),
        .RegFile5(RegFile5));

// Immediate Data Extractor: Reads the sign-extended 64-bit Immediate value
Imm_Data_Extractor IDE_module_1(.Instruction(IFID_Instruction), // the 32-bit Instruction
        .immediate(immediate_data));

///////////////////////////////ID/EX Pipeline Register////////////////////////////////////////////////////////
wire [63:0] IDEX_PC;

wire IDEX_Branch;
wire IDEX_MemRead;
wire IDEX_MemToReg;
wire [1:0] IDEX_ALUOp;
wire IDEX_MemWrite;
wire IDEX_ALUSrc;
wire IDEX_RegWrite;
wire IDEX_Shift;
wire [63:0] IDEX_Read_Data_1;
wire [63:0] IDEX_Read_Data_2;
wire [63:0] IDEX_immediate_data;
wire [3:0] IDEX_Funct;
wire [4:0] IDEX_rd;
wire [4:0] IDEX_rs1;
wire [4:0] IDEX_rs2;

IDEX_2 IDEX_Reg(.clock(clock),
    .reset(reset),

    .RegWrite(sig_RegWrite),
    .MemToReg(sig_MemToReg),
    .Branch(sig_Branch),
    .MemRead(sig_MemRead),
    .MemWrite(sig_MemWrite),
    .ALUSrc(sig_ALUSrc),
    .Shift(sig_Shift),
    .ALUOp(sig_ALUOp),

    // PC
    .PC(IFID_PC),

    // RegisterFile contents
    .Read_Data_1(read_data1),
    .Read_Data_2(read_data2),

    // imm, Funct, rd
    .Immediate(immediate_data),
    .Rs1(rs1),
    .Rs2(rs2),
    .Instruction_30_14_12({instruction[30],instruction[14:12]}),
    .Instruction_11_7(rd),

    .IDEX_RegWrite(IDEX_RegWrite),
    .IDEX_MemToReg(IDEX_MemToReg),
    .IDEX_Branch(IDEX_Branch),
    .IDEX_MemRead(IDEX_MemRead),
    .IDEX_MemWrite(IDEX_MemWrite),
    .IDEX_ALUSrc(IDEX_ALUSrc),
    .IDEX_Shift(IDEX_Shift),
    .IDEX_ALUOp(IDEX_ALUOp),

    .IDEX_PC(IDEX_PC),

    .IDEX_Read_Data_1(IDEX_Read_Data_1),
    .IDEX_Read_Data_2(IDEX_Read_Data_2),

    .IDEX_Immediate(IDEX_immediate_data),
    .IDEX_Rs1(IDEX_rs1),
    .IDEX_Rs2(IDEX_rs2),
    .IDEX_Instruction_30_14_12(IDEX_Funct),
    .IDEX_Instruction_11_7(IDEX_rd));

////////////////////////////////////EXECUTE STAGE/////////////////////////////////////////////////////////

// Branch instruction adder. immediate data is shifted left by 1.
Adder Adder_2(.a(IDEX_PC), 
        .b(IDEX_immediate_data), 
        .out(adder2_out));

Mux_3x1 Forward_Mux1(.in0(IDEX_Read_Data_1),
        .in1(write_data),
        .in2(EXMEM_ALU_Result),
        .sel(sig_ForwardA),
        .data_out(FMux1_out));

Mux_3x1 Forward_Mux2(.in0(IDEX_Read_Data_2),
        .in1(write_data),
        .in2(EXMEM_ALU_Result),
        .sel(sig_ForwardB),
        .data_out(FMux2_out));

Mux_2x1 ALU_Mux(.a(FMux2_out),
        .b(IDEX_immediate_data),
        .sel_bit(IDEX_ALUSrc),
        .data_out(ALU_mux_out));

ALU_Control ALUC_module_1(.ALUOp(IDEX_ALUOp),
        .Funct(IDEX_Funct),
        .Operation(sig_operation));

ALU_64_bit ALU_module_1(.a(FMux1_out), 
        .b(ALU_mux_out),
        .ALUOp(sig_operation),
        .Shift(IDEX_Shift),
        .Result(ALU_Result),
        .Zero(sig_zero));

Forwarding_Unit FU_module_1(.MEMWB_rd(MEMWB_rd),
        .EXMEM_rd(EXMEM_rd),
        .MEMWB_RegWrite(MEMWB_RegWrite),
        .EXMEM_RegWrite(EXMEM_RegWrite),
        .IDEX_Rs1(IDEX_rs1),
        .IDEX_Rs2(IDEX_rs2),
        .ForwardA(sig_ForwardA),
        .ForwardB(sig_ForwardB));

///////////////////////////////EX/MEM Pipeline Register////////////////////////////////////////////////////////
wire [63:0] EXMEM_PC;

wire EXMEM_Branch;
wire EXMEM_MemRead;
wire EXMEM_MemToReg;
wire EXMEM_MemWrite;
wire EXMEM_RegWrite;

wire EXMEM_Zero;
wire [63:0] EXMEM_ALU_Result;
wire [63:0] EXMEM_Read_Data_2;
wire [4:0] EXMEM_rd;

EXMEM EXMEM_Register(.clock(clock),
    .reset(reset),

    .RegWrite(IDEX_RegWrite),
    .MemToReg(IDEX_MemToReg),
    .Branch(IDEX_Branch),
    .MemRead(IDEX_MemRead),
    .MemWrite(IDEX_MemWrite),

    .PC(adder2_out),

    .ALU_Result(ALU_Result),
    .Zero(sig_zero),

    .Read_Data_2(FMux2_out),
    .Instruction_11_7(IDEX_rd),

    .EXMEM_RegWrite(EXMEM_RegWrite),
    .EXMEM_MemToReg(EXMEM_MemToReg),
    .EXMEM_Branch(EXMEM_Branch),
    .EXMEM_MemRead(EXMEM_MemRead),
    .EXMEM_MemWrite(EXMEM_MemWrite),

    .EXMEM_PC(EXMEM_PC),

    .EXMEM_ALU_Result(EXMEM_ALU_Result),
    .EXMEM_Zero(EXMEM_Zero),

    .EXMEM_Read_Data_2(EXMEM_Read_Data_2),
    .EXMEM_Instruction_11_7(EXMEM_rd));
    
////////////////////////////////////MEMORY STAGE//////////////////////////////////////////////////////////////

Data_Memory DM_module_1(.Memory_Address(EXMEM_ALU_Result), // 64 bit input specifiying memroy address
        .Write_Data(EXMEM_Read_Data_2), // 64 bit data input
        .clock(clock), // clock
        .MemWrite(EXMEM_MemWrite), // MemWrite signal from the control unit that determines the write operation
        .MemRead(EXMEM_MemRead), // MemRead signal from the control unit that determines the read operation
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
        .Stack5(Stack5)); // 64 bit output in case if data is read

////////////////////////////////////MEM/WB Pipeline Register//////////////////////////////////////////////////

wire MEMWB_MemToReg;
wire MEMWB_RegWrite;

wire [63:0] MEMWB_ALU_Result;
wire [63:0] MEMWB_Read_Data;

wire [4:0] MEMWB_rd;

MEMWB MEMWB_Register(.clock(clock),
    .reset(reset),

    .RegWrite(EXMEM_RegWrite),
    .MemToReg(EXMEM_MemToReg),

    .ALU_Result(EXMEM_ALU_Result),
    .Read_Data(mem_read_data),

    .Instruction_11_7(EXMEM_rd),

    .MEMWB_RegWrite(MEMWB_RegWrite),
    .MEMWB_MemToReg(MEMWB_MemToReg),

    .MEMWB_ALU_Result(MEMWB_ALU_Result),
    .MEMWB_Read_Data(MEMWB_Read_Data),

    .MEMWB_Instruction_11_7(MEMWB_rd));

////////////////////////////////////WRITE BACK STAGE//////////////////////////////////////////////////////////

Mux_2x1 MEM_Mux(.a(MEMWB_ALU_Result),
        .b(MEMWB_Read_Data),
        .sel_bit(MEMWB_MemToReg),
        .data_out(write_data));


endmodule