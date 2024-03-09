.data
	lower: .asciiz "Enter lower bound: "
	upper: .asciiz "Enter upper bound: "
	count: .asciiz "The number of prime numbers in the given range is "
	newline: .asciiz "\n"
	
.text 

main:
	li $v0, 4
	la $a0, lower
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0
	
	li $v0, 4
	la $a0, upper
	syscall
	
	li $v0, 5
	syscall
	move $t1, $v0	
	
	addi $t1, $t1, -1
	li $t6, 0 #count
	
range_check:
	bgt $t0, $t1, newline_print
	addi $t0, $t0, 1
	
	li $t2, 0 #flag=0
	li $t3, 1
	
	prime_check:
		addi $t3, $t3, 1
		beq $t3, $t0, range_check
		div $t1, $t0, $t3
		mfhi $t4
		
		beqz $t4, update
		update:
			addi $t2, $t2, 1
			
		j prime_check
	move $t5, $t0
	beqz $t2, yes
	yes:
		addi $t6, $t6, 1
		li $v0, 1
		move $a0, $t5
		syscall
		
		li $a0, 32 # 32 is the ASCII code for space
		li $v0, 11 # syscall number for printing character
		syscall
	j range_check


newline_print:
	li $v0, 4
	la $a0, newline
	syscall
	
countnum:
	li $v0, 4
	la $a0, count
	syscall
	
	li $v0, 1
	move $a0, $t6
	syscall
	
exit:
	li $v0, 10
	syscall