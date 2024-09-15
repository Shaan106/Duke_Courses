# Assignment 2

Written portion seperate.

# Question 6

(40 points) We are going to use SimpleScalar in this assignment. The function sim main()
inside sim-safe.c, the file that you’re going to modify, is responsible to execute each
instruction in-order. We’re going to add more functionalities to the simulator. Note:
Please do all the following experiments with the three benchmarks in README.

## Part a

*(10 points - Base case) In this base case, consider a 3-wide, in-order superscalar processor which can execute a maximum of 3 instructions per cycle. Simply ignoring data dependencies and assuming no hazards of any kind, how many cycles does it take to run each benchmark? You need to create a cycle counter and increment the counter by one during each iteration in sim-safe.c.*
*(Hint: There is an easily extensible way to maintain a statistical count of events like is done for sim num insn in sim-safe.c.)*

using `cycle_counter_3widesuperscalar` as my counter variable.

__gcc:__
```shell
sim_num_insn              337341064 # total number of instructions executed
cycles_3widesuperscalar    112447022 # total number of insts executed in 3 wide superscalar
```

__anagram:__
```shell
sim_num_insn               25597522 # total number of instructions executed
cycles_3widesuperscalar      8532508 # total number of insts executed in 3 wide superscalar
```

__go:__
```shell
sim_num_insn              545811896 # total number of instructions executed
cycles_3widesuperscalar    181937300 # total number of insts executed in 3 wide superscalar
```

## Part b
*(10 points - Register data hazards) Now consider a processor that cannot execute read-after-write instructions in the same cycle. For example, if an instruction writes to register 2, then no subsequent instruction (in program order) that reads register 2 can execute in the same cycle (it must wait until the next cycle). How many cycles does it take to run each benchmark?*
*(Hint: One thing you have to do is to check for RAW data dependency for each lane and decide whether to stall.)*

I decided to create variables to keep track of the registers for each lane, in order to calculate and deal with dependencies.

```cpp
int src_reg1_lane1, src_reg2_lane1, dest_reg_lane1;
int src_reg1_lane2, src_reg2_lane2, dest_reg_lane2;
int src_reg1_lane3, src_reg2_lane3, dest_reg_lane3;
int stall_current_cycle = 0;
static counter_t ovr_stalls = 0;
static counter_t lane2_stalls = 0;
static counter_t lane3_stalls = 0;
```

and assigned them values as follows, within the main computation block:

```cpp
if (sim_num_insn % 3 == 0) {
        /* dependency checks, reset stall */
        stall_current_cycle = 0;
        /* lane 1*/
        src_reg1_lane1 = RA; // update current lane regs
        src_reg2_lane1 = RB;
        dest_reg_lane1 = RC;
      } else if (sim_num_insn % 3 == 1) {
        /* check for data hazards */
        if ((dest_reg_lane1 == RA || dest_reg_lane1 == RB)) {
          stall_current_cycle = 1;
        }
        if (stall_current_cycle == 0) {
          /* lane 2*/
          src_reg1_lane2 = RA; // update current lane regs
          src_reg2_lane2 = RB;
          dest_reg_lane2 = RC;
        } else {
          /* stall */
          lane2_stalls++;
        }
       
      } else if (sim_num_insn % 3 == 2) {
        /* check for data hazards */
        if ((dest_reg_lane1 == RA || dest_reg_lane1 == RB) || (dest_reg_lane2 == RA || dest_reg_lane2 == RB)) {
          stall_current_cycle = 1;
        }
        if (stall_current_cycle == 0) {
          /* lane 3*/
          src_reg1_lane3 = RA; // update current lane regs
          src_reg2_lane3 = RB;
          dest_reg_lane3 = RC;
        } else {
          /* stall */
          lane3_stalls++;
        }
      }
```
And then, we know that `cycles_3widesuperscalar` are the number of cycles taken by an ideal (hazardless) 3-wide superscalar processor. And, we can do `ovr_stalls = lane2_stalls + lane3_stalls` to get the total number of stalls. Then, to calculate the number of cycles taken by the processor with register data hazards, we can do 

$Total Cycles=Base Case Cycles+RAW Hazard Stalls$

which gives us the total number of cycles that the superscalar 3-wide processor takes to execute the given benchmark.

__gcc:__
```shell
sim: ** simulation statistics **
sim_num_insn              337341064 # total number of instructions executed
cycles_superscalar        112447022 # total number of insts executed in 3 wide superscalar, no hazards
ovr_stalls                 82374005 # total number of stalls due to RAW hazards
lane2_stalls               27709403 # total number of stalls in lane 2
lane3_stalls               54664603 # total number of stalls in lane 3
cycles_superscalar_RAW    194821027 # total number of cycles with RAW hazards
```

