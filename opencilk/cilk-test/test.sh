#!/bin/sh
set -e

echo "--- Test Cilk installation ---"

echo "compile fib.c source"
clang -fopencilk -O3 fib.c -o fib
echo ok

echo "run ./fib"
./fib
echo ok
