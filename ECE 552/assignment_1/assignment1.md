# Assignment 1

Written portion seperate.

## Question 7

### Part a

__gcc:__

Input command: `./sim-safe cc1.alpha -O 1stmt.i`

Output:
```shell
sim: ** simulation statistics **
sim_num_insn              337341064 # total number of instructions executed
sim_num_refs              121898424 # total number of loads and stores executed
sim_elapsed_time                  8 # total simulation time in seconds
sim_inst_rate          42167633.0000 # simulation speed (in insts/sec)
ld_text_base           0x0120000000 # program text (code) segment base
ld_text_size                1564672 # program text (code) size in bytes
ld_data_base           0x0140000000 # program initialized data segment base
ld_data_size                 277104 # program init'ed `.data' and uninit'ed `.bss' size in bytes
ld_stack_base          0x011ff9b000 # program stack segment base (highest address in stack)
ld_stack_size                 16384 # program initial stack size
ld_prog_entry          0x0120025f70 # program entry point (initial PC)
ld_environ_base        0x011ff97000 # program environment base address address
ld_target_big_endian              0 # target executable endian-ness, non-zero if big endian
mem.page_count                  656 # total number of pages allocated
mem.page_mem                  5248k # total size of memory pages allocated
mem.ptab_misses              869237 # total first level page table misses
mem.ptab_accesses         922384930 # total page table accesses
mem.ptab_miss_rate           0.0009 # first level page table miss rate
```

__anagram:__

Input command: `./sim-safe anagram.alpha words < anagram.in > OUT`

Output:
```shell
sim: ** simulation statistics **
sim_num_insn               25597522 # total number of instructions executed
sim_num_refs                9033559 # total number of loads and stores executed
sim_elapsed_time                  1 # total simulation time in seconds
sim_inst_rate          25597522.0000 # simulation speed (in insts/sec)
ld_text_base           0x0120000000 # program text (code) segment base
ld_text_size                 106496 # program text (code) size in bytes
ld_data_base           0x0140000000 # program initialized data segment base
ld_data_size                  71264 # program init'ed `.data' and uninit'ed `.bss' size in bytes
ld_stack_base          0x011ff9b000 # program stack segment base (highest address in stack)
ld_stack_size                 16384 # program initial stack size
ld_prog_entry          0x01200059c0 # program entry point (initial PC)
ld_environ_base        0x011ff97000 # program environment base address address
ld_target_big_endian              0 # target executable endian-ness, non-zero if big endian
mem.page_count                   55 # total number of pages allocated
mem.page_mem                   440k # total size of memory pages allocated
mem.ptab_misses              454175 # total first level page table misses
mem.ptab_accesses          69957391 # total page table accesses
mem.ptab_miss_rate           0.0065 # first level page table miss rate
```

__go:__

Input command: `./sim-safe go.alpha 50 9 2stone9.in > OUT`

Output:
```shell
sim: ** simulation statistics **
sim_num_insn              545811896 # total number of instructions executed
sim_num_refs              211690416 # total number of loads and stores executed
sim_elapsed_time                 12 # total simulation time in seconds
sim_inst_rate          45484324.6667 # simulation speed (in insts/sec)
ld_text_base           0x0120000000 # program text (code) segment base
ld_text_size                 376832 # program text (code) size in bytes
ld_data_base           0x0140000000 # program initialized data segment base
ld_data_size                 612032 # program init'ed `.data' and uninit'ed `.bss' size in bytes
ld_stack_base          0x011ff9b000 # program stack segment base (highest address in stack)
ld_stack_size                 16384 # program initial stack size
ld_prog_entry          0x0120007bb0 # program entry point (initial PC)
ld_environ_base        0x011ff97000 # program environment base address address
ld_target_big_endian              0 # target executable endian-ness, non-zero if big endian
mem.page_count                  120 # total number of pages allocated
mem.page_mem                   960k # total size of memory pages allocated
mem.ptab_misses             1656385 # total first level page table misses
mem.ptab_accesses        1515993092 # total page table accesses
mem.ptab_miss_rate           0.0011 # first level page table miss rate
```
### Part b

In the silicon space you are allocated, you can ask the physical designers to
change the layout for a speedup of 5 for both integer and floating point computations
at the cost of slowing down memory accesses by 20%, or a speedup of 10 for the
memory accesses at the cost of slowing down integer and floating point computations
by 10%. Find the overall speedup for both redesigns for gcc, go, and anagram. Based
on these results, would you ask the physical designers to dedicate more resources to
speeding up integer and floating point computations, memory accesses, or keep the
chip as is?

