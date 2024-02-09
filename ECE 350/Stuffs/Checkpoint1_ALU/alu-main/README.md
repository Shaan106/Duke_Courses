# ALU
## Name

## Description of Design

## Adder:

This adds two numbers. Used a Carry Lookahead Adder design that was specified by Professor Board in lectures. All gates used have less than 8 inputs and there are two levels (8-bit adder levels, and another level that generates c8, c16, c24, c32 bits).

## Subtractor:

This is just the adder except the second input (operand B) has all of its bits flipped, and the carry in for the adder is set to one. This ends up performing subtraction using two's compliment arithmetic.

## AND:

This performs a bitwise and on two 32 bit operands and returns the 32 bit value

## OR:

This performs a bitwise or on two 32 bit operands and returns the 32 bit value

## SLL

This performs a logical left shift on the input data by shamt amount. This is done by having stages of 16, 8, 4, 2 and 1 shifts and using the bits of shamt to combine those amounts of shift and apply it. 

## SRA

This performs a right arithmetic shift on the input data by shamt amount. This is done by having stages of 16, 8, 4, 2 and 1 shifts and using the bits of shamt to combine those amounts of shift and apply it. Furthermore the MSB is preserved in this shift (due to it being arithmetic)

## Bugs
no bugs!!!

Bug for reference - 

                .' '.            __
       .        .   .           (__\_
        .         .         . -{{_(|8)
          ' .  . ' ' .  . '     (__/