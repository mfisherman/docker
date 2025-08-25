#include <tbb/parallel_for.h>
#include <tbb/global_control.h>
#include <vector>
#include <iostream>

int main() {
    const int N = 1000;
    std::vector<int> data(N, 1);

    tbb::parallel_for(0, N, [&](int i) {
        data[i] *= 2;
    });

    std::cout << "First 10 elements doubled:\n";
    for (int i = 0; i < 10; ++i) {
        std::cout << i << " " << data[i] << std::endl;
    }

    return 0;
}