Case A: x5 for int and fp, x0.8 for mem accesses.
or
Case B: x10 for mem accesses, x0.9 for int and fp.

Amdahl's law: $Speedup = \frac{1}{(1 - f) + \frac{f}{s}}$, where $f$ is the fraction of the program that can be sped up and $s$ is the speedup factor.

$T_{new} = T_{old}*(1-f_{int, fp}-f_{mem} + \frac{f_{int, fp}}{s_{int, fp}} + \frac{f_{mem}}{s_{mem}})$ 

$\therefore Speedup = \frac{T_{old}}{T_{new}} = \frac{1}{(1-f_{int, fp}-f_{mem} + \frac{f_{int, fp}}{s_{int, fp}} + \frac{f_{mem}}{s_{mem}})}$

sim-safe.c updated to include int, fp and mem accesses counts.

__gcc:__
```shell
sim: ** simulation statistics **
sim_num_insn              337341064 # total number of instructions executed
int_counter               156184423 # total number of int instructions executed
fp_counter                   374706 # total number of fp instructions executed
mem_counter               121898424 # total number of mem instructions executed
```

Total instructions executed: $337341064$

fraction of int and fp: $\frac{156184423 + 374706}{337341064} = \frac{156559129}{337341064} = 0.464$

fraction of mem: $\frac{121898424}{337341064} = 0.361$

_Case A_:

$s_{int, fp} = 5, s_{mem} = 0.8$

$\therefore Speedup_{case A} = \frac{1}{1-0.464-0.361 + \frac{0.464}{5} + \frac{0.361}{0.8}} = 1.391$

_Case B_:

$s_{int, fp} = 0.9, s_{mem} = 10$

$\therefore Speedup_{case B} = \frac{1}{1-0.464-0.361 + \frac{0.464}{0.9} + \frac{0.361}{10}} = 1.376$

__anagram:__
```shell
sim: ** simulation statistics **
sim_num_insn               25597522 # total number of instructions executed
int_counter                11423177 # total number of int instructions executed
fp_counter                  1360117 # total number of fp instructions executed
mem_counter                 9033559 # total number of mem instructions executed
```

Total instructions executed: $25597522$

fraction of int and fp: $\frac{11423177 + 1360117}{25597522} = \frac{12783294}{25597522} = 0.499$

fraction of mem: $\frac{9033559}{25597522} = 0.353$

_Case A_:

$s_{int, fp} = 5, s_{mem} = 0.8$

$\therefore Speedup_{case A} = \frac{1}{1-0.499-0.353 + \frac{0.499}{5} + \frac{0.353}{0.8}} = 1.451$

_Case B_:

$s_{int, fp} = 0.9, s_{mem} = 10$

$\therefore Speedup_{case B} = \frac{1}{1-0.499-0.353 + \frac{0.499}{0.9} + \frac{0.353}{10}} = 1.355$


__go:__
```shell
sim: ** simulation statistics **
sim_num_insn              545811896 # total number of instructions executed
int_counter               260042127 # total number of int instructions executed
fp_counter                   174876 # total number of fp instructions executed
mem_counter               211690416 # total number of mem instructions executed
```

Total instructions executed: $545811896$

fraction of int and fp: $\frac{260042127 + 174876}{545811896} = \frac{260217003}{545811896} = 0.477$

fraction of mem: $\frac{211690416}{545811896} = 0.388$

_Case A_:

$s_{int, fp} = 5, s_{mem} = 0.8$

$\therefore Speedup_{case A} = \frac{1}{1-0.477-0.388 + \frac{0.477}{5} + \frac{0.388}{0.8}} = 1.398$

_Case B_:

$s_{int, fp} = 0.9, s_{mem} = 10$

$\therefore Speedup_{case B} = \frac{1}{1-0.477-0.388 + \frac{0.477}{0.9} + \frac{0.388}{10}} = 1.421$


_Conclusion:_

Both cases show that there is a speedup in the overall performance of the system by around 40%. Therefore, it is definitely worth asking the physical designers to dedicate more resources to speeding up integer and floating point computations.

There is no clear winner between Case A ($s_{int, fp} = 5, s_{mem} = 0.8$) and Case B ($s_{int, fp} = 0.9, s_{mem} = 10$) as the speedup is almost the same for all the programs. If one had to be chosen, I would choose Case A as it has a better speedup for `anagram` and `gcc` whereas Case B has a better speedup for `go`. Therefore, I would ask the physical designers to dedicate more resources to speeding up integer and floating point computations.