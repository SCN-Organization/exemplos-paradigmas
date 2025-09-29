#include <stdlib.h>
#include <stdio.h>
#include <pthread.h>

//retorna valor entre 0 e limit-1
int delay_time(int limit) {
    return rand() % limit;
}

int l = -1;//indefinido
int h = -1;//indefinido

void* func1(void* x) {
  l = 0;//l = false
  printf("0");
  return 0;
}

void* func2(void* x) {
  l = 1;//l = true
  printf("1");
  return 0;
}

void* func3(void* x) {
  // while(l == -1){//espera por valor em l
  //   usleep(delay_time(200));//dorme por até 200 ms
  // }
  h = l;
  printf("h");
  return 0;
}

//4 linhas de execução
int main(int argc, char** argv) {
  pthread_t th1, th2, th3;
  pthread_create(&th1, NULL, func1, NULL);
  pthread_create(&th2, NULL, func2, NULL);
  pthread_create(&th3, NULL, func3, NULL);
  pthread_join(th1, NULL);//espera concluir th1
  pthread_join(th2, NULL);//espera concluir th2
  pthread_join(th3, NULL);//espera concluir th3
  printf("\nh = %d", h);//h pode ser -1, 0, 1
  return 0;
}
