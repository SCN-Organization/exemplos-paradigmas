#include<stdio.h>

void Triangle_init(Triangle *tri, double a_in,
                   double b_in, double c_in) {
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
  printf("Triangle = {%f,%f,%f}", tri->a, tri->b, tri->c);
}

