#include <stdio.h>
#include <stdlib.h>

// A triangle ADT.
typedef struct {
  double a;
  double b;
  double c;
} Triangle;

Triangle *Triangle_new() {
  Triangle *t = (Triangle *) malloc (sizeof(Triangle));
  // Inicializando os valores do triângulo
  t->a = 0.0;
  t->b = 0.0;
  t->c = 0.0;
  return t; 
}

void Triangle_init(Triangle *tri, 
                    double a_in, double b_in, double c_in) {
  tri->a = a_in;
  tri->b = b_in;
  tri->c = c_in;
}

double Triangle_perimeter(const Triangle *tri) {
  return tri->a + tri->b + tri->c;
}

void Triangle_scale(Triangle *tri, double s) {
  tri->a *= s;
  tri->b *= s;
  tri->c *= s;
}

void Triangle_print(const Triangle *tri) {
  printf("Triangle = {%.2lf,%.2lf,%.2lf}\n", tri->a, tri->b, tri->c);
}

int main() {
  Triangle t1;
  Triangle_init(&t1, 3, 4, 5);
  Triangle_scale(&t1, 2);         // sides are now 6, 8, 10
  printf("%.2lf\n", Triangle_perimeter(&t1)); // prints 24
  Triangle_print(&t1);
}