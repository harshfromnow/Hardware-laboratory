.data
    prompt: .asciiz "Enter a positive number: "
    result: .asciiz "The factorial of is: "
    newline: .asciiz "\n"
    
.text

main:
    # Print prompt and read input
    li $v0, 4  # syscall for printing a string
    la $a0, prompt  # load address of prompt string
    syscall

    # Read the number
    li $v0, 5  # syscall for reading an integer
    syscall
    move $t0, $v0  # store number in temporary register



    # Initialize factorial and counter
    li $t1, 1    
    li $t2, 1 

factorial_loop:
    # Multiply factorial by counter
    mul $t1, $t1, $t2  
    addi $t2, $t2, 1   
    ble $t2, $t0, factorial_loop  # jump back to loop if counter < input

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
