#include <stdio.h>
#include <stdint.h>
#include <inttypes.h>
#include <cilk/cilk.h>

uint64_t fib(uint64_t n) {
    if (n < 2) return n;

    uint64_t x, y;
    cilk_scope {
        x = cilk_spawn fib(n-1);
        y = fib(n-2);
    }

    return x + y;
}

int main(int argc, char* argv[]) {
    uint64_t n = 40;
    uint64_t result = fib(n);
    printf("fib(%" PRIu64 ") = %" PRIu64 "\n", n, result);

    return 0;
}

