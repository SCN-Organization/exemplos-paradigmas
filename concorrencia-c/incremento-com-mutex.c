#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h> //linux

int counter = 0;
pthread_mutex_t mutex;

int delay_time(int limit) {
    return rand() % limit;
}

void *thread1(void *tno) {

    pthread_mutex_lock(&mutex); // wait do sem. binário
    int x = counter;
    usleep(delay_time(200));//200ms de delay
    counter = x + 1;
    pthread_mutex_unlock(&mutex); // release do sem. binario

    return 0;
}

int main() {
    pthread_mutex_init(&mutex, NULL);

    int N = 2;
    pthread_t threads[N];

    for(int i = 0; i < N; i++)
        pthread_create(&threads[i], NULL, (void *)thread1, NULL);

    for(int i = 0; i < N; i++)
        pthread_join(threads[i], NULL);

    printf("counter = %d", counter);

    return 0;
}