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
    //printf("thread1 x = %d\n", x);    
    //usleep(delay_time(200));//200ms de delay
    counter = x + 1;
    pthread_mutex_unlock(&mutex); // fim da região crítica

    return 0;
}

/*
void *thread2(void *tno) {
    pthread_mutex_lock(&mutex); // inicio da região crítica
    int x = counter;
    printf("thread2 x = %d\n", x);
    counter = x + 1;
    pthread_mutex_unlock(&mutex); // fim da região crítica

    return 0;
}
*/

int main() {
    pthread_mutex_init(&mutex, NULL);

    pthread_t t1, t2, t3;

    pthread_create(&t1, NULL, (void *)thread1, NULL);
    pthread_create(&t2, NULL, (void *)thread1, NULL);
    //pthread_create(&t3, NULL, (void *)thread1, NULL);

    pthread_join(t1, NULL);
    pthread_join(t2, NULL);
    //pthread_join(t3, NULL);

    printf("counter = %d", counter);

    return 0;
}