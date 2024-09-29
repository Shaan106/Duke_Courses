cd simplesim-3.0
make config-alpha
make sim-outorder
cp sim-outorder ../benchmarks
cd ../benchmarks
./sim-outorder -d cc1.alpha -O 1stmt.i > _gcc_stats.txt #gcc
./sim-outorder go.alpha 50 9 2stone9.in > _go_stats.txt #go
cd ..