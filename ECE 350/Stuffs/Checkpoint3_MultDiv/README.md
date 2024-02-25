# MultDiv
## Name

## Description of Design

This is going to be long.

## Counter

My story begins with the counter. It counts. It uses a collection of 5 T-flip flops arranged as shown in lecture. The first one is wired to 1, and the reset are toggled by an and gate with the outputs of all the previous T-flip flops. If I take the output from each TFF and put them together as one number - this leads to a binary counter that can count from 0 to 63.

## Divider - also known as divider_called_bob

This is a divider that can divide two 32 bit integers in 33 clock cycles. General overview is to use the divison algorithm shown in lecture. Negate numbers and compute as if both numbers are positive and fix at the end to correct for positive/negative. Run 33 cycles of the optimised divide algorithm where you shift, check if MSB is 1 then take away or reset the remainder and set the last bit to 1 if MSB = 0 or 0 if MSB = 1. I also made the remainder work because why not, it may be useful in the future.

## MultDiv

basic controls for choosing when to return what. Slight issue at first because didn't realise that crtls were impulses. Then stored the choice in d flip flpo, and used that to choose whether to return the multiplied value or the divided value.

## mux_2_64

2 input mux for 64 bit numbers.

## single_reg_64

single reg file that can hold 64 bits. Used to hold my final output from my divider so that I can output it for more than 1 clock cycle and it's all nice and not an instant spike with wierd timings.

## T_flip_flop

My implementation of one whole T_flip_flop. Used for my counters.

## Wallace Tree Multiplier

Sadly I did not know that I was actually making an RCA multiplier not a wallace tree multiplier. So I made an RCA multiplier. At first I made it work for positive numbers, then implemented a two's complement version of the RCA multiplier. I made a python script to generate this (wallaceTreeComplement.py). It's basically a lot of combinational logic (I did this by defining what each block in general would look like - which is shown in the images RCA-1.png and RCA-2.png)
