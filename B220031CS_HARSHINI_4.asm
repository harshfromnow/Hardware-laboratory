.data
	prompt: .asciiz "Enter 32 bit binary number: "
	result: .asciiz "It's decimal equivalent is "
	
.text

main:
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0 #int num
	
	li $t1, 0 #sum
	li $t2, 0 #counter
	
convert_loop:
	beqz $t0, print_result #check if num=0, then come out of loop
	
	div $t0, $t0, 10 # divide num by 10
	mfhi $t4 #digit=num%10
	
	li $t5, 1
	move $t6, $t2
	
	power_loop:
		beqz $t6, power_done
		mul $t5, $t5, 2
		addi $t6, $t6, -1
		j power_loop
	power_done:
	
	mul $t7, $t4, $t5
	add $t1, $t1, $t7
	
	addi $t2, $t2, 1
	
	j convert_loop	
	
print_result:
	li $v0, 4
	la $a0, result
	syscall

	li $v0, 1
	move $a0, $t1
	syscall
	
exit:
	li $v0, 10
	syscall