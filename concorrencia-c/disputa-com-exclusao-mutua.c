//original obtido em https://shivammitra.com/c/producer-consumer-problem-in-c/#
//modificações feitas por sidney.nogueira@ufrpe.br
#include <pthread.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h> //linux

//experimente comentar as linhas que fazem lock/unlock e veja que o valor do
//contador vai ultrapassar NUMBER_OF_RESOURCES 

#define MAX_ATTEMPTS 10
#define NUMBER_OF_RESOURCES 2 //quantidade de recurso disponível

int counter = 0;//quantidade de tasks usando o recurso
pthread_mutex_t mutex;

int delay_time(int limit){
  return rand()%limit;
}

void *task(void *tno)
{   
    for(int i = 0; i < MAX_ATTEMPTS; i++) {
        pthread_mutex_lock(&mutex);//inicio da região crítica
        if(counter < NUMBER_OF_RESOURCES){
            usleep(delay_time(500));
            counter++;
            printf("Task %d ENTROU, counter = %d\n",*((int *)tno),counter);
            pthread_mutex_unlock(&mutex);//fim da região crítica
            
            printf("Task %d USANDO\n",*((int *)tno));
              
            pthread_mutex_lock(&mutex);
            counter--;
            printf("Task %d SAIU, counter = %d\n",*((int *)tno),counter);
            pthread_mutex_unlock(&mutex);
            usleep(delay_time(500));
        }else{
            printf("Task %d NAO entrou, counter = %d\n",*((int *)tno),counter);
            pthread_mutex_unlock(&mutex);
            usleep(delay_time(500));
        }
    }
    return 0;
}

int main()
{   
    pthread_t tasks[5];//array of producers
    pthread_mutex_init(&mutex, NULL);

    int a[5] = {1,2,3,4,5}; //Just used for numbering

    for(int i = 0; i < 5; i++) {
        pthread_create(&tasks[i], NULL, (void *)task, (void *)&a[i]);
    }

    for(int i = 0; i < 5; i++) {
        pthread_join(tasks[i], NULL);
    }

    pthread_mutex_destroy(&mutex);
    
    return 0;
    
}