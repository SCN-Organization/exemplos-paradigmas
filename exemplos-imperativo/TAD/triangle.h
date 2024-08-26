#include<stdio.h>

// A triangle ADT.
struct Triangle {
  double a;
  double b;
  double c;
  // INVARIANTS: a > 0 && b > 0 && c > 0 &&
  //             a + b > c && a + c > b && b + c > a
};

// REQUIRES: tri points to a Triangle object
// MODIFIES: *tri
// EFFECTS:  Initializes the triangle with the given side lengths.
void Triangle_init(Triangle *tri, double a_in, double b_in, double c_in);

// REQUIRES: tri points to a valid Triangle
// EFFECTS:  Returns the perimeter of the given Triangle.
double Triangle_perimeter(const Triangle *tri) ;

// REQUIRES: tri points to a valid Triangle; s > 0
// MODIFIES: *tri
// EFFECTS:  Scales the sides of the Triangle by the factor s.
void Triangle_scale(Triangle *tri, double s);

void Triangle_print(const Triangle *tri);
