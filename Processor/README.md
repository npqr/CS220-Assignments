# Verilog HDL Processor

This repository contains the implementation of a 32-bit MIPS-like processor in Verilog HDL. The processor supports upto 32 registers, 32-bit instructions, and 32-bit memory addressing. The processor is capable of executing a subset of the MIPS instruction set, and currently supports the following instructions:

- ADD, ADDU
- ADDI, ADDIU
- SUB, SUBU
- AND, ANDI
- OR, ORI
- XOR, XORI
- NOR
- SLT, SLTU
- SLTI, SLTIU
- SLL, SLLV
- SRA, SRAV
- SRL, SRLV
- MULT, MULTU
- DIV, DIVU
- MFHI, MFLO
- MTHI, MTLO
- BEQ, BNE
- BLEZ, BGTZ
- BLTZ, BGEZ
- BLTZAL, BGEZAL
- J, JAL
- JALR, JR
- MFC0, MTC0
- BREAK, SYSCALL
- LB, LBU
- LH, LHU
- LW
- SB
- SH
- SW
- LUI
- DIV
- MULT
- NOR
- MFHI