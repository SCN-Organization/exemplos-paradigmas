//não precisa de include em https://pythontutor.com/c.html#mode=edit  

int i1; //se mover esta declaração para a linha 17, dá erro na linha 6

void sub(){
  printf("i1 = %d\n", i1);
  int i1 = 1;
  int i2 = 2;
  printf("i1 = %d\n", i1);
  while(i2 > 1){
    int i1 = 10;
    printf("i1 = %d\n", i1);
    i2--;
  }
  printf("i1 = %d\n", i1);
}

int main() {
  i1 = 0;
  sub();
  printf("i1 = %d\n", i1);
  return 0;
}