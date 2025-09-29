#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h> //linux

int counter = 0;

int delay_time(int limit) { 
  return rand() % limit; 
}

void *thread1(void *tno) {
  int x = counter;
  // printf("t1 x = %d\n", x);
  usleep(delay_time(200)); //comente esta linha para ver contador = 2
  counter = x + 1;
  return 0;
}

/*
void *thread2(void *tno) {
  int x = counter;
  // printf("t2 x = %d\n", x);
  counter = x + 1;
  return 0;
}
*/

int main() {
  pthread_t t1, t2;

  pthread_create(&t1, NULL, thread1, NULL);
  pthread_create(&t2, NULL, thread1, NULL);

  pthread_join(t1, NULL);
  pthread_join(t2, NULL);

  printf("counter = %d", counter);

  return 0;
}