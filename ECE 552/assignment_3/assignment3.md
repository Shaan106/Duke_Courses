# Assignment 3

Written portion seperate.

# Question 8

*(20 points) Simplescalar Dynamic Scheduling Simulations: Start with the sim-outorder simulator and just use gcc and go benchmarks. You will NOT have to modify the sim-outorder.c code for this assignment (and thus you don’t need to turn in any code), but you will have to provide it with different command line parameters to configure it. If you run sim-outorder without any input parameters, it will print out all of the possible parameters,which should help you to figure out how to specify the configurations in the following experiments. Remember that running ‘./sim-outorder -h’ can help you to find different flags and options for running the simulator. Make sure to put screenshots of simulation outputs and the commands you used to run the code in your final report.*

## (a) Experiment 1

*Experiment 1: Compare in-order versus out of-order execution (hint: the default is out-of-order, and there’s a flag that can change this). Don’t change any other flags. What do you observe? For the rest of the experiments, assume an out-of-order core. Use the default parameter values for any parameters not discussed in the question.*

### Running experiment

__gcc__:

Command: 
```sh
./sim-outorder -issue:inorder true -d cc1.alpha -O 1stmt.i > _gcc_stats.txt #in order
./sim-outorder -d cc1.alpha -O 1stmt.i > _gcc_stats.txt #out of order
```

In order output:
```sh
sim: ** simulation statistics **
sim_num_insn              337341064 # total number of instructions committed
sim_num_refs              121898424 # total number of loads and stores committed
sim_num_loads              83205310 # total number of loads committed
sim_num_stores         38693114.0000 # total number of stores committed
sim_num_branches           58872871 # total number of branches committed
sim_elapsed_time                114 # total simulation time in seconds
sim_inst_rate          2959132.1404 # simulation speed (in insts/sec)
sim_total_insn            347743510 # total number of instructions executed
sim_total_refs            126510967 # total number of loads and stores executed
sim_total_loads            87507761 # total number of loads executed
sim_total_stores       39003206.0000 # total number of stores executed
sim_total_branches         60429337 # total number of branches executed
sim_cycle                 477508790 # total simulation time in cycles
sim_IPC                      0.7065 # instructions per cycle
sim_CPI                      1.4155 # cycles per instruction
sim_exec_BW                  0.7282 # total instructions (mis-spec + committed) per cycle
sim_IPB                      5.7300 # instruction per branch
IFQ_count                1524098678 # cumulative IFQ occupancy
# more outputs...
```

Out of order output:
```sh
sim: ** simulation statistics **
sim_num_insn              337341064 # total number of instructions committed
sim_num_refs              121898424 # total number of loads and stores committed
sim_num_loads              83205310 # total number of loads committed
sim_num_stores         38693114.0000 # total number of stores committed
sim_num_branches           58872871 # total number of branches committed
sim_elapsed_time                122 # total simulation time in seconds
sim_inst_rate          2765090.6885 # simulation speed (in insts/sec)
sim_total_insn            395863147 # total number of instructions executed
sim_total_refs            143438962 # total number of loads and stores executed
sim_total_loads           100705775 # total number of loads executed
sim_total_stores       42733187.0000 # total number of stores executed
sim_total_branches         68754231 # total number of branches executed
sim_cycle                 273297198 # total simulation time in cycles
sim_IPC                      1.2343 # instructions per cycle
sim_CPI                      0.8102 # cycles per instruction
sim_exec_BW                  1.4485 # total instructions (mis-spec + committed) per cycle
sim_IPB                      5.7300 # instruction per branch
IFQ_count                 621660469 # cumulative IFQ occupancy
#more outputs...
```

__go__:

Command:
```sh
./sim-outorder -issue:inorder true go.alpha 50 9 2stone9.in > _go_stats.txt # in order
./sim-outorder go.alpha 50 9 2stone9.in > _go_stats.txt #out of order
```

