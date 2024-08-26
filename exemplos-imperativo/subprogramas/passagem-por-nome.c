#include <stdio.h>

#define multiplica(x,y) x*y

#define maximo(x,y) x>y?x:y

int main(){
	printf("%d\n", multiplica((1+2),6)); // (1+2)*6 = 18
	printf("%d\n", multiplica(1+2,6)); // 1+2*6 = 13

 	int a = 5;
	int b = 3;
	printf("%d\n", maximo(a,b)); //a>b?a:b = 5
	printf("%d\n", maximo(++a,b)); //++a>b?++a:b = 7

	return 0;
}