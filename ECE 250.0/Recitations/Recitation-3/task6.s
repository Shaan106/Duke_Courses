
.text
.align 2

main:
    # incrementing the stack pointer
    addi $sp, $sp, -4

    # stores the current return address on the stack at the place of the stack pointer.
    sw $ra, 0($sp)

    li $a0, 1
    li $a1, 2

    # jal stores address into $ra
    jal _foo

    #moving v0 in a0 to allow for v0 to be changed for prin
    move $a0, $v0

    #code for printing
    li $v0, 1
    syscall


    #resetting value of ra
    lw $ra, 0($sp)
    # resetting stack pointer after function is done running
    addi $sp, $sp, 4

    jr $ra

_foo:
    #stores a0 + a1 into v1
    add $v0, $a0, $a1   
    jr $ra


.data