In order output:
```sh
sim: ** simulation statistics **
sim_num_insn              545811896 # total number of instructions committed
sim_num_refs              211690416 # total number of loads and stores committed
sim_num_loads             167116095 # total number of loads committed
sim_num_stores         44574321.0000 # total number of stores committed
sim_num_branches           73904290 # total number of branches committed
sim_elapsed_time                180 # total simulation time in seconds
sim_inst_rate          3032288.3111 # simulation speed (in insts/sec)
sim_total_insn            573332832 # total number of instructions executed
sim_total_refs            222858191 # total number of loads and stores executed
sim_total_loads           177848856 # total number of loads executed
sim_total_stores       45009335.0000 # total number of stores executed
sim_total_branches         77088167 # total number of branches executed
sim_cycle                 725585824 # total simulation time in cycles
sim_IPC                      0.7522 # instructions per cycle
sim_CPI                      1.3294 # cycles per instruction
sim_exec_BW                  0.7902 # total instructions (mis-spec + committed) per cycle
sim_IPB                      7.3854 # instruction per branch
IFQ_count                2396294042 # cumulative IFQ occupancy
```

Out of order output:
```sh
sim: ** simulation statistics **
sim_num_insn              545811896 # total number of instructions committed
sim_num_refs              211690416 # total number of loads and stores committed
sim_num_loads             167116095 # total number of loads committed
sim_num_stores         44574321.0000 # total number of stores committed
sim_num_branches           73904290 # total number of branches committed
sim_elapsed_time                219 # total simulation time in seconds
sim_inst_rate          2492291.7626 # simulation speed (in insts/sec)
sim_total_insn            696342016 # total number of instructions executed
sim_total_refs            270205964 # total number of loads and stores executed
sim_total_loads           216505550 # total number of loads executed
sim_total_stores       53700414.0000 # total number of stores executed
sim_total_branches         92006964 # total number of branches executed
sim_cycle                 413102901 # total simulation time in cycles
sim_IPC                      1.3212 # instructions per cycle
sim_CPI                      0.7569 # cycles per instruction
sim_exec_BW                  1.6856 # total instructions (mis-spec + committed) per cycle
sim_IPB                      7.3854 # instruction per branch
IFQ_count                1025177076 # cumulative IFQ occupancy
```

### Analysis

Out-of-order execution is significantly faster than in order execution. This can be seen clearly through a few statistics, and encapsulated well by the `IPC` (number of instructions throughput per cycle).

GCC num instructions: `337341064`
In order IPC: `0.7065`
Out of order IPC: `1.2343`

Go num instructions: `545811896`
In order IPC: `0.7522`
Out of order IPC: `1.3212`

As can be seen, the IPC for out of order execution is significantly higher than in order execution in both benchmarks. This essentially means there are more instructions being executed by the out of order core in the same number of cycles as the in order core. This is a clear indication that out of order execution is faster than in order execution.

## (b) Experiment 2
*Experiment 2: In SimpleScalar, Reservation Stations (RS) and the Re-Order Buffer (ROB) are combined into a Register Update Unit (RUU). The size of the RUU can be thought of as the number of instructions that the ROB can hold. Evaluate the importance of the RUU size by comparing a size of 16 vs. a size of 32 vs. a size of 64. As with all experiments here, don’t change anything else. Explain your results- that is, why did the changes in RUU size have a small/big impact?*

### Running experiment

__gcc__:

Relevant flag: `-ruu:size # register update unit (RUU) size`

Command:
```sh
./sim-outorder -ruu:size 16 -d cc1.alpha -O 1stmt.i > _gcc_stats.txt # RUU size 16
./sim-outorder -ruu:size 32 -d cc1.alpha -O 1stmt.i > _gcc_stats.txt # RUU size 32
./sim-outorder -ruu:size 64 -d cc1.alpha -O 1stmt.i > _gcc_stats.txt # RUU size 64
```

Outputs (only showing relevant statistics):

