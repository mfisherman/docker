#!/bin/sh
set -e

echo "--- Test oneTBB installation ---"

echo "compile parallel_for.cpp source"
g++ -std=c++17 parallel_for.cpp -ltbb -o parallel_for

echo ok

echo "run ./parallel_for"
./parallel_for

echo ok
