.data
	prompt: .asciiz "Enter a positive integer: "
	yes: .asciiz "Yes, the given integer is an Armstrong number"
	no: .asciiz "No, the given integer is not an Armstrong number"
	
.text

main:
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0
	move $t3, $t0
	move $t6, $t0
	
	#initialize
	li $t2, 0
	li $t4, 0
	
digit_count:
	beqz $t0, loop
	
	div $t0, $t0, 10
	addi $t4, $t4, 1 #digit counter
	j digit_count
	
loop:
	beqz $t3, check
	div $t3, $t3, 10
	mfhi $t1 #num%10
	move $t7, $t1
	move $t5, $t4 #digit counter
	power:
		ble $t5, 1, sum
		mul $t7, $t7, $t1
		addi $t5, $t5, -1
		j power
	sum:
		add $t2, $t2, $t7
		j loop
	
check:
	beq $t2, $t6 print_yes
	j print_no
	
print_yes:
	li $v0, 4
	la $a0, yes
	syscall 
	j exit

print_no:
	li $v0, 4
	la $a0, no
	syscall 
	j exit
	
exit:
	li $v0, 10
	syscall