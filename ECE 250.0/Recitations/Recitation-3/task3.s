

.text
.align 2


main:
    li $t0, 0 #number to print
    li $t1, 11 # threshold

_while_loop:
    li $v0, 1 # tells syscall to print val in $a0
    #look at this https://courses.missouristate.edu/kenvollmar/mars/help/syscallhelp.html

    move $a0, $t0 # copy t0 to $a0, line 12 said that $a0 is to be printed by syscall
    
    syscall

    li $v0, 4 #instructs syscall to print string
    la $a0, nln #loads the address of the new line string defined at the end of the code
    syscall

    addi $t0, $t0, 1 #increment t0 = t0 + 1

    blt $t0, $t1, _while_loop # if val in $t0 is less than val in $t1 branch to _while_loop.

jr $ra


.data

nln: .asciiz "\n"
