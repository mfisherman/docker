#include <upc_relaxed.h>
#include <stdio.h>

int main(){
   printf("Hello World from THREAD %d (of %d THREADS)\n", MYTHREAD, THREADS);
}
