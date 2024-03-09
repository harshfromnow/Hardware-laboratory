.data
    prompt: .asciiz "Enter a number: "
    even: .asciiz "The number is even.\n"
    odd: .asciiz "The number is odd.\n"

.text

main:
    li $v0, 4  # syscall for printing a string
    la $a0, prompt  # load address of prompt string
    syscall

    # Read the number
    li $v0, 5  # syscall for reading an integer
    syscall
    move $t0, $v0  # store number in temporary register

check:
	div $t0, $t0, 2
	mfhi $t1
	
	beqz $t1, print_even
	j print_odd

print_even:
    # Print even message
    li $v0, 4
    la $a0, even
    syscall
    j exit

print_odd:
	li $v0, 4
	la $a0, odd
	syscall
	
exit:
    li $v0, 10
    syscall