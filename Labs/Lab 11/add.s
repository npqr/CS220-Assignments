.data
input_msg0:	.asciiz "Enter length of vector: "
input_msg1:	.asciiz "\nInput float number: "
output_msg0:.asciiz "\nAnswer: "
.text
.globl main

main:
# input n
li $v0, 4
la $a0, input_msg0
syscall
li $v0, 5
syscall

add $s0, $v0, $0
add $t0, $s0, $0
sub.s $f1, $f1, $f1
add $t1, $0, $0

loop:
li $v0, 4
la $a0, input_msg1
syscall
li $v0, 6
syscall

andi $t2, $t1, 1
beq $t2, $0, add1
sub.s $f1, $f1, $f0
j endif

add1:
add.s $f1, $f1, $f0

endif:
addi $t1, $t1, 1
bne $t0, $t1, loop

li $v0, 4
la $a0, output_msg0
syscall
li $v0, 2
mov.s $f12, $f1
syscall
jr $ra