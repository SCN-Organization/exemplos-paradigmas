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

    pthread_mutex_lock(&mutex); // inicio da região crítica
    int x = counter;
    usleep(delay_time(200));//200ms de delay
    counter = x + 1;
    pthread_mutex_unlock(&mutex); // fim da região crítica

    return 0;
}

int main() {
    pthread_mutex_init(&mutex, NULL);

    int MAX = 100;
    pthread_t threads[MAX];

    for(int i = 0; i < MAX; i++)
        pthread_create(&threads[i], NULL, (void *)thread1, NULL);

    for(int i = 0; i < MAX; i++)
        pthread_join(threads[i], NULL);

    printf("counter = %d", counter);

    return 0;
}