RUU size 16:
```sh
sim: ** simulation statistics **
sim_num_insn              337341064 # total number of instructions committed
sim_IPC                      1.2343 # instructions per cycle
sim_exec_BW                  1.4485 # total instructions (mis-spec + committed) per cycle
RUU_count                2301021651 # cumulative RUU occupancy
RUU_fcount                 66041848 # cumulative RUU full count
ruu_occupancy                8.4195 # avg RUU occupancy (insn's)
ruu_rate                     1.4485 # avg RUU dispatch rate (insn/cycle)
ruu_latency                  5.8127 # avg RUU occupant latency (cycle's)
ruu_full                     0.2416 # fraction of time (cycle's) RUU was full
```

RUU size 32:
```sh
sim: ** simulation statistics **
sim_num_insn              337341064 # total number of instructions committed
sim_IPC                      1.2583 # instructions per cycle
sim_exec_BW                  1.5526 # total instructions (mis-spec + committed) per cycle
RUU_count                2663531771 # cumulative RUU occupancy
RUU_fcount                  5862910 # cumulative RUU full count
ruu_occupancy                9.9351 # avg RUU occupancy (insn's)
ruu_rate                     1.5526 # avg RUU dispatch rate (insn/cycle)
ruu_latency                  6.3989 # avg RUU occupant latency (cycle's)
ruu_full                     0.0219 # fraction of time (cycle's) RUU was full
```

RUU size 64:
```sh
sim: ** simulation statistics **
sim_num_insn              337341064 # total number of instructions committed
sim_IPC                      1.2589 # instructions per cycle
sim_exec_BW                  1.5600 # total instructions (mis-spec + committed) per cycle
RUU_count                2705993289 # cumulative RUU occupancy
RUU_fcount                   310215 # cumulative RUU full count
ruu_occupancy               10.0984 # avg RUU occupancy (insn's)
ruu_rate                     1.5600 # avg RUU dispatch rate (insn/cycle)
ruu_latency                  6.4735 # avg RUU occupant latency (cycle's)
ruu_full                     0.0012 # fraction of time (cycle's) RUU was full
```

__go__:

Command:
```sh
./sim-outorder -ruu:size 16 go.alpha 50 9 2stone9.in > _go_stats.txt # RUU size 16
./sim-outorder -ruu:size 32 go.alpha 50 9 2stone9.in > _go_stats.txt # RUU size 32
./sim-outorder -ruu:size 64 go.alpha 50 9 2stone9.in > _go_stats.txt # RUU size 64
```

Outputs (only showing relevant statistics):

RUU size 16:
```sh
sim: ** simulation statistics **
sim_num_insn              545811896 # total number of instructions committed
sim_IPC                      1.3212 # instructions per cycle
sim_exec_BW                  1.6856 # total instructions (mis-spec + committed) per cycle
RUU_count                3688144369 # cumulative RUU occupancy
RUU_fcount                111885254 # cumulative RUU full count
ruu_occupancy                8.9279 # avg RUU occupancy (insn's)
ruu_rate                     1.6856 # avg RUU dispatch rate (insn/cycle)
ruu_latency                  5.2965 # avg RUU occupant latency (cycle's)
ruu_full                     0.2708 # fraction of time (cycle's) RUU was full
```

RUU size 32:
```sh
sim: ** simulation statistics **
sim_num_insn              545811896 # total number of instructions committed
sim_IPC                      1.3371 # instructions per cycle
sim_exec_BW                  1.8228 # total instructions (mis-spec + committed) per cycle
RUU_count                4153446048 # cumulative RUU occupancy
RUU_fcount                  1494037 # cumulative RUU full count
ruu_occupancy               10.1748 # avg RUU occupancy (insn's)
ruu_rate                     1.8228 # avg RUU dispatch rate (insn/cycle)
ruu_latency                  5.5820 # avg RUU occupant latency (cycle's)
ruu_full                     0.0037 # fraction of time (cycle's) RUU was full
```

