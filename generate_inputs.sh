#!/bin/bash

mkdir -p input_files

echo "Generating 22 scheduler test files..."

# (Use the same content you previously approved)

cat > input_files/test1.txt <<< "10, 1, 0, 10, 0, 0"
cat > input_files/test2.txt <<< "10, 1, 0, 10, 5, 1"
cat > input_files/test3.txt <<< "10, 1, 0, 10, 0, 0
1, 2, 3, 5, 0, 0"
cat > input_files/test4.txt <<< "10, 1, 0, 5, 2, 3
1, 2, 3, 5, 0, 0"

cat > input_files/test5.txt <<< "5, 3, 0, 20, 0, 0
3, 4, 5, 15, 0, 0
1, 2, 10, 10, 0, 0"

cat > input_files/test6.txt <<< "10, 8, 0, 100, 0, 0
8, 6, 0, 80, 0, 0
6, 5, 0, 60, 0, 0
4, 4, 0, 40, 0, 0"

cat > input_files/test7.txt <<< "7, 3, 0, 50, 5, 2
5, 4, 0, 40, 4, 2
3, 2, 0, 30, 3, 1
1, 3, 0, 20, 2, 1"

cat > input_files/test8.txt <<< "9, 10, 0, 100, 0, 0
7, 8, 5, 80, 15, 3
5, 6, 10, 60, 10, 2
3, 5, 15, 40, 0, 0"

cat > input_files/test9.txt <<< "1, 40, 0, 50, 0, 0
2, 25, 0, 40, 0, 0
3, 15, 5, 30, 0, 0
4, 10, 10, 20, 0, 0
5, 8, 15, 15, 0, 0
6, 2, 20, 10, 0, 0"

cat > input_files/test10.txt <<< "1, 5, 0, 10, 0, 0
2, 50, 2, 20, 0, 0
3, 3, 5, 8, 0, 0"

cat > input_files/test11.txt <<< "8, 5, 0, 30, 3, 5
6, 4, 0, 25, 3, 5
4, 3, 0, 20, 3, 5"

cat > input_files/test12.txt <<< "10, 10, 0, 200, 0, 0
5, 5, 0, 10, 0, 0
3, 3, 5, 8, 0, 0
1, 2, 10, 5, 0, 0"

cat > input_files/test13.txt <<< "10, 8, 0, 50, 10, 5
5, 6, 0, 40, 0, 0
1, 4, 20, 30, 0, 0"

cat > input_files/test14.txt <<< "8, 5, 0, 250, 0, 0
7, 4, 0, 250, 0, 0
6, 3, 0, 250, 0, 0"

cat > input_files/test15.txt <<< "5, 2, 0, 50, 10, 1
4, 2, 0, 50, 10, 1
3, 2, 0, 50, 10, 1
2, 2, 0, 50, 10, 1"

cat > input_files/test16.txt <<< "10, 5, 0, 30, 0, 0
8, 4, 50, 25, 0, 0
6, 3, 100, 20, 0, 0
4, 2, 150, 15, 0, 0"

cat > input_files/test17.txt <<< "5, 5, 0, 40, 8, 2
4, 5, 0, 40, 8, 2
3, 5, 0, 40, 8, 2"

cat > input_files/test18.txt <<< "7, 4, 0, 50, 10, 1
6, 4, 0, 50, 10, 3
5, 4, 0, 50, 10, 5
4, 4, 0, 50, 10, 8"

cat > input_files/test19.txt <<< "1, 5, 0, 40, 5, 3
10, 6, 0, 50, 0, 0
5, 4, 10, 30, 0, 0"

cat > input_files/test20.txt <<< "1, 40, 0, 20, 0, 0
2, 2, 5, 15, 0, 0
3, 25, 10, 20, 0, 0
4, 8, 15, 15, 0, 0"

cat > input_files/test21.txt <<< "6, 3, 0, 50, 2, 1
5, 3, 0, 50, 2, 1
4, 3, 0, 50, 2, 1"

cat > input_files/test22.txt <<< "10, 2, 0, 20, 0, 0
9, 2, 2, 18, 0, 0
8, 2, 4, 16, 0, 0
7, 2, 6, 14, 0, 0
6, 2, 8, 12, 0, 0
5, 2, 10, 10, 0, 0
4, 2, 12, 8, 0, 0
3, 2, 14, 6, 0, 0"

echo "✓ All 22 input tests generated."


