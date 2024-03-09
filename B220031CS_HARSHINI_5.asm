.data
	prompt: .asciiz "Enter a positive integer: "
	yes: .asciiz "Yes, given integer is a perfect number"
	no: .asciiz "No, given integer is not a perfect number"
	
.text

main:
	li $v0, 4
	la $a0, prompt
	syscall
	
	#read integer
	li $v0, 5
	syscall
	move $t0, $v0
	
	#initialise
	li $t1, 1 #factors
	li $t2, 0 #sum=0
	
perfect_loop:
	beq $t1, $t0 result
	
	div $t3, $t0, $t1
	mfhi $t4
	
	beqz $t4 check
		
	addi $t1, $t1, 1
	j perfect_loop
	
check:
	add $t2, $t2, $t1
	addi $t1, $t1, 1
	j perfect_loop
	
result:
	beq $t0, $t2 yes_print
	j no_print


yes_print:
	li $v0, 4
	la $a0, yes
	syscall
	j exit
	
no_print:
	li $v0, 4
	la $a0, no
	syscall
	j exit
		
exit:
	li $v0, 10
	syscall
	
	