pipelined_riscv_processor
=========================

This is an implementation of pipelined version of the processor compatible with RISC V ISA. Verilog HDL is used to design the hardware for the processor. 
The assembly code is assembled using the opensource python riscv-assembler tool, which translates the .s assembly code file to a .txt file which acts as instruction 
memory. This .txt is read by the instruction_memory module at the first clock cycle
