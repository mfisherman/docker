#!/bin/sh
set -e

echo "--- Test OpenMP installation ---"

echo "check for gcc"
gcc --version > /dev/null
echo ok

echo "compile openmp_hello_world.c source"
gcc -o openmp_hello_world -fopenmp openmp_hello_world.c > /dev/null
echo ok

echo "run openmp_hello_world"
./openmp_hello_world > /dev/null
echo ok
