#include <stdio.h>
#include <cilk/cilk.h>

int fib(int n) {
    if (n < 2) return n;

    int x = cilk_spawn fib(n-1);
    int y = fib(n-2);
    cilk_sync;

    return x + y;
}

int main(int argc, char* argv[]) {
    int n = 10;
    int result = fib(n);
    printf("fib(%d) = %d\n", n, result);

    return 0;
}

