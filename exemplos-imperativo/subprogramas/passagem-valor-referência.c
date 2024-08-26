#include <stdio.h>

int f(int a){
	return a + 1;
}

void p_valor(int a) {
	a = a + 1;
}

void p_ref(int *a) {
	*a = *a + 1;
}

int main() {
	int x = 100;

	p_valor(x);
	printf("%d\n", x);//100

	p_ref(&x);
	printf("%d\n", x);//101

	printf("%d\n", f(x);//102

	return 0;
}