cd simplesim-3.0
make config-alpha
make sim-outorder
cp sim-outorder ../benchmarks
cd ../benchmarks
./sim-outorder -d cc1.alpha -O 1stmt.i > _gcc_stats.txt #gcc
./sim-outorder go.alpha 50 9 2stone9.in > _go_stats.txt #go
cd ..

./sim-outorder -issue:width 2 -issue:inorder true -cache:dl1 dl1:8:64:2:l -cache:dl1lat 2 -d cc1.alpha -O 1stmt.i > _gcc_stats.txt #gcc
./sim-outorder -issue:width 2 -issue:inorder true -cache:dl1 dl1:8:64:2:l -cache:dl1lat 3 -d cc1.alpha -O 1stmt.i > _gcc_stats.txt #gcc
./sim-outorder -issue:width 2 -issue:inorder true -cache:dl1 dl1:8:64:2:l -cache:dl1lat 4 -d cc1.alpha -O 1stmt.i > _gcc_stats.txt #gcc
sim_IPC                      0.6096 # instructions per cycle
sim_IPC                      0.5887 # instructions per cycle
sim_IPC                      0.5659 # instructions per cycle

./sim-outorder -issue:width 2 -issue:inorder true -cache:dl1 dl1:8:64:2:l -cache:dl1lat 2 go.alpha 50 9 2stone9.in > _go_stats.txt #go
./sim-outorder -issue:width 2 -issue:inorder true -cache:dl1 dl1:8:64:2:l -cache:dl1lat 3 go.alpha 50 9 2stone9.in > _go_stats.txt #go
./sim-outorder -issue:width 2 -issue:inorder true -cache:dl1 dl1:8:64:2:l -cache:dl1lat 4 go.alpha 50 9 2stone9.in > _go_stats.txt #go
sim_IPC                      0.3926 # instructions per cycle
sim_IPC                      0.3734 # instructions per cycle
sim_IPC                      0.3555 # instructions per cycle

./sim-outorder -issue:width 2 -ruu:size 4 -cache:dl1 dl1:8:64:2:l -cache:dl1lat 2 -d cc1.alpha -O 1stmt.i > _gcc_stats.txt #gcc
./sim-outorder -issue:width 2 -ruu:size 4 -cache:dl1 dl1:8:64:2:l -cache:dl1lat 3 -d cc1.alpha -O 1stmt.i > _gcc_stats.txt #gcc
./sim-outorder -issue:width 2 -ruu:size 4 -cache:dl1 dl1:8:64:2:l -cache:dl1lat 4 -d cc1.alpha -O 1stmt.i > _gcc_stats.txt #gcc
sim_IPC                      0.6622 # instructions per cycle
sim_IPC                      0.6249 # instructions per cycle
sim_IPC                      0.5902 # instructions per cycle

./sim-outorder -issue:width 2 -ruu:size 4 -cache:dl1 dl1:8:64:2:l -cache:dl1lat 2 go.alpha 50 9 2stone9.in > _go_stats.txt #go
./sim-outorder -issue:width 2 -ruu:size 4 -cache:dl1 dl1:8:64:2:l -cache:dl1lat 3 go.alpha 50 9 2stone9.in > _go_stats.txt #go
./sim-outorder -issue:width 2 -ruu:size 4 -cache:dl1 dl1:8:64:2:l -cache:dl1lat 4 go.alpha 50 9 2stone9.in > _go_stats.txt #go
sim_IPC                      0.5864 # instructions per cycle
sim_IPC                      0.5737 # instructions per cycle
sim_IPC                      0.5582 # instructions per cycle

./sim-outorder -issue:width 2 -ruu:size 32 -cache:dl1 dl1:8:64:2:l -cache:dl1lat 2 -d cc1.alpha -O 1stmt.i > _gcc_stats.txt #gcc
./sim-outorder -issue:width 2 -ruu:size 32 -cache:dl1 dl1:8:64:2:l -cache:dl1lat 3 -d cc1.alpha -O 1stmt.i > _gcc_stats.txt #gcc
./sim-outorder -issue:width 2 -ruu:size 32 -cache:dl1 dl1:8:64:2:l -cache:dl1lat 4 -d cc1.alpha -O 1stmt.i > _gcc_stats.txt #gcc
sim_IPC                      0.9440 # instructions per cycle
sim_IPC                      0.9293 # instructions per cycle
sim_IPC                      0.9114 # instructions per cycle

./sim-outorder -issue:width 2 -ruu:size 32 -cache:dl1 dl1:8:64:2:l -cache:dl1lat 2 go.alpha 50 9 2stone9.in > _go_stats.txt #go
./sim-outorder -issue:width 2 -ruu:size 32 -cache:dl1 dl1:8:64:2:l -cache:dl1lat 3 go.alpha 50 9 2stone9.in > _go_stats.txt #go
./sim-outorder -issue:width 2 -ruu:size 32 -cache:dl1 dl1:8:64:2:l -cache:dl1lat 4 go.alpha 50 9 2stone9.in > _go_stats.txt #go
sim_IPC                      0.8950 # instructions per cycle
sim_IPC                      0.8829 # instructions per cycle
sim_IPC                      0.8676 # instructions per cycle