.data
	prompt: .asciiz "Enter a positive number: "
	result: .asciiz "The factorial is "
	newline: .asciiz "\n"
	
.text

main:
	li $v0, 4
	la $a0, prompt
	syscall 
	
	li $v0, 5
	syscall
	move $t0, $v0
	
	li $t1, 1
	li $t2, 1
	
factorial_loop:
	mul $t1,$t1,$t2
	addi $t2, $t2, 1
	ble $t2, $t0, factorial_loop
	
print_result:
	li $v0, 4
	la $a0, result
	syscall

print_factorial:
	li $v0, 1
	move $a0, $t1
	syscall	

print_newline:
	li $v0, 4
	la $a0, newline
	syscall
	
exit:
	li $v0, 10
	syscall