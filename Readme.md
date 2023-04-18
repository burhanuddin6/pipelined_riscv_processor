pipelined_riscv_processor
=========================

This is an implementation of pipelined version of the processor compatible with RISC V ISA. Verilog HDL is used to design the hardware for the processor. 
The assembly code is assembled using the opensource python riscv-assembler tool, which translates the .s assembly code file to a .txt file which acts as instruction 
memory. This .txt is read by the instruction_memory module at the first clock cycle

About pipelined_processor directory
------------------------------------
This directory contains vivado project for the processor (to simulate). The src files are added from the src_files repo.

Usage
-----
The sources as well as a vivado project is added to this repository making it easy to use. Clone the whole repo and start working with Vivado.
Make sure to add the (if any) new src files to the src_files folder and then add it to the vivado project using Addfiles option.
