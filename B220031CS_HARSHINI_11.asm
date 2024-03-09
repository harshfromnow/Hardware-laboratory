.data
    prompt: .asciiz "Enter a string: "
    result: .asciiz "Result: "
    address: .space 256

.text

main:
    li $v0, 4
    la $a0, prompt
    syscall

    li $v0, 8
    la $a0, address
    li $a1, 255 #max length of string to be read
    syscall

    la $t0, address # Points to the beginning of string

firstcheck:
    lb $t1, 0($t0)
    beqz $t1, resultstr # Check end of string

    li $t2, 'a'
    li $t3, 'z'
    blt $t1, $t2, uppercheck
    bgt $t1, $t3, uppercheck

    addi $t1, $t1, -32
    sb $t1, 0($t0)
    j next_character

uppercheck:
    li $t4, 'A'
    li $t5, 'Z'
    blt $t1, $t4, next_character
    bgt $t1, $t5, next_character

    addi $t1, $t1, 32
    sb $t1, 0($t0)

next_character:
    addi $t0, $t0, 1
    j firstcheck

resultstr:
    li $v0, 4
    la $a0, result
    syscall

    li $v0, 4
    la $a0, address
    syscall

    li $v0, 10
    syscall

	