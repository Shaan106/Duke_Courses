cd simplesim-3.0
make config-alpha
make sim-safe
cp sim-safe ../benchmarks
cd ../benchmarks
./sim-safe -d cc1.alpha -O 1stmt.i > _gcc_stats.txt #gcc
./sim-safe anagram.alpha words < anagram.in > _anagram_stats.txt #anagram
./sim-safe go.alpha 50 9 2stone9.in > _go_stats.txt #go
cd ..