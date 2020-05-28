#!/bin/sh
set -e

echo "--- Test MPICH installation ---"

echo "check for mpicc"
mpicc --version > /dev/null
echo ok

echo "check for mpiexec"
mpiexec --version > /dev/null
echo ok

echo "compile mpi_hello_world.c source"
mpicc -o mpi_hello_world mpi_hello_world.c > /dev/null
echo ok

echo "run mpi_hello_world"
mpirun --allow-run-as-root -n 4 ./mpi_hello_world > /dev/null
echo ok
