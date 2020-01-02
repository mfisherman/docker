#!/bin/sh
set -e

echo "--- Test GCC installation ---"

echo "check for gcc"
gcc --version > /dev/null
echo ok

echo "check for g++"
g++ --version > /dev/null
echo ok

echo "compile hello_world.c source"
gcc -o hello_world hello_world.c > /dev/null
echo ok

echo "run hello-world"
./hello_world > /dev/null
echo ok
