.data
    prompt: .asciiz "Enter a number: "
    even: .asciiz "The number is even.\n"
    odd: .asciiz "The number is odd.\n"

.align 2
.text

.globl main

main:
    li $v0, 4  # syscall for printing a string
    la $a0, prompt  # load address of prompt string
    syscall

    # Read the number
    li $v0, 5  # syscall for reading an integer
    syscall
    move $t0, $v0  # store number in temporary register

    # Check if even using bitwise AND (and immediate)
    andi $t1, $t0, 1  # check least significant bit (LSB)
    beqz $t1, print_even  # branch to print_even if LSB is zero (even)

    # Print odd message (only reached if LSB is one)
    li $v0, 4
    la $a0, odd
    syscall

    j exit  # Jump to exit after printing "odd"

print_even:
    # Print even message
    li $v0, 4
    la $a0, even
    syscall

exit:
    # Exit the program
    li $v0, 10
    syscall
