#!/bin/sh
set -e

echo "--- Test UPC installation ---"

echo "check for upc"
upc --version > /dev/null
echo ok

echo "compile upc_hello_world.upc source"
upc -o upc_hello_world upc_hello_world.upc > /dev/null
echo ok

echo "run upc_hello_world"
./upc_hello_world -n 4 > /dev/null
echo ok