RUU size 64:
```sh
sim: ** simulation statistics **
sim_num_insn              545811896 # total number of instructions committed
sim_IPC                      1.3372 # instructions per cycle
sim_exec_BW                  1.8251 # total instructions (mis-spec + committed) per cycle
RUU_count                4158910985 # cumulative RUU occupancy
RUU_fcount                     5354 # cumulative RUU full count
ruu_occupancy               10.1893 # avg RUU occupancy (insn's)
ruu_rate                     1.8251 # avg RUU dispatch rate (insn/cycle)
ruu_latency                  5.5830 # avg RUU occupant latency (cycle's)
ruu_full                     0.0000 # fraction of time (cycle's) RUU was full
```


### Analysis

RUU size from 16 to 32 leads to a noticeable improvement in performance metrics, showing that increasing the RUU size allows the processor to handle more instructions concurrently, enhancing IPC and reducing CPI. However, from RUU size 32 to 64 there are diminishing returns. Further increases in RUU size yield additional, but smaller, performance gains. This shows the effectiveness of larger RUUs in keeping high instruction throughput but also demonstrates a point of diminishing returns.

### **Expanded Analysis with Concrete Evidence from gcc and go Benchmarks**

Increasing the RUU size from 16 to 32 in the sim-outorder simulator results in a noticeable improvement in performance metrics for both the gcc and go benchmarks. For the gcc benchmark, the Instructions Per Cycle (IPC) increases from 1.2343 to 1.2583, and the Cycles Per Instruction (CPI) decreases from 0.8102 to 0.7947. Similarly, in the go benchmark, IPC rises from 1.3212 to 1.3371, while the execution bandwidth (sim_exec_BW) improves from 1.6856 to 1.8228 instructions per cycle. Additionally, the RUU full fraction drops significantly from 0.2416 to 0.0219 for gcc and from 0.2708 to 0.0037 for go, indicating that larger RUU sizes effectively reduce stalls caused by RUU saturation. This enhancement allows the processor to handle more instructions concurrently, thereby exploiting greater instruction-level parallelism and improving overall efficiency.

However, expanding the RUU size from 32 to 64 yields only marginal gains for both benchmarks. For gcc, IPC slightly increases from 1.2583 to 1.2589, and CPI marginally decreases from 0.7947 to 0.7943. In the go benchmark, IPC remains almost unchanged at 1.3372, and the execution bandwidth sees a negligible rise from 1.8228 to 1.8251 instructions per cycle. The RUU full fraction further decreases to 0.0012 for gcc and virtually 0.0000 for go, but these changes have little impact on the already optimized performance metrics. This indicates that while increasing the RUU size from 16 to 32 substantially enhances performance by allowing more instructions to be processed in parallel, further enlarging the RUU to 64 offers diminishing returns. The initial expansion significantly mitigates stalls and improves parallelism, but beyond a certain point, the benefits plateau as the processor already effectively utilizes the available instruction-level parallelism at an RUU size of 32.

## (c) Experiment 3
*Experiment 3: Evaluate the importance of superscalar width by comparing a 2-wide, a 4-wide, and an 8-wide processor. Remember that you want to balance the widths of decode, issue, execute, and commit (i.e., the pipeline should be 2-wide, 4-wide, or 8-wide at all stages). Is the performance benefit of going from 2-wide to 4-wide worth the hardware and power costs? From 4-wide to 8-wide? Explain why or why not.*

### Running experiment

For this question, I am assuming there are no additional functional units added to the processor. The only change is the width of the pipeline stages.

Relevant flags:
```
-decode:width	#Set instruction decode width (2, 4, 8)
-issue:width	#Set instruction issue width (2, 4, 8)
-commit:width	#Set instruction commit width (2, 4, 8)
```

__gcc__:

Command:
```sh
./sim-outorder -decode:width 2 -issue:width 2 -commit:width 2 -d cc1.alpha -O 1stmt.i > _gcc_stats.txt # 2-wide
./sim-outorder -decode:width 4 -issue:width 4 -commit:width 4 -d cc1.alpha -O 1stmt.i > _gcc_stats.txt # 4-wide
./sim-outorder -decode:width 8 -issue:width 8 -commit:width 8 -d cc1.alpha -O 1stmt.i > _gcc_stats.txt # 8-wide
```

Outputs (only showing relevant statistics):

