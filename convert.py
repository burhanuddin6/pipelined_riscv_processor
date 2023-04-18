from riscv_assembler.convert import AssemblyConverter as AC
# instantiate object, by default outputs to a file in nibbles, not in hexademicals
convert = AC(output_mode = 'f', nibble_mode = False, hex_mode = False)

# Convert a whole .s file to text file
convert("assembly.s", "result.txt")

file1 = open('result.txt','r')
file2 = open('instructions.mem','w')
output = []
for line in file1.readlines():
    line = line.strip()
    for i in range(32,0,-8):
        output.append(line[i-8:i])
    
file2.write('\n'.join(output))
file1.close()
file2.close()