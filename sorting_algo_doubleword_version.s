addi x11,x0,5
addi x10,x0,0 
addi sp, x0, 200
addi x12, x0, 15
sd x12, 0(x10)
addi x12, x0, 3
sd x12,4(x10)
addi x12, x0, 18
sd x12, 8(x10)
addi x12, x0, 2
sd x12, 12(x10)
addi x12, x0, 14
sd x12, 16(x10)
sort: addi sp, sp, -40  
sd x1, 16(sp)  
sd x22, 12(sp) 
sd x21, 8(sp)  
sd x20, 4(sp)  
sd x19, 0(sp) 
add x21, x10, x0  base = 0
add x22, x11, x0  n = 5
addi x19, x0, 0 
for1tst: beq x19, x22, exit1 
addi x20, x19, -1 
for2tst: blt x20, x0, exit2 
slli x5, x20, 3
add x5, x21, x5 
ld x6, 0(x5) 
ld x7, 8(x5) 
blt x6, x7, exit2
add x10, x21, x0 
add x11, x20, x0 
beq x0, x0, swap
HookBack: addi x20, x20, -1 
beq x0, x0, for2tst
exit2: addi x19, x19, 1
beq x0, x0, for1tst       
swap: slli x6, x11, 2
add x6, x10, x6 
ld x5, 0(x6)
ld x7, 8(x6)
sd x7, 0(x6)
sd x5, 4(x6)
beq x0, x0, HookBack
exit1: ld x19, 0(sp) 
ld x20, 8(sp) 
ld x21, 16(sp) 
ld x22, 24(sp) 
ld x1, 32(sp) 
addi sp, sp, 40
