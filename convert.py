# CONVERT RISCV ASSEMBLY SCRIPT TO MACHINE CODE IN TXT FILE
# Github: https://github.com/kcelebi
# Install: $pip install riscv-assembler


from riscv_assembler.convert import AssemblyConverter as AC
# instantiate object, by default outputs to a file in nibbles, not in hexademicals
convert = AC(output_mode = 'f', nibble_mode = True, hex_mode = False)

# Convert a whole .s file to text file
convert("assembly.s", "result.txt")