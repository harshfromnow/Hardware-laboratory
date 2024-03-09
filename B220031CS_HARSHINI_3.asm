.data
    prompt: .asciiz "Enter a positive number: "
    yes: .asciiz "Yes, it's a palindrome"
    no: .asciiz "No, it's not a palindrome"

.text

main:
    li $v0, 4
    la $a0, prompt
    syscall
    
    li $v0, 5
    syscall
    move $t0, $v0 # loads integer
    
    move $t1, $zero   # reversed number
    move $t2, $t0     # original number
    
reverse_loop:
    beqz $t2, compare_numbers
    
    # extract the last digit of the original number
    div $t2, $t2, 10
    mfhi $t3
    
    # append the digit to the reversed number
    mul $t1, $t1, 10
    add $t1, $t1, $t3
    
    j reverse_loop

compare_numbers:
    beq $t0, $t1, print_yes
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


	
	