Therefore, total cycles taken by the processor with register data hazards is $194821027$.

__anagram:__
```shell
sim: ** simulation statistics **
sim_num_insn               25597522 # total number of instructions executed
cycles_superscalar          8532508 # total number of insts executed in 3 wide superscalar, no hazards
ovr_stalls                  5575843 # total number of stalls due to RAW hazards
lane2_stalls                1656131 # total number of stalls in lane 2
lane3_stalls                3919713 # total number of stalls in lane 3
cycles_superscalar_RAW     14108351 # total number of cycles with RAW hazards
```

Therefore, total cycles taken by the processor with register data hazards is $14108351$.

__go:__
```shell
sim: ** simulation statistics **
sim_num_insn              545811896 # total number of instructions executed
cycles_superscalar        181937300 # total number of insts executed in 3 wide superscalar, no hazards
ovr_stalls                106227226 # total number of stalls due to RAW hazards
lane2_stalls               30468499 # total number of stalls in lane 2
lane3_stalls               75758728 # total number of stalls in lane 3
cycles_superscalar_RAW    288164526 # total number of cycles with RAW hazards
```

Therefore, total cycles taken by the processor with register data hazards is $288164526$.

## Part c

*(10 points - Structural hazards) Based on the previous question, now further assume that the L1 data cache has only one port so that the processor can only execute at most one memory operation (load or store) per cycle. How many cycles does it take to run each benchmark?*
*(Hint: You need to keep track of the port to see if it’s currently in use.)*

Created new variables to keep track of the memory ports in use for each lane, and some counters for statistics:

```cpp
int mem_in_use_lane1, mem_in_use_lane2, mem_in_use_lane3;
static counter_t lane2_cache_stalls = 0;
static counter_t lane3_cache_stalls = 0;
static counter_t cycles_3widesuperscalar_mem = 0;
```

Updated overal stalls to include cache stalls:

```cpp
ovr_stalls = lane2_stalls + lane3_stalls + lane2_cache_stalls + lane3_cache_stalls;
```

Updated logic to check for memory port availability (only lane 3 shown here for brevity):

```cpp 
} else if (sim_num_insn % 3 == 2) {
    /* check for data hazards */
    if ((dest_reg_lane1 == RA || dest_reg_lane1 == RB) || (dest_reg_lane2 == RA || dest_reg_lane2 == RB)) {
        stall_current_cycle = 1;
    }
    /* reset */
    mem_in_use_lane3 = 0;
    /* lane 3*/
    
    // check if stalled due to RAW or if cache port is already in use.
    if (stall_current_cycle == 0 && !((mem_in_use_lane1 == 1 && (MD_OP_FLAGS(op) & F_MEM)) || (mem_in_use_lane2 == 1 && (MD_OP_FLAGS(op) & F_MEM)))) {
        src_reg1_lane3 = RA; // update current lane regs
        src_reg2_lane3 = RB;
        dest_reg_lane3 = RC;
        if (MD_OP_FLAGS(op) & F_MEM){
            mem_in_use_lane3 = 1;
        } else {
            mem_in_use_lane3 = 0;
        }
        } else if ((mem_in_use_lane1 == 1 && (MD_OP_FLAGS(op) & F_MEM)) || (mem_in_use_lane2 == 1 && (MD_OP_FLAGS(op) & F_MEM))) {
        /* stall */
            lane3_cache_stalls++;
        } else {
        /* stall */
            lane3_stalls++;
    }
}
```

Results:

__gcc:__
```shell
sim: ** simulation statistics **
sim_num_insn              337341064 # total number of instructions executed
cycles_superscalar        112447022 # total number of insts executed in 3 wide superscalar, no hazards
lane2_stalls_RAW           27044952 # total number of stalls in lane 2 due to RAW
lane3_stalls_RAW           50344187 # total number of stalls in lane 3 die to RAW
cycles_superscalar_RAW    189836160 # total number of cycles with RAW hazards
lane2_cache_stalls         18723385 # total number of stalls in lane 2 due to cache port full
lane3_cache_stalls         25082816 # total number of stalls in lane 3 due to cache port full
cycles_superscalar_mem    233642361 # total number of cycles with RAW and cache port full hazards
ovr_stalls                121195339 # total number of stalls due to RAW and mem port hazards
```

Therefore, total cycles taken by the processor with register data hazards and structural hazards is $233642361$.

