//original obtido em https://shivammitra.com/c/producer-consumer-problem-in-c/#
//modificações feitas por sidney.nogueira@ufrpe.br
#include <pthread.h>
#include <semaphore.h>
#include <stdlib.h>
#include <stdio.h>

/*
This program provides a possible solution for producer-consumer problem using mutex and semaphore.
I have used 5 producers and 5 consumers to demonstrate the solution. You can always play with these values.
*/

#define MaxItems 5 // Maximum items a producer can produce or a consumer can consume
#define BufferSize 3 // Size of the buffer

sem_t empty;
sem_t full;
pthread_mutex_t mutex;

//controle do buffer circular
int buffer[BufferSize];
int in = 0;//index for inserting
int out = 0;//index for removing

void *producer(void *pno)
{   
    int item;
    for(int i = 0; i < MaxItems; i++) {
        item = rand()%10; // Produce an random item in [0,10[
        sem_wait(&empty);//waits for empty cells and decrements
        pthread_mutex_lock(&mutex);
        buffer[in] = item;
        printf("Producer %d: Insert Item %d at %d\n", *((int *)pno),buffer[in],in);
        in = (in+1)%BufferSize; // in está no conjunto [0,BufferSize-1]
        pthread_mutex_unlock(&mutex);
        sem_post(&full);//increments cells with content
    }
    return 0;
}
void *consumer(void *cno)
{   
    for(int i = 0; i < MaxItems; i++) {
        sem_wait(&full);//waits for non empty cells and decrements 
        pthread_mutex_lock(&mutex);
        int item = buffer[out];
        printf("Consumer %d: Remove Item %d from %d\n",*((int *)cno),item, out);
        out = (out+1)%BufferSize;
        pthread_mutex_unlock(&mutex);
        sem_post(&empty);//increments empty cells
    }
    return 0;
}

int main()
{   
    pthread_t pro[5];//array of producers
    pthread_t con[5];//array of consumers
    
    sem_init(&empty,0,BufferSize);//sem,type sem,initial value
    sem_init(&full,0,0);
    pthread_mutex_init(&mutex, NULL);

    int indexes[5] = {1,2,3,4,5}; //Just used for numbering the producer and consumer

    //creates five producers
    for(int i = 0; i < 5; i++) {
        pthread_create(&pro[i], NULL, (void *)producer, (void *)&indexes[i]);
    }

    //creates five consumers
    for(int i = 0; i < 5; i++) {
        pthread_create(&con[i], NULL, (void *)consumer, (void *)&indexes[i]);
    }

    for(int i = 0; i < 5; i++) {
        pthread_join(pro[i], NULL);
    }
    
    for(int i = 0; i < 5; i++) {
        pthread_join(con[i], NULL);
    }

    sem_destroy(&empty);
    sem_destroy(&full);
    pthread_mutex_destroy(&mutex);

    return 0;
    
}