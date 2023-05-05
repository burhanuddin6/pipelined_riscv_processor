`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module Hazard_Unit(
input [4:0] Rs1,
input [4:0] Rs2,
input [4:0] IDEX_Rd,
input IDEX_MemRead,
output PCWrite,
output IFIDWrite,
output Stall
);

always @(*)
begin
    if (IDEX_MemRead and ((IDEX_Rd = Rs1) or (IDEX_Rd == Rs2)))
    begin
        Stall = 1;
        PCWrite = 0;
        IFIDWrite = 0;
    end
    else
    begin
        Stall = 0;
        PCWrite = 1;
        IFIDWrite = 1;
    end
end
