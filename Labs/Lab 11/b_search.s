.data
array:		.space 48
input_msg0:	.asciiz "Enter length of the array: "
input_msg2:	.asciiz "\nInput number: "
input_msg3:	.asciiz "\nEnter number to search: "
output_msg0:.asciiz "\nFound element at index: "
output_msg1:.asciiz "\nElement was not found"

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

# input array
la $s1, array
add $t1, $s1, $0
loop:
li $v0, 4
la $a0, input_msg2
syscall
li $v0, 5
syscall
sw $v0, 0($t1)
addi $t1, $t1, 4
addi $t0, $t0, -1
bne $t0, $0, loop

# input k
li $v0, 4
la $a0, input_msg3
syscall
li $v0, 5
syscall
add $s2, $v0, $0

add $a0, $s1, $0
add $a1, $0, $0
add $a2, $s0, $0
add $a3, $s2, $0
addi $sp, $sp, -4
sw $ra, 0($sp)
jal bin_search
lw $ra, 0($sp)
addi $sp, $sp, 4
sll $t1, $v0, 2 
add $t1, $t1, $s1 
lw $t1, 0($t1)
beq $t1, $s2, found

# element not found
addi $v0, $0, 4
la $a0, output_msg1
syscall
jr $ra

# element found
found:
add $t0, $v0, $0
addi $v0, $0, 4
la $a0, output_msg0
syscall
addi $v0, $0, 1
add $a0, $t0, $0
syscall
jr $ra


# bin_search(array, lo, hi, k)
bin_search:

# if hi < lo return -1
sltu $t0, $a1, $a2
bne $t0, $0, label0
add $v0, $a1, $0
jr $ra

label0:
add $t0, $a1, $a2
srl $t0, $t0, 1
sll $t1, $t0, 2
add $t1, $a0, $t1
lw $t1, 0($t1)
sltu $t1, $t1, $a3
beq $t1, $0, label1


# if(arr[mid] < k)
addi $sp, $sp, -4
sw $ra, 0($sp)
addi $a1, $t0, 1
jal bin_search
lw $ra, 0($sp)
addi $sp, $sp, 4
jr $ra

# else
label1:
addi $sp, $sp, -4
sw $ra, 0($sp)
add $a2, $t0, $0
jal bin_search
lw $ra, 0($sp)
addi $sp, $sp, 4
jr $ra
