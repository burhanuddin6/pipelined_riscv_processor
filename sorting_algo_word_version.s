addi x11,x0,5
addi x10,x0,0 
addi x12, x0, 15
sw x12, 0(x10)
addi x12, x0, 3
sw x12, 4(x10)
addi x12, x0, 18
sw x12, 8(x10)
addi x12, x0, 2
sw x12, 12(x10)
addi x12, x0, 14
sw x12, 16(x10)

sort: 
addi sp, sp, -20  
sw x1, 16(sp)  
sw x22, 12(sp) 
sw x21, 8(sp)  
sw x20, 4(sp)  
sw x19, 0(sp) 
add x21, x10, x0  
add x22, x11, x0 
addi x19, x0, 0    

for1tst: 
beq x19, x22, exit1 
addi x20, x19, -1 
        
for2tst: 
blt x20, x0, exit2 
slli x5, x20, 2
add x5, x21, x5 
lw x6, 0(x5) 
lw x7, 4(x5) 
blt x6, x7, exit2
add x10, x21, x0 
add x11, x20, x0 
beq x0, x0, swap

HookBack:
addi x20, x20, -1 
beq x0, x0 for2tst

exit2: 
addi x19, x19, 1
beq x0, x0, for1tst       
       
swap: 
slli x6, x11, 2
add x6, x10, x6 
lw x5, 0(x6)
lw x7, 4(x6)
sw x7, 0(x6)
sw x5, 4(x6)
beq x0, x0, HookBack
      
exit1: 
lw x19, 0(sp) 
lw x20, 4(sp) 
lw x21, 8(sp) 
lw x22, 12(sp) 
lw x1, 16(sp) 
addi sp, sp, 20
