from riscv_assembler.convert import AssemblyConverter as AC
# instantiate object, by default outputs to a file in nibbles, not in hexademicals
convert = AC(output_mode = 'f', nibble_mode = False, hex_mode = True)

# Convert a whole .s file to text file
convert("assembly.s", "src_files/instructions.txt")