__anagram:__
```shell
sim: ** simulation statistics **
sim_num_insn               25597522 # total number of instructions executed
cycles_superscalar          8532508 # total number of insts executed in 3 wide superscalar, no hazards
lane2_stalls_RAW            1653087 # total number of stalls in lane 2 due to RAW
lane3_stalls_RAW            3422996 # total number of stalls in lane 3 die to RAW
cycles_superscalar_RAW     13608590 # total number of cycles with RAW hazards
lane2_cache_stalls          1096617 # total number of stalls in lane 2 due to cache port full
lane3_cache_stalls          1746804 # total number of stalls in lane 3 due to cache port full
cycles_superscalar_mem     16452011 # total number of cycles with RAW and cache port full hazards
ovr_stalls                  7919503 # total number of stalls due to RAW and mem port hazards
mem_counter                 9033559 # total number of mem instructions executed
```

Therefore, total cycles taken by the processor with register data hazards and structural hazards is $16452011$.

__go:__
```shell
sim: ** simulation statistics **
sim_num_insn              545811896 # total number of instructions executed
cycles_superscalar        181937300 # total number of insts executed in 3 wide superscalar, no hazards
lane2_stalls_RAW           29727351 # total number of stalls in lane 2 due to RAW
lane3_stalls_RAW           66092941 # total number of stalls in lane 3 die to RAW
cycles_superscalar_RAW    277757591 # total number of cycles with RAW hazards
lane2_cache_stalls         24066502 # total number of stalls in lane 2 due to cache port full
lane3_cache_stalls         40826007 # total number of stalls in lane 3 due to cache port full
cycles_superscalar_mem    342650100 # total number of cycles with RAW and cache port full hazards
ovr_stalls                160712800 # total number of stalls due to RAW and mem port hazards
mem_counter               211690416 # total number of mem instructions executed
```

Therefore, total cycles taken by the processor with register data hazards and structural hazards is $342650100$.

## Part d

*(10 points - Control hazards) Based on the previous question, now further assume that the processor has a 10-stage pipeline. The result of a conditional branch (i.e., taken or not-taken) is computed in stage 8. The processor statically predicts all conditional branches as not-taken and continues fetching from the instruction after the branch (the fall-through instruction). If the branch is indeed not-taken, then there is no penalty. If the branch is taken, then all instructions after the branch are squashed and fetching resumes from the instruction immediately from the branch destination. With this new change, how many cycles does it take to run each benchmark?*
*(Hint: don’t overthink it - you do not have to actually implement a pipeline to get the answer. You just have to check if there’s a misprediction and add certain amount of penalty to the total cycles.)*

Branch at stage 8, no penalty if not taken. If taken, __7 cycles__ are wrong and need to be flushed. Therefore the penalty for a branch taken is 7 cycles.

now, need to keep track of how many branches were taken, do this by checking `if next PC == prev PC + standard inst length` just before the PC update and if not, increment a counter.

And then, to calculate the penalty, we can do `branches_taken * 7`.

```cpp
if ((regs.regs_NPC) != (regs.regs_PC + sizeof(md_inst_t))) {
    branches_taken++;
    branches_penalty = branches_penalty + 7;
}
```

We can then add this to the overall stalls, and also calculate the total cycles taken by the processor with all hazards.

Results:

__gcc:__
```shell
sim: ** simulation statistics **
sim_num_insn              337341064 # total number of instructions executed
cycles_superscalar        112447022 # total number of insts executed in 3 wide superscalar, no hazards
... # other stats
branches_taken             35037965 # total number of branches taken
branches_penalty          245265755 # total number of cycles due to branch penalty
cycles_superscalar_cond    478908116 # total number of cycles with RAW, cache port full, and branch penalty hazards
ovr_stalls                121195339 # total number of stalls due to RAW and mem port hazards
```

Therefore, total cycles taken by the processor with all hazards is $478908116$.

__anagram:__
```shell
sim: ** simulation statistics **
sim_num_insn               25597522 # total number of instructions executed
cycles_superscalar          8532508 # total number of insts executed in 3 wide superscalar, no hazards
... # other stats
branches_taken              2597149 # total number of branches taken
branches_penalty           18180043 # total number of cycles due to branch penalty
cycles_superscalar_cond     34632054 # total number of cycles with RAW, cache port full, and branch penalty hazards
ovr_stalls                  7919503 # total number of stalls due to RAW and mem port hazards
```

Therefore, total cycles taken by the processor with all hazards is $34632054$.

__go:__
```shell
sim: ** simulation statistics **
sim_num_insn              545811896 # total number of instructions executed
cycles_superscalar        181937300 # total number of insts executed in 3 wide superscalar, no hazards
... # other stats
branches_taken             45953415 # total number of branches taken
branches_penalty          321673905 # total number of cycles due to branch penalty
cycles_superscalar_cond    664324005 # total number of cycles with RAW, cache port full, and branch penalty hazards
ovr_stalls                160712800 # total number of stalls due to RAW and mem port hazards
```

Therefore, total cycles taken by the processor with all hazards is $664324005$.