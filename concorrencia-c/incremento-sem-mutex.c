#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h> //linux

int counter = 0;

int delay_time(int limit) {
  usleep(200);
  return rand() % limit;
}

void *thread1(void *tno) {
  usleep(delay_time(200));
  int x = counter;
  usleep(delay_time(200));
  counter = x + 1;
  return 0;
}

int main() {
  pthread_t t1, t2;

  pthread_create(&t1, NULL, thread1, NULL);
  pthread_create(&t2, NULL, thread1, NULL);

  pthread_join(t1, NULL);
  pthread_join(t2, NULL);

  printf("counter = %d", counter);

  return 0;
}