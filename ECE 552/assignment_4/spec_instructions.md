```sh

source shrc

go mcf_s

rm -r build

runcpu --fake --config sample-gcc-linux-x86 mcf_s

```

output:
```sh
(base) shaan@shaan-mega-computer:~/SPEC2017/benchspec/CPU/605.mcf_s$ runcpu --fake --config Example-gcc-linux-x86 mcf_s
SPEC CPU(r) 2017 Benchmark Suites
Copyright 1995-2017 Standard Performance Evaluation Corporation (SPEC)

runcpu v5825
Using 'linux-x86_64' tools
Reading file manifests... read 32272 entries from 2 files in 0.09s (374676 files/s)
Loading runcpu modules.................
Locating benchmarks...found 47 benchmarks in 53 benchsets.

=============================================================================
The config file you're using:
  /home/shaan/SPEC2017/config/Example-gcc-linux-x86.cfg
is one of the pre-supplied examples from SPEC.  Please copy it to a new
file with some other name, and look for places marked EDIT within it.

Note: The examples supplied with SPEC CPU2017 may use different 
hardware / software than yours, and adjustments may be needed.

To learn about config files:
   https://www.spec.org/cpu2017/Docs/config.html
To see actual results, and download their config files:
   https://www.spec.org/cpu2017/
Troubleshooting:
   https://www.spec.org/cpu2017/Docs/config.html#troubleshooting
Technical support:
   https://www.spec.org/cpu2017/Docs/techsupport.html
Generally, issues with compiling should be directed to your compiler vendor.
=============================================================================

There is no log file for this run.

*
* Temporary files were NOT deleted; keeping temporaries such as
* /home/shaan/SPEC2017/tmp
* (These may be large!)
*
runcpu finished at 2024-10-28 21:31:59; 0 total seconds elapsed
```

```sh
# had to copy the config file into the spec configs folder

cd build/build_base_mytest-m64.0000

specmake

go mcf_s

cd run/run_base_refspeed_mytest-m64.0000

specinvoke -n
```


```sh
/home/shaan/Desktop/AdvCompArch/gem5/build/X86/gem5.opt /home/shaan/Desktop/AdvCompArch/gem5/configs/se.py --cmd=../../build/build_base_mytest-m64.0000/mcf_s --options="inp.in" --mem-size=8GB --maxinsts=1000000000

/home/shaan/Desktop/AdvCompArch/gem5/build/X86/gem5.opt /home/shaan/Desktop/AdvCompArch/gem5/configs/se.py --cmd=../../build/build_base_mytest-m64.0000/mcf_s --options="inp.in" --mem-size=8GB --maxinsts=1000000000 --l1d_size=64kB --cacheline_size=64 --cpu-clock=1GHz --l1d_assoc=4
```

2055571389 
2055571389 

/home/shaan/Desktop/AdvCompArch/gem5/build/X86/gem5.opt /home/shaan/Desktop/AdvCompArch/gem5/configs/se.py --cmd=../../build/build_base_mytest-m64.0000/mcf_s --options=inp.in --mem-size=8GB --maxinsts=1000000000 --l1d_size=64kB --l1d_assoc=2 --cacheline_size=64 --cpu-clock=1GHz --cpu-type=X86O3CPU --caches