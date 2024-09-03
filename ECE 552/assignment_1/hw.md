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