2-wide:
```sh
sim: ** simulation statistics **
sim_num_insn              337341064 # total number of instructions committed
sim_cycle                 349867311 # total simulation time in cycles
sim_IPC                      0.9642 # instructions per cycle
sim_CPI                      1.0371 # cycles per instruction
sim_exec_BW                  1.1183 # total instructions (mis-spec + committed) per cycle
```

4-wide:
```sh
sim: ** simulation statistics **
sim_num_insn              337341064 # total number of instructions committed
sim_cycle                 273297198 # total simulation time in cycles
sim_IPC                      1.2343 # instructions per cycle
sim_CPI                      0.8102 # cycles per instruction
sim_exec_BW                  1.4485 # total instructions (mis-spec + committed) per cycle
```

8-wide:
```sh
sim: ** simulation statistics **
sim_num_insn              337341064 # total number of instructions committed
sim_cycle                 269363670 # total simulation time in cycles
sim_IPC                      1.2524 # instructions per cycle
sim_CPI                      0.7985 # cycles per instruction
sim_exec_BW                  1.4670 # total instructions (mis-spec + committed) per cycle
```

__go__:

Command:
```sh
./sim-outorder -decode:width 2 -issue:width 2 -commit:width 2 go.alpha 50 9 2stone9.in > _go_stats.txt # 2-wide
./sim-outorder -decode:width 4 -issue:width 4 -commit:width 4 go.alpha 50 9 2stone9.in > _go_stats.txt # 4-wide
./sim-outorder -decode:width 8 -issue:width 8 -commit:width 8 go.alpha 50 9 2stone9.in > _go_stats.txt # 8-wide
```

Outputs (only showing relevant statistics):

2-wide:
```sh
sim: ** simulation statistics **
sim_num_insn              545811896 # total number of instructions committed
sim_cycle                 540963327 # total simulation time in cycles
sim_IPC                      1.0090 # instructions per cycle
sim_CPI                      0.9911 # cycles per instruction
sim_exec_BW                  1.2497 # total instructions (mis-spec + committed) per cycle
```

4-wide:
```sh
sim: ** simulation statistics **
sim_num_insn              545811896 # total number of instructions committed
sim_cycle                 413102901 # total simulation time in cycles
sim_IPC                      1.3212 # instructions per cycle
sim_CPI                      0.7569 # cycles per instruction
sim_exec_BW                  1.6856 # total instructions (mis-spec + committed) per cycle
```

8-wide:
```sh
sim: ** simulation statistics **
sim_num_insn              545811896 # total number of instructions committed
sim_cycle                 407791992 # total simulation time in cycles
sim_IPC                      1.3385 # instructions per cycle
sim_CPI                      0.7471 # cycles per instruction
sim_exec_BW                  1.7020 # total instructions (mis-spec + committed) per cycle
```

### Analysis

Increasing the superscalar width from 2-wide to 4-wide in the sim-outorder simulator shows clear performance gains for both the gcc and go benchmarks. For gcc, the Instructions Per Cycle (IPC) jumps from 0.9642 to 1.2343, and the Cycles Per Instruction (CPI) drops from 1.0371 to 0.8102. Similarly, the go benchmark sees IPC rise from 1.0090 to 1.3212 and CPI decrease from 0.9911 to 0.7569. The execution bandwidth also improves significantly, indicating that the processor can handle more instructions each cycle. These improvements suggest that a 4-wide pipeline effectively takes advantage of increased instruction-level parallelism, making the extra hardware and power costs worthwhile.

However, expanding the width further to 8-wide results in only minor performance enhancements. For gcc, IPC increases slightly to 1.2524 and CPI decreases marginally to 0.7985. In the go benchmark, IPC goes up to 1.3385 and CPI drops to 0.7471, with execution bandwidth showing little additional improvement. These small gains indicate that the processor is reaching its limit in terms of exploiting parallelism efficiently. The increased complexity and power consumption needed for an 8-wide pipeline don't provide enough performance benefit to justify the costs, making the 4-wide configuration the more balanced and efficient choice.

