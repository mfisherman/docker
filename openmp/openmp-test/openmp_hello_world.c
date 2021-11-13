#include <omp.h>
#include <stdio.h>

int main() {
    omp_set_num_threads(4);

    #pragma omp parallel for
    for (int i = 0; i < 4; ++i) {
        const int id = omp_get_thread_num();

        printf("Hello World from thread %d\n", id);

        // Nur im Master-Thread ausführen
        if (id == 0)
            printf("There are %d threads\n", omp_get_num_threads());
    }

    return 0;
}

