

.text
.align 2


main:
    li $t0, 1 # int i = 1

_loop:
    
    slti $t2, $t0, 11 # if t0 < 11 then t2 = true = 1 else t2 = false = 0
    beqz $t2, _endloop # if $t2 is 0 then fo to endloop


_endloop:

#LOOK AT VIDEO ON RECITATION DOCUMENT TO FINISH CODE.

jr $ra


.data

nln: .asciiz "\n"