# Question 9

*(20 points) Gem5 Setup: In your AWS linux machine, run build Gem5 using the provided setup script gem5_setup.sh. In this directory, copy the provided gem5_simple.py script. This file creates a barebones system and executes ’hello’, a simple Hello World application. We are now going to repeat the previous experiments with the setup Gem5 simulator. You can view the simulation statistics in m5out/stats.txt.*

## (a) Experiment 1

*Experiment 1: Compare in-order versus out-of-order execution. Execute the command build/X86/gem5.opt gem5_simple.py to get the in-order execution time. Now in the file, change the CPU type to an out-of-order processor - X86O3CPU(). Simulate it again to get the out-of-order execution time. Make sure to put screen- shots of simulation outputs and the commands you used to run the code in your final report.*

Running the simulator:
```sh
./build/X86/gem5.opt _ECE552/hw3/gem5_simple.py 
```

# in order execution

In the Python script:
```python
system.cpu = X86TimingSimpleCPU()
```

Terminal output:
```sh
(base) shaan@shaan-mega-computer:~/Desktop/AdvCompArch/gem5$ ./build/X86/gem5.opt _ECE552/hw3/gem5_simple.py 
gem5 Simulator System.  https://www.gem5.org
gem5 is copyrighted software; use the --copyright option for details.

gem5 version 24.0.0.1
gem5 compiled Sep 28 2024 20:13:05
gem5 started Sep 28 2024 20:21:12
gem5 executing on shaan-mega-computer, pid 337594
command line: ./build/X86/gem5.opt _ECE552/hw3/gem5_simple.py

Global frequency set at 1000000000000 ticks per second
warn: No dot file generated. Please install pydot to generate the dot file and pdf.
src/mem/dram_interface.cc:690: warn: DRAM device capacity (8192 Mbytes) does not match the address range assigned (512 Mbytes)
src/base/statistics.hh:279: warn: One of the stats is a legacy stat. Legacy stat is a stat that does not belong to any statistics::Group. Legacy stat is deprecated.
system.remote_gdb: Listening for connections on port 7000
Beginning simulation!
src/sim/simulate.cc:199: info: Entering event queue @ 0.  Starting simulation...
Hello world!
Exiting @ tick 495867000 because exiting with last active thread context
```

Simulation time (from m5out/stats.txt):
```sh
simSeconds       0.000496        # Number of seconds simulated (Second)
```

# out of order execution

In the Python script:
```python
system.cpu = X86O3CPU()
```

Terminal output:
```sh
(base) shaan@shaan-mega-computer:~/Desktop/AdvCompArch/gem5$ ./build/X86/gem5.opt _ECE552/hw3/gem5_simple.py 
gem5 Simulator System.  https://www.gem5.org
gem5 is copyrighted software; use the --copyright option for details.

gem5 version 24.0.0.1
gem5 compiled Sep 28 2024 20:13:05
gem5 started Sep 28 2024 20:25:37
gem5 executing on shaan-mega-computer, pid 344432
command line: ./build/X86/gem5.opt _ECE552/hw3/gem5_simple.py

Global frequency set at 1000000000000 ticks per second
warn: No dot file generated. Please install pydot to generate the dot file and pdf.
src/mem/dram_interface.cc:690: warn: DRAM device capacity (8192 Mbytes) does not match the address range assigned (512 Mbytes)
src/base/statistics.hh:279: warn: One of the stats is a legacy stat. Legacy stat is a stat that does not belong to any statistics::Group. Legacy stat is deprecated.
system.remote_gdb: Listening for connections on port 7000
Beginning simulation!
src/sim/simulate.cc:199: info: Entering event queue @ 0.  Starting simulation...
Hello world!
Exiting @ tick 81884000 because exiting with last active thread context
```

Simulation time (from m5out/stats.txt):
```sh
simSeconds       0.000082       # Number of seconds simulated (Second)
```

Therefore, in order execution time is `0.000496` "simulation seconds" and out of order execution time is `0.000082` "simulation seconds".