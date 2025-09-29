//não precisa de include em https://pythontutor.com/c.html#mode=edit  

void f1(char c){
  int x = 10; //stack-dynamic
  printf("x = %d\n", x);
}

int f2(){
  static int y = 20; //static
  y+= 1;
  return y;
}

void f3(){
  int *x = malloc(3*sizeof(int));//heap-dynamic
  x[0] = 30;
  x[1] = 40;
  x[2] = 50;
  int *y = x;//alias
  printf("y = \{%d,%d,%d\}\n", 
    y[0], y[1], y[2]);
  free(x);
}

int main() {
  f1('a');   
  f1('b');
  printf("y = %d\n", f2());
  printf("y = %d\n", f2());
  f3();
  return 0;
}