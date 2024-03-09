.data
	array: .space 100
	array_size: .word 0
	size: .asciiz "Enter size of array: "
	prompt: .asciiz "Enter element of array: "
	key: .asciiz "Enter key to be searched: "
	foundyes: .asciiz "Key found at position "
	foundno: .asciiz "Key not found in given array"
	
.text

main:
	#array size
	li $v0, 4
	la $a0, size
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0 #t0 has array size
	sw $t0, array_size
	
	li $t1, 0
	la $t3, array #stores base address of array
	
	li $t2, 1 #position
	
input:
	beq $t1, $t0 search
	
	#input element
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 5
	syscall
	sw $v0, ($t3)
	
	addi $t1, $t1, 1
	addi $t3, $t3, 4
	
	j input
	
search:
	li $v0, 4
	la $a0, key
	syscall
	
	li $v0, 5
	syscall
	move $t4, $v0
	
#initialize loop variables
lw $t0, array_size
la $t3, array
	
loop:
	bgt $t2, $t0, notfound
	lw $t5, ($t3)
	beq $t5, $t4, found
	addi $t2, $t2, 1
	addi $t3, $t3, 4
	j loop
	
found:
	li $v0, 4
	la $a0, foundyes
	syscall
	
	li $v0, 1
	move $a0, $t2
	syscall
	j exit
	
notfound:
	li $v0, 4
	la $a0, foundno
	syscall
	j exit
	
exit:
	li $v0, 10
	syscall
