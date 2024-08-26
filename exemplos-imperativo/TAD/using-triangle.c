#include<stdio.h>
#include<triangle.h>

int main() {
  Triangle t1;
  Triangle_init(&t1,3,4,5);
  Triangle_scale(&t1, 2);           // sides are now 6, 8, 10
  printf(Triangle_perimeter(&t1));  // prints 24
  Triangle_print(&t1);